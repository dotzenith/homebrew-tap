class Tok < Formula
  desc "A CLI client for tick tick"
  homepage "https://github.com/dotzenith/tok"
  version "0.1.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/dotzenith/tok/releases/download/v0.1.2/tok-aarch64-apple-darwin.tar.xz"
      sha256 "c7864dbbb484661e388185fdfdd1de58ce1f90e6429bb3f9d40478a0d91b80c5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dotzenith/tok/releases/download/v0.1.2/tok-x86_64-apple-darwin.tar.xz"
      sha256 "418411df5c2142ede01edadb64b34950f178f315eb7a7bf919f7e4ec75ebc940"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/dotzenith/tok/releases/download/v0.1.2/tok-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "5b93f7bde464cec100e042402bb4de50f02a4f6c3a8bfcbf4aeae22ad70ab266"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dotzenith/tok/releases/download/v0.1.2/tok-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "1f92074758e4518cfeb3fa4d4773ef89dadafc696f89340946ddbb901a6a2956"
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
