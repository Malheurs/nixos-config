{ stdenv, fetchFromGitHub }:
{
  sddm-astraunot = stdenv.mkDerivation rec {
    pname = "sddm-astronaut-theme";
    version = "5e39e0841d4942757079779b4f0087f921288af6";
    dontBuild = true;
    installPhase = ''
      mkdir -p $out/share/sddm/themes
      cp -aR $src $out/share/sddm/themes/sugar-dark
    '';
    src = fetchFromGitHub {
      owner = "lifeashansen";
      repo = "sddm-nixos";
      rev = "v${version}";
      sha256 = "bqMnJs59vWkksJCm+NOJWgsuT4ABSyIZwnABC3JLcSc=";
    };
  };
}