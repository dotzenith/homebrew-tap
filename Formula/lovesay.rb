class Lovesay < Formula
  desc "lovesay but rusty"
  homepage "https://github.com/dotzenith/lovesay.rs"
  version "1.0.6"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/dotzenith/lovesay.rs/releases/download/v1.0.6/lovesay-aarch64-apple-darwin.tar.xz"
      sha256 "2ae48211c1ddf5a4534add2efdd5b05ec80254665e133318129618a5050e19d7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dotzenith/lovesay.rs/releases/download/v1.0.6/lovesay-x86_64-apple-darwin.tar.xz"
      sha256 "351166b9c91e2584f0953b66cf4c2551c81b28bbc865fa719436f2896da32411"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/dotzenith/lovesay.rs/releases/download/v1.0.6/lovesay-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "7b585aac98c84b381baa457ae9e77107f96f1ceaf7dbf877e095cfca5b71c811"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dotzenith/lovesay.rs/releases/download/v1.0.6/lovesay-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "b89c3929722a5733fa2e55a62c9fcc7e8d64f231f1cd887885cf7dd2b2db6899"
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
