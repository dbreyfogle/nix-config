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
      hash = "sha256-DVTc8f9nxg1Lbhh0PPbbCF/7OG1wVyEjczk14fVr3xk=";
    };
    "aarch64-linux" = {
      name = "linux_arm64";
      hash = "sha256-Np2KROuprHl1FRZ9hKwHbUeq05eahGwoX/UNvSOFxfU=";
    };
    "x86_64-darwin" = {
      name = "darwin_amd64";
      hash = "sha256-iXEXlt2pL5RRN2P+WwS32mfLfVfBfrVf0sM3r/2atnE=";
    };
    "aarch64-darwin" = {
      name = "darwin_arm64";
      hash = "sha256-mghb8hyshZDjNdonnnuJslg0E+iOit3IhYUixWa+ZRU=";
    };
  };
  platform = systemToPlatform.${system} or throwSystem;
in
stdenv.mkDerivation (finalAttrs: {
  pname = "astro-cli";
  version = "1.38.1";

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
