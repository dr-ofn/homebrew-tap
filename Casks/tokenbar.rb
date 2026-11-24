cask "tokenbar" do
  version "9.0.5"
  sha256 "fbed82384954663735e8fafca2842d8eaeec4f2862dca6242f3364d229f76602"

  url "https://github.com/dr-ofn/TokenBar/releases/download/v#{version}/TokenBar-#{version}.zip"
  name "TokenBar"
  desc "Menu bar app that counts AI coding tool token usage from local logs"
  homepage "https://github.com/dr-ofn/TokenBar"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :sonoma
  # Releases are universal (scripts/release.sh VERSION --universal): arm64 and x86_64.

  app "TokenBar.app"

  zap trash: [
    "~/Library/Application Support/TokenBar",
    "~/Library/Caches/TokenBar",
    "~/Library/Preferences/io.github.tokenbar.plist",
  ]

  caveats <<~EOS
    TokenBar is not signed with an Apple Developer ID and is not notarized, so
    macOS Gatekeeper blocks it the first time you open it. Homebrew no longer
    offers a flag to skip this (--no-quarantine was deprecated in 5.0.0).

    To open it once:
      1. Open TokenBar and dismiss the warning.
      2. System Settings > Privacy & Security, scroll down, click "Open Anyway",
         then confirm with "Open".

    Or, if you trust the source, clear the download flag from Terminal:
      xattr -dr com.apple.quarantine /Applications/TokenBar.app

    More: https://support.apple.com/en-us/102445
  EOS
end
