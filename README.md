# VerinFast/homebrew-jamgraf

Homebrew tap for [Jamgraf](https://github.com/VerinFast/jamgraf) (formerly
Waikiki), a small local wiki for a human and an LLM to edit the same page.

```sh
brew tap verinfast/jamgraf
brew trust verinfast/jamgraf   # Homebrew >= 7.0.10 refuses third-party taps until trusted
brew install --cask jamgraf
```

**Already installed as Waikiki?** This tap used to be `verinfast/homebrew-waikiki`, and GitHub redirects the old name. Three commands move an existing install across (tested on Homebrew 7.0.10):

```sh
brew update                     # follows the redirect: verinfast/waikiki becomes verinfast/jamgraf
brew trust verinfast/jamgraf    # Homebrew drops trust when a tap is renamed, so trust it again
brew migrate --cask waikiki     # renames the installed cask to jamgraf
```

Homebrew prints the `brew trust` line itself the first time it refuses the cask. Skipping `brew migrate` is harmless: the app updates itself either way, and `brew list` just warns that `waikiki` was renamed.

Jamgraf is not notarized yet, so macOS blocks the first launch. After the first
attempt, open **System Settings → Privacy & Security** and click **Open Anyway**,
once. Alternatively:

```sh
xattr -dr com.apple.quarantine /Applications/Jamgraf.app
```

(Current Homebrew has no `--no-quarantine`, and since macOS 15 right-click → Open
no longer bypasses Gatekeeper.)

Apple Silicon only for now; an Intel build is a separate pipeline rather than a
flag, and the cask declares the requirement so an Intel install fails with a
reason instead of a broken app.

## Updates

The cask sets `auto_updates true`: Homebrew installs Jamgraf and then leaves it
alone, because the app updates itself. Each release is Ed25519-verified against
a key compiled into the build before it is installed. That's a stronger guarantee
than the checksum in this file, which anyone who can edit this tap could change
along with the URL.

So `brew upgrade` will not move Jamgraf, by design. The app will.
