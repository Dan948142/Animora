# Animora: DSL for Web-based Animations (Group 19)

## Table of Contents
1. [Introduction & Motivation](#1-introduction--motivation)
2. [Language Overview & Features](#2-language-overview--features)
3. [Sample Program & Output](#3-sample-program--output)
4. [Code Reduction & Efficiency](#4-code-reduction--efficiency)
5. [Team Members & Contributions (Group 19)](#5-team-members--contributions-group-19)
6. [Build and Run Instructions](#6-build-and-run-instructions)
7. [User Survey & Feedback](#7-user-survey--feedback)
8. [Project Demo Video](#8-project-demo-video)
* [Documentation Directory](#documentation-directory)

## 1. Introduction & Motivation
**Animora** is a domain-specific language (DSL) designed to make 2D animation creation accessible, expressive, and programmable. 
Creating web animations traditionally requires wrestling with heavyweight tools (like Adobe After Effects) or writing hundreds of lines of boilerplate JavaScript and HTML5 Canvas API code. Animora bridges this gap by providing a unified, declarative language for defining shapes, animations, physics, and user interactions—all compiled directly into optimized web code.

**Target User Group:**
* **CS Students:** Creating algorithm visualizations and data structure animations.
* **Educators & Professors:** Designing interactive teaching aids and visual explanations of technical concepts.
* **Creative Coders & Artists:** Producing generative art, spirographs, fractals, and particle systems.
* **Web Developers:** Protyping animated UI components, loaders, and interactive transitions.

## 2. Language Overview & Features
Animora allows developers to write `.anim` source scripts which are transpiled by an OCaml compiler directly into standalone HTML, CSS, and optimized JavaScript code that runs natively in any browser.

**Core Keywords and Grammar:**
* **Program Structure:** `canvas`, `fps`, `duration`, `seconds`
* **Declarations & Types:** `let`, `true`, `false`, `fn`, `return`
* **Shapes:** `circle`, `rect`, `triangle`, `line`, `text`
* **Control Flow:** `if`, `else`, `loop` (counter-based), `for in` (collection-based)
* **Animation Blocks:** `every frame` (per-frame logic), `animate` (declarative tweening), `keyframes` (multi-point interpolation), `after` (delayed execution), `repeat` (looping logic)
* **Interactions:** `on click`, `on key`, `on mouse_move`
* **Built-in Functions:** `sin()`, `cos()`, `abs()`, `random()`, `min()`, `max()`, `len()`

## 3. Sample Program & Output
Here is an example program generating a simple interactive bouncing ball simulation:

```animora
canvas 1000 600 background "#05050a"
fps 60

// 1. Shapes & Score
let paddle1 = rect { x: 30, y: 250, width: 20, height: 100, color: "#ffffff" }
let paddle2 = rect { x: 950, y: 250, width: 20, height: 100, color: "#ffffff" }
let ball = circle { x: 500, y: 300, radius: 10, color: "#00f2ff" }

let score1 = 0
let score2 = 0
let score_text = text { x: 450, y: 60, content: "0 - 0", color: "#888888", fontSize: 32 }

// 2. Physics Parameters 
let vx = 6.0
let vy = 4.0
let paddle_speed = 35.0

// 3. Game Engine Loop
every frame {
  // Movement
  ball.x = ball.x + vx
  ball.y = ball.y + vy
  
  // Ceiling and Floor Bounce
  if ball.y <= 10 or ball.y >= 590 {
    vy = -vy
  }
  
  // Paddle Collisions (Left)
  if ball.x <= 55 and ball.x >= 30 {
    if ball.y >= paddle1.y and ball.y <= (paddle1.y + 100) {
      vx = -vx * 1.05 // Speed up for difficulty
      ball.x = 56     // Prevent multiple detections
    }
  }
  
  // Paddle Collisions (Right)
  if ball.x >= 945 and ball.x <= 970 {
    if ball.y >= paddle2.y and ball.y <= (paddle2.y + 100) {
      vx = -vx * 1.05
      ball.x = 944
    }
  }
  
  // Scored Point (Left Wall)
  if ball.x < 0 {
    score2 = score2 + 1
    ball.x = 500
    ball.y = 300
    vx = 6.0
    score_text.content = "" + score1 + " - " + score2
  }
  
  // Scored Point (Right Wall)
  if ball.x > 1000 {
    score1 = score1 + 1
    ball.x = 500
    ball.y = 300
    vx = -6.0
    score_text.content = "" + score1 + " - " + score2
  }
}

// 4. Controls (Player 1: W/S, Player 2: Arrows)
on key "w" { paddle1.y = max(0, paddle1.y - paddle_speed) }
on key "s" { paddle1.y = min(500, paddle1.y + paddle_speed) }

on key "ArrowUp" { paddle2.y = max(0, paddle2.y - paddle_speed) }
on key "ArrowDown" { paddle2.y = min(500, paddle2.y + paddle_speed) }
```

**Final Output:** This compiles into a standalone HTML webpage.
![Pong Gameplay](assets/Pong.gif)

> **Browse our [Gallery of Use Cases](docs/gallery.md)** to see more examples of what can be built with Animora.

## 4. Code Reduction & Efficiency

One of the primary goals of Animora is to drastically reduce boilerplate code and complexity. Creating standard web animations usually requires writing and managing three separate files: HTML (structure), CSS (styling), and JavaScript (logic/rendering).

With the Animora DSL, developers can declare elements, behavior, events, and physics in **one single file**. Based on our benchmarks across ~30 animated examples and simulations, Animora reduces the amount of code needed by an average of **74%**.

[**Read the full Code Reduction Analysis & Metrics here**](docs/code_reduction.md)

## 5. Team Members & Contributions (Group 19)

* **Singarapu Abhinaya (Roll No: 24CS10033) — 25% Effort**
  * *Contribution:* As a part of the team i have contributed to the devolopment of the Animora compiler by implementing the static analysis phase of the compiler, including symbol table design, semantic validations, and error handling checks to ensure type safety and runtime correctness.
* **Sanskar Sovitkar (Roll No: 24CS10131) — 25% Effort**
  * *Contribution:* Contributed to the development of the Animora compiler by implementing the lexical analysis module, including a robust tokenizer with comprehensive unit tests for correctness and reporting.
* **Konala Saran Teja Anuroop Reddy (Roll No: 24CS10063) — 25% Effort**  
  * *Contribution:* Contributed to the development of the Animora DSL by designing and implementing the parser, converting the language grammar into a structured AST construction pipeline and ensuring that grammar matches the parser.
* **Yug Bargaway (Roll No: 24CS10140) — 25% Effort**
  * *Contribution:* As the manager and lead contributor of the project, I orchestrated the overall idea, feature and grammar of the DSL. I contributed in the core compilation backend, building the code generation layer (JavaScript, CSS, HTML), the type system and dynamic checks, and the VS Code extension.

## 6. Build and Run Instructions

The easiest way to run the project on Ubuntu is using the provided setup script. It installs `opam`, `graphviz`, and `dune` dependencies automatically.

1. **Run the Initialization Script:**
   ```bash
   chmod +x setup.sh
   ./setup.sh
   ```
2. **Activate the Environment:**
   ```bash
   eval $(opam env)
   ```
3. **Compile an Animation (.anim):**
   ```bash
   cd animora
   dune exec animora -- ../example/simulations/bouncing_ball.anim
   ```
   *(This outputs the interactive webpage into the `public/` directory. Rest developmental outputs are present in the `dev/` folder which includes, tokens, ast_nodes and ast diagram.)*

4. **Running Unit Tests:**
   The language is thoroughly tested covering the Lexer/Scanner, Parser, Static Checks, Dynamic Checks and Codegen:
   ```bash
   cd animora
   dune test
   ```

## 7. User Survey & Feedback
To validate the necessity and syntax clarity of our DSL, we conducted a survey amongst 16 student participants.
**Survey Link:** [https://forms.gle/Vo5K3uUt4XWZyLBj6](https://forms.gle/Vo5K3uUt4XWZyLBj6)

**Questions Asked:**
1. What is your primary role or background?
2. How would you rate your prior experience with specialized programming languages or animation libraries?
3. Which types of projects did you build or explore using Animora?
4. How easy was it to learn and understand Animora's syntax?
5. How would you rate the readability of Animora code compared to traditional general-purpose languages?
6. Which features of Animora did you find the most useful?
7. Did you encounter any major pain points or frustrations while using Animora?
8. How helpful was the official documentation and the provided examples?
9. What new feature or improvement would you most like to see in the next version of Animora?
10. On a scale of 1-10, how likely are you to recommend Animora to a peer?

**Summary of Responses:**
* **Demographics & Experience:** 100% of the participants were students, with prior experience in DSLs and animation libraries spread relatively evenly from pure beginners (1/5) to experts (5/5).
* **Ease of Use & Readability:** **75% of users** rated Animora's syntax as "Easy" or "Very Easy" to learn (4 or 5 out of 5). An overwhelming **93.7%** found the Animora codebase more readable than traditional languages when building animations.
* **Popular Use Cases:** Mini-Games (built by ~81% of users) and Algorithmic Visualizations (50%) were the most explored project types.
* **Valuable Features:** The custom VS Code Extension with syntax highlighting, the provided example gallery, and built-in shape/event handling primitives were praised as the most useful features across all users.
* **Constructive Feedback:** While the syntax was loved, some users pointed out pain points with manual coordinate tracking and generic error messages. Highly requested features for V2 include a visual editor and expanded animation libraries.
* **NPS / Recommendation:** Participants gave an average recommendation score of **8.75 / 10** for building interactive 2D animations and educational visualizations.


## 8. Project Demo Video
**[🎥 Click Here to view the YouTube Project Demo](https://www.youtube.com/watch?v=IQ3tclZ23q4)**

---
## Documentation Directory
For an exhausted deep-dive into writing programs, view the `docs/` folder:
1. [Language Guide & Syntax](docs/language_guide.md)
2. [Animations Reference](docs/animations.md)
3. [Events & Interactions](docs/events.md)
4. [Formal Grammar Specification](docs/grammar.md)
5. [Compiler Architecture](docs/architecture.md)
6. [Examples (Inputs & Outputs)](docs/examples.md)
7. [Developmental Flowchart](docs/development_timeline.md)
8. [Gallery of Usecases](docs/gallery.md)
9. [Code Reduction and Efficiency](docs/code_reduction.md)
