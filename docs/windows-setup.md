# Windows Setup Guide for GPG Signed Commits

## Prerequisites
Before setting up GPG signed commits on Windows, ensure you have the following installed:

- [Git for Windows](https://gitforwindows.org/)
- [GPG (GNU Privacy Guard)](https://gnupg.org/)

### Step 1: Install Git for Windows
If you haven’t installed Git on your system yet, download and install **Git for Windows** from the link provided.

- During installation, **ensure that you select "Use Git from the Windows Command Prompt"** for easier access to Git commands.

### Step 2: Install GPG (GNU Privacy Guard)
Download and install **GPG for Windows** from the official site.

- Follow the installation prompts to install GPG.
- After installation, verify that GPG is installed correctly by opening the **Command Prompt** and running:

    ```sh
    gpg --version
    ```

You should see the version of GPG installed on your system.

### Step 3: Generate Your GPG Key
Now, you’ll need to create a GPG key pair that will be used for signing your commits.

1. Open Git Bash (or the Windows Command Prompt) and run the following command to start the GPG key generation process:

    ```sh
    gpg --full-generate-key
    ```

2. You will be prompted to select the key type. Choose the default option (1) for RSA and RSA.

3. When prompted for the key size, choose 2048 bits or 4096 bits (4096 bits is more secure).

4. Set an expiration date for your key `(optional)`. If you prefer no expiration, just press Enter to skip.

5. Enter your name and email address. Make sure the email matches the one you use on GitHub.

6. Enter a passphrase to protect your key. This adds an extra layer of security. `Optional: you can leave it blank to use passwordless`

### Step 4: List Your GPG Keys
Once the key is created, you need to find the key ID to configure Git. Run the following command to list your keys:

```sh
gpg --list-secret-keys --keyid-format LONG
```

You should see output similar to this:

```sh
/Users/you/.gnupg/secring.gpg
------------------------------
sec   4096R/<Your-Key-ID> 2019-09-12 [expires: 2024-09-12]
uid                          Your Name <youremail@example.com>
ssb   4096R/<Your-Subkey-ID> 2019-09-12
```

The long key ID is the value following `4096R/`. Copy the entire key ID (`<Your-Key-ID>`) to use in the next step.

### Step 5: Configure Git to Use Your GPG Key
Now that you have your GPG key, configure Git to use it for signing commits:

1. Set the key in your global Git configuration:

    ```sh
    git config --global user.signingkey <Your-Key-ID>
    ```

    Replace <Your-Key-ID> with the key ID you obtained from the previous step.

2. Enable commit signing by default:

    ```sh
    git config --global commit.gpgSign true
    ```

### Step 6: Add Your GPG Key to GitHub
To sign your commits on GitHub, you need to add your GPG key to your GitHub account:

1. Export your public key with the following command:

    ```sh
    gpg --armor --export <Your-Key-ID>
    ```

    This will output your public key in ASCII format. Copy the entire output (including `-----BEGIN PGP PUBLIC KEY BLOCK-----` and `-----END PGP PUBLIC KEY BLOCK-----`).

2. Go to your [GitHub GPG keys settings](https://github.com/settings/keys).

3. Click New GPG key, then paste your copied public key into the provided field and click Add GPG key.

### Step 7: Test GPG Signed Commits
Now, you’re ready to test your GPG setup by making a commit:

1. Make a change to a repository and stage it:
    ```sh
    git add .
    ```

2. Commit the change with a message:

    ```sh
    git commit -m "Test GPG signed commit"
    ```

3. Push your commit to GitHub:

    ```sh
    git push origin main
    ```

4. Go to your GitHub repository and confirm that the commit shows as Verified.

## Troubleshooting
If your commit does not show as "`Verified`" on GitHub, try the following:

- Ensure your email matches on GitHub and in GPG: The email address associated with your GPG key should match the one used in your GitHub account.
- Verify GPG is working correctly: Run `gpg --list-keys` to ensure your key is available.
- Check GPG passphrase: If you're prompted for the passphrase when making a commit, ensure it’s entered correctly.

## FAQ
- **Q: How do I remove my GPG key from GitHub?** A: Go to GitHub's GPG settings and click the Delete button next to the key you wish to remove.

- **Q: Can I use my GPG key across multiple computers?** A: Yes, as long as you export and import your GPG key on all your devices and configure Git to use the same key ID.

---

That's it! You've successfully set up GPG signed commits on Windows. Now your commits will be cryptographically signed, ensuring they’re verifiable and tamper-proof.