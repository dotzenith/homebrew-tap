class Spotifetch < Formula
  desc "A simple and beautiful fetch tool for spotify, now rusty :) "
  homepage "https://github.com/dotzenith/SpotiFetch.rs"
  version "0.1.8"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/dotzenith/SpotiFetch.rs/releases/download/v0.1.8/spotifetch-aarch64-apple-darwin.tar.xz"
      sha256 "be3b15f9d435ca7a5a72ac9f946ef1ab964eebf56ddf2e60c084349171fc7d7f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dotzenith/SpotiFetch.rs/releases/download/v0.1.8/spotifetch-x86_64-apple-darwin.tar.xz"
      sha256 "7ba4f3f58edd273f909f727047ce1d5d4ca51aa705ac8ba903238a4075584b80"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/dotzenith/SpotiFetch.rs/releases/download/v0.1.8/spotifetch-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "1740ff67be3b559d0f3582ebd16f84fc80e89f5163ec581bf8acf08cf9c53993"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dotzenith/SpotiFetch.rs/releases/download/v0.1.8/spotifetch-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "61e5cb09043455ba9dd985d119b1fdb1abcce73be88490cc3695adc5c4697d10"
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
