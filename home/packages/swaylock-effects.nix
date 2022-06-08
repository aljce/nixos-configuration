{ stdenv, fetchFromGitHub,
  meson, ninja, pkgconfig, scdoc,
  wayland, wayland-protocols, libxkbcommon,
  cairo, gdk-pixbuf, pam
}:

stdenv.mkDerivation rec {
  pname = "swaylock-effects";
  version = "v1.6-1";

  src = fetchFromGitHub {
    owner = "mortie";
    repo = "swaylock-effects";
    rev = version;
    sha256 = "044fc4makjx8v29fkx5xlil6vr1v4r0k6c8741pl67gzvlm4cx3i";

  };

  postPatch = ''
    sed -iE "s/version: '1\.3',/version: '${version}',/" meson.build
  '';

  nativeBuildInputs = [ meson ninja pkgconfig scdoc ];
  buildInputs = [ wayland wayland-protocols libxkbcommon cairo gdk-pixbuf pam ];

  mesonFlags = [
    "-Dpam=enabled" "-Dgdk-pixbuf=enabled" "-Dman-pages=enabled"
  ];
}
