class Theseptatimes < Formula
  desc "A CLI application for the SEPTA API "
  homepage "https://github.com/dotzenith/TheSeptaTimes.rs"
  version "0.3.0"
  license "MIT"
  
  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/dotzenith/TheSeptaTimes.rs/releases/download/0.3.0/tst-0.3.0-x86_64-apple-darwin.tar.gz"
    sha256 "fc0daa6aaf1bf82e27a341ba9832e53ffc89cae8fbfb108e8f0387128c1a7809 "
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/dotzenith/TheSeptaTimes.rs/releases/download/0.3.0/tst-0.3.0-aarch64-apple-darwin.tar.gz"
    sha256 "968c671a6c994502ad3dcff2f3fb4c9653a12c3b7034a44587b352d6a3c63d8a"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/dotzenith/TheSeptaTimes.rs/releases/download/0.3.0/tst-0.3.0-x86_64-unknown-linux-musl.tar.gz"
    sha256 "a37cce5e859be1fc33644413ce406831ebb258f9148f13c43a689e934090465d"
  end

  if OS.linux? && Hardware::CPU.arm?
    url "https://github.com/dotzenith/TheSeptaTimes.rs/releases/download/0.3.0/tst-0.3.0-arm-unknown-linux-gnueabihf.tar.gz"
    sha256 "e9e8b2fa656554c34fa979b07f4960ed0829c37da078cdbaea7b15b8e3ea771a"
  end

  def install
    bin.install "tst"
  end
end
