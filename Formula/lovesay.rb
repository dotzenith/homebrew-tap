class Lovesay < Formula
  desc "lovesay but rusty"
  homepage "https://github.com/dotzenith/lovesay.rs"
  version "1.0.5"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/dotzenith/lovesay.rs/releases/download/v1.0.5/lovesay-aarch64-apple-darwin.tar.xz"
      sha256 "3e299e600a9730db5cd6658c7a44b5aafba28fc0d4b1df760494cf45841858bf"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dotzenith/lovesay.rs/releases/download/v1.0.5/lovesay-x86_64-apple-darwin.tar.xz"
      sha256 "6258a8763d3fe5660df62b5fcd6b343de87bc9415922f40f030fce93a521e92f"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/dotzenith/lovesay.rs/releases/download/v1.0.5/lovesay-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "0321d852286fe106a2670c9920ea44af72187654b12749fb8cad0b18cd969515"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dotzenith/lovesay.rs/releases/download/v1.0.5/lovesay-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "db0c0ed35d02df900569f86e050d4065cae123932866c43c9a3f88a6a781802c"
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
