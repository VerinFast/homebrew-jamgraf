cask "jamgraf" do
  version "1.1.0"
  sha256 "0000000000000000000000000000000000000000000000000000000000000000"

  url "https://github.com/VerinFast/jamgraf/releases/download/v#{version}/Jamgraf-macos.zip"
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
  auto_updates true
  # The build is arm64-only. Without this an Intel user installs cleanly and gets
  # an app that cannot launch; with it they get told why.
  depends_on arch: :arm64
  depends_on :macos

  app "Jamgraf.app"

  # Everything the app writes. Deliberately NOT in `zap` alone: wikis are the
  # user's documents, so an uninstall leaves them and only `brew uninstall --zap`
  # removes them. The Waikiki paths are the pre-rename install (the old data
  # folder is left as a symlink to the new one on first launch).
  zap trash: [
    "~/Library/Application Support/Jamgraf",
    "~/Library/Application Support/Waikiki",
    "~/Library/Saved Application State/com.verinfast.jamgraf.savedState",
    "~/Library/Saved Application State/com.waikiki.app.savedState",
  ]

  # Not notarized yet (VerinFast/jamgraf#66). Homebrew quarantines casks, and
  # current Homebrew has no --no-quarantine; since macOS 15, right-click → Open
  # no longer gets past Gatekeeper either. Remove this when notarization lands.
  caveats <<~EOS
    Jamgraf is not notarized yet, so macOS will block the first launch.
    After the first attempt, open System Settings → Privacy & Security and
    click "Open Anyway" next to Jamgraf, once. Or, from a terminal:
      xattr -dr com.apple.quarantine "#{appdir}/Jamgraf.app"
  EOS
end
