class Avatarsay < Formula
  desc "Beautiful quotes from Avatar: The Last Airbender"
  homepage "https://github.com/dotzenith/AvatarSay"
  version "0.1.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/dotzenith/AvatarSay/releases/download/v0.1.1/avatarsay-aarch64-apple-darwin.tar.xz"
      sha256 "7344d3a9b7504f3b17f1d3f4fd696728d9efaf47e0f452966c4c712e12b0bddc"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dotzenith/AvatarSay/releases/download/v0.1.1/avatarsay-x86_64-apple-darwin.tar.xz"
      sha256 "4eb0d4303f6f191fa0826c6476cb181ef1ff3e1818be5dc53f22d29d9b67fa1c"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/dotzenith/AvatarSay/releases/download/v0.1.1/avatarsay-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "d5d47f3eb737463c1176a6588b9c854a63ca5cb96147fe86798df6bfc39003e9"
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":              {},
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
    bin.install "avatarsay" if OS.mac? && Hardware::CPU.arm?
    bin.install "avatarsay" if OS.mac? && Hardware::CPU.intel?
    bin.install "avatarsay" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
