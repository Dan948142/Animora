exception Lexer_error of string


type token_kind =
	| INT | STRING | FLOAT | IDENT
	| CANVAS | FPS | DURATION | SECONDS
	| FN | RETURN | LET
	| TRUE | FALSE | AND | OR | NOT
	| CIRCLE | RECT | TRIANGLE | LINE | TEXT
	| IF | ELSE | LOOP | FOR | IN | FROM | TO
	| EVERY | FRAME | ANIMATE | KEYFRAMES | REPEAT | OVER | EASING | AT | AFTER | TIMES | INTERVAL
	| ON | CLICK | KEY | MOUSE_MOVE
	| ASSIGN | EQUAL | MINUS | PLUS | LESS | MORE | COLON | STAR | SLASH | COMMA | DOT
	| LEFT_CURL | RIGHT_CURL | LEFT_PAR | RIGHT_PAR
	| LINEAR | EASE_IN | EASE_OUT | EASE_IN_OUT | BOUNCE
	| PERCENT
	| NOT_EQUALS | LESS_EQUAL | MORE_EQUAL
	| LEFT_BRACKET | RIGHT_BRACKET
	| END


type position = { 
  line : int; 
  col : int; 
};;


type span = { 
  start_pos : position;
  end_pos : position; 
};;


type token = {
	kind : token_kind;
	lexeme : string;
	literal : string;
	span : span;
};;


let token_kind_to_string = function
	| INT -> "INT"
	| STRING -> "STRING"
	| FLOAT -> "FLOAT"
	| IDENT -> "IDENT"
	| CANVAS -> "CANVAS"
	| FPS -> "FPS"
	| DURATION -> "DURATION"
	| SECONDS -> "SECONDS"
	| FN -> "FN"
	| RETURN -> "RETURN"
	| LET -> "LET"
	| TRUE -> "TRUE"
	| FALSE -> "FALSE"
	| AND -> "AND"
	| OR -> "OR"
	| NOT -> "NOT"
	| CIRCLE -> "CIRCLE"
	| RECT -> "RECT"
	| TRIANGLE -> "TRIANGLE"
	| LINE -> "LINE"
	| TEXT -> "TEXT"
	| IF -> "IF"
	| ELSE -> "ELSE"
	| LOOP -> "LOOP"
	| FOR -> "FOR"
	| IN -> "IN"
	| FROM -> "FROM"
	| TO -> "TO"
	| EVERY -> "EVERY"
	| FRAME -> "FRAME"
	| ANIMATE -> "ANIMATE"
	| KEYFRAMES -> "KEYFRAMES"
	| REPEAT -> "REPEAT"
	| OVER -> "OVER"
	| EASING -> "EASING"
	| AT -> "AT"
	| AFTER -> "AFTER"
	| TIMES -> "TIMES"
	| INTERVAL -> "INTERVAL"
	| ON -> "ON"
	| CLICK -> "CLICK"
	| KEY -> "KEY"
	| MOUSE_MOVE -> "MOUSE_MOVE"
	| ASSIGN -> "ASSIGN"
	| EQUAL -> "EQUAL"
	| MINUS -> "MINUS"
	| PLUS -> "PLUS"
	| LESS -> "LESS"
	| MORE -> "MORE"
	| COLON -> "COLON"
	| STAR -> "STAR"
	| SLASH -> "SLASH"
	| COMMA -> "COMMA"
	| DOT -> "DOT"
	| LEFT_CURL -> "LEFT_CURL"
	| RIGHT_CURL -> "RIGHT_CURL"
	| LEFT_PAR -> "LEFT_PAR"
	| RIGHT_PAR -> "RIGHT_PAR"
	| LINEAR -> "LINEAR"
	| EASE_IN -> "EASE_IN"
	| EASE_OUT -> "EASE_OUT"
	| EASE_IN_OUT -> "EASE_IN_OUT"
	| BOUNCE -> "BOUNCE"
	| PERCENT -> "PERCENT"
	| NOT_EQUALS -> "NOT_EQUALS"
	| LESS_EQUAL -> "LESS_EQUAL"
	| MORE_EQUAL -> "MORE_EQUAL"
	| LEFT_BRACKET -> "LEFT_BRACKET"
	| RIGHT_BRACKET -> "RIGHT_BRACKET"
	| END -> "END"


let print_token tok =
	Printf.printf "%s %s [%d:%d - %d:%d]\n"
		(token_kind_to_string tok.kind)
		tok.lexeme
		tok.span.start_pos.line
		tok.span.start_pos.col
		tok.span.end_pos.line
		tok.span.end_pos.col
;;


let print_tokens tokens =
	List.iter print_token tokens
;;
