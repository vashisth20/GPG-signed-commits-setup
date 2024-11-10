# Running the GPG Signed Commits Setup Script

This guide will walk you through how to run the `setup-gpg-signed-commits.sh` script to automatically set up GPG signed commits in your Git environment.

## Running the Script
The script automates the setup of GPG signed commits. To run the script, follow these steps:

### Step 1: Clone the Repository
If you haven't already, clone the repository where the script is hosted:

```sh
git clone https://github.com/CloudAutomation-Hub/GPG-signed-commits-setup.git
```

### Step 2: Make the Script Executable
Ensure that the script has executable permissions. You can do this by running:

```sh
chmod +x setup-gpg-signed-commits.sh
```

### Step 3: Execute the Script
Run the script with the following command:

```sh
./setup-gpg-signed-commits.sh
```

### Step 4: Follow the Prompts
The script will guide you through the setup process. You'll be prompted for the following:

1. **GPG Key ID:** If you already have a GPG key, provide the key ID. If you don't have one, the script will help you generate it.

2. **GitHub Key Addition:** The script will automatically open your default web browser and take you to the GitHub GPG keys page to add your public GPG key. If the browser doesn’t open, you'll be provided with a URL to open manually.

3. **Test Commit:** After setting up, the script will attempt to make a test commit to ensure that everything is working correctly.

### Step 5: Verify the Setup
Once the script completes, go to your GitHub account and verify that the commit is marked as "`Verified`" on the test repository.

## Troubleshooting
- **xdg-open:** command not found: If you're using WSL or Linux and the browser does not open automatically, you can manually open the GitHub GPG keys page by navigating to [GitHub GPG Keys Settings](https://github.com/settings/keys).

- **GPG Key Not Found:** If the script can't find your GPG key, make sure you've generated it and that you're using the correct key ID.