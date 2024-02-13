class TheSeptaTimes < Formula
  desc "A CLI application for the SEPTA API"
  version "0.5.2"
  on_macos do
    on_arm do
      url "https://github.com/dotzenith/TheSeptaTimes.rs/releases/download/v0.5.2/the-septa-times-aarch64-apple-darwin.tar.xz"
      sha256 "ebf0f4c7ad5dcc348f7a69d2a768defb13c9a1d42116fcd320286a66cefe0813"
    end
    on_intel do
      url "https://github.com/dotzenith/TheSeptaTimes.rs/releases/download/v0.5.2/the-septa-times-x86_64-apple-darwin.tar.xz"
      sha256 "393d2a17b9a10993bd9865a781d28a6e16a7dfb37616db5d8c36647071130413"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/dotzenith/TheSeptaTimes.rs/releases/download/v0.5.2/the-septa-times-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "b2c31c525aab376a5ef9e439a9b4c710827e629c0618b3705c1bd8ecd768bb04"
    end
    on_intel do
      url "https://github.com/dotzenith/TheSeptaTimes.rs/releases/download/v0.5.2/the-septa-times-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "ddc2cc869c95bce20583d1a400494db802215c0ac3fb81d0aa66fd39ed046339"
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
