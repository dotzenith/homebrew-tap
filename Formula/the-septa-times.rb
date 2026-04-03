class TheSeptaTimes < Formula
  desc "A SEPTA app for the terminal"
  homepage "https://github.com/dotzenith/TheSeptaTimes.rs"
  version "0.12.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/dotzenith/TheSeptaTimes.rs/releases/download/v0.12.2/the-septa-times-aarch64-apple-darwin.tar.xz"
      sha256 "03511ca912ba32ddb4fdd2e4e2f40502ca3324ec7cacd85bce45f0e208e7a8d1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dotzenith/TheSeptaTimes.rs/releases/download/v0.12.2/the-septa-times-x86_64-apple-darwin.tar.xz"
      sha256 "83842d75598408b00708ed59e066df95349132d858e69a09043ed18812705b4e"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/dotzenith/TheSeptaTimes.rs/releases/download/v0.12.2/the-septa-times-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "6870e463c9b8caacb8159be8db5a9b3b57c1bfad47e4a5e8dc7a1fc088ed3616"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dotzenith/TheSeptaTimes.rs/releases/download/v0.12.2/the-septa-times-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "68d49da354ec3b2a024b8fbd87bd55e5ac1ec7aec08d7eac9d22e594c61c9857"
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
    bin.install "tst" if OS.mac? && Hardware::CPU.arm?
    bin.install "tst" if OS.mac? && Hardware::CPU.intel?
    bin.install "tst" if OS.linux? && Hardware::CPU.arm?
    bin.install "tst" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Generate and install shell completions
    generate_completions_from_executable(bin/"tst", "completion")

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
