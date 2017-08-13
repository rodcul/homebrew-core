class Pioneer < Formula
  desc "Game of lonely space adventure"
  homepage "https://pioneerspacesim.net/"
  url "https://github.com/pioneerspacesim/pioneer/archive/20170813.tar.gz"
  sha256 "9a2feec5236f8ca6ee8f0d75bccdee7bf6ae62f7a08b9e37cdd178642fdd32f3"
  head "https://github.com/pioneerspacesim/pioneer.git"

  bottle do
    sha256 "7d0009340d6fed7255d2708e0f65f8890fceece4e308bd0bb9ff70e23febe5e2" => :sierra
    sha256 "44034738f7049109724ca1bbcc17d4d14c870990166fdb509f9bb461b9053730" => :el_capitan
    sha256 "a5005f151f46a0e2baf596ca5c14e89d7c36a6fbd814d8cde4a0b5a389232323" => :yosemite
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "pkg-config" => :build
  depends_on "assimp"
  depends_on "freetype"
  depends_on "sdl2"
  depends_on "sdl2_image"
  depends_on "libsigc++"
  depends_on "libvorbis"
  depends_on "libpng"
  depends_on "lua"

  needs :cxx11

  def install
    ENV.cxx11
    ENV["PIONEER_DATA_DIR"] = "#{pkgshare}/data"

    # Remove as soon as possible
    # https://github.com/pioneerspacesim/pioneer/issues/3839
    ENV["ARFLAGS"] = "cru"

    system "./bootstrap"
    system "./configure", "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}",
                          "--with-version=#{version}",
                          "--with-external-liblua"
    system "make", "install"
  end

  test do
    assert_equal "#{name} #{version}", shell_output("#{bin}/pioneer -v 2>&1").chomp
    assert_equal "modelcompiler #{version}", shell_output("#{bin}/modelcompiler -v 2>&1").chomp
  end
end
