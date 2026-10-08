# version and sha256 are rewritten by scripts/release.sh in Babissimo/ratchet on every release.
cask "ratchet" do
  version "1.0.0"
  sha256 "c0a183d64840ad1aaccb9e98f26d3cf55e825f1900a7b3483ef0d57d44ab9ed3"

  url "https://github.com/Babissimo/ratchet/releases/download/v#{version}/Ratchet.app.zip"
  name "Ratchet"
  desc "Menu-bar time tracker for FreeAgent"
  homepage "https://ratchet.babissimo.net/"

  depends_on macos: :ventura

  app "Ratchet.app"

  # Ratchet isn't notarised, so Gatekeeper would refuse to open the quarantined download.
  postflight_steps do
    run "/usr/bin/xattr",
        args:           ["-dr", "com.apple.quarantine", "{{appdir}}/Ratchet.app"],
        writable_paths: ["{{appdir}}/Ratchet.app"]
  end

  uninstall quit: "com.ratchet.app"

  zap trash: [
    "~/Library/Caches/com.ratchet.app",
    "~/Library/HTTPStorages/com.ratchet.app",
    "~/Library/Preferences/com.ratchet.app.plist",
  ]
end
