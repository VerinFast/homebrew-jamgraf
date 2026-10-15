# VerinFast/homebrew-jamgraf

Homebrew tap for [Jamgraf](https://github.com/VerinFast/jamgraf) — a small local
wiki for a human and an LLM to edit the same page.

```sh
brew tap VerinFast/jamgraf
brew install --cask jamgraf
```

Jamgraf is not notarized yet, so macOS refuses the first launch. Until that
lands, either install with `--no-quarantine`:

```sh
brew install --cask jamgraf --no-quarantine
```

or right-click the app in Applications and choose **Open**, once.

Apple Silicon only for now; an Intel build is a separate pipeline rather than a
flag, and the cask declares the requirement so an Intel install fails with a
reason instead of a broken app.

## Jamgraf was called Waikiki

If you installed it as `waikiki`, there is nothing to do. `cask_renames.json`
points Homebrew at the new name, and the app moves your wikis, your Kahala
sign-in and its own bundle to the new name the first time it opens.
`brew tap VerinFast/waikiki` still works too: GitHub redirects the old tap's
address to this one.

## Updates

The cask sets `auto_updates true`: Homebrew installs Jamgraf and then leaves it
alone, because the app updates itself. Each release is Ed25519-verified against
a key compiled into the build before it is installed — a stronger guarantee than
the checksum in this file, which anyone who can edit this tap could change along
with the URL.

So `brew upgrade` will not move Jamgraf, by design. The app will.
