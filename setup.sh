#!/bin/bash
set -e

echo ""
echo "Animora Setup Script                "
echo ""

# Install prerequisites if not present
echo "[1/6] Checking and installing system dependencies (opam, build-essential, graphviz)..."
if ! command -v opam &> /dev/null; then
    echo "opam not found. Installing via apt-get..."
    sudo apt-get update
    sudo apt-get install -y opam build-essential
else
    echo "opam is already installed."
fi

if ! command -v dot &> /dev/null; then
    echo "graphviz (dot) not found. Installing via apt-get..."
    sudo apt-get update
    sudo apt-get install -y graphviz
else
    echo "graphviz is already installed."
fi

# Initialize opam
echo "[2/6] Initializing opam environment..."
if [ ! -d ~/.opam ]; then
    opam init -y --disable-sandboxing
else
    echo "opam is already initialized."
fi

# Add opam to global environment automatically
echo "[3/6] Setting up global environment variables..."
SHELL_RC="$HOME/.bashrc"
if [ -n "$ZSH_VERSION" ] || [[ "$SHELL" == *"zsh"* ]]; then
    SHELL_RC="$HOME/.zshrc"
fi

if ! grep -q "eval \$(opam env)" "$SHELL_RC"; then
    echo "Adding 'eval \$(opam env)' to $SHELL_RC..."
    echo -e "\n# OPAM Configuration\neval \$(opam env)" >> "$SHELL_RC"
fi

eval $(opam env)

# Install project dependencies including dune
echo "[4/6] Installing project dependencies (including dune)..."
ROOT_DIR="$(pwd)"
cd animora
opam install . --deps-only --with-test -y
if ! command -v dune &> /dev/null; then
    opam install -y dune
fi

# Set up VS Code Extension for syntax highlighting
echo "[5/6] Setting up VS Code syntax highlighting..."
mkdir -p ~/.vscode/extensions
rm -rf ~/.vscode/extensions/vscode-animora
# Create a symlink to the extension folder so changes reflect automatically
ln -s "$ROOT_DIR/vscode-animora" ~/.vscode/extensions/vscode-animora
echo "VS Code extension for Animora linked successfully. (Restart VS Code to see syntax colors)"
code --install-extension "$ROOT_DIR/vscode-animora/animora.vsix"

# 6. Build and Test
echo "[6/6] Building and testing Animora..."
dune build
dune test

echo ""
echo " Setup complete! All tests passed.      "
echo ""
echo ""
echo "To start using Animora, you can run:"
echo "  cd animora"
echo "  dune exec animora -- example/simulations/bouncing_ball.anim"
echo ""
echo "Note: You may need to run 'source $SHELL_RC' or restart your terminal"
echo "to have the 'dune' command available globally."
