class Lovesay < Formula
  desc "Cowsay, but full of love and now a little rusty"
  homepage "https://github.com/dotzenith/lovesay.rs"
  version "0.5.2"
  license "MIT"
  
  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/dotzenith/lovesay.rs/releases/download/0.5.2/lovesay-0.5.2-x86_64-apple-darwin.tar.gz"
    sha256 "8d48befe2df7fb5a3a75df2684c174b2f3fb2d5b1cc0106b79dc0ae11a0fa699"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/dotzenith/lovesay.rs/releases/download/0.5.2/lovesay-0.5.2-aarch64-apple-darwin.tar.gz"
    sha256 "fb62e9b220349bd58f53b911fa70a2012c96c213b7e33dc11ad0d34daf46a35f"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/dotzenith/lovesay.rs/releases/download/0.5.2/lovesay-0.5.2-x86_64-unknown-linux-musl.tar.gz"
    sha256 "f188715f196c68e5213fdcdb949a8d331c34b44356814613dc3df72c5dd49d2e"
  end

  if OS.linux? && Hardware::CPU.arm?
    url "https://github.com/dotzenith/lovesay.rs/releases/download/0.5.2/lovesay-0.5.2-arm-unknown-linux-gnueabihf.tar.gz"
    sha256 "0453c6042fe6d24304c42cad0b2f9e38b1c508a8fdd844a41942a6ce8bb4ef43"
  end

  def install
    bin.install "lovesay"
  end
end
