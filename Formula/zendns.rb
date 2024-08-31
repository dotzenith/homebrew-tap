class Zendns < Formula
  desc "Manage Dynamic DNS with serenity"
  homepage "https://github.com/dotzenith/ZenDNS"
  version "0.1.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/dotzenith/ZenDNS/releases/download/v0.1.1/zendns-aarch64-apple-darwin.tar.xz"
      sha256 "02cb0a6304fdccb4fe2c5268aac250d7957a07d2f5263b1df45729735a4a9f41"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dotzenith/ZenDNS/releases/download/v0.1.1/zendns-x86_64-apple-darwin.tar.xz"
      sha256 "d0771993317030876f7dbeab7225bb6a114d5ee3e5aac0a789134c10e89cef67"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/dotzenith/ZenDNS/releases/download/v0.1.1/zendns-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "d1dad29e7801e79876adac8b820a78bed485ed871afc371548483a4d83d0bd05"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dotzenith/ZenDNS/releases/download/v0.1.1/zendns-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "616b1a73b2284793c7770b53e39a2c6b54a3396dad3b3a2a2cc25c47726f0a66"
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
      bin.install "zendns"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "zendns"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "zendns"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "zendns"
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
