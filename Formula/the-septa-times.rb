class TheSeptaTimes < Formula
  desc "A CLI application for the SEPTA API"
  version "0.5.0"
  on_macos do
    on_arm do
      url "https://github.com/dotzenith/TheSeptaTimes.rs/releases/download/v0.5.0/the-septa-times-aarch64-apple-darwin.tar.xz"
      sha256 "449e6da37eb4a79c37357307ab5464772d6601c36408630048dd30cd046d7cdb"
    end
    on_intel do
      url "https://github.com/dotzenith/TheSeptaTimes.rs/releases/download/v0.5.0/the-septa-times-x86_64-apple-darwin.tar.xz"
      sha256 "18ebea3260f19989434ce809085b867dab364185abd356ec2c0a9dee1279660e"
    end
  end
  on_linux do
    on_intel do
      url "https://github.com/dotzenith/TheSeptaTimes.rs/releases/download/v0.5.0/the-septa-times-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "e4b295a40ad0278c52fa0df47f8c466c515e19916a609b437393479d7b734bd7"
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
