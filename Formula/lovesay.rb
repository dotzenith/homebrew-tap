class Lovesay < Formula
  desc "Cowsay, but full of love and now a little rusty"
  homepage "https://github.com/dotzenith/lovesay.rs"
  version "0.5.3"
  license "MIT"
  
  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/dotzenith/lovesay.rs/releases/download/0.5.3/lovesay-0.5.3-x86_64-apple-darwin.tar.gz"
    sha256 "51ed4e334a081cb79969a7a2bd4d27089139ca8b7371d68142e0282cd3dad0fb"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/dotzenith/lovesay.rs/releases/download/0.5.3/lovesay-0.5.3-aarch64-apple-darwin.tar.gz"
    sha256 "45011237d7a3ed4cf7778d907e1cf9cdbdf5f9e358186252006f1555de283afd"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/dotzenith/lovesay.rs/releases/download/0.5.3/lovesay-0.5.3-x86_64-unknown-linux-musl.tar.gz"
    sha256 "6b7cd6b6a3577f925591571ce06794d4ac5bc9e174866897c0e7b85f5920b8e0"
  end

  if OS.linux? && Hardware::CPU.arm?
    url "https://github.com/dotzenith/lovesay.rs/releases/download/0.5.3/lovesay-0.5.3-arm-unknown-linux-gnueabihf.tar.gz"
    sha256 "427ebcb2254467af5f915a1486c0892bf292d0c1c94e8841fa2a64d285976ab5"
  end

  def install
    bin.install "lovesay"
  end
end
