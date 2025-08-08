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
      dbtHash = "sha256-I60qLKhZt7lO8YhM9Slurzoh10l73m1LhaP3g9/fd18=";
      lspHash = "sha256-T+zBBy4vttTmgkuVeWwE/nuLyO+9FLltoZOSyUAPZ5E=";
    };
    "aarch64-linux" = {
      name = "aarch64-unknown-linux-gnu";
      dbtHash = "sha256-qcAydCLZQIsoMMRyvV6FZ9CV6+rKYkz2PGJQLlDtrP0=";
      lspHash = "sha256-SM1kiVP1n2w6DTy4AKZCfKpDV5NMD7UfnW5wbh7+TtM=";
    };
    "x86_64-darwin" = {
      name = "x86_64-apple-darwin";
      dbtHash = "sha256-xMPsJitUJBn43pd7jdPfckuxpZ8xnDvqazxKg7W1eUs=";
      lspHash = "sha256-xtSMNTHU/HArVPt1RoPWynm1PhY2j5vFSlA2ul0NXxU=";
    };
    "aarch64-darwin" = {
      name = "aarch64-apple-darwin";
      dbtHash = "sha256-uaQ3K+xwp0WIuWeyGNfsxAlFHlujvVPUnSS66bDY8nU=";
      lspHash = "sha256-jd82NefefW+TBidsPUHwv6bt7lYQzrd6ztDzIwbIl4k=";
    };
  };
  platform = systemToPlatform.${system} or throwSystem;
in
stdenv.mkDerivation (finalAttrs: {
  pname = "dbt-fusion";
  version = "2.0.0-beta.60";

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
