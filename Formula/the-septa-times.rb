class TheSeptaTimes < Formula
  desc "A SEPTA app for the terminal"
  homepage "https://github.com/dotzenith/TheSeptaTimes.rs"
  version "0.9.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/dotzenith/TheSeptaTimes.rs/releases/download/v0.9.3/the-septa-times-aarch64-apple-darwin.tar.xz"
      sha256 "e875d2be66277a8331ada4aaf953136e29689cacacf0bfa998c084abdfe28072"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dotzenith/TheSeptaTimes.rs/releases/download/v0.9.3/the-septa-times-x86_64-apple-darwin.tar.xz"
      sha256 "ab10bd6161889bc57af2e496b182b4b37955d8973816e516ae8f848b0613889e"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/dotzenith/TheSeptaTimes.rs/releases/download/v0.9.3/the-septa-times-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "e50739aa33e0e0b247eaf63da2e78dac87d5565638d8ab2a2be1f9e80536e2c3"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dotzenith/TheSeptaTimes.rs/releases/download/v0.9.3/the-septa-times-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "c8829cfaa204554b11afc4ebe8dff914c1f44d32199ff501985e9b579a5a9696"
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
