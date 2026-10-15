cask "jamgraf" do
  # Filled in by `scripts/release.sh` in VerinFast/jamgraf when v1.1.0 is cut —
  # run it with this tap checked out on this branch and it sets both lines.
  version "1.1.0"
  sha256 "0000000000000000000000000000000000000000000000000000000000000000"

  url "https://github.com/VerinFast/jamgraf/releases/download/v#{version}/Jamgraf-macos.zip",
      verified: "github.com/VerinFast/jamgraf/"
  name "Jamgraf"
  desc "Local wiki for human and LLM collaboration, with an MCP server"
  homepage "https://github.com/VerinFast/jamgraf"

  livecheck do
    url :url
    strategy :github_latest
  end

  # Jamgraf updates itself: each release is Ed25519-verified against a key
  # pinned into the build before it is installed, which is a stronger guarantee
  # than a checksum in this file — whoever can edit this cask can change the URL
  # and the sha256 together, and the pinned key still refuses a bundle we did not
  # sign. So Homebrew installs it and then leaves it alone; `brew upgrade` skips
  # it deliberately.
  #
  # That is also why the rename from Waikiki needs nothing from Homebrew beyond
  # cask_renames.json: an installed copy updates itself across the rename and
  # renames its own bundle on first launch (leaving Waikiki.app as a symlink),
  # and Homebrew's migration only moves its install record — never the app.
  auto_updates true

  # The build is arm64-only. Without this an Intel user installs cleanly and gets
  # an app that cannot launch; with it they get told why.
  depends_on arch: :arm64
  depends_on macos: :big_sur

  app "Jamgraf.app"

  # Not notarized yet (VerinFast/jamgraf#66 — the Apple Developer portal is
  # unavailable). Homebrew quarantines casks by default, so without this the
  # first launch hits Gatekeeper. Remove this caveat when notarization lands.
  caveats <<~EOS
    Jamgraf is not notarized yet, so macOS will refuse the first launch.
    Either reinstall with:
      brew install --cask jamgraf --no-quarantine
    or right-click Jamgraf in Applications and choose Open, once.

    Jamgraf was called Waikiki. Upgrading needs nothing: your wikis, your Kahala
    sign-in and the app itself move to the new name the first time it opens.
  EOS

  # Everything the app writes, under both names: Jamgraf was Waikiki, and an
  # install from before the rename left its own set. Deliberately NOT in `zap`
  # alone: wikis are the user's documents, so an uninstall leaves them and only
  # `brew uninstall --zap` removes them. The bundle ids are the real ones —
  # this list used to name `com.waikiki.app`, which never matched anything.
  zap trash: [
    "/Applications/Waikiki.app",
    "~/Library/Application Support/Jamgraf",
    "~/Library/Application Support/Waikiki",
    "~/Library/Caches/com.verinfast.jamgraf",
    "~/Library/Caches/com.verinfast.waikiki",
    "~/Library/HTTPStorages/com.verinfast.jamgraf",
    "~/Library/HTTPStorages/com.verinfast.jamgraf.binarycookies",
    "~/Library/HTTPStorages/com.verinfast.waikiki",
    "~/Library/HTTPStorages/com.verinfast.waikiki.binarycookies",
    "~/Library/Preferences/com.verinfast.jamgraf.plist",
    "~/Library/Preferences/com.verinfast.waikiki.plist",
    "~/Library/Saved Application State/com.verinfast.jamgraf.savedState",
    "~/Library/Saved Application State/com.verinfast.waikiki.savedState",
    "~/Library/WebKit/com.verinfast.jamgraf",
    "~/Library/WebKit/com.verinfast.waikiki",
  ]
end
