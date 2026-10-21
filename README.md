# VerinFast/homebrew-jamgraf

Homebrew tap for [Jamgraf](https://github.com/VerinFast/jamgraf) (formerly
Waikiki), a small local wiki for a human and an LLM to edit the same page.

```sh
brew tap verinfast/jamgraf
brew install --cask jamgraf
```

**Already installed as Waikiki?** Nothing to do. This tap used to be
`verinfast/homebrew-waikiki`. GitHub redirects the old name, and
`cask_renames.json` maps the `waikiki` cask to `jamgraf`, so `brew update` moves
an existing install across.

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
