class TheSeptaTimes < Formula
  desc "A SEPTA app for the terminal"
  homepage "https://github.com/dotzenith/TheSeptaTimes.rs"
  version "0.11.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/dotzenith/TheSeptaTimes.rs/releases/download/v0.11.1/the-septa-times-aarch64-apple-darwin.tar.xz"
      sha256 "2d6206cc1170ece88e179ae3979a4c3a0bc7a0d5e0c4f7922d3c4a4b5dbb43e8"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dotzenith/TheSeptaTimes.rs/releases/download/v0.11.1/the-septa-times-x86_64-apple-darwin.tar.xz"
      sha256 "c84450fabee3dd7c3509fa58e4b7f53a258b152bbdfadda05e30cad7b37e6522"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/dotzenith/TheSeptaTimes.rs/releases/download/v0.11.1/the-septa-times-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "bc8e5e0b4b8c99686005b115a51e477a02365dff29859486b59fd90cbe1d6549"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dotzenith/TheSeptaTimes.rs/releases/download/v0.11.1/the-septa-times-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "352f6d2e67e19cb805644ff126263f4abccd0fb32eb4fb9e7e4a96fe99d46ecf"
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
    bin.install "tst" if OS.mac? && Hardware::CPU.arm?
    bin.install "tst" if OS.mac? && Hardware::CPU.intel?
    bin.install "tst" if OS.linux? && Hardware::CPU.arm?
    bin.install "tst" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
