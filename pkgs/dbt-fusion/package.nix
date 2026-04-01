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
      dbtHash = "sha256-1m/c2MO8X4fDuNjdagpIspN3TJXLjGsdGzNWh0BDEBo=";
      lspHash = "sha256-tCUlk2l3+3K/7ZGuH28ZdI7Dm6S7Yrj38TRXnBOvX6A=";
    };
    "aarch64-linux" = {
      name = "aarch64-unknown-linux-gnu";
      dbtHash = "sha256-TXrNmJyJnPdUdcQQv6HbwP4c2PfDcbe7m7QHXp+VGuc=";
      lspHash = "sha256-OuBpgwB+odFIkT9Njcn7GZ5mVYkAOJvHESV7Y5Ox2K0=";
    };
    "x86_64-darwin" = {
      name = "x86_64-apple-darwin";
      dbtHash = "sha256-zGwzNLg153/Y1/r8q4iLUuzOwmbkh4c4zJtA+VVWIyA=";
      lspHash = "sha256-zv2w18iJoLZSnBhH+E8B9/SoKz/cLzOM/lWY5ZGuORw=";
    };
    "aarch64-darwin" = {
      name = "aarch64-apple-darwin";
      dbtHash = "sha256-OgRjVqkOWky7/dApbn9FFcjdhykqd0fcsp5cMEJZD94=";
      lspHash = "sha256-CRzRIqPanPQZL641hUmV+F59VMZcMw86OOlCOH9yZAw=";
    };
  };
  platform = systemToPlatform.${system} or throwSystem;
in
stdenv.mkDerivation (finalAttrs: {
  pname = "dbt-fusion";
  version = "2.0.0-preview.164";

  srcs = [
    (fetchurl {
      url = "https://public.cdn.getdbt.com/fs/cli/fs-v${finalAttrs.version}-${platform.name}.tar.gz";
      hash = platform.dbtHash;
    })
    (fetchurl {
      url = "https://public.cdn.getdbt.com/fs/lsp/fs-lsp-v${finalAttrs.version}-${platform.name}.tar.gz";
      hash = platform.lspHash;
    })
  ];

  nativeBuildInputs = lib.optionals stdenv.hostPlatform.isLinux [ autoPatchelfHook ];

  buildInputs = [ libgcc ];

  sourceRoot = ".";

  installPhase = ''
    runHook preInstall
    install -m755 -D dbt $out/bin/dbtf
    install -m755 -D dbt-lsp $out/bin/dbt-lsp
    runHook postInstall
  '';

  passthru.updateScript = ./update.sh;

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
