# VerinFast/homebrew-waikiki

Homebrew tap for [Waikiki](https://github.com/VerinFast/waikiki) — a small local
wiki for a human and an LLM to edit the same page.

```sh
brew tap VerinFast/waikiki
brew install --cask waikiki
```

Waikiki is not notarized yet, so macOS refuses the first launch. Until that
lands, either install with `--no-quarantine`:

```sh
brew install --cask waikiki --no-quarantine
```

or right-click the app in Applications and choose **Open**, once.

Apple Silicon only for now; an Intel build is a separate pipeline rather than a
flag, and the cask declares the requirement so an Intel install fails with a
reason instead of a broken app.

## Updates

The cask sets `auto_updates true`: Homebrew installs Waikiki and then leaves it
alone, because the app updates itself. Each release is Ed25519-verified against
a key compiled into the build before it is installed — a stronger guarantee than
the checksum in this file, which anyone who can edit this tap could change along
with the URL.

So `brew upgrade` will not move Waikiki, by design. The app will.
