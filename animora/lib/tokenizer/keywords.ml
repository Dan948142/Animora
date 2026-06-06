open Tokens


let build_keywords () =
  let build_hash_table = Hashtbl.create 64 in
    let add k v = Hashtbl.add build_hash_table k v in
      add "canvas" CANVAS; 
      add "fps" FPS; 
      add "duration" DURATION; 
      add "seconds" SECONDS;
      add "let" LET; 
      add "true" TRUE; 
      add "false" FALSE;
      add "circle" CIRCLE; 
      add "rect" RECT; 
      add "triangle" TRIANGLE;
      add "line" LINE; 
      add "text" TEXT;
      add "if" IF; 
      add "else" ELSE; 
      add "loop" LOOP;
      add "for" FOR; 
      add "in" IN; 
      add "from" FROM; 
      add "to" TO;
      add "fn" FN; 
      add "return" RETURN;
      add "every" EVERY; 
      add "frame" FRAME; 
      add "animate" ANIMATE;
      add "over" OVER; 
      add "easing" EASING; 
      add "keyframes" KEYFRAMES;
      add "at" AT; 
      add "after" AFTER; 
      add "repeat" REPEAT;
      add "times" TIMES; 
      add "interval" INTERVAL;
      add "on" ON; 
      add "click" CLICK; 
      add "key" KEY; 
      add "mouse_move" MOUSE_MOVE;
      add "linear" LINEAR; 
      add "ease_in" EASE_IN; 
      add "ease_out" EASE_OUT;
      add "ease_in_out" EASE_IN_OUT; 
      add "bounce" BOUNCE;
      add "and" AND; 
      add "or" OR; 
      add "not" NOT;
     build_hash_table
