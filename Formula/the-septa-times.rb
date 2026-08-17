class TheSeptaTimes < Formula
  desc "A SEPTA app for the terminal"
  homepage "https://github.com/dotzenith/TheSeptaTimes.rs"
  version "0.12.4"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/dotzenith/TheSeptaTimes.rs/releases/download/v0.12.4/the-septa-times-aarch64-apple-darwin.tar.xz"
      sha256 "cb8d0681772a77026048bd4d6ff27dc8c3a8e292dc77249f02a66074fe9a1bb4"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dotzenith/TheSeptaTimes.rs/releases/download/v0.12.4/the-septa-times-x86_64-apple-darwin.tar.xz"
      sha256 "76d275bd36a978489594dcc51b3303715941701052b7c1896004ecea3a8ccf58"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/dotzenith/TheSeptaTimes.rs/releases/download/v0.12.4/the-septa-times-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "2e8031b13ef2506607446e5d430b3f3f0ee5578ed2ef27b7616c807ab68cb328"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dotzenith/TheSeptaTimes.rs/releases/download/v0.12.4/the-septa-times-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "1568a3a7b06193d45c002c7cdf6d5c8260d5e75f18dc80c59195c0ea21691a53"
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
      bin.install "tst"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "tst"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "tst"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "tst"
    end

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
