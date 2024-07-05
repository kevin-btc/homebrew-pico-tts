class PicoTts < Formula
  desc "lib and unix binary for text-to-speech engine from mac"
  homepage "https://github.com/kevin-btc/pico-tts"
  url "https://github.com/Iiridayn/pico-tts.git", tag: "0.1", using: :git
  license "MIT"

  def install
    system "git", "submodule", "init"
    system "git", "submodule", "update"
    system "sed", "-i", "''", "s|/usr/share/pico-tts/|#{prefix}/pico-tts/|", "pico-tts.c"

    system "make"

    # Installation manuelle des fichiers
    mkdir_p "#{lib}"
    mkdir_p "#{bin}"
    mkdir_p "#{share}/pico-tts"

    system "install", "-s", "libsvoxpico.so", "#{lib}/"
    system "install", "-s", "pico-tts", "#{bin}/"
    system "install", "-m", "0644", *Dir["svox/pico/lang/*"], "#{share}/pico-tts/"
  end

  test do
    system "#{bin}/pico-tts", "--version"
  end
end

