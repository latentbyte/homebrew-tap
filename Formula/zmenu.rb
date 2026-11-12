class Zmenu < Formula
  desc "Fast native fuzzy menu for macOS, a dmenu alternative"
  homepage "https://latentbyte.com/products/zmenu"
  url "https://github.com/hamidzr/zmenu/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "84a736ed64f2ee249ffc5b60c12157410cef2b95c91231287a3d9da62fe40a64"
  license "MIT"
  head "https://github.com/hamidzr/zmenu.git", branch: "main"

  depends_on "zig" => :build
  depends_on :macos

  def install
    system "zig", "build", *std_zig_args
  end

  test do
    assert_match "ipc-protocol", shell_output("#{bin}/zmenu --version")
    assert_path_exists bin/"zmenuctl"
  end
end
