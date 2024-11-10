#!/bin/bash

# Automated GPG Signed Commits Setup Script

# Function to check if a command exists
command_exists() {
    command -v "$1" &> /dev/null
}

# Step 1: Install Git and GPG if not already installed
echo "Checking if Git and GPG are installed..."

# Check if Git is installed
if ! command_exists git; then
    echo "Git not found! Installing Git..."
    sudo apt update && sudo apt install -y git
else
    echo "Git is already installed."
fi

# Check if GPG is installed
if ! command_exists gpg; then
    echo "GPG not found! Installing GPG..."
    sudo apt install -y gnupg
else
    echo "GPG is already installed."
fi

# Step 2: Generate GPG key if not already created
echo "Checking if GPG key exists..."

# List existing GPG keys
existing_key=$(gpg --list-secret-keys --keyid-format LONG)

if [[ -z "$existing_key" ]]; then
    echo "No GPG key found! Generating a new key..."

    # Generate a new GPG key
    gpg --full-generate-key

    # Wait for key generation
    echo "Please follow the prompts to generate your GPG key."
else
    echo "GPG key already exists."
fi

# Step 3: Set up Git configuration to use GPG key
echo "Configuring Git to use GPG key for signing commits..."

# Get GPG key ID
GPG_KEY_ID=$(gpg --list-secret-keys --keyid-format LONG | grep sec | awk '{print $2}' | sed 's/\/.*//')

if [[ -z "$GPG_KEY_ID" ]]; then
    echo "No GPG key found. Exiting setup."
    exit 1
else
    echo "Using GPG key ID: $GPG_KEY_ID"
    # Configure Git to use the GPG key
    git config --global user.signingkey "$GPG_KEY_ID"
    git config --global commit.gpgSign true
fi

# Step 4: Export the GPG key to be added to GitHub
echo "Exporting GPG public key..."

gpg --armor --export "$GPG_KEY_ID" > ~/gpg-public-key.asc

echo "Please copy the following GPG key and add it to your GitHub account under Settings > SSH and GPG keys > New GPG key:"
cat ~/gpg-public-key.asc

# Step 5: Ask user to confirm addition of the GPG key to GitHub
echo "Do you want to open GitHub to add the key now? (y/n)"
read -r open_github

if [[ "$open_github" == "y" ]]; then
    if command_exists xdg-open; then
        xdg-open "https://github.com/settings/keys"
    else
        echo "Opening GitHub in your default browser. Please add the GPG key manually."
        cmd.exe /C start "https://github.com/settings/keys"
    fi
else
    echo "Please manually visit https://github.com/settings/keys and add the GPG key."
fi

# Step 6: Verify the GPG setup and test signed commit
echo "Testing GPG signed commit..."

# Create a test commit
git init test-repo
cd test-repo
echo "Testing GPG signed commit" > test-file.txt
git add test-file.txt
git commit -m "Test GPG signed commit"

echo "If everything was set up correctly, this commit should be signed and verified on GitHub."

# End of the script
echo "GPG signed commit setup complete!"
