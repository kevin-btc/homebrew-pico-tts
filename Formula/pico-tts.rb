class PicoTts < Formula
  desc "lib and unix binary for text-to-speech engine from mac"
  homepage "https://github.com/kevin-btc/pico-tts"
  url "https://github.com/Iiridayn/pico-tts.git", tag: "0.1", using: :git
  license "MIT"

  def install
    system "git", "submodule", "init"
    system "git", "submodule", "update"
    system "sed", "-i", "''", "s|/usr/share/pico-tts/|#{prefix}/pico-tts/|", "pico-tts.c"

    # Supprimer l'option -D dans le Makefile
    system "sed", "-i", "''", "s/install -D/install/", "Makefile"

    system "make"

    # Création des répertoires nécessaires
    mkdir_p "#{prefix}/usr/lib/"
    mkdir_p "#{prefix}/usr/bin/"
    mkdir_p "#{prefix}/usr/share/"

    # Utilisation de make install avec le bon DESTDIR
    system "make", "DESTDIR=#{prefix}/", "install"
  end

  test do
    system "#{bin}/pico-tts", "--version"
  end
end

