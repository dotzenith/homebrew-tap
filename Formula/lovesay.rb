class Lovesay < Formula
  desc "lovesay but rusty"
  homepage "https://github.com/dotzenith/lovesay.rs"
  version "0.6.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/dotzenith/lovesay.rs/releases/download/v0.6.1/lovesay-aarch64-apple-darwin.tar.xz"
      sha256 "92a0b6ae7d7cf4d7743142d9d486c9d58b7c6da2f93b7051c392ef792f29526f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dotzenith/lovesay.rs/releases/download/v0.6.1/lovesay-x86_64-apple-darwin.tar.xz"
      sha256 "47a5bf5c2fd693a3139aa359c4d67f4be6014b6819f1b8118c0c31d933d706e3"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/dotzenith/lovesay.rs/releases/download/v0.6.1/lovesay-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "587f19394b229f2393115737555551c238006bfd264827d9cb3a746a24ba2987"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dotzenith/lovesay.rs/releases/download/v0.6.1/lovesay-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "98866c57226dee3dce732b2bb885d6758f8270395aaa0d0b3872d7f60a19968e"
    end
  end
  license "MIT"

  BINARY_ALIASES = {"aarch64-apple-darwin": {}, "aarch64-unknown-linux-gnu": {}, "aarch64-unknown-linux-musl-dynamic": {}, "aarch64-unknown-linux-musl-static": {}, "x86_64-apple-darwin": {}, "x86_64-pc-windows-gnu": {}, "x86_64-unknown-linux-gnu": {}, "x86_64-unknown-linux-musl-dynamic": {}, "x86_64-unknown-linux-musl-static": {}}

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
      bin.install "lovesay"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "lovesay"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "lovesay"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "lovesay"
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
