# Linux (WSL) Setup Guide for GPG Signed Commits

## Prerequisites
Before setting up GPG signed commits on Linux (WSL), ensure you have the following installed:

- [Git](https://git-scm.com/)
- [GPG (GNU Privacy Guard)](https://gnupg.org/)
- [Windows Subsystem for Linux (WSL)](https://learn.microsoft.com/en-us/windows/wsl/install) installed and running

### Step 1: Install Git and GPG on WSL
If you haven’t installed Git and GPG on your WSL distribution yet, follow these steps to install them.

1. Open your **WSL terminal**.
2. Update the package list and install Git and GPG:

    ```sh
    sudo apt update
    sudo apt install git gnupg
    ```

3. Verify that Git and GPG are installed by running:

    ```sh
    git --version
    gpg --version
    ```

    You should see the version details for both Git and GPG.

### Step 2: Generate Your GPG Key
Now you’ll create a GPG key pair to use for signing your commits.

1. Run the following command to generate your GPG key:

    ```sh
    gpg --full-generate-key
    ```

2. Choose the default key type (1) for RSA and RSA.

3. Select 4096 bits for the key size `(this is more secure)`.

4. Set the expiration date for your key `(optional)`. You can leave it blank for no expiration.

5. Enter your name and email address. Ensure the email you provide matches the one you use on GitHub.

6. Set a passphrase to protect your key. This adds an extra layer of security. `Optional: you can leave it blank to use passwordless`

### Step 3: List Your GPG Keys
Once the key is created, you need to find the key ID to configure Git.

1. Run the following command to list all your GPG keys:

    ```sh
    gpg --list-secret-keys --keyid-format LONG
    ```

2. You will see something like this:

    ```sh
    /Users/you/.gnupg/secring.gpg
    ------------------------------
    sec   4096R/<Your-Key-ID> 2019-09-12 [expires: 2020-09-12]
    uid                          Your Name <youremail@example.com>
    ssb   4096R/<Your-Subkey-ID> 2019-09-12
    ```

3. Copy the long key ID (the string after `4096R/`), which you’ll use in the next steps.

### Step 4: Configure Git to Use Your GPG Key
Now, let’s configure Git to use your GPG key for signing commits.

1. Set the key in your global Git configuration:

    ```sh
    git config --global user.signingkey <Your-Key-ID>
    ```

    Replace `<Your-Key-ID>` with the key ID you copied earlier.

2. Enable commit signing by default:

    ```sh
    git config --global commit.gpgSign true
    ```

### Step 5: Add Your GPG Key to GitHub
To have your signed commits verified on GitHub, you need to add your GPG key to your GitHub account.

1. Export your public key with the following command:

    ```sh
    gpg --armor --export <Your-Key-ID>
    ```
    This will output your public key in ASCII format. Copy the entire output, including the `-----BEGIN PGP PUBLIC KEY BLOCK-----` and `-----END PGP PUBLIC KEY BLOCK-----` lines.

2. Go to your [GitHub GPG keys settings](https://github.com/settings/keys).

3. Click New GPG key, then paste your copied public key into the provided field and click Add GPG key.

### Step 6: Test GPG Signed Commits
Now that you’ve set everything up, let’s test it by making a signed commit.

1. Make a change to a repository and stage the changes:

    ```sh
    git add .
    ```

2. Commit the changes with a message:

    ```sh
    git commit -m "Test GPG signed commit"
    ```

3. Push the commit to GitHub:

    ```sh
    git push origin main
    ```

4. Visit your GitHub repository and verify that the commit shows as `Verified`.

## Troubleshooting
If your commit does not show as "`Verified`" on GitHub, try the following:

- Ensure your email matches on GitHub and in GPG: The email address associated with your GPG key must match the one used in your GitHub account.
- Verify GPG is working correctly: Run `gpg --list-keys` to ensure your key is available.
- Check GPG passphrase: If you are prompted for the passphrase when making a commit, ensure it is entered correctly.


## Key Sections in This Guide:
- **Install GPG and Git**: Step-by-step instructions for installing and verifying GPG and Git on WSL.
- **Generating and Configuring Keys**: How to generate a GPG key and configure Git to use it for commit signing.
- **Adding the Key to GitHub**: Detailed instructions for adding your GPG key to your GitHub account.
- **Troubleshooting**: Solutions to common issues that may arise during setup.

This guide should provide users with everything they need to configure GPG signed commits on Linux via WSL, ensuring that their commits are verified on GitHub.
