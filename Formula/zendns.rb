class Zendns < Formula
  desc "Manage Dynamic DNS with serenity"
  homepage "https://github.com/dotzenith/ZenDNS"
  version "0.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/dotzenith/ZenDNS/releases/download/v0.3.0/zendns-aarch64-apple-darwin.tar.xz"
      sha256 "e0b730d4c6b1dd14aa1efb1c53db4b018bfef16f7d621acf0832b5ebe8daa7ce"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dotzenith/ZenDNS/releases/download/v0.3.0/zendns-x86_64-apple-darwin.tar.xz"
      sha256 "0ebac0d2ac792c23580ab4a42c6697c99d4229d0bc22ce9b638f85aa1048571b"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/dotzenith/ZenDNS/releases/download/v0.3.0/zendns-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "cdf56acd0efc6ee598f2474e8fd48eee6ba88c5d1fb6bf34d6d37852e6261e85"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dotzenith/ZenDNS/releases/download/v0.3.0/zendns-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "add8274e9b67ed80c948f33b5478919f553a7043cb9544cb26701fc4ebbc43b6"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":              {},
    "aarch64-unknown-linux-gnu":         {},
    "x86_64-apple-darwin":               {},
    "x86_64-pc-windows-gnu":             {},
    "x86_64-unknown-linux-gnu":          {},
    "x86_64-unknown-linux-musl-dynamic": {},
    "x86_64-unknown-linux-musl-static":  {},
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
    bin.install "zendns" if OS.mac? && Hardware::CPU.arm?
    bin.install "zendns" if OS.mac? && Hardware::CPU.intel?
    bin.install "zendns" if OS.linux? && Hardware::CPU.arm?
    bin.install "zendns" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
