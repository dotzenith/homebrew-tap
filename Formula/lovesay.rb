class Lovesay < Formula
  desc "lovesay but rusty"
  version "0.5.7"
  on_macos do
    on_arm do
      url "https://github.com/dotzenith/lovesay.rs/releases/download/v0.5.7/lovesay-aarch64-apple-darwin.tar.xz"
      sha256 "b7f11bd27908aec42cba58f1f78dbe8b70dae5dcddaca3c41d403b1ca083dd6f"
    end
    on_intel do
      url "https://github.com/dotzenith/lovesay.rs/releases/download/v0.5.7/lovesay-x86_64-apple-darwin.tar.xz"
      sha256 "9aa40951f5ef84ed83ca2dfbdc9f07ed0d81434962d423df3413835fc8b9e437"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/dotzenith/lovesay.rs/releases/download/v0.5.7/lovesay-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "88f2cc47ea9bdc47ac58e134ad44d369119ff1cfcbd4296f0b481922cf83f677"
    end
    on_intel do
      url "https://github.com/dotzenith/lovesay.rs/releases/download/v0.5.7/lovesay-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "7cd49a5f23f240c4cfe9b43e8a8158f39826352905f0ecae1bcf9b696ae2eb3f"
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
