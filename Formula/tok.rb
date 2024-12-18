class Tok < Formula
  desc "A CLI client for tick tick"
  homepage "https://github.com/dotzenith/tok"
  version "0.0.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/dotzenith/tok/releases/download/v0.0.1/tok-aarch64-apple-darwin.tar.xz"
      sha256 "2b7c8b7d661dce4c0c3f997c81cb25c01642a910e2cfc2f0b90e8db70ea3f8e9"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dotzenith/tok/releases/download/v0.0.1/tok-x86_64-apple-darwin.tar.xz"
      sha256 "51a1b92abd496e395a454df0518568357a443fbd67112e77bfbc29bd6571b516"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/dotzenith/tok/releases/download/v0.0.1/tok-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "9dc198c28f90dc3e0015234fb26603b1a39cbe4dd617562dd25f58871bd93060"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dotzenith/tok/releases/download/v0.0.1/tok-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "be69cacfda9bf74d25507d949dea2de0d2b4f06fadacdc42525c67c5f2e12538"
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
