class Avatarsay < Formula
  desc "Beautiful quotes from Avatar: The Last Airbender"
  homepage "https://github.com/dotzenith/AvatarSay"
  version "0.1.4"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/dotzenith/AvatarSay/releases/download/v0.1.4/avatarsay-aarch64-apple-darwin.tar.xz"
      sha256 "7c485f4775f6e1faa2953ae0dab6984495ce5d4914a52387041299ba0aeaab4d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dotzenith/AvatarSay/releases/download/v0.1.4/avatarsay-x86_64-apple-darwin.tar.xz"
      sha256 "4f882b64e4b2dd6b0f1fd38125552a29f7d13c9100ed59ace31900e93881b159"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/dotzenith/AvatarSay/releases/download/v0.1.4/avatarsay-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "89118aeb4ef08f03b044fb14dc24095bbecbdc1ad2021e11d8f8213fa78881a3"
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":              {},
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
    bin.install "avatarsay" if OS.mac? && Hardware::CPU.arm?
    bin.install "avatarsay" if OS.mac? && Hardware::CPU.intel?
    bin.install "avatarsay" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
