class Teamux < Formula
  desc "Create and Join tmux sessions with ease"
  homepage "https://github.com/dotzenith/teamux"
  version "1.0.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/dotzenith/teamux/releases/download/v1.0.1/teamux-aarch64-apple-darwin.tar.xz"
      sha256 "d5cbb7b04b650e6190dbea57873436e080b655b5d6da07704409ce682040d0c1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dotzenith/teamux/releases/download/v1.0.1/teamux-x86_64-apple-darwin.tar.xz"
      sha256 "46221e09e8eee062f51aa9d320aa7859eaecdd7bd57665ad0ed072d77ceddf57"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/dotzenith/teamux/releases/download/v1.0.1/teamux-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "8760438991ee1390c2177acabc94964fd0e481db43a1e682520d7f7b044a1512"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dotzenith/teamux/releases/download/v1.0.1/teamux-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "b5f812293b3796d4b188762e78c51903abba362ea6b16ee673bac9837b0bdf24"
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
