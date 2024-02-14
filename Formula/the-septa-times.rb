class TheSeptaTimes < Formula
  desc "A CLI application for the SEPTA API"
  version "0.5.3"
  on_macos do
    on_arm do
      url "https://github.com/dotzenith/TheSeptaTimes.rs/releases/download/v0.5.3/the-septa-times-aarch64-apple-darwin.tar.xz"
      sha256 "6f8271e15b10c2a8d5c5b697c06a284e91302d9a9698988649c83af86c288e7b"
    end
    on_intel do
      url "https://github.com/dotzenith/TheSeptaTimes.rs/releases/download/v0.5.3/the-septa-times-x86_64-apple-darwin.tar.xz"
      sha256 "1a355d1a7b2e30e2222e7341a910aa78c3db6a06bd3cc5d63ea01434675fefb6"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/dotzenith/TheSeptaTimes.rs/releases/download/v0.5.3/the-septa-times-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "04c4e7e937ea8516ba1ef549715d8d623b0d5f13c4995b0c977ccae448daa532"
    end
    on_intel do
      url "https://github.com/dotzenith/TheSeptaTimes.rs/releases/download/v0.5.3/the-septa-times-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "959b5d769ab08e33a303e94ce44662332a0c856ad7bf8074d814f3934e60dfd3"
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
