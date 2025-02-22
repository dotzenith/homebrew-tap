class Spotifetch < Formula
  desc "A simple and beautiful fetch tool for spotify, now rusty :) "
  homepage "https://github.com/dotzenith/SpotiFetch.rs"
  version "0.1.7"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/dotzenith/SpotiFetch.rs/releases/download/v0.1.7/spotifetch-aarch64-apple-darwin.tar.xz"
      sha256 "5db47b25375fb8b8d0298e004f00717a385b79ea60782e73e0a104d05bfab7b6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dotzenith/SpotiFetch.rs/releases/download/v0.1.7/spotifetch-x86_64-apple-darwin.tar.xz"
      sha256 "101117663685da30ddf74f396f37460be0fe51dd6f650f7e1376e36ae88fc17b"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/dotzenith/SpotiFetch.rs/releases/download/v0.1.7/spotifetch-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "47b8c5d4320759164f3e1653921a664228ac98d7b347598c5c2fa8dedd1f306f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dotzenith/SpotiFetch.rs/releases/download/v0.1.7/spotifetch-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "41a3d10ca94ebed91df1e0e32d14b53914b69ea6ae7c9c197343573df09f720e"
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
