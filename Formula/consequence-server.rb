class ConsequenceServer < Formula
  desc "Server for consequence: A task runner for home servers"
  homepage "https://github.com/dotzenith/consequence"
  version "0.0.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/dotzenith/consequence/releases/download/v0.0.1/consequence-server-aarch64-apple-darwin.tar.xz"
      sha256 "1aa8cfa9ebbe2e2bb5d79648af8cccbfce59c4eaff3c7db3617b99dc9f02fbed"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dotzenith/consequence/releases/download/v0.0.1/consequence-server-x86_64-apple-darwin.tar.xz"
      sha256 "98b8946f4f0a608503ff92fc29a3f9dfbfe7277cf2329d86ad562d347b2fc551"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/dotzenith/consequence/releases/download/v0.0.1/consequence-server-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "1d13619a3b4052405f937f24ee387bf47bed59fea9e19a264c172f9f94e294a2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dotzenith/consequence/releases/download/v0.0.1/consequence-server-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "c35cafd5f46f1bcc7c055a1fb8496556bddf86a33a014a745bed01fc9b85fc45"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-unknown-linux-gnu":  {},
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
    bin.install "consequence-server" if OS.mac? && Hardware::CPU.arm?
    bin.install "consequence-server" if OS.mac? && Hardware::CPU.intel?
    bin.install "consequence-server" if OS.linux? && Hardware::CPU.arm?
    bin.install "consequence-server" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
