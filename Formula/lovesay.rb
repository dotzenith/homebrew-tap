class Lovesay < Formula
  desc "lovesay but rusty"
  homepage "https://github.com/dotzenith/lovesay.rs"
  version "1.0.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/dotzenith/lovesay.rs/releases/download/v1.0.2/lovesay-aarch64-apple-darwin.tar.xz"
      sha256 "56af7a84f5df08c35a6f8ebc731c294d9bef3bcd4d889e71b992d97fc888174e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dotzenith/lovesay.rs/releases/download/v1.0.2/lovesay-x86_64-apple-darwin.tar.xz"
      sha256 "69ffc0d7f081b1277e1c1c57b23784910774a6ef92aaa1b3281ca538a93b0c80"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/dotzenith/lovesay.rs/releases/download/v1.0.2/lovesay-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "9b8d86b4306421315f2a330a226880e3861b4278e27444fc02dca6aeae9ad6f6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dotzenith/lovesay.rs/releases/download/v1.0.2/lovesay-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "e16b8ba7a818b19237bb50d08554bc0672550e1ae99c15271e3e776984c57415"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":               {},
    "aarch64-unknown-linux-gnu":          {},
    "aarch64-unknown-linux-musl-dynamic": {},
    "aarch64-unknown-linux-musl-static":  {},
    "x86_64-apple-darwin":                {},
    "x86_64-pc-windows-gnu":              {},
    "x86_64-unknown-linux-gnu":           {},
    "x86_64-unknown-linux-musl-dynamic":  {},
    "x86_64-unknown-linux-musl-static":   {},
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
