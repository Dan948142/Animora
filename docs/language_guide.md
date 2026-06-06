# Animora Language Guide

Welcome to the **Animora** Language Guide! This document provides a comprehensive overview of the correct syntax and structures for building 2D animations and games.

---

## 1. Setup and Canvas Definition

Every Animora script typically starts by defining the drawing `canvas` and core settings like `fps` (Frames per Second).

```animora
canvas 1000 1000 background "#05050A"
fps 60
```

- **canvas `<width>` `<height>` background `"<color>"`**: Sets up the scene.
- **fps `<number>`**: Sets the animation tick rate.

---

## 2. Variables and Expressions

Variables are declared using the `let` keyword. They are dynamically typed and can store numbers, booleans, or objects.

```animora
let speed = 5
let gravity = 0.5
let is_bouncing = true
let factor = (10 + 2) / speed
```

---

## 3. Shapes and Objects

Shapes are the native objects of the DSL. You declare them with `let`, their type (`circle`, `rect`, `line`, etc.), and a `{}` block with initial property values (no commas needed between properties).

```animora
let my_ball = circle {
    x: 500,
    y: 300,
    radius: 20,
    color: "#00F2FF"
}

let platform = rect {
    x: 400,
    y: 900,
    width: 200,
    height: 20,
    color: "#FFFFFF"
}
```

Shape types:
- `circle { x, y, radius, color }`
- `rect { x, y, width, height, color }`
- `line { x1, y1, x2, y2, color }`
- `text { x, y, content, size, color }`

---

## 4. Animation Operations

Animora supports two primary ways to animate: **Declarative Tweens** and **Continuous Processing**.

### Declarative Tweens (`animate`)

The `animate` keyword is used for direct interpolations on arbitrary shape properties (`target.field`).

```animora
// Syntax: animate <target.property> from <start> to <end> over <time> seconds [easing <type>]

animate my_ball.x from 100 to 700 over 2 seconds easing bounce
```

Common easings include: `linear`, `ease_in`, `ease_out`, `ease_in_out`, and `bounce`.

### Continuous Frame Updates (`every frame`)

For continuous logic (physics, gravity loops, velocity application), you use the `every frame` block.

```animora
let vx = 5
let vy = 2

every frame {
    my_ball.x = my_ball.x + vx
    my_ball.y = my_ball.y + vy

    // Bounce off walls
    if (my_ball.x > 1000) {
        vx = vx * -1
    }
}
```

---

## 5. Control Flow

### If / Else
Standard branching logic.

```animora
if (score > 10) {
    print("You win!")
} else {
    print("Keep trying")
}
```

### Loops
Animora uses a `loop` keyword for bounded iterations.

```animora
let arr = [1, 2, 3, 4]
let n = arr.length

loop i from 0 to (n - 1) {
    print(arr[i])
}
```

---

## 6. Events and Interactivity

Interactivity is configured by prefixing event listeners with the `on` keyword.

### Object Clicks
```animora
on click(my_ball) {
    my_ball.color = "#FF0000"
}
```

### Global Keyboard Input
```animora
on key "space" {
    vy = -10
}
```
