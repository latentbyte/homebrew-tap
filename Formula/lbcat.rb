class Lbcat < Formula
  desc "Let coding agents drive your signed-in browser through the LBcat extension"
  homepage "https://github.com/latentbyte/lbcat"
  version "4.35.4"
  license "Apache-2.0"

  depends_on :macos
  depends_on "terminal-notifier"

  on_arm do
    url "https://github.com/latentbyte/lbcat/releases/download/v4.35.4/lbcat-4.35.4-darwin-arm64.tar.gz"
    sha256 "d2508f08e761793b7f0d38905be2d8db184b4dd1e899835a2d9f06fc0908b729"
  end
  on_intel do
    url "https://github.com/latentbyte/lbcat/releases/download/v4.35.4/lbcat-4.35.4-darwin-amd64.tar.gz"
    sha256 "c44a8e9d30f794189e5e2f018c433bcdd443e337ec571188dbd20ef8cf564d7b"
  end

  def install
    bin.install "browser-control", "browser-control-daemon", "lbcat-shim"
    bin.install_symlink "browser-control" => "bctl"
    pkgshare.install "skills"
  end

  def caveats
    <<~EOS
      Register the Native Messaging host for your browsers, then restart them:
        #{HOMEBREW_PREFIX}/bin/browser-control install
      For an unpacked LBcat build in a Chromium browser, add its ID from chrome://extensions:
        #{HOMEBREW_PREFIX}/bin/browser-control install --extension-id <id>

      Install the LBcat extension: https://github.com/latentbyte/lbcat#install

      Agent skill for coding agents:
        #{opt_pkgshare}/skills/browser-control
    EOS
  end

  test do
    assert_match "agent-window", shell_output("#{bin}/browser-control --help")
    assert_path_exists bin/"lbcat-shim"
  end
end
