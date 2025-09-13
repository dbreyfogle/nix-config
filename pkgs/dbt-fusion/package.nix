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
      dbtHash = "sha256-c7Z9Iy5Cnvi4n2n01yHTsAmuGUfIrTeBck9/pAIq6MM=";
      lspHash = "sha256-IL65bufefp5t89NoFoVNR4onF71FES+PRyuTd7JFQL0=";
    };
    "aarch64-linux" = {
      name = "aarch64-unknown-linux-gnu";
      dbtHash = "sha256-y7rw8UqcuBvo1tJriwyNkSAQjbRapaWVnrwnXxQD2bE=";
      lspHash = "sha256-LlbP0S4XgMay/uAO0SQRZNuf4EVA6UnbpG8lSIOJzoA=";
    };
    "x86_64-darwin" = {
      name = "x86_64-apple-darwin";
      dbtHash = "sha256-w3dGPTAap5JZEZR7CxTYPa+MIkPJZp/DKKGrg5pkj7c=";
      lspHash = "sha256-GB+AIrSV+AMu/SDN5J7KFRnhMqVDjwn5RW3eYrgVnOc=";
    };
    "aarch64-darwin" = {
      name = "aarch64-apple-darwin";
      dbtHash = "sha256-xYmdH2j/AHqB1YP/BByWRgbjAs5LTqYJCoLYZ8Tw7bo=";
      lspHash = "sha256-rZ8jc63FdeswIdu6/0zaTl2JvonwegRHiViSXtARvck=";
    };
  };
  platform = systemToPlatform.${system} or throwSystem;
in
stdenv.mkDerivation (finalAttrs: {
  pname = "dbt-fusion";
  version = "2.0.0-preview.14";

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
