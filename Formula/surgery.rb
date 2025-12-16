class Surgery < Formula
  desc "A simple CLI for Real Debrid "
  homepage "https://github.com/dotzenith/surgery"
  version "1.0.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/dotzenith/surgery/releases/download/v1.0.0/surgery-aarch64-apple-darwin.tar.xz"
      sha256 "4237b30477a64269c84344e4fe3a341de3f44c74a9be5b48c2026278e1cb3e3f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dotzenith/surgery/releases/download/v1.0.0/surgery-x86_64-apple-darwin.tar.xz"
      sha256 "f6d473dddb2f721d24edd0aefbc1d89758a5c65ba1d6467d00590b7a4f65d7a7"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/dotzenith/surgery/releases/download/v1.0.0/surgery-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "84ad79db65c1c9db109c8a35553d82ce1c923a569094974950eea421cf594981"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dotzenith/surgery/releases/download/v1.0.0/surgery-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "29e9564cc26c2402933a58909d44fe7d7e32d25d304a96c7901ce9b6bb2d7aeb"
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
