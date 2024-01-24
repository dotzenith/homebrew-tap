class TheSeptaTimes < Formula
  desc "A CLI application for the SEPTA API"
  version "0.4.2"
  on_macos do
    on_arm do
      url "https://github.com/dotzenith/TheSeptaTimes.rs/releases/download/v0.4.2/the-septa-times-aarch64-apple-darwin.tar.xz"
      sha256 "4f8ee7d7fd33361fbf7e4b191a6e7fb7f541ad78774e01a5a74a5daa22c89bed"
    end
    on_intel do
      url "https://github.com/dotzenith/TheSeptaTimes.rs/releases/download/v0.4.2/the-septa-times-x86_64-apple-darwin.tar.xz"
      sha256 "14a954556122b7d1fa6e7f71532047b9d471a5c9d266551ea0458907c75b81f7"
    end
  end
  on_linux do
    on_intel do
      url "https://github.com/dotzenith/TheSeptaTimes.rs/releases/download/v0.4.2/the-septa-times-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "8ce96d54e1e0654bf52c7a2127ab9fccb04c6c04a0c6a2707444f524c15c3bf1"
    end
  end
  license "MIT"

  def install
    bin.install "tst"

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install *leftover_contents unless leftover_contents.empty?
  end
end
