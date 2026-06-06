# Animating in Animora

Animora removes the complex boilerplate of traditional canvas animation—like the tick loops, time deltas, and math matrices—and replaces it with an intuitive, declarative syntax.

---

## The `animate` Keyword

The `animate` command performs interpolations (tweens) on a property over a designated time.

**Syntax:**
```animora
animate <target>.<property> from <start_value> to <end_value> over <duration> seconds [easing <easing_style>]
```

### Basic Movement

```animora
let my_circle = circle { x: 100, y: 100, radius: 20, color: "#FF0000"}

// Move the circle to x=800 over 3 seconds
animate my_circle.x from 100 to 800 over 3 seconds
```

### Morphing Colors and Size

Animora allows transitions on other properties like radius or color natively.

```animora
animate my_circle.color from "#FF0000" to "#0000FF" over 2 seconds
animate my_circle.radius from 20 to 100 over 2 seconds easing ease_in_out
```

### Easing Methods

By default, animations are `linear`. You can specify easing variants:
- `linear` - Constant speed.
- `ease_in` - Starts slow, accelerates.
- `ease_out` - Starts fast, decelerates.
- `ease_in_out` - Starts slow, speeds up in middle, slows down at end.
- `bounce` - Simulates a physical bounce effect at the end.

---

## Continuous `every frame` Animations

When you need continuous physical behavior rather than declarative tweens, the `every frame` block allows executing code exactly on the engine tick.

```animora
let gravity = 0.5
let vy = 0
let ball = circle { x: 500, y: 100, radius: 20, color: "#FFFFFF" }

every frame {
    // Apply gravity
    vy = vy + gravity
    ball.y = ball.y + vy
    
    // Floor collision
    if (ball.y > 900) {
        ball.y = 900
        vy = vy * -0.8 // Invert and lose energy
    }
}
```

---

## Managing Triggers (`interaction`)

Animations often need to be triggered by events rather than running instantly.

```animora
let hero = rect { x: 100, y: 500, width: 40, height: 60, color: "#00FF00" }

on key "space" {
    // Jump animation
    let current_y = hero.y
    animate hero.y from current_y to (current_y - 150) over 0.5 seconds easing ease_out
}
```
