#!/bin/bash

# Exit immediately if a command fails
set -e

EMAIL="ak.tech106@gmail.com"
SSH_KEY_PATH="$HOME/.ssh/id_ed25519"

echo "🔐 Setting up GitHub SSH authentication..."

# Step 1: Generate SSH key if it doesn't exist
if [ -f "$SSH_KEY_PATH" ]; then
  echo "✅ SSH key already exists at $SSH_KEY_PATH"
else
  echo "➡️ Generating a new SSH key..."
  ssh-keygen -t ed25519 -C "$EMAIL" -f "$SSH_KEY_PATH" -N ""
  echo "✅ SSH key generated"
fi

# Step 2: Start ssh-agent
echo "➡️ Starting ssh-agent..."
eval "$(ssh-agent -s)"

# Step 3: Add SSH key to agent
echo "➡️ Adding SSH key to ssh-agent..."
ssh-add "$SSH_KEY_PATH"

# Step 4: Show public key
echo ""
echo "📌 COPY the SSH public key below and add it to GitHub:"
echo "GitHub → Settings → SSH and GPG keys → New SSH key"
echo "----------------------------------------------------"
cat "${SSH_KEY_PATH}.pub"
echo "----------------------------------------------------"

echo ""
echo "✅ SSH setup complete!"
echo "👉 After adding the key to GitHub, test with:"
echo "   ssh -T git@github.com"

