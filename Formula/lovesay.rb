class Lovesay < Formula
  desc "lovesay but rusty"
  version "0.5.5"
  on_macos do
    on_arm do
      url "https://github.com/dotzenith/lovesay.rs/releases/download/v0.5.5/lovesay-aarch64-apple-darwin.tar.xz"
      sha256 "3b68acace5ef295ab10d6e5803f5b01cb431274dc9493d17d963b93600a82aba"
    end
    on_intel do
      url "https://github.com/dotzenith/lovesay.rs/releases/download/v0.5.5/lovesay-x86_64-apple-darwin.tar.xz"
      sha256 "7acd60c42a758a2f931d45de6ecd1dc423c658efef8cc9aca5f707d4abd48110"
    end
  end
  on_linux do
    on_intel do
      url "https://github.com/dotzenith/lovesay.rs/releases/download/v0.5.5/lovesay-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "d6d2e41171f4541038b2d441ec37a58d38e88f31b5f6c612a3358d7b1378b792"
    end
  end
  license "MIT"

  def install
    bin.install "lovesay"

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install *leftover_contents unless leftover_contents.empty?
  end
end
