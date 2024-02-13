class TheSeptaTimes < Formula
  desc "A CLI application for the SEPTA API"
  version "0.5.1"
  on_macos do
    on_arm do
      url "https://github.com/dotzenith/TheSeptaTimes.rs/releases/download/v0.5.1/the-septa-times-aarch64-apple-darwin.tar.xz"
      sha256 "383f486a50d7882890d6df290ae6f7b915b1b4a349148912decb7de832d9cae4"
    end
    on_intel do
      url "https://github.com/dotzenith/TheSeptaTimes.rs/releases/download/v0.5.1/the-septa-times-x86_64-apple-darwin.tar.xz"
      sha256 "89e95735f78cc8227724ace5adb9a6d278051a4eb6348369c1ec89aff80f7afc"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/dotzenith/TheSeptaTimes.rs/releases/download/v0.5.1/the-septa-times-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "bd4a967dfe0a918787ed1ba81344dd1c422116d04717b97d84ba65cf6044ddd9"
    end
    on_intel do
      url "https://github.com/dotzenith/TheSeptaTimes.rs/releases/download/v0.5.1/the-septa-times-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "39ed570b9b5c67805995aab2b23fbe40c476c41a07c1f22d27f56d973ad6adc4"
    end
  end
  license "MIT"

  def install
    on_macos do
      on_arm do
        bin.install "tst"
      end
    end
    on_macos do
      on_intel do
        bin.install "tst"
      end
    end
    on_linux do
      on_arm do
        bin.install "tst"
      end
    end
    on_linux do
      on_intel do
        bin.install "tst"
      end
    end

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install *leftover_contents unless leftover_contents.empty?
  end
end
