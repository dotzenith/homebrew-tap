class Avatarsay < Formula
  desc "Beautiful quotes from Avatar: The Last Airbender"
  homepage "https://github.com/dotzenith/AvatarSay"
  version "0.1.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/dotzenith/AvatarSay/releases/download/v0.1.2/avatarsay-aarch64-apple-darwin.tar.xz"
      sha256 "4b2880331643b7b2d5f4d22ab02bbc8c7d86ac565aa2cdb915fa01b39649a681"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dotzenith/AvatarSay/releases/download/v0.1.2/avatarsay-x86_64-apple-darwin.tar.xz"
      sha256 "5dad853792baa026e0ff11ab14822b529c3336a230f7c0444d734e5853a4ac32"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/dotzenith/AvatarSay/releases/download/v0.1.2/avatarsay-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "4297f9759765a4f0eb6b4ef4e602ffdac9ec4a5507fd5c1477f92bd7467edce3"
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
