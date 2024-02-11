class Spotifetch < Formula
  desc "A simple and beautiful fetch tool for spotify, now rusty :) "
  version "0.1.0"
  on_macos do
    on_arm do
      url "https://github.com/dotzenith/SpotiFetch.rs/releases/download/v0.1.0/spotifetch-aarch64-apple-darwin.tar.xz"
      sha256 "bff11093f17e00f68106e328b0684551f8de2bb46ab7c35a98852ac26cafb5eb"
    end
    on_intel do
      url "https://github.com/dotzenith/SpotiFetch.rs/releases/download/v0.1.0/spotifetch-x86_64-apple-darwin.tar.xz"
      sha256 "92db6b3a2affb52db693920f1345852b3775e8be0834b3e9ed03fd77bc323845"
    end
  end
  on_linux do
    on_intel do
      url "https://github.com/dotzenith/SpotiFetch.rs/releases/download/v0.1.0/spotifetch-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "a64c3bff58a292df021766c4bb37ed6ac7ba0d33c990f751941bb1849ef4b0b7"
    end
  end
  license "MIT"

  def install
    bin.install "spotifetch"

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install *leftover_contents unless leftover_contents.empty?
  end
end
