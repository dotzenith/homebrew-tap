class Theseptatimes < Formula
  desc "A CLI application for the SEPTA API "
  homepage "https://github.com/dotzenith/TheSeptaTimes.rs"
  version "0.4.1"
  license "MIT"
  
  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/dotzenith/TheSeptaTimes.rs/releases/download/0.4.1/tst-0.4.1-x86_64-apple-darwin.tar.gz"
    sha256 "2a54f6aee51070cb8a2089b75a55977298db6b8802de16ae4a0df405fe6832e6"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/dotzenith/TheSeptaTimes.rs/releases/download/0.4.1/tst-0.4.1-aarch64-apple-darwin.tar.gz"
    sha256 "384186ab2cecbabd7bf83fee4eff35dab6771b89433b16647fb4c90898bc5827"
  end

  if OS.linux? && Hardware::CPU.arm?
    url "https://github.com/dotzenith/TheSeptaTimes.rs/releases/download/0.4.1/tst-0.4.1-arm-unknown-linux-gnueabihf.tar.gz"
    sha256 "41f52c07cc441a509fc74a29533c026b0e4a95ad4216ad6062d18c97fea19d8d"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/dotzenith/TheSeptaTimes.rs/releases/download/0.4.1/tst-0.4.1-x86_64-unknown-linux-musl.tar.gz"
    sha256 "4ca3c9701274e00ef1aa2eff2a0c31037220c2b5f193532b464b7c46a0612c7c"
  end

  def install
    bin.install "tst"
  end
end
