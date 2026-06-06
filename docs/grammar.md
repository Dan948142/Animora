# Animora DSL Grammar Specification

The following formal grammar defines the structure of the Animora DSL program. The language is designed to be easily readable and express intent directly without boilerplate.

## 1. Program Structure

A valid Animora program begins by optionally declaring the canvas settings, frames per second (fps), and animation duration, followed by the main body.

```ebnf
<program> ::= <canvas_decl> [<fps_decl>] [<duration_decl>] <body>

<canvas_decl> ::= 'canvas' INT INT ['background' STRING]
<fps_decl> ::= 'fps' INT
<duration_decl> ::= 'duration' NUMBER 'seconds'

<body> ::= { <top_level_stmt> }
```

## 2. Variable Declarations

```ebnf
<variable_decl> ::= 'let' IDENT '=' <expr>
```

## 3. Shape Declarations

Shapes are assigned to variables and initialized with a property list. 

```ebnf
<shape_decl> ::= 'let' IDENT '=' <shape_type> '{' <property_list> '}'

<shape_type> ::= 'circle' | 'rect' | 'triangle' | 'line' | 'text'

<property_list> ::= <property> { ',' <property> }
<property> ::= IDENT ':' <expr>
```

## 4. Statements

```ebnf
<statement> ::= <variable_decl>
              | <assignment>
              | <if_stmt>
              | <loop_stmt>
              | <for_stmt>
              | <return_stmt>
              | <expr_stmt>

<top_level_stmt> ::= <statement> 
                   | <function_decl>
                   | <animation_block>
                   | <interaction_block>
```

## 5. Animation Blocks

Animora simplifies time-based operations with continuous update loops and declarative tweening.

```ebnf
<every_frame> ::= 'every' 'frame' '{' <stmt_list> '}'

<animate_stmt> ::= 'animate' <field_access> 
                   'from' <expr> 
                   'to' <expr> 
                   'over' NUMBER 'seconds' 
                   [ 'easing' <easing_type> ]

<easing_type> ::= 'linear' | 'ease_in' | 'ease_out' | 'ease_in_out' | 'bounce'
```

## 6. Functions & Control Flow

```ebnf
<function_decl> ::= 'fn' IDENT '(' [<param_list>] ')' '{' <stmt_list> '}'
<loop_stmt> ::= 'loop' IDENT 'from' <expr> 'to' <expr> '{' <stmt_list> '}'
<for_stmt> ::= 'for' IDENT 'in' <list_expr> '{' <stmt_list> '}'
<if_stmt> ::= 'if' <expr> '{' <stmt_list> '}' ['else' '{' <stmt_list> '}']  
```

## 7. Interactivity

Animora allows registering event listeners directly on shapes or globally (like keys).

```ebnf
<interaction_block> ::= 'on' 'click' '(' IDENT ')' '{' <stmt_list> '}'
                      | 'on' 'key' STRING '{' <stmt_list> '}'
                      | 'on' 'mouse' 'move' '{' <stmt_list> '}'
```

## 8. Built-in Functions

- `random(min, max)` - Returns a random integer.
- `random_choice(list)` - Returns a random element from a list.
- `dist(x1, y1, x2, y2)` - Returns the Euclidean distance between two points.
- `sin(angle)`, `cos(angle)`, `tan(angle)` - Trigonometric functions.
- `print(expr)` - Prints to the console log.
