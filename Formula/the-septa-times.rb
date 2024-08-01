class TheSeptaTimes < Formula
  desc "A CLI application for the SEPTA API"
  homepage "https://github.com/dotzenith/TheSeptaTimes.rs"
  version "0.6.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/dotzenith/TheSeptaTimes.rs/releases/download/v0.6.2/the-septa-times-aarch64-apple-darwin.tar.xz"
      sha256 "3da2ef031ef806ac7fb8772ec990efc55d47213b931549a7c969d744edb8b152"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dotzenith/TheSeptaTimes.rs/releases/download/v0.6.2/the-septa-times-x86_64-apple-darwin.tar.xz"
      sha256 "831a3c74a49d120c9c2d628f5cccac4a615e6fa3851cc4a5d1d9ea936cc296f3"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/dotzenith/TheSeptaTimes.rs/releases/download/v0.6.2/the-septa-times-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "5959af8a516509e8d8fa1ff27e3e7305dac226181a064fdc0a3bc6063edfa393"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dotzenith/TheSeptaTimes.rs/releases/download/v0.6.2/the-septa-times-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "98232302e1b6cc6ca16e3565e6201b25c234466c434b32ca6f0cb84aa108f6d5"
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
