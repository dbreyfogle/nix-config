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
      hash = "sha256-v+p9vmb7O7VZT/5jKQL4nd9e1b2UYD86NANGPeQBZLU=";
    };
    "aarch64-linux" = {
      name = "linux_arm64";
      hash = "sha256-uwKGCP5f+cPdg802jbbmmoYqI69+mc8Mdw8hInlo0G4=";
    };
    "x86_64-darwin" = {
      name = "darwin_amd64";
      hash = "sha256-3di8jybM/5XUofq1xpDFtoPjyOUWub0qdDwjbTi3Fwc=";
    };
    "aarch64-darwin" = {
      name = "darwin_arm64";
      hash = "sha256-abG8AVx+7iY6gmcUXIfNe0X+liQq2JRgFvAPdF0uU+s=";
    };
  };
  platform = systemToPlatform.${system} or throwSystem;
in
stdenv.mkDerivation (finalAttrs: {
  pname = "astro-cli";
  version = "1.43.0";

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
