class Surgery < Formula
  desc "A simple CLI for Real Debrid "
  homepage "https://github.com/dotzenith/surgery"
  version "1.2.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/dotzenith/surgery/releases/download/v1.2.1/surgery-aarch64-apple-darwin.tar.xz"
      sha256 "9e66504ad846d929c73f64686c8908ab2d49979fc0c130a73e39c0e5fac5b9d9"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dotzenith/surgery/releases/download/v1.2.1/surgery-x86_64-apple-darwin.tar.xz"
      sha256 "9e5068d8c7015e9c5f93d00b1406f771d04b7b2c9a42a70e02b5d55192d2fb8a"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/dotzenith/surgery/releases/download/v1.2.1/surgery-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "1169d849b8a1c200c5265bebd3e1aa24b67207c37fd7962856348dc83479bbcb"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dotzenith/surgery/releases/download/v1.2.1/surgery-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "e50f69a92f69a1fb3307f7f18aa989b0422f6d3db8fb019eb9fd7df53943c29c"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    bin.install "srg" if OS.mac? && Hardware::CPU.arm?
    bin.install "srg" if OS.mac? && Hardware::CPU.intel?
    bin.install "srg" if OS.linux? && Hardware::CPU.arm?
    bin.install "srg" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
