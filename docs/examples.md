# Animora Examples

Here are some fully working examples showcasing the power and expressiveness of the Animora DSL.

---

## 1. Bouncing Ball Simulation

A basic physics simulation handling boundary collision.

> **Video Output:**
> <img src="../assets/Bouncing_Ball_Wall_Strike.gif" alt="Bouncing Ball" width="400">

```animora
canvas 800 600 background "#111111"
fps 60

let ball = circle {
    x: 400,
    y: 300,
    radius: 20,
    color: "#00F2FF"
}

let vx = 5
let vy = 5

every frame {
    ball.x = ball.x + vx
    ball.y = ball.y + vy

    if (ball.x + ball.radius > 800) {
        vx = vx * -1
    }
    if (ball.x - ball.radius < 0) {
        vx = vx * -1
    }
    if (ball.y + ball.radius > 600) {
        vy = vy * -1
    }
    if (ball.y - ball.radius < 0) {
        vy = vy * -1
    }
}
```

---

## 2. Interactive Click Counter

Clicking a circle increases a score and moves the circle to a random location.

> **Video Output:**
> <img src="../assets/Click_on_Ball.gif" alt="Interactive Gameplay" width="400">

```animora
canvas 800 600 background "#222222"
fps 60

let score = 0

let target = circle {
    x: 400,
    y: 300,
    radius: 30,
    color: "#FF3366"
}

let score_text = text {
    x: 20,
    y: 40,
    content: "Score: 0",
    size: 24,
    color: "#FFFFFF"
}

on click(target) {
    score = score + 1
    score_text.content = "Score: " + score

    target.x = random(50, 750)
    target.y = random(50, 550)
}
```

---

## 3. Algorithm Visualization: Visual Array Sorting

Animating bars corresponding to an array sorting algorithm.

> **Video Output:**
> <img src="../assets/Visual_Sorting.gif" alt="Visual Sorting" width="400">

```animora
canvas 800 600 background "#05050A"
fps 10

let arr = [50, 20, 80, 40, 10]
let n = arr.length

// Initialize graphical bars mapping to the array
let bar0 = rect { x: 100, y: 500, width: 40, height: 50, color: "#FFAA00" }
let bar1 = rect { x: 200, y: 500, width: 40, height: 20, color: "#FFAA00" }
let bar2 = rect { x: 300, y: 500, width: 40, height: 80, color: "#FFAA00" }
let bar3 = rect { x: 400, y: 500, width: 40, height: 40, color: "#FFAA00" }
let bar4 = rect { x: 500, y: 500, width: 40, height: 10, color: "#FFAA00" }

// In a real Animora engine with a loop or tick-based update
every frame {
```
