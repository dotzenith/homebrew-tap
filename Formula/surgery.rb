class Surgery < Formula
  desc "A simple CLI for Real Debrid "
  homepage "https://github.com/dotzenith/surgery"
  version "1.1.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/dotzenith/surgery/releases/download/v1.1.1/surgery-aarch64-apple-darwin.tar.xz"
      sha256 "0d3a84bf17885b28d26bc75e2303c8591be904b03c6ffd80d62a876f8120cbb5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dotzenith/surgery/releases/download/v1.1.1/surgery-x86_64-apple-darwin.tar.xz"
      sha256 "0a23f0b9fdeb528468ae94d4ad5583c575905dabbbdfca9bd2fc63b6bd76a084"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/dotzenith/surgery/releases/download/v1.1.1/surgery-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "6f3b9d533f9e86f463fa48a2b93a77a37c67957a1595373037d6e2095c67b48f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dotzenith/surgery/releases/download/v1.1.1/surgery-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "2fd6400da4cf72ace940ab67a0489c86533f8758a1af4db9eebe3df2497390fc"
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
