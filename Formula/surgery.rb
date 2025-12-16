class Surgery < Formula
  desc "A simple CLI for Real Debrid "
  homepage "https://github.com/dotzenith/surgery"
  version "1.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/dotzenith/surgery/releases/download/v1.1.0/surgery-aarch64-apple-darwin.tar.xz"
      sha256 "640ce820006f770c11208065f24d195a59e0ebb031dcf18502ce93441c7e4178"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dotzenith/surgery/releases/download/v1.1.0/surgery-x86_64-apple-darwin.tar.xz"
      sha256 "149a4e199fb7f14bed647b9e61c2d1fefd8bfc67f89fe0fcae1ae4f5234ec747"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/dotzenith/surgery/releases/download/v1.1.0/surgery-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "219a8285c320ce54244db97e2d9263589f459952f625dad946987b5c178c57e7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dotzenith/surgery/releases/download/v1.1.0/surgery-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "93306a1ecb29a67ccac7a2d0dbb0413d84a54d883ed4387fc13bf49d85a8f966"
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
    bin.install "srg" if OS.mac? && Hardware::CPU.arm?
    bin.install "srg" if OS.mac? && Hardware::CPU.intel?
    bin.install "srg" if OS.linux? && Hardware::CPU.arm?
    bin.install "srg" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
