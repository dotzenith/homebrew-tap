class Zendns < Formula
  desc "Manage Dynamic DNS with serenity"
  homepage "https://github.com/dotzenith/ZenDNS"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/dotzenith/ZenDNS/releases/download/v0.1.0/zendns-aarch64-apple-darwin.tar.xz"
      sha256 "59ea97b75b2f8c14a383012cbbef72efa564d8f2bc2175efdcf4db2b4eec2512"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dotzenith/ZenDNS/releases/download/v0.1.0/zendns-x86_64-apple-darwin.tar.xz"
      sha256 "6bcc851d652c9fdaf4127e4296fb59233eb8199aaf6e9d74206105cd18b32d70"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/dotzenith/ZenDNS/releases/download/v0.1.0/zendns-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "63323a46151d3b068988aaf7fa1af9ca1358fe53728d60f9f63c551a27329b16"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dotzenith/ZenDNS/releases/download/v0.1.0/zendns-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "e3d22a99a90dda173ff35ef08538c1ea441f4918d738c53dca284ad24da142ac"
    end
  end
  license "MIT"

  BINARY_ALIASES = {"aarch64-apple-darwin": {}, "aarch64-unknown-linux-gnu": {}, "x86_64-apple-darwin": {}, "x86_64-pc-windows-gnu": {}, "x86_64-unknown-linux-gnu": {}, "x86_64-unknown-linux-musl-dynamic": {}, "x86_64-unknown-linux-musl-static": {}}

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
