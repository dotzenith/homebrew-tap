class Zendns < Formula
  desc "Manage Dynamic DNS with serenity"
  homepage "https://github.com/dotzenith/ZenDNS"
  version "1.0.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/dotzenith/ZenDNS/releases/download/v1.0.3/zendns-aarch64-apple-darwin.tar.xz"
      sha256 "3217602f380d69fca6ee6f9c39dc90c83c2cc080858e7f4144dc35ba38ee8048"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dotzenith/ZenDNS/releases/download/v1.0.3/zendns-x86_64-apple-darwin.tar.xz"
      sha256 "52c2c1731835bb4b6cb9e71e25d843823e8e92ca9101b357c4a8d0ac5fc9a8e4"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/dotzenith/ZenDNS/releases/download/v1.0.3/zendns-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "1da9723e151cf64dd3cd0a72a37b9220bdfdefc4fa43faa1d8ad6d623be22035"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dotzenith/ZenDNS/releases/download/v1.0.3/zendns-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "654095ff3e23673e4a135eb0e958e3fb82ebff6ac374992e572f3a277d923aeb"
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
