{
  stdenv,
  lib,
  fetchurl,
}:

let
  inherit (stdenv.hostPlatform) system;
  throwSystem = throw "Unsupported system: ${system}";
  systemToPlatform = {
    "x86_64-linux" = {
      name = "linux_amd64";
      hash = "sha256-eWGc9QaqA7AfOJ+Mg+MU2LurKdtRNQ2VrfJZvRArHVo=";
    };
    "aarch64-linux" = {
      name = "linux_arm64";
      hash = "sha256-69DrP+qwwCZNa9NpYc5g1ne4IukP62imcW4gpXD/Jzg=";
    };
    "x86_64-darwin" = {
      name = "darwin_amd64";
      hash = "sha256-U0a1BcW7Y9vpYJLMOFcWzD8BBlGd88jknmtkdJjGNm0=";
    };
    "aarch64-darwin" = {
      name = "darwin_arm64";
      hash = "sha256-h8JallK0IPR8BnqAZxzfSL/GYH8twT0Zim91rdw0wCY=";
    };
  };
  platform = systemToPlatform.${system} or throwSystem;
in
stdenv.mkDerivation (finalAttrs: {
  pname = "astro-cli";
  version = "1.42.1";

  src = fetchurl {
    url = "https://github.com/astronomer/astro-cli/releases/download/v${finalAttrs.version}/astro_${finalAttrs.version}_${platform.name}.tar.gz";
    hash = platform.hash;
  };

  sourceRoot = ".";

  installPhase = ''
    runHook preInstall
    install -m755 -D astro $out/bin/astro
    runHook postInstall
  '';

  passthru.updateScript = ./update.sh;

  meta = {
    changelog = "https://github.com/astronomer/astro-cli/releases/tag/v${finalAttrs.version}";
    description = "CLI that makes it easy to create, test and deploy Airflow DAGs to Astronomer";
    homepage = "https://github.com/astronomer/astro-cli";
    license = lib.licenses.asl20;
    mainProgram = "astro";
    maintainers = with lib.maintainers; [ dbreyfogle ];
    platforms = lib.attrNames systemToPlatform;
  };
})
