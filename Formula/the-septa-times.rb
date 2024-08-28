class TheSeptaTimes < Formula
  desc "A CLI application for the SEPTA API"
  homepage "https://github.com/dotzenith/TheSeptaTimes.rs"
  version "0.7.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/dotzenith/TheSeptaTimes.rs/releases/download/v0.7.0/the-septa-times-aarch64-apple-darwin.tar.xz"
      sha256 "f4696baf89dc4fc6634cef55c22401b83b1df8b63e8e9a656fce50fd7cce16b5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dotzenith/TheSeptaTimes.rs/releases/download/v0.7.0/the-septa-times-x86_64-apple-darwin.tar.xz"
      sha256 "55f97f38ebcfde4fe4628457d684b7cfe09a28f9d45e0f1638fd59c22d33e20c"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/dotzenith/TheSeptaTimes.rs/releases/download/v0.7.0/the-septa-times-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "195e2891aa6b6f48d2b1a28e5a51a136c47dbccbb1b135112e0bef13e4299bab"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dotzenith/TheSeptaTimes.rs/releases/download/v0.7.0/the-septa-times-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "d4e10783a5958e5a124bab4e7141ab5977fdb8d6cf269a5d4300bbc725a28b3a"
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
