open Tokens


type lexer_state = {
  source : string;
  mutable line : int;
  mutable col : int;
  mutable start_line : int;
  mutable start_col : int;
  mutable start_idx : int;
  mutable curr_idx : int;
  keywords : (string, token_kind) Hashtbl.t;
};;


let create_lexer source = {
  source;
  line = 1;
  col = 1;
  start_line = 1;
  start_col = 1;
  start_idx = 0;
  curr_idx = 0;
  keywords = Keywords.build_keywords ();
};;


let is_at_end st = st.curr_idx >= String.length st.source;;


let advance st =
  if is_at_end st 
  then '\000'
  else
    let c = st.source.[st.curr_idx] in
      st.curr_idx <- st.curr_idx + 1;
      if c = '\n' then (
        st.line <- st.line + 1;
        st.col <- 1
      ) else
        st.col <- st.col + 1;
    c
;;


let peek st = if is_at_end st then '\000' else st.source.[st.curr_idx]
;;


let peek_next st =
  if st.curr_idx + 1 < String.length st.source 
  then st.source.[st.curr_idx + 1]
  else '\000'
;;


let match_char st expected =
  if is_at_end st 
  then false
  else 
    if st.source.[st.curr_idx] <> expected 
    then false
    else
      let _ = advance st in
    true
;;


let make_token st kind text value = {
  kind;
  lexeme = text;
  literal = value;
  span = {
    start_pos = { 
      line = st.start_line; 
      col = st.start_col 
    };
    end_pos = { 
      line = st.line; 
      col = st.col 
    };
  };
};;
