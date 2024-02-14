class Spotifetch < Formula
  desc "A simple and beautiful fetch tool for spotify, now rusty :) "
  version "0.1.3"
  on_macos do
    on_arm do
      url "https://github.com/dotzenith/SpotiFetch.rs/releases/download/v0.1.3/spotifetch-aarch64-apple-darwin.tar.xz"
      sha256 "db84497c58682287c8d428acf6efca03ea5d5d19720a75f7a840544948eb81a8"
    end
    on_intel do
      url "https://github.com/dotzenith/SpotiFetch.rs/releases/download/v0.1.3/spotifetch-x86_64-apple-darwin.tar.xz"
      sha256 "d09f78afa3f5d499a885d0d1fa355db8696fecb555a872399c70cd99bb4131bf"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/dotzenith/SpotiFetch.rs/releases/download/v0.1.3/spotifetch-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "81f779e9599ba86a8f49942caf2083521484e8bea244332d10e002fdb4cbe6f2"
    end
    on_intel do
      url "https://github.com/dotzenith/SpotiFetch.rs/releases/download/v0.1.3/spotifetch-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "37a8d5f468c2a5d2e3f7f291f8d46c881314f11d6ba5df26c78af8ae3cc8346a"
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
