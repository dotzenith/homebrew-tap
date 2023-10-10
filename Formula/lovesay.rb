class Lovesay < Formula
  desc "Cowsay, but full of love and now a little rusty"
  homepage "https://github.com/dotzenith/lovesay.rs"
  version "0.5.2"
  license "MIT"
  
  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/dotzenith/lovesay.rs/releases/download/0.5.2/lovesay-0.5.2-x86_64-apple-darwin.tar.gz"
    sha256 "454b17b5654848864a16686901d068b7204e86dc"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/dotzenith/lovesay.rs/releases/download/0.5.2/lovesay-0.5.2-aarch64-apple-darwin.tar.gz"
    sha256 "d7a9536e57820400ae4d80c0360895e1ff7413b2"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/dotzenith/lovesay.rs/releases/download/0.5.2/lovesay-0.5.2-x86_64-unknown-linux-musl.tar.gz"
    sha256 "b73ded66b201cf530160f7df98f2430a084fbbfa"
  end

  if OS.linux? && Hardware::CPU.arm?
    url "https://github.com/dotzenith/lovesay.rs/releases/download/0.5.2/lovesay-0.5.2-arm-unknown-linux-gnueabihf.tar.gz"
    sha256 "b0dd1eb4b91f9fb5528c98c3ade0d9fbad096a5d"
  end

  def install
    bin.install "lovesay"
  end
end
