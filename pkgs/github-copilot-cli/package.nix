{
  lib,
  buildNpmPackage,
  fetchzip,
  nix-update-script,
}:

buildNpmPackage (finalAttrs: {
  pname = "github-copilot-cli";
  version = "0.0.330";

  src = fetchzip {
    url = "https://registry.npmjs.org/@github/copilot/-/copilot-${finalAttrs.version}.tgz";
    hash = "sha256-Pmx5fJoGoiuvYiRqKE8LN44U5c4Sfij3iHdha0pBkPM=";
  };

  npmDepsHash = "sha256-u2lofopWa07/D+0n98Y63OhK0LaWmY5iEMGS6qQ/mEs=";

  postPatch = ''
    cp ${./package-lock.json} package-lock.json
  '';

  dontNpmBuild = true;

  passthru.updateScript = nix-update-script { extraArgs = [ "--generate-lockfile" ]; };

  meta = {
    description = "GitHub Copilot CLI brings the power of Copilot coding agent directly to your terminal";
    homepage = "https://github.com/github/copilot-cli";
    changelog = "https://github.com/github/copilot-cli/releases/tag/v${finalAttrs.version}";
    downloadPage = "https://www.npmjs.com/package/@github/copilot";
    license = lib.licenses.unfree;
    maintainers = with lib.maintainers; [
      dbreyfogle
    ];
    mainProgram = "copilot";
  };
})
