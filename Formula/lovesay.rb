class Lovesay < Formula
  desc "lovesay but rusty"
  homepage "https://github.com/dotzenith/lovesay.rs"
  version "1.0.8"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/dotzenith/lovesay.rs/releases/download/v1.0.8/lovesay-aarch64-apple-darwin.tar.xz"
      sha256 "ddc5985a958501f39a89720fec82673b92ec240d9c18fad47886b8da4f522712"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dotzenith/lovesay.rs/releases/download/v1.0.8/lovesay-x86_64-apple-darwin.tar.xz"
      sha256 "214cd3d1de41d3a72771ed7a8ed8736609e18eaf4451f134475278ce46321974"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/dotzenith/lovesay.rs/releases/download/v1.0.8/lovesay-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "9f60d688919568d8c866ebffc6832254f177a9af1c8a701fb6ce39f852acf08d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dotzenith/lovesay.rs/releases/download/v1.0.8/lovesay-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "de2bae95c80e1ebf4ec3994c420a3a99722ecae2524bce0b560e5c2f864a0614"
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
    bin.install "lovesay" if OS.mac? && Hardware::CPU.arm?
    bin.install "lovesay" if OS.mac? && Hardware::CPU.intel?
    bin.install "lovesay" if OS.linux? && Hardware::CPU.arm?
    bin.install "lovesay" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
