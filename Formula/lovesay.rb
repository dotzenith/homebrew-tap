class Lovesay < Formula
  desc "lovesay but rusty"
  version "0.6.0"
  on_macos do
    on_arm do
      url "https://github.com/dotzenith/lovesay.rs/releases/download/v0.6.0/lovesay-aarch64-apple-darwin.tar.xz"
      sha256 "7163aef5706bb4950c15d0b450384156be58ebfb4018d04b6bc6e0afb73e5f8c"
    end
    on_intel do
      url "https://github.com/dotzenith/lovesay.rs/releases/download/v0.6.0/lovesay-x86_64-apple-darwin.tar.xz"
      sha256 "c06481f0492743bf08093a6f05531e145479ce1b6ff6de6d9d94d3e12db96551"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/dotzenith/lovesay.rs/releases/download/v0.6.0/lovesay-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "122d5f9eae282dd31c83db490ffdd6b382ad6f7d33a89fdaf64f50b41e67b06a"
    end
    on_intel do
      url "https://github.com/dotzenith/lovesay.rs/releases/download/v0.6.0/lovesay-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "a26c1396b7d7020c28fcd33314bde27ac56d012b3fe62381a6f07cba105ab2f0"
    end
  end
  license "MIT"

  def install
    on_macos do
      on_arm do
        bin.install "lovesay"
      end
    end
    on_macos do
      on_intel do
        bin.install "lovesay"
      end
    end
    on_linux do
      on_arm do
        bin.install "lovesay"
      end
    end
    on_linux do
      on_intel do
        bin.install "lovesay"
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
