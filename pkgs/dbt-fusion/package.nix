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
      dbtHash = "sha256-sM0DUfDq2fpenivmErkJa8x9tP889Its8/6nPe58WRU=";
      lspHash = "sha256-YHWutfw7IzS+b4ArCI/Z7EBRUKDokvTdWFjheCoKS7c=";
    };
    "aarch64-linux" = {
      name = "aarch64-unknown-linux-gnu";
      dbtHash = "sha256-JJBGoPCbMJrEm+l/4oGCl3vukpPLmvE0lBIgOGIn5k8=";
      lspHash = "sha256-/E2VtR4iVodi6Sfme/yj8m1RkDizdN37ohdthHgajYs=";
    };
    "x86_64-darwin" = {
      name = "x86_64-apple-darwin";
      dbtHash = "sha256-CIPgamL5FsojN0/Jshf7/euyuUIVwI4N1Zo9s2bihDo=";
      lspHash = "sha256-tCvyDnoo2tvheHVJQ+8rNo5mhcUC39ryIcA3rsI5Nmc=";
    };
    "aarch64-darwin" = {
      name = "aarch64-apple-darwin";
      dbtHash = "sha256-6e+1wlfF+kGmnGVuItv6YMugEgYfk8SOcwAoyW4y8To=";
      lspHash = "sha256-Jt4LYD3yn6lUlFiqVDMqMqwnMTmVzWmdOCnHzBcF0wc=";
    };
  };
  platform = systemToPlatform.${system} or throwSystem;
in
stdenv.mkDerivation (finalAttrs: {
  pname = "dbt-fusion";
  version = "2.0.0-preview.27";

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
