class Lbcat < Formula
  desc "Let coding agents drive your signed-in browser through the LBcat extension"
  homepage "https://github.com/latentbyte/lbcat"
  version "4.32.7"
  license "Apache-2.0"

  depends_on :macos
  depends_on "terminal-notifier"

  on_arm do
    url "https://github.com/latentbyte/lbcat/releases/download/v4.32.7/lbcat-4.32.7-darwin-arm64.tar.gz"
    sha256 "0347d80891073211c7ffba5bbe93352aeed6cd1cc6324c85bd804b2436b07b37"
  end
  on_intel do
    url "https://github.com/latentbyte/lbcat/releases/download/v4.32.7/lbcat-4.32.7-darwin-amd64.tar.gz"
    sha256 "94ba5893a3a4898e7a445d0b61a5df46be5a4de00739bbc89524a5f997b8d128"
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
