class TheSeptaTimes < Formula
  desc "A CLI application for the SEPTA API"
  homepage "https://github.com/dotzenith/TheSeptaTimes.rs"
  version "0.5.4"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/dotzenith/TheSeptaTimes.rs/releases/download/v0.5.4/the-septa-times-aarch64-apple-darwin.tar.xz"
      sha256 "d88306cca4d6e4051be5d793ce633323b04b1280492a3e79703d5eaf6a2ef80a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dotzenith/TheSeptaTimes.rs/releases/download/v0.5.4/the-septa-times-x86_64-apple-darwin.tar.xz"
      sha256 "5dd3cf97518a13c1533d7e4479f8fb054fd7c93e1ee43b2d78d64956dd7e1cfd"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/dotzenith/TheSeptaTimes.rs/releases/download/v0.5.4/the-septa-times-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "53f3affa9a7df562d52d6fbd943430000bb027d92fee985d86f3226606b840bc"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dotzenith/TheSeptaTimes.rs/releases/download/v0.5.4/the-septa-times-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "4fa24f0c4cf4a7c1e7dd855e1762c37bd8dc4fa31fc18f7258156d3b2c6b3d47"
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
