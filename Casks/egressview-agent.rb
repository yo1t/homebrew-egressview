cask "egressview-agent" do
  version "0.5.83"
  sha256 "0d51ef4bdf6167bcfcd6a4dfabcb8704ab60392642f25da9c75def96b5cd23a4"

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
