class TheSeptaTimes < Formula
  desc "A SEPTA app for the terminal"
  homepage "https://github.com/dotzenith/TheSeptaTimes.rs"
  version "0.12.5"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/dotzenith/TheSeptaTimes.rs/releases/download/v0.12.5/the-septa-times-aarch64-apple-darwin.tar.xz"
      sha256 "de48abcaaa266462678e744500017536ab07fbb7655811adbf5cc76416867ebe"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dotzenith/TheSeptaTimes.rs/releases/download/v0.12.5/the-septa-times-x86_64-apple-darwin.tar.xz"
      sha256 "28809d71f586a3f1e87be29e90dcad2bb13cc9205b57474fc4ab42bf62c37af2"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/dotzenith/TheSeptaTimes.rs/releases/download/v0.12.5/the-septa-times-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "3391581109a1918c813061ded4e1d2214f5f9add32b64ad8081e23a71f226e77"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dotzenith/TheSeptaTimes.rs/releases/download/v0.12.5/the-septa-times-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "45d9444b5c625496b87c2acc61066932c6cc03dfdb516e3a97aa51f06defc540"
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

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
