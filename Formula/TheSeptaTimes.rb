class Theseptatimes < Formula
  desc "A CLI application for the SEPTA API "
  homepage "https://github.com/dotzenith/TheSeptaTimes.rs"
  version "0.1.2"
  license "MIT"
  
  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/dotzenith/TheSeptaTimes.rs/releases/download/0.1.2/tst-0.1.2-x86_64-apple-darwin.tar.gz"
    sha256 "e86e7cca3e8f5198c95cf78c33bb35128e21bb474f9278b998d03cc3289e97e5"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/dotzenith/TheSeptaTimes.rs/releases/download/0.1.2/tst-0.1.2-aarch64-apple-darwin.tar.gz"
    sha256 "82798b5827f494c2ae4134404a46f43ddceb10d50f4a02b6577489e0f4b627dd"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/dotzenith/TheSeptaTimes.rs/releases/download/0.1.2/tst-0.1.2-x86_64-unknown-linux-musl.tar.gz"
    sha256 "904282793c368604bb88bd46c4da0cb653e5fd00323f714366cb262facb3b5df"
  end

  if OS.linux? && Hardware::CPU.arm?
    url "https://github.com/dotzenith/TheSeptaTimes.rs/releases/download/0.1.2/tst-0.1.2-arm-unknown-linux-gnueabihf.tar.gz"
    sha256 "0a6b473200990a65df852bb550f03ea239af1e29be0177a5919aee08198a26f1"
  end

  def install
    bin.install "tst"
  end
end
