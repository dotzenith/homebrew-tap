class Zendns < Formula
  desc "Manage Dynamic DNS with serenity"
  homepage "https://github.com/dotzenith/ZenDNS"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/dotzenith/ZenDNS/releases/download/v0.2.0/zendns-aarch64-apple-darwin.tar.xz"
      sha256 "3ef5cfc47e564530e6b4595538dd44f3222ac5ae5fe2534cc6f62a70056b63fa"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dotzenith/ZenDNS/releases/download/v0.2.0/zendns-x86_64-apple-darwin.tar.xz"
      sha256 "dc91fc23a7c805465eb220f4c164f7cc4b8e0e00df39ffcdeeff0005aea20056"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/dotzenith/ZenDNS/releases/download/v0.2.0/zendns-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "70c20aba146579a170bd5806254796e383f0f9e9aa1d9878c2517b6b79bb3eca"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dotzenith/ZenDNS/releases/download/v0.2.0/zendns-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "ef01706abdfa4fe045d35b3fb7ee32bc41a60c6817a25b3b5b4abdae0c320ec7"
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
