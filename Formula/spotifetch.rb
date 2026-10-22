class Spotifetch < Formula
  desc "A simple and beautiful fetch tool for spotify, now rusty :) "
  homepage "https://github.com/dotzenith/SpotiFetch.rs"
  version "1.0.4"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/dotzenith/SpotiFetch.rs/releases/download/v1.0.4/spotifetch-aarch64-apple-darwin.tar.xz"
      sha256 "c873a1b6fc45b7af0242d0ab794012384cbc42b1deaf28523c641710fbc91fde"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dotzenith/SpotiFetch.rs/releases/download/v1.0.4/spotifetch-x86_64-apple-darwin.tar.xz"
      sha256 "c88bdeb3108ca74e4accdd74bb2456a123ca68c9fda7e25994d13bd22371dbec"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/dotzenith/SpotiFetch.rs/releases/download/v1.0.4/spotifetch-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "5183837ffa65f1a743c2b92181172b85ac7f9172edd9712def1b6efda6ef4c58"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dotzenith/SpotiFetch.rs/releases/download/v1.0.4/spotifetch-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "f0ace566a6eafc8dc97a91d3ad9a0e6c091e00c1212b8e42112706a2da1c53f0"
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
    if OS.mac? && Hardware::CPU.arm?
      bin.install "spotifetch"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "spotifetch"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "spotifetch"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "spotifetch"
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
