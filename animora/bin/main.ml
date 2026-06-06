open Animora.Scanner
open Animora.Tokens
open Animora.Parser
open Animora.Ast_dot
open Animora.Ast
open Animora.Codegen_ctx
open Animora.Js_gen
open Animora.Css_gen
open Animora.Html_gen
open Static_check.Analyzer
open Static_check.Errors
open Static_check.Warn


let read_file filename =
  let ic = open_in filename in
  let n = in_channel_length ic in
  let s = really_input_string ic n in
  close_in ic;
  s
;;

  
let write_file path content =
  let oc = open_out path in
  output_string oc content;
  close_out oc
;;


let format_token tok =
  Printf.sprintf "%-16s  %-20s  [%d:%d - %d:%d]\n"
    (token_kind_to_string tok.kind)
    tok.lexeme
    tok.span.start_pos.line
    tok.span.start_pos.col
    tok.span.end_pos.line
    tok.span.end_pos.col
;;


let build_ctx (prog : program) : ctx =
  let ctx = make_ctx () in
  List.iter (fun item ->
    match item with
    | TIVarDecl (name, expr) -> ctx.vars <- ctx.vars @ [(name, expr)]
    | TIShapeDecl (name, kind, props) -> ctx.shapes <- ctx.shapes @ [(name, kind, props)]
    | TIFuncDecl (name, params, body) -> ctx.funcs <- ctx.funcs @ [(name, params, body)]
    | TIEveryFrame body -> ctx.every_frame <- ctx.every_frame @ body
    | TIAnimate (tgt, fr, to_, dur, ease) -> ctx.tweens <- ctx.tweens @ [(tgt, fr, to_, dur, ease)]
    | TIKeyframes (name, frames) -> ctx.keyframes <- ctx.keyframes @ [(name, frames)]
    | TIAfter (dur, body) -> ctx.afters <- ctx.afters @ [(dur, body)]
    | TIRepeat (c, i, body) -> ctx.repeats <- ctx.repeats @ [(c, i, body)]
    | TIEvent (ev, body) -> ctx.events <- ctx.events @ [(ev, body)]
    | TIStmt s -> ctx.init_stmts <- ctx.init_stmts @ [s]
  ) prog.items;
  ctx
;;


let ensure_dir path =
  try Unix.mkdir path 0o755 with Unix.Unix_error (Unix.EEXIST, _, _) -> ()
;;


let () =
  if Array.length Sys.argv < 2 then begin
    prerr_endline "Usage: dune exec animora -- <path-to-file>";
    exit 1
  end;

  let input_path = Sys.argv.(1) in
    let basename =
      input_path
      |> Filename.basename
      |> Filename.remove_extension
    in
      let tmp_base = "dev" in
        ensure_dir tmp_base;
      let tmp_dir = Filename.concat tmp_base basename in
        ensure_dir tmp_dir;

  (* Read and tokenize the input file *)
  let source = read_file input_path in
    let tokens = scan_tokens source in

      let tokens_path = Filename.concat tmp_dir (basename ^ "_tokens.txt") in
        let token_content =
          let header = Printf.sprintf "Tokens for: %s\n%s\n" input_path (String.make 60 '-') ^ "\n" in
          let lines = List.map format_token tokens in
          header ^ String.concat "" lines
        in
          write_file tokens_path token_content;

  (* AST nodes file *)
  let ast = parse tokens in
    let errors = Static_check.Analyzer.analyze_program ast in
      if List.length errors > 0 then 
      begin
        Printf.eprintf "\n%s\n" (String.make 60 '-');
        Printf.eprintf "Static Analysis Errors:\n";
        Printf.eprintf "%s\n" (String.make 60 '-');
        List.iter (fun err ->
          Printf.eprintf "- %s\n" (Static_check.Errors.to_string err)
        ) errors;
        Printf.eprintf "Compilation failed due to static analysis errors.\n";
        exit 1
      end;
  
  let dot_str = generate_dot ast in
    let dot_path = Filename.concat tmp_dir (basename ^ "_ast.dot") in
      write_file dot_path dot_str;

  (* Generating AST png using graphviz *)
  let png_path = Filename.concat tmp_dir (basename ^ "_ast.png") in
    let dot_cmd = Printf.sprintf "dot -Tpng %s -o %s" dot_path png_path in
      let png_ok = Sys.command dot_cmd = 0 in

  (* Code Generation part *)
  let out_base = "public" in
    ensure_dir out_base;
      let out_dir = Filename.concat out_base basename in
        ensure_dir out_dir;
  
  let ctx = build_ctx ast in
  let js_code = generate_js ast ctx in
  let css_code = generate_css ast.canvas in
  
  let js_filename = basename ^ ".js" in
  let css_filename = basename ^ ".css" in
  let html_filename = basename ^ ".html" in
  
  let html_code = generate_html 
    ~width:ast.canvas.width 
    ~height:ast.canvas.height 
    ~css_file:css_filename 
    ~js_file:js_filename 
  in

  let html_path = Filename.concat out_dir html_filename in
  write_file (Filename.concat out_dir js_filename) js_code;
  write_file (Filename.concat out_dir css_filename) css_code;
  write_file html_path html_code;

  (* Reference Output for the user *)
  Printf.printf "Output written to %s/\n" tmp_dir;
  Printf.printf "  tokens : %s\n" tokens_path;
  Printf.printf "  ast    : %s\n" dot_path;
  if png_ok then
    Printf.printf "  png    : %s\n" png_path
  else
    Printf.printf "  png    : (skipped — 'dot' not found or failed)\n";

  Printf.printf "\nCode Generated in %s/\n" out_dir;
  Printf.printf "  html   : %s\n" html_path;
  Printf.printf "  css    : %s/%s\n" out_dir css_filename;
  Printf.printf "  js     : %s/%s\n" out_dir js_filename;
  Printf.printf "Compilation completed successfully!\n";

  let open_cmd = Printf.sprintf "open %s" html_path in
  ignore (Sys.command open_cmd)
;;
