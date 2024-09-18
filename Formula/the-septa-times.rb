class TheSeptaTimes < Formula
  desc "A CLI application for the SEPTA API"
  homepage "https://github.com/dotzenith/TheSeptaTimes.rs"
  version "0.8.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/dotzenith/TheSeptaTimes.rs/releases/download/v0.8.0/the-septa-times-aarch64-apple-darwin.tar.xz"
      sha256 "d812f09f841e7442c56f94d33c8a5c0590d5afa36b5a4f8d7c7d2277a8ec3241"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dotzenith/TheSeptaTimes.rs/releases/download/v0.8.0/the-septa-times-x86_64-apple-darwin.tar.xz"
      sha256 "b736ce817c4b6128d06bdcf17bb84b5ea70afd7cad27b451ceede3ec7ef4d8d9"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/dotzenith/TheSeptaTimes.rs/releases/download/v0.8.0/the-septa-times-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "b1577814ebc34d4c8ecee8caadfef5754bb6150c39669fdce8c141455174069b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dotzenith/TheSeptaTimes.rs/releases/download/v0.8.0/the-septa-times-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "7a40db4188e572c0f1b5263bc1a7910a9594c27de21b40cae5fa129c53827a86"
    end
  end
  license "MIT"

  BINARY_ALIASES = {"aarch64-apple-darwin": {}, "aarch64-unknown-linux-gnu": {}, "x86_64-apple-darwin": {}, "x86_64-pc-windows-gnu": {}, "x86_64-unknown-linux-gnu": {}, "x86_64-unknown-linux-musl-dynamic": {}, "x86_64-unknown-linux-musl-static": {}}

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
    if OS.mac? && Hardware::CPU.arm?
      bin.install "tst"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "tst"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "tst"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "tst"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
