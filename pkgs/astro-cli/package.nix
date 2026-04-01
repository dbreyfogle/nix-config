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
      hash = "sha256-kq2y0yNXlj9RwFd7yCECeRicPFkk+vhs52XDD970UVY=";
    };
    "aarch64-linux" = {
      name = "linux_arm64";
      hash = "sha256-4g1cMkSwB4OjpGIJxr9iH9+DmEUtW3LPp2CISkFmul8=";
    };
    "x86_64-darwin" = {
      name = "darwin_amd64";
      hash = "sha256-naC1U31Gzyzp5nh3BcABjA3XfyQR9ffEcdkqGTeq3/c=";
    };
    "aarch64-darwin" = {
      name = "darwin_arm64";
      hash = "sha256-eKhF/VAMNTpcqBG1fFtRhm2lBhEJwFvWWLPNKZki900=";
    };
  };
  platform = systemToPlatform.${system} or throwSystem;
in
stdenv.mkDerivation (finalAttrs: {
  pname = "astro-cli";
  version = "1.40.1";

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
