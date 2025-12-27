class Surgery < Formula
  desc "A simple CLI for Real Debrid "
  homepage "https://github.com/dotzenith/surgery"
  version "1.1.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/dotzenith/surgery/releases/download/v1.1.3/surgery-aarch64-apple-darwin.tar.xz"
      sha256 "cb95da7d0c87bd9fe1a2029c56b5e6e2d8bd7443de5a4b0967884140232a245d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dotzenith/surgery/releases/download/v1.1.3/surgery-x86_64-apple-darwin.tar.xz"
      sha256 "0b1edf0edd5436051c5ffbdec6c885fc082312f74203f07e08b0a61b170a5054"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/dotzenith/surgery/releases/download/v1.1.3/surgery-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "efd4001ffb45b1ad92db5429716a45a9e3ec9d0e30db767bb533360c1417098e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dotzenith/surgery/releases/download/v1.1.3/surgery-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "226a2c5bb95b8e254d8f4d6984c44a6c69ae970a16cba6c8f2b347f23929c0e8"
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
