class Zendns < Formula
  desc "Manage Dynamic DNS with serenity"
  homepage "https://github.com/dotzenith/ZenDNS"
  version "1.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/dotzenith/ZenDNS/releases/download/v1.1.0/zendns-aarch64-apple-darwin.tar.xz"
      sha256 "d5420c488f6f12d616a93be551b5476186ff0d72c96900f2dff3c86fe700b2fc"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dotzenith/ZenDNS/releases/download/v1.1.0/zendns-x86_64-apple-darwin.tar.xz"
      sha256 "0f7201794da9af6a772f63582e8814dc51b00cb0f3422a33f7cdec392b5ab291"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/dotzenith/ZenDNS/releases/download/v1.1.0/zendns-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "9de3f115de4b0309c0ff99fc08cc5c9007a2d7b99d171c44cf0c46746ed1fc4e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dotzenith/ZenDNS/releases/download/v1.1.0/zendns-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "851a8b007c443efdbd1a4fbff6efa4976fa7d274677aec172486e61bb0766a1a"
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
