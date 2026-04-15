class Spotifetch < Formula
  desc "A simple and beautiful fetch tool for spotify, now rusty :) "
  homepage "https://github.com/dotzenith/SpotiFetch.rs"
  version "1.0.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/dotzenith/SpotiFetch.rs/releases/download/v1.0.3/spotifetch-aarch64-apple-darwin.tar.xz"
      sha256 "e203afd369769a205fc932c3f080ea2bd41ff85760a69a970a6bc17a3e6d48a4"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dotzenith/SpotiFetch.rs/releases/download/v1.0.3/spotifetch-x86_64-apple-darwin.tar.xz"
      sha256 "145e4d559e6e432e16c654c2cd8ae01e091256e0624ecb7444d8dc3b0dcea6a1"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/dotzenith/SpotiFetch.rs/releases/download/v1.0.3/spotifetch-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "ca14e1324c3f9d7483c5b03e6f296f78ca6733a78dfe890e7afda9550e75e7b7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dotzenith/SpotiFetch.rs/releases/download/v1.0.3/spotifetch-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "f876be5e162f573eb86133719fa945217abe6533a19e6f12f6f5a78e7d1caf8f"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
    "x86_64-unknown-linux-gnu":  {},
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
    bin.install "spotifetch" if OS.mac? && Hardware::CPU.arm?
    bin.install "spotifetch" if OS.mac? && Hardware::CPU.intel?
    bin.install "spotifetch" if OS.linux? && Hardware::CPU.arm?
    bin.install "spotifetch" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
