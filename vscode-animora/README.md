# Animora Language Support

A VS Code extension for the **Animora DSL**, providing rich language support for `.anim` files.

Built by [Anuroop Konala](https://github.com/anuroopkonala).

## Features

- **Syntax highlighting** - TextMate grammar for Animora constructs
- **Semantic highlighting** - distinct coloring for variables, parameters, functions, properties, shape types, and easing values
- **Diagnostics** - real-time standalone validation built into the extension
- **Completions** - keywords, built-in functions, shape types, animatable fields, and key names
- **Language configuration** - bracket matching, auto-closing pairs, comment toggling

## Requirements

- VS Code **1.105.0** or newer

## Getting Started


### Install from `.vsix`

```bash
code --install-extension animora.vsix
```

Or go to **Extensions -> ... -> Install from VSIX...** and select the file.

## Standalone Validation

The extension does **not** require the external Animora compiler to validate code.

Its lexer, parser, and semantic checker are bundled inside the extension, so diagnostics work:

- offline
- in fresh workspaces
- even when the compiler is not installed or built

## Language Overview

Animora is a DSL for declarative canvas animations. Files use the `.anim` extension. Example:

```anim
canvas 800 500 background "#1a1a2e"
fps 60
duration 10 seconds

let vy = 0.0
let gravity = 0.4
let bounce_factor = 0.75
```

## Extension Settings

Semantic highlighting is enabled by default for Animora files:

```json
"[animora]": {
  "editor.semanticHighlighting.enabled": true
}
```

## License

MIT © [Anuroop Konala](./LICENSE) (Konala Saran Teja Anuroop Reddy)
