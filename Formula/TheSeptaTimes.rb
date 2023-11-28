class Theseptatimes < Formula
  desc "A CLI application for the SEPTA API "
  homepage "https://github.com/dotzenith/TheSeptaTimes.rs"
  version "0.4.0"
  license "MIT"
  
  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/dotzenith/TheSeptaTimes.rs/releases/download/0.4.0/tst-0.4.0-x86_64-apple-darwin.tar.gz"
    sha256 "012686c044e865fd657d79604f3af56115b42dee53e6a68177491802decc1edb"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/dotzenith/TheSeptaTimes.rs/releases/download/0.4.0/tst-0.4.0-aarch64-apple-darwin.tar.gz"
    sha256 "2717d6545fae646dc0e0cea41867b41e1b1bc486b762cec7130976193da9367f"
  end

  if OS.linux? && Hardware::CPU.arm?
    url "https://github.com/dotzenith/TheSeptaTimes.rs/releases/download/0.4.0/tst-0.4.0-arm-unknown-linux-gnueabihf.tar.gz"
    sha256 "d40260345392619bcf439cde072cfa092067ca4a2ccfbb0ca1b263a5a7084010"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/dotzenith/TheSeptaTimes.rs/releases/download/0.4.0/tst-0.4.0-x86_64-unknown-linux-musl.tar.gz"
    sha256 "ed1e9e0332d5453cfac83c7106533dd79afbff927de5d60e59a024a994757917"
  end

  def install
    bin.install "tst"
  end
end
