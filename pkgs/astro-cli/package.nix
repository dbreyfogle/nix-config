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
      hash = "sha256-8VR4JGPOoTOpjUZRXQBcpPiGnwSXNqn4cz6/zGHFCSk=";
    };
    "aarch64-linux" = {
      name = "linux_arm64";
      hash = "sha256-R8BLGT/klLXHpSdFoco3NYKMF4a0FSl45tPIzU1Y5A0=";
    };
    "x86_64-darwin" = {
      name = "darwin_amd64";
      hash = "sha256-F66M8kwqXHCt4WuvMULoyHIDT5oRLD/tt2EeiBEB1xE=";
    };
    "aarch64-darwin" = {
      name = "darwin_arm64";
      hash = "sha256-JfgTTidUDZ/HXtQrlCOMLl82lqYw/gKEXlFGGVlqfuQ=";
    };
  };
  platform = systemToPlatform.${system} or throwSystem;
in
stdenv.mkDerivation (finalAttrs: {
  pname = "astro-cli";
  version = "1.43.1";

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
