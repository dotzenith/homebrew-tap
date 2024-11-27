class TheSeptaTimes < Formula
  desc "A CLI application for the SEPTA API"
  homepage "https://github.com/dotzenith/TheSeptaTimes.rs"
  version "0.9.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/dotzenith/TheSeptaTimes.rs/releases/download/v0.9.1/the-septa-times-aarch64-apple-darwin.tar.xz"
      sha256 "b0688577fc8380d2fb561a50e6c8a099cb170324895468e3cbcb4b7511221bb7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dotzenith/TheSeptaTimes.rs/releases/download/v0.9.1/the-septa-times-x86_64-apple-darwin.tar.xz"
      sha256 "9a98f9f08f2eb132c0db2db2297adcbb4cee3d763cd989d91c44696093dc67d4"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/dotzenith/TheSeptaTimes.rs/releases/download/v0.9.1/the-septa-times-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "40de65977951c0bb412b7f2f57741336d6ba91ce9bdc267dc2782cb4820da058"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dotzenith/TheSeptaTimes.rs/releases/download/v0.9.1/the-septa-times-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "6eb37e2e7bbe0bd9a0ecf691db08f8fb1894ad496bb1d1ce2764b3a3a8d89682"
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

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
