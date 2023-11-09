class Theseptatimes < Formula
  desc "A CLI application for the SEPTA API "
  homepage "https://github.com/dotzenith/TheSeptaTimes.rs"
  version "0.2.0"
  license "MIT"
  
  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/dotzenith/TheSeptaTimes.rs/releases/download/0.2.0/tst-0.2.0-x86_64-apple-darwin.tar.gz"
    sha256 "13ddbdfe1b6dfdfebcf6a8a5f036bcd7f2c49361052d54b7a1aea4dff370889c"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/dotzenith/TheSeptaTimes.rs/releases/download/0.2.0/tst-0.2.0-aarch64-apple-darwin.tar.gz"
    sha256 "4f8d1817ae529df31f419d8759065cf82a1e958a559336d639567f1b792f9073"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/dotzenith/TheSeptaTimes.rs/releases/download/0.2.0/tst-0.2.0-x86_64-unknown-linux-musl.tar.gz"
    sha256 "7ab3a104971468430366fb4abe71ede9b8bccadd26fc1227dc0702eed309a848"
  end

  if OS.linux? && Hardware::CPU.arm?
    url "https://github.com/dotzenith/TheSeptaTimes.rs/releases/download/0.2.0/tst-0.2.0-arm-unknown-linux-gnueabihf.tar.gz"
    sha256 "1c73f511d3e2ae2856f7b6b6d4ec09a4b7f67722cbaa8a7d1b65ab76f4127b8c"
  end

  def install
    bin.install "tst"
  end
end
