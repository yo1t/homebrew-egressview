cask "egressview-agent" do
  version "0.5.137"
  sha256 "acef6914a7db36b75e08abdc2bf26bd0574be71cf758d9d041abf5d09882afbb"

  url "https://dl.egressview.com/macos/egressview-agent-#{version}.pkg"
  name "EgressView Agent"
  desc "Shows which application is talking to where"
  homepage "https://github.com/yo1t/egressview"

  # The manifest every installed agent already polls for updates, so brew and
  # the agent itself cannot disagree about what the current version is.
  livecheck do
    url "https://dl.egressview.com/macos/manifest.json"
    strategy :json do |json|
      json["version"]
    end
  end

  # The agent checks for signed releases itself and offers the installer, so
  # an agent updated that way is not reinstalled by a plain `brew upgrade`.
  auto_updates true
  # Apple silicon only, and macOS 13 or later: the app's own
  # LSMinimumSystemVersion, not a guess.
  depends_on arch: :arm64
  depends_on macos: :ventura

  pkg "egressview-agent-#{version}.pkg"

  uninstall quit:    "com.egressview.agent.macos",
            pkgutil: "com.egressview.agent.macos"

  zap trash: [
    "~/Library/Group Containers/group.com.egressview.agent",
    "~/Library/Preferences/com.egressview.agent.macos.plist",
  ]

  caveats <<~EOS
    EgressView Agent installs a Network Extension to observe outbound
    connections. Before uninstalling, turn it off in
    System Settings > General > Login Items & Extensions > Network Extensions.
    macOS keeps the extension registered otherwise, and the uninstall leaves it
    behind.
  EOS
end
