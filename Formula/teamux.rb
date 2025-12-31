class Teamux < Formula
  desc "Create and Join tmux sessions with ease"
  homepage "https://github.com/dotzenith/teamux"
  version "1.0.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/dotzenith/teamux/releases/download/v1.0.0/teamux-aarch64-apple-darwin.tar.xz"
      sha256 "c101a4c505a8556d737ae9ca79a67a5a9182967786b9dca0304c80c2a38c265e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dotzenith/teamux/releases/download/v1.0.0/teamux-x86_64-apple-darwin.tar.xz"
      sha256 "ddfb7bf773ff8ce9d0aa435d0f425d4f57353e982367e949d6df22f1b8b6625c"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/dotzenith/teamux/releases/download/v1.0.0/teamux-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "8a82a2a13bf238a5807b9b5e9b393b0760ba64fa45868b1e5dc15fb014b368f6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dotzenith/teamux/releases/download/v1.0.0/teamux-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "4377f4de78b30615f26e35f25fb7bfeadfc5b55af054aadb9268e2b3077e2dca"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":              {},
    "aarch64-unknown-linux-gnu":         {},
    "x86_64-apple-darwin":               {},
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
    bin.install "mux" if OS.mac? && Hardware::CPU.arm?
    bin.install "mux" if OS.mac? && Hardware::CPU.intel?
    bin.install "mux" if OS.linux? && Hardware::CPU.arm?
    bin.install "mux" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
