class Surgery < Formula
  desc "A simple CLI for Real Debrid "
  homepage "https://github.com/dotzenith/surgery"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/dotzenith/surgery/releases/download/v0.1.0/surgery-aarch64-apple-darwin.tar.xz"
      sha256 "810e498002c94e46e7a713b7b6059cf3ee9b216901ccda24dd1656badfea1ba0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dotzenith/surgery/releases/download/v0.1.0/surgery-x86_64-apple-darwin.tar.xz"
      sha256 "b7344ff3eed9629879481bca8aa82d82f511a8b65f9566889895448f23b3b3a4"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/dotzenith/surgery/releases/download/v0.1.0/surgery-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "b733847c74fe0b7aaaec05d89b65a43d46b65cec7a51f9844fc4dc958944ab69"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dotzenith/surgery/releases/download/v0.1.0/surgery-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "e3ef91da41dc858573cf25d3425bdc80761cdc29c6961abd265a228f9d5306eb"
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
    bin.install "sg" if OS.mac? && Hardware::CPU.arm?
    bin.install "sg" if OS.mac? && Hardware::CPU.intel?
    bin.install "sg" if OS.linux? && Hardware::CPU.arm?
    bin.install "sg" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
