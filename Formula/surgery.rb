class Surgery < Formula
  desc "A simple CLI for Real Debrid "
  homepage "https://github.com/dotzenith/surgery"
  version "1.2.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/dotzenith/surgery/releases/download/v1.2.2/surgery-aarch64-apple-darwin.tar.xz"
      sha256 "1be14dd764350d362d7f640318c0d8c499be7a21780261e00e630e0cd6452c4c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dotzenith/surgery/releases/download/v1.2.2/surgery-x86_64-apple-darwin.tar.xz"
      sha256 "38a4c44a899102550f00f7c2152b9118b837335c1c8b215fe0e0502582302f8e"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/dotzenith/surgery/releases/download/v1.2.2/surgery-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "ccdcd9371b91bc10cc1f511ebc6b767ad8094f78eeab1ac3409142d23377674c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dotzenith/surgery/releases/download/v1.2.2/surgery-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "221aea2856055180d96349dff2ee5c53804745c285a30110a2c0dee06a84113c"
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
      bin.install "srg"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "srg"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "srg"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "srg"
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
