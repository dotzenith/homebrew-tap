class Tok < Formula
  desc "A CLI client for tick tick"
  homepage "https://github.com/dotzenith/tok"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/dotzenith/tok/releases/download/v0.1.0/tok-aarch64-apple-darwin.tar.xz"
      sha256 "413fe8ca588a2d33e29025e15353eb1732eaf52d584da3eba84096392e0f983e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dotzenith/tok/releases/download/v0.1.0/tok-x86_64-apple-darwin.tar.xz"
      sha256 "61f074e64f9ecf15af734ed7358fa1fb2cca47ad685f4179fdff4124428a1a3e"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/dotzenith/tok/releases/download/v0.1.0/tok-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "575edc53f1a0b8fc617b530bb8f567d75327dcacf056d894b5542e07c614debe"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dotzenith/tok/releases/download/v0.1.0/tok-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "81fec4e99e8f092d66a28b3999ac73cd2c2e3b98945891c3867fe3eec96635b1"
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
    bin.install "tok" if OS.mac? && Hardware::CPU.arm?
    bin.install "tok" if OS.mac? && Hardware::CPU.intel?
    bin.install "tok" if OS.linux? && Hardware::CPU.arm?
    bin.install "tok" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
