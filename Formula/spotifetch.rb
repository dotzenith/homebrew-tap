class Spotifetch < Formula
  desc "A simple and beautiful fetch tool for spotify, now rusty :) "
  homepage "https://github.com/dotzenith/SpotiFetch.rs"
  version "0.1.9"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/dotzenith/SpotiFetch.rs/releases/download/v0.1.9/spotifetch-aarch64-apple-darwin.tar.xz"
      sha256 "e19e37d044f35df10bdc4be181e4c102d044a770c08a42449bfec2c13d91a950"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dotzenith/SpotiFetch.rs/releases/download/v0.1.9/spotifetch-x86_64-apple-darwin.tar.xz"
      sha256 "9d00ae084b681200ca8406f8a0ca1b564f459dbd032547fe4b0a81cb41d90bb3"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/dotzenith/SpotiFetch.rs/releases/download/v0.1.9/spotifetch-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "b9b7c7082f7d73304d8acc5f560f141bb93b26994501487d59a34c7dd4477536"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dotzenith/SpotiFetch.rs/releases/download/v0.1.9/spotifetch-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "8fc9b7579901bd288b6e118e834683379a0e33ed8b888b0ca83a05ec57ea80e2"
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
