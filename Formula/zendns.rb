class Zendns < Formula
  desc "Manage Dynamic DNS with serenity"
  homepage "https://github.com/dotzenith/ZenDNS"
  version "0.1.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/dotzenith/ZenDNS/releases/download/v0.1.2/zendns-aarch64-apple-darwin.tar.xz"
      sha256 "f8256ef5ed5e9ea2b94e8bfef9aa2017235f9929d681a689f85e5c641eeff2cb"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dotzenith/ZenDNS/releases/download/v0.1.2/zendns-x86_64-apple-darwin.tar.xz"
      sha256 "b4835ca40d1833b5975391a87eb9030f440073cfb9af9b904bb3088fb1d4fe88"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/dotzenith/ZenDNS/releases/download/v0.1.2/zendns-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "b1d28e2fd6a3419dc1f0e6b22e740c935f17937ea76d1f0fee76d2e8e8411e3e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dotzenith/ZenDNS/releases/download/v0.1.2/zendns-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "163b8af3471c823dadb7ea23dccd201a4edee6e1adfbc5253a4654ff547d655b"
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
