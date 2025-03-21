class Avatarsay < Formula
  desc "Beautiful quotes from Avatar: The Last Airbender"
  homepage "https://github.com/dotzenith/AvatarSay"
  version "0.1.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/dotzenith/AvatarSay/releases/download/v0.1.3/avatarsay-aarch64-apple-darwin.tar.xz"
      sha256 "ff7062c12dfefb2555d3b55ff4a21814f3dabc15fef1860c494a431d9ce5cd26"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dotzenith/AvatarSay/releases/download/v0.1.3/avatarsay-x86_64-apple-darwin.tar.xz"
      sha256 "5f8960b37975ba44fd82d4cd0305d9a867db5ea0f8fd08acac226608f107307b"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/dotzenith/AvatarSay/releases/download/v0.1.3/avatarsay-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "c236b24c0260d11745ddae407dbf4ac0145f33ab60c10cba2264e97798470694"
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
