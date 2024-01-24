class Lovesay < Formula
  desc "lovesay but rusty"
  version "0.5.6"
  on_macos do
    on_arm do
      url "https://github.com/dotzenith/lovesay.rs/releases/download/v0.5.6/lovesay-aarch64-apple-darwin.tar.xz"
      sha256 "4d2e448dfc6c19e53bb2a37d816f1266eb41cb490bbb297b4317264430fb4f46"
    end
    on_intel do
      url "https://github.com/dotzenith/lovesay.rs/releases/download/v0.5.6/lovesay-x86_64-apple-darwin.tar.xz"
      sha256 "f2b66b60767c85697c49eb3850a096a3f5a8b350469ddd0064020949f5c03ed0"
    end
  end
  on_linux do
    on_intel do
      url "https://github.com/dotzenith/lovesay.rs/releases/download/v0.5.6/lovesay-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "8be6f7e62e5fa4cd6c248b2695328c51b2c33a99deadfda52b2073b369a46f23"
    end
  end
  license "MIT"

  def install
    bin.install "lovesay"

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install *leftover_contents unless leftover_contents.empty?
  end
end
