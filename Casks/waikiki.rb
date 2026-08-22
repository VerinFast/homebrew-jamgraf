cask "waikiki" do
  version "1.0.1"
  sha256 "43a1b10819a8e5c640a270be8f81a31354ed0a37b90f709442244268d13b3c06"

  url "https://github.com/VerinFast/waikiki/releases/download/v#{version}/Waikiki-macos.zip",
      verified: "github.com/VerinFast/waikiki/"
  name "Waikiki"
  desc "Local wiki for human and LLM collaboration, with an MCP server"
  homepage "https://github.com/VerinFast/waikiki"

  livecheck do
    url :url
    strategy :github_latest
  end

  # Waikiki updates itself: each release is Ed25519-verified against a key
  # pinned into the build before it is installed, which is a stronger guarantee
  # than a checksum in this file — whoever can edit this cask can change the URL
  # and the sha256 together, and the pinned key still refuses a bundle we did not
  # sign. So Homebrew installs it and then leaves it alone; `brew upgrade` skips
  # it deliberately.
  auto_updates true

  # The build is arm64-only. Without this an Intel user installs cleanly and gets
  # an app that cannot launch; with it they get told why.
  depends_on arch: :arm64
  depends_on macos: :big_sur

  app "Waikiki.app"

  # Not notarized yet (VerinFast/waikiki#66 — the Apple Developer portal is
  # unavailable). Homebrew quarantines casks by default, so without this the
  # first launch hits Gatekeeper. Remove this caveat when notarization lands.
  caveats <<~EOS
    Waikiki is not notarized yet, so macOS will refuse the first launch.
    Either reinstall with:
      brew install --cask waikiki --no-quarantine
    or right-click Waikiki in Applications and choose Open, once.
  EOS

  # Everything the app writes. Deliberately NOT in `zap` alone: wikis are the
  # user's documents, so an uninstall leaves them and only `brew uninstall --zap`
  # removes them.
  zap trash: [
    "~/Library/Application Support/Waikiki",
    "~/Library/Saved Application State/com.waikiki.app.savedState",
  ]
end
