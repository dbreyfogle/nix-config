{
  stdenv,
  lib,
  fetchurl,
  autoPatchelfHook,
  libgcc,
}:

let
  inherit (stdenv.hostPlatform) system;
  throwSystem = throw "Unsupported system: ${system}";
  systemToPlatform = {
    "x86_64-linux" = {
      name = "x86_64-unknown-linux-gnu";
      hash = "sha256-njjdrtLsReYrv9dHtBu4bEbrjrWXRAcshaOEoizuEQM=";
    };
    "aarch64-linux" = {
      name = "aarch64-unknown-linux-gnu";
      hash = "sha256-UaFD9Jd8whxYXbANA3NawGCiG72xRZ5bUlau5LTjwjc=";
    };
    "x86_64-darwin" = {
      name = "x86_64-apple-darwin";
      hash = "sha256-NJJe2cz26aQDlH9/ZrIbw91ZT6e4EjPKPcqiqSOGOuI=";
    };
    "aarch64-darwin" = {
      name = "aarch64-apple-darwin";
      hash = "sha256-Ik8osQsKuZ7DVILH7V7S4V2cttck1zgRKVVj2c4jL5E=";
    };
  };
  platform = systemToPlatform.${system} or throwSystem;
in
stdenv.mkDerivation (finalAttrs: {
  pname = "dbt-fusion";
  version = "2.0.0-beta.15";

  src = fetchurl {
    url = "https://public.cdn.getdbt.com/fs/cli/fs-v${finalAttrs.version}-${platform.name}.tar.gz";
    hash = platform.hash;
  };

  nativeBuildInputs = lib.optionals stdenv.hostPlatform.isLinux [ autoPatchelfHook ];

  buildInputs = [ libgcc ];

  sourceRoot = ".";

  installPhase = ''
    runHook preInstall
    install -m755 -D dbt $out/bin/dbtf
    runHook postInstall
  '';

  meta = {
    changelog = "https://github.com/dbt-labs/dbt-fusion/blob/main/CHANGELOG.md";
    description = "Next-generation engine for dbt";
    homepage = "https://github.com/dbt-labs/dbt-fusion";
    license = lib.licenses.elastic20;
    mainProgram = "dbtf";
    maintainers = with lib.maintainers; [ dbreyfogle ];
    platforms = lib.attrNames systemToPlatform;
  };
})
