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
      hash = "sha256-J78EbHD40NqbSCrkl13Sy8L0IU2Geh3PMA4DZGk5orQ=";
    };
    "aarch64-linux" = {
      name = "linux_arm64";
      hash = "sha256-5hPDG/FoWvRAYM9eCchcTiDxldctlmCmoZr83cfHpxM=";
    };
    "x86_64-darwin" = {
      name = "darwin_amd64";
      hash = "sha256-UYioyF7lZ+wnUqYbB7XysLOw1vSc/5Rbs+AUPBtwzJQ=";
    };
    "aarch64-darwin" = {
      name = "darwin_arm64";
      hash = "sha256-Kdzc4JnLMAVr2JnGGJ2mxsr72uEkk2MUHnq8LMR4FsU=";
    };
  };
  platform = systemToPlatform.${system} or throwSystem;
in
stdenv.mkDerivation (finalAttrs: {
  pname = "astro-cli";
  version = "1.39.0";

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
