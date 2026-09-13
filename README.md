# EgressView Homebrew tap

`EgressView Agent for Mac` — shows which application on this Mac is talking to
where, on the Mac itself. No router required.

```sh
brew trust yo1t/egressview
brew tap yo1t/egressview
brew install --cask egressview-agent
```

`brew trust` is Homebrew's own step, not ours: it refuses to load a cask from
a tap outside homebrew-core until you say you trust it, and it records that in
`~/.homebrew/trust.json`. Nothing here can skip it, and you should not let
anything skip it for you.

Apple silicon, macOS 13 or later. The package is signed with a Developer ID
certificate and notarised by Apple.

## Before uninstalling

The agent installs a Network Extension. Turn it off first in **System Settings
→ General → Login Items & Extensions → Network Extensions**, otherwise macOS
keeps the extension registered and the uninstall leaves it behind.

```sh
brew uninstall --cask egressview-agent
brew uninstall --zap --cask egressview-agent   # also removes the local history
```

`--zap` deletes the local database of observed connections. That history never
leaves the Mac unless you send it to a Hub you run yourself.

## What this installs

- The source, the Hub, and the issue tracker: <https://github.com/yo1t/egressview>
- The packages this tap downloads: <https://dl.egressview.com>
- Licence: AGPL-3.0
