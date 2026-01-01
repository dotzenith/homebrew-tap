class Surgery < Formula
  desc "A simple CLI for Real Debrid "
  homepage "https://github.com/dotzenith/surgery"
  version "1.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/dotzenith/surgery/releases/download/v1.2.0/surgery-aarch64-apple-darwin.tar.xz"
      sha256 "dae4965bc97273d1a1148da3479b127e313c37bf0ab70a968881ce7513ff9308"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dotzenith/surgery/releases/download/v1.2.0/surgery-x86_64-apple-darwin.tar.xz"
      sha256 "34b0568eb462f3ed6b89a278a1266376b569c87e82bca6f1e01f4e58e9db677f"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/dotzenith/surgery/releases/download/v1.2.0/surgery-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "e173b996e0390c19dd0e5dc3459bc23aff8211ba55f61f845c80f00559613c0f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dotzenith/surgery/releases/download/v1.2.0/surgery-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "307b3d0e0f8a5c1d69ed476a2b2d48f8a2473ce82bbd784b04ee2f1a1188826d"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
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
    bin.install "srg" if OS.mac? && Hardware::CPU.arm?
    bin.install "srg" if OS.mac? && Hardware::CPU.intel?
    bin.install "srg" if OS.linux? && Hardware::CPU.arm?
    bin.install "srg" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
