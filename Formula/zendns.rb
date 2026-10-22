class Zendns < Formula
  desc "Manage Dynamic DNS with serenity"
  homepage "https://github.com/dotzenith/ZenDNS"
  version "1.1.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/dotzenith/ZenDNS/releases/download/v1.1.2/zendns-aarch64-apple-darwin.tar.xz"
      sha256 "25e3b3e654cf03ed80f9e8ef47e983cd55f1add2647849b348671d8ec56010ba"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dotzenith/ZenDNS/releases/download/v1.1.2/zendns-x86_64-apple-darwin.tar.xz"
      sha256 "7bed2e6016b350d3207ed2f8f2babbddab3de11a66b60cd8615e86e71e9ae329"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/dotzenith/ZenDNS/releases/download/v1.1.2/zendns-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "bd5b4c632a734b3d269fdcd56283360fba8a20b2594b6c8126ffd38cfd1f79e7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dotzenith/ZenDNS/releases/download/v1.1.2/zendns-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "83b7ac3e95c72381e0eaae45dda955a261f0a4a1bd977844b59df25481f94328"
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
    if OS.mac? && Hardware::CPU.arm?
      bin.install "zendns"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "zendns"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "zendns"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "zendns"
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
