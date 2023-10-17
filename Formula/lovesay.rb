class Lovesay < Formula
  desc "Cowsay, but full of love and now a little rusty"
  homepage "https://github.com/dotzenith/lovesay.rs"
  version "0.5.4"
  license "MIT"
  
  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/dotzenith/lovesay.rs/releases/download/0.5.4/lovesay-0.5.4-x86_64-apple-darwin.tar.gz"
    sha256 "9ec8d0dcae3caf3176892779a304aead70273e6d1a76af2db08a539c4aad5805"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/dotzenith/lovesay.rs/releases/download/0.5.4/lovesay-0.5.4-aarch64-apple-darwin.tar.gz"
    sha256 "df072a86920b5778273272b968fe327057a177f3357937c4f221df67841eda7b"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/dotzenith/lovesay.rs/releases/download/0.5.4/lovesay-0.5.4-x86_64-unknown-linux-musl.tar.gz"
    sha256 "2d21536b5ab8bf248db4c1973afdba8f16c7baa80637d97c6b95b5cc55ba1eab"
  end

  if OS.linux? && Hardware::CPU.arm?
    url "https://github.com/dotzenith/lovesay.rs/releases/download/0.5.4/lovesay-0.5.4-arm-unknown-linux-gnueabihf.tar.gz"
    sha256 "c613f1573a4792af64324aaa698f5e742a5eededd4c794439d2aacaebd9cc948"
  end

  def install
    bin.install "lovesay"
  end
end
