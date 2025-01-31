class Spotifetch < Formula
  desc "A simple and beautiful fetch tool for spotify, now rusty :) "
  homepage "https://github.com/dotzenith/SpotiFetch.rs"
  version "0.1.6"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/dotzenith/SpotiFetch.rs/releases/download/v0.1.6/spotifetch-aarch64-apple-darwin.tar.xz"
      sha256 "c1e8e64f9dd29e12811bb0386643f13cb98362ce5802d54d4a90544e1f1929cb"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dotzenith/SpotiFetch.rs/releases/download/v0.1.6/spotifetch-x86_64-apple-darwin.tar.xz"
      sha256 "384e1a7eea0ea316ef54c698d7558d35daf75fc54f36bd3d40b8a3e29ecef4ba"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/dotzenith/SpotiFetch.rs/releases/download/v0.1.6/spotifetch-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "dfd1e9982dd5383e3d318118e9c738666ff586a04a0963cc72884dcda34001d0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dotzenith/SpotiFetch.rs/releases/download/v0.1.6/spotifetch-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "6d77c222d0254498f5cfee883f1d5997af8b896d7ae2a0af9fda02df44cd6a87"
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
    bin.install "spotifetch" if OS.mac? && Hardware::CPU.arm?
    bin.install "spotifetch" if OS.mac? && Hardware::CPU.intel?
    bin.install "spotifetch" if OS.linux? && Hardware::CPU.arm?
    bin.install "spotifetch" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
