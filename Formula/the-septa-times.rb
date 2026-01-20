class TheSeptaTimes < Formula
  desc "A SEPTA app for the terminal"
  homepage "https://github.com/dotzenith/TheSeptaTimes.rs"
  version "0.12.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/dotzenith/TheSeptaTimes.rs/releases/download/v0.12.1/the-septa-times-aarch64-apple-darwin.tar.xz"
      sha256 "5510d00ea5ed90c2fc7f36d3bd6eeee4f3cda2ad9519c3103c888ee2e385156a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dotzenith/TheSeptaTimes.rs/releases/download/v0.12.1/the-septa-times-x86_64-apple-darwin.tar.xz"
      sha256 "b996d86c664bab6017c3a4418ebc2559304c560d6ed5cf550d6c8460643c67a0"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/dotzenith/TheSeptaTimes.rs/releases/download/v0.12.1/the-septa-times-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "3e6f6fc6d29aadafd541e3cb575b6096f2366e8905e1e691c49948cca87af728"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dotzenith/TheSeptaTimes.rs/releases/download/v0.12.1/the-septa-times-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "fa07d70c4c110a664186f192ad0f08dd8940c118bf08363a305260382d3b3a9c"
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
