class PicoTTS < Formula
  desc "lib and unix binary for text-to-speech engine from mac"
  homepage "https://github.com/kevin-btc/pico-tts"
  url "https://github.com/kevin-btc/pico-tts.git", tag: "0.1", using: :git
  license "MIT"

  def install
    system "git", "submodule", "init"
    system "git", "submodule", "update"
    system "sed", "-i", "s|/usr/local/pico-tts/|#{prefix}/usr/local/pico-tts/|", "pico-tts.c"
 system "make"
 system "make", "DESTDIR=#{prefix}/", "install"
  end
end
