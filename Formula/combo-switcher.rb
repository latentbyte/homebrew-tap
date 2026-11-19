class ComboSwitcher < Formula
  desc "Keyboard launcher and switcher for macOS apps, windows, tabs and tmux"
  homepage "https://latentbyte.com/products/combo-switcher"
  url "https://github.com/latentbyte/homebrew-tap/releases/download/combo-switcher-v0.1.0/combo-switcher-0.1.0-darwin-arm64.tar.gz"
  version "0.1.0"
  sha256 "78388cfb5a5eef5c040aca97aacca165ee29ff3f9e6a920967267b010b5e8888"

  depends_on arch: :arm64
  depends_on :macos

  # bundles its own zmenu build
  conflicts_with "zmenu", because: "both install a zmenu binary"

  def install
    bin.install "combo-switcher", "cs-cli", "zmenu"
  end

  service do
    run [opt_bin/"combo-switcher", "--daemon"]
    # launchd has no shell PATH; this one finds zmenu, AeroSpace, yabai and tmux
    environment_variables PATH: std_service_path_env
    keep_alive true
    log_path var/"log/combo-switcher.log"
    error_log_path var/"log/combo-switcher.log"
  end

  def caveats
    <<~EOS
      Start the daemon now and at login:
        brew services start combo-switcher

      combo-switcher has no hotkey of its own. Bind one to:
        #{opt_bin}/cs-cli toggle
      with skhd, AeroSpace, Hammerspoon or a macOS Shortcut.

      Check your setup:
        combo-switcher doctor
    EOS
  end

  test do
    assert_match "combo-switcher", shell_output("#{bin}/combo-switcher version")
    assert_path_exists bin/"zmenu"
  end
end
