class PicoTts < Formula
  desc "lib and unix binary for text-to-speech engine from mac"
  homepage "https://github.com/kevin-btc/pico-tts"
  url "https://github.com/Iiridayn/pico-tts.git", tag: "0.1", using: :git
  license "MIT"

  def install
    system "git", "submodule", "init"
    system "git", "submodule", "update"
    system "sed", "-i", "''", "s|/usr/share/pico-tts/|#{prefix}/pico-tts/|", "pico-tts.c"

    # Supprimer les options -D et -t dans le Makefile
    system "sed", "-i", "''", "s|install -D -s -t $(DESTDIR)/usr/lib/ ${TARGET_LIB}|mkdir -p $(DESTDIR)/usr/lib/ && install -s ${TARGET_LIB} $(DESTDIR)/usr/lib/|", "Makefile"
    system "sed", "-i", "''", "s|install -D -s -t $(DESTDIR)/usr/bin/ pico-tts|mkdir -p $(DESTDIR)/usr/bin/ && install -s pico-tts $(DESTDIR)/usr/bin/|", "Makefile"
    system "sed", "-i", "''", "s|install -D -m 0644 -t $(DESTDIR)/usr/share/pico-tts svox/pico/lang/*|mkdir -p $(DESTDIR)/usr/share/pico-tts && install -m 0644 svox/pico/lang/* $(DESTDIR)/usr/share/pico-tts/|", "Makefile"

    system "make"

    # Utilisation de make install avec le bon DESTDIR
    system "make", "DESTDIR=#{prefix}/", "install"
  end

  test do
    system "#{bin}/pico-tts", "--version"
  end
end

