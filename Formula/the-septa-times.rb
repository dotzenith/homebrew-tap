class TheSeptaTimes < Formula
  desc "A SEPTA app for the terminal"
  homepage "https://github.com/dotzenith/TheSeptaTimes.rs"
  version "0.9.9"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/dotzenith/TheSeptaTimes.rs/releases/download/v0.9.9/the-septa-times-aarch64-apple-darwin.tar.xz"
      sha256 "8c53612668618795eb0c206c1a605709add90fe30b2abc71fa3a0b5e446ed568"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dotzenith/TheSeptaTimes.rs/releases/download/v0.9.9/the-septa-times-x86_64-apple-darwin.tar.xz"
      sha256 "9901b3a4a5d1b5faa850f88a6814293f3db943e5c72fdcfe9075da5a614c36c5"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/dotzenith/TheSeptaTimes.rs/releases/download/v0.9.9/the-septa-times-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "fc44a5b43d5212d760bd7b8cfedf0d125a3ea8c37340d45bc8c9c2504ae08540"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dotzenith/TheSeptaTimes.rs/releases/download/v0.9.9/the-septa-times-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "5d863b2d63f0a53c093446671f4ce0aad007017ad7bb26bad27d4114fe7a7a29"
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
