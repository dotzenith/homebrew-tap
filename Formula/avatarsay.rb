class Avatarsay < Formula
  desc "Beautiful quotes from Avatar: The Last Airbender"
  homepage "https://github.com/dotzenith/AvatarSay"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/dotzenith/AvatarSay/releases/download/v0.1.0/avatarsay-aarch64-apple-darwin.tar.xz"
      sha256 "273ac4779b2ca233dea0f76c3de300730dfbd48f82f8d8e99266c2e5b1fe5a02"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dotzenith/AvatarSay/releases/download/v0.1.0/avatarsay-x86_64-apple-darwin.tar.xz"
      sha256 "30a98e98d36a7fdeaa246032706e6f9b11a6669090caf9836636e592c1d0dd43"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/dotzenith/AvatarSay/releases/download/v0.1.0/avatarsay-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "882ee8933495bc88a6d40dae59c0eca27af9244876d565a539c523556ef13f06"
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
