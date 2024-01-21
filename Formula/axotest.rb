class Axotest < Formula
  desc "testing out cargo dist"
  version "0.1.0"
  on_macos do
    on_arm do
      url "https://github.com/dotzenith/axotest/releases/download/v0.1.0/axotest-aarch64-apple-darwin.tar.xz"
      sha256 "5a76377703086e04f38469be9a794b2487847a09c645bb538cf23d19cca77a88"
    end
    on_intel do
      url "https://github.com/dotzenith/axotest/releases/download/v0.1.0/axotest-x86_64-apple-darwin.tar.xz"
      sha256 "143df5fe1a6b71c129accdcd98ecae9d6e2d4bc4adab74f881468aa087ffcb34"
    end
  end
  on_linux do
    on_intel do
      url "https://github.com/dotzenith/axotest/releases/download/v0.1.0/axotest-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "406d0f96ba392bb002f0849d22dd1fb58f36b0a4ba85a8cda9e48e57432bbf75"
    end
  end
  license "MIT"

  def install
    bin.install "axotest"

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install *leftover_contents unless leftover_contents.empty?
  end
end
