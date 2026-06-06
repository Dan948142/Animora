# Animora Events & Interactions

Handling user inputs like mouse movement, mouse clicks, and key presses is essential for creating interactive simulations and games in Animora.

## Mouse Click Events
You can attach `on click` handlers to specific shapes or the canvas. The engine calculates hit-tests on bounding boxes or circle collision radii and automatically filters interactions.

### Clicking a Shape
```animora
let my_button = rect { x: 50, y: 50, width: 100, height: 40, color: "blue" }

on click my_button {
  my_button.color = "red"
}
```

## Mouse Move Events
Global `on mouse_move` blocks allow developers to read coordinates directly from the window pointer, updating physics systems, flow fields, or games natively.

```animora
let cursor = circle { x: 0, y: 0, radius: 10, color: "white" }

on mouse_move {
  // Logic inside move callbacks generally maps the pointer manually
  cursor.x = mouse.x
  cursor.y = mouse.y
}
```

## Keyboard Input
Attach code logic to specific key events by declaring `on key "name"`.
Spaces, arrows, modifiers, letters, and numbers are natively supported.

```animora
let character = rect { x: 0, y: 0, width: 30, height: 30, color: "green" }

on key "right" {
  character.x = character.x + 10
}

on key "left" {
  character.x = character.x - 10
}

on key "space" {
  // Trigger jump or interaction
  character.y = character.y - 20
}
```
