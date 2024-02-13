class Spotifetch < Formula
  desc "A simple and beautiful fetch tool for spotify, now rusty :) "
  version "0.1.2"
  on_macos do
    on_arm do
      url "https://github.com/dotzenith/SpotiFetch.rs/releases/download/v0.1.2/spotifetch-aarch64-apple-darwin.tar.xz"
      sha256 "45911ed0959750d656bff62fdf49c45c0c291eb554fa11d13c185246723d7fcb"
    end
    on_intel do
      url "https://github.com/dotzenith/SpotiFetch.rs/releases/download/v0.1.2/spotifetch-x86_64-apple-darwin.tar.xz"
      sha256 "be4a1238dea2e97e8c00a464d3e9d5a072614b3d5fe80a4da2b6e1c80a20c460"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/dotzenith/SpotiFetch.rs/releases/download/v0.1.2/spotifetch-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "1fcfa3716a03a40f36e192043ac5f0fd5e18d6bcef471f69c81d627fcd82b2a7"
    end
    on_intel do
      url "https://github.com/dotzenith/SpotiFetch.rs/releases/download/v0.1.2/spotifetch-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "bfc6b68c094e96a496990fb5bdbdd319eb8d6b3fa350f653c85fc82dcc74c500"
    end
  end
  license "MIT"

  def install
    on_macos do
      on_arm do
        bin.install "spotifetch"
      end
    end
    on_macos do
      on_intel do
        bin.install "spotifetch"
      end
    end
    on_linux do
      on_arm do
        bin.install "spotifetch"
      end
    end
    on_linux do
      on_intel do
        bin.install "spotifetch"
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
