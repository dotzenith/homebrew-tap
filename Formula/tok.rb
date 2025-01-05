class Tok < Formula
  desc "A CLI client for tick tick"
  homepage "https://github.com/dotzenith/tok"
  version "0.1.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/dotzenith/tok/releases/download/v0.1.1/tok-aarch64-apple-darwin.tar.xz"
      sha256 "564ae0c65683f5fcf821ded820a17e48218b8a59515e72fb2711bfbbeb03fe5f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dotzenith/tok/releases/download/v0.1.1/tok-x86_64-apple-darwin.tar.xz"
      sha256 "eee572f9380d2d25c10d171368120307abb788abe1272533a7fa7c74d8270b08"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/dotzenith/tok/releases/download/v0.1.1/tok-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "660b596fa6e00662e54861c2c4b3856e4af1c19fd255ea9e20134262f9b2553a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dotzenith/tok/releases/download/v0.1.1/tok-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "3cefb20791959e5aa1eebe75f05a0ec656a323ec60277bb44e2f07f08e842e4f"
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
    bin.install "tok" if OS.mac? && Hardware::CPU.arm?
    bin.install "tok" if OS.mac? && Hardware::CPU.intel?
    bin.install "tok" if OS.linux? && Hardware::CPU.arm?
    bin.install "tok" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
