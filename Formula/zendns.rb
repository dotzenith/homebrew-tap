class Zendns < Formula
  desc "Manage Dynamic DNS with serenity"
  homepage "https://github.com/dotzenith/ZenDNS"
  version "0.3.4"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/dotzenith/ZenDNS/releases/download/v0.3.4/zendns-aarch64-apple-darwin.tar.xz"
      sha256 "997f5741224e81b4e7ce8034b166121c404216db896de7d73ebc72ea32b78316"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dotzenith/ZenDNS/releases/download/v0.3.4/zendns-x86_64-apple-darwin.tar.xz"
      sha256 "84ed2e7217c5f2659c07a5e558a8b6f856fa96d7797083837ac336d4b8622b95"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/dotzenith/ZenDNS/releases/download/v0.3.4/zendns-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "27f1483753002ae6691cd18a74ffc2da680c0980332641c543f12fce6645179d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dotzenith/ZenDNS/releases/download/v0.3.4/zendns-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "6e7db0095924d70beede674dec63c8998f457c6cab81943b42f7e307cf5a427c"
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
    bin.install "zendns" if OS.mac? && Hardware::CPU.arm?
    bin.install "zendns" if OS.mac? && Hardware::CPU.intel?
    bin.install "zendns" if OS.linux? && Hardware::CPU.arm?
    bin.install "zendns" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
