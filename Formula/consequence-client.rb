class ConsequenceClient < Formula
  desc "Client for consequence: A task runner for home servers"
  homepage "https://github.com/dotzenith/consequence"
  version "0.0.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/dotzenith/consequence/releases/download/v0.0.1/consequence-client-aarch64-apple-darwin.tar.xz"
      sha256 "753e98cbdafe67b50d771fb2f8409d317fa0a61b620000f0c0c55ec1e05999c0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dotzenith/consequence/releases/download/v0.0.1/consequence-client-x86_64-apple-darwin.tar.xz"
      sha256 "83b1f9b8202aeb882ddf90333464adfb03a1ab7dd2d915853b8412b64ae27fed"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/dotzenith/consequence/releases/download/v0.0.1/consequence-client-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "92e4fc9a02779494e6d35050a8d91d2dd91154d7dda927fefae3708a0a1ec8a6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dotzenith/consequence/releases/download/v0.0.1/consequence-client-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "7d3ca2f95adabb0b6f5f991b36647b22b49e07b6c3c4f300b00a41b800d7fa4e"
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
    bin.install "consequence-client" if OS.mac? && Hardware::CPU.arm?
    bin.install "consequence-client" if OS.mac? && Hardware::CPU.intel?
    bin.install "consequence-client" if OS.linux? && Hardware::CPU.arm?
    bin.install "consequence-client" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
