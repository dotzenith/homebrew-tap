class Spotifetch < Formula
  desc "A simple and beautiful fetch tool for spotify, now rusty :) "
  version "0.1.1"
  on_macos do
    on_arm do
      url "https://github.com/dotzenith/SpotiFetch.rs/releases/download/v0.1.1/spotifetch-aarch64-apple-darwin.tar.xz"
      sha256 "5a0aa261f9ac232c2db63b166c4534defca3f401fb8801cce3a527dd00c61969"
    end
    on_intel do
      url "https://github.com/dotzenith/SpotiFetch.rs/releases/download/v0.1.1/spotifetch-x86_64-apple-darwin.tar.xz"
      sha256 "06f412c6846511a5b72b1a77c7786af84194bdd26408f3277519409782456cbd"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/dotzenith/SpotiFetch.rs/releases/download/v0.1.1/spotifetch-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "b8a327115aea365fe565f9c756ad20debebb8f9828f20654133f9c4d0a58ca7b"
    end
    on_intel do
      url "https://github.com/dotzenith/SpotiFetch.rs/releases/download/v0.1.1/spotifetch-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "3081aa18480733221d31e0cbc4f117e6f2d860f4ff3300908e26f319b75dba8f"
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
