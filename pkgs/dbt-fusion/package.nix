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
      dbtHash = "sha256-I1MB+uVu5FW2RtqjK4FNEWbv/5eidf/vYjiFnMzRCD8=";
      lspHash = "sha256-FOYL2gGOOqLP5WnQvaTaYn/+vMMzCzXsWg1hO/Ih/Lk=";
    };
    "aarch64-linux" = {
      name = "aarch64-unknown-linux-gnu";
      dbtHash = "sha256-/Pa/4JSCyFCObzMrgjT8WBeYaZ+y49Qqp9kwH7PFRyo=";
      lspHash = "sha256-X5+6b28/lDrWobsSsFBu/KAd2LmXf9erl+fpoZGxfB8=";
    };
    "x86_64-darwin" = {
      name = "x86_64-apple-darwin";
      dbtHash = "sha256-2VVfgkJbREJGR/gtmaH7YP/n+Z3HpNJiOsGNF5GQ8kw=";
      lspHash = "sha256-T9/TPGIz5uj2OqSls2tra8ZJr/j+winsWnKTiD2MCV0=";
    };
    "aarch64-darwin" = {
      name = "aarch64-apple-darwin";
      dbtHash = "sha256-fyH6averdx4/N7F/Ipt5UcCE9MT6m8d+QiEG6keAfhc=";
      lspHash = "sha256-AvmWPmq+kTOtf55jXgExpbiebyULoQ5QrIl6nySYB58=";
    };
  };
  platform = systemToPlatform.${system} or throwSystem;
in
stdenv.mkDerivation (finalAttrs: {
  pname = "dbt-fusion";
  version = "2.0.0-preview.114";

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
