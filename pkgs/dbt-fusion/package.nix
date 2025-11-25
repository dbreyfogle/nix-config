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
      dbtHash = "sha256-7q+XNvXVGTLOKACQxuoFs3gjk3bcwzYnzZtDI7xg+GQ=";
      lspHash = "sha256-OhpNtZZSWpOB4jlGQFoe2VXN4dLV0q77wQ/vkuGSmFs=";
    };
    "aarch64-linux" = {
      name = "aarch64-unknown-linux-gnu";
      dbtHash = "sha256-m4atyFQFL2GW3jvhZrgOKzEeEKaA3856x9Rz/IkXQzg=";
      lspHash = "sha256-r7hqbCvD52hOp7dFIL1HG8YyjA6wlRc3KWlw1jlxwvw=";
    };
    "x86_64-darwin" = {
      name = "x86_64-apple-darwin";
      dbtHash = "sha256-GZqqqpBevgVw/qJETZykq4arFX+5w5RvzgQ6ZOj9fEo=";
      lspHash = "sha256-auB/Zq7FPGmhK7dSVESE/EdkFMe6Ta2rqcnAddoa0Uc=";
    };
    "aarch64-darwin" = {
      name = "aarch64-apple-darwin";
      dbtHash = "sha256-daVUCmXA7N75/014oAkZ2LX9B+ZeQOszOqrKJ2HYNWc=";
      lspHash = "sha256-6yI2IBywp+lFAimbPO2Fu6qYG7D9+GC5k5kJWDbMrbg=";
    };
  };
  platform = systemToPlatform.${system} or throwSystem;
in
stdenv.mkDerivation (finalAttrs: {
  pname = "dbt-fusion";
  version = "2.0.0-preview.76";

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
