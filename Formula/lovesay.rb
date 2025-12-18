class Lovesay < Formula
  desc "lovesay but rusty"
  homepage "https://github.com/dotzenith/lovesay.rs"
  version "1.0.4"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/dotzenith/lovesay.rs/releases/download/v1.0.4/lovesay-aarch64-apple-darwin.tar.xz"
      sha256 "73977f8ee51cf194b2b3710262ceb6a0381ffcf1e5b38ac762aafd2f97206740"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dotzenith/lovesay.rs/releases/download/v1.0.4/lovesay-x86_64-apple-darwin.tar.xz"
      sha256 "281577a9951cf4afd5e7b72b98feafceb30b7e6a9e80e31a14c23ffcbceb4d61"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/dotzenith/lovesay.rs/releases/download/v1.0.4/lovesay-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "9631aa058c6eea7def8c46ac08a182fbebb8ad6e8f32a032fc53b7ba3b276c87"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dotzenith/lovesay.rs/releases/download/v1.0.4/lovesay-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "b6b51a55588e9b0e0bda56c9f460d4a33a0377bbaefe8f970dc01c567052aec2"
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
    bin.install "lovesay" if OS.mac? && Hardware::CPU.arm?
    bin.install "lovesay" if OS.mac? && Hardware::CPU.intel?
    bin.install "lovesay" if OS.linux? && Hardware::CPU.arm?
    bin.install "lovesay" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
