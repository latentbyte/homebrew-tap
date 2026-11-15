class Lbcat < Formula
  desc "Let coding agents drive your signed-in browser through the LBcat extension"
  homepage "https://github.com/latentbyte/lbcat"
  version "4.35.6"
  license "Apache-2.0"

  depends_on :macos
  depends_on "terminal-notifier"

  on_arm do
    url "https://github.com/latentbyte/lbcat/releases/download/v4.35.6/lbcat-4.35.6-darwin-arm64.tar.gz"
    sha256 "9e452212423d86b5b2c4d57aca9289e10e8ba69f6b8c2b2db1d4dd4820178075"
  end
  on_intel do
    url "https://github.com/latentbyte/lbcat/releases/download/v4.35.6/lbcat-4.35.6-darwin-amd64.tar.gz"
    sha256 "c61333cc49ccfdf4f5742cf2098ed95f2c1fa72875487d90ea5f60b3c113dada"
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
