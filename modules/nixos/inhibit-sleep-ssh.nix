{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.myModules.nixos.inhibitSleepDuringSsh;

  inhibitScript = pkgs.writeShellScriptBin "inhibit-sleep-ssh" ''
    #!/bin/sh
    export PATH="${pkgs.procps}/bin:${pkgs.iproute2}/bin:${pkgs.gnugrep}/bin:$PATH"

    cleanup() {
      if [ -f /tmp/inhibit.pid ]; then
        kill "$(cat /tmp/inhibit.pid)"
        rm /tmp/inhibit.pid
      fi
      exit 0
    }
    trap cleanup EXIT

    while true; do
      # Check for active SSH sessions using ss and grep
      if ss -tpn | grep -E ':22(\s|$)' | grep -vqE '127.0.0.1|::1'; then
        if [ ! -f /tmp/inhibit.pid ]; then
          ${config.systemd.package}/bin/systemd-inhibit --what=sleep --why="Active SSH Session" \
            sleep infinity &
          echo $! > /tmp/inhibit.pid
        fi
      else
        if [ -f /tmp/inhibit.pid ]; then
          kill "$(cat /tmp/inhibit.pid)"
          rm /tmp/inhibit.pid
        fi
      fi
      sleep 60
    done
  '';
in
{
  options.myModules.nixos.inhibitSleepDuringSsh = {
    enable = lib.mkEnableOption "Inhibit sleep while SSH sessions are active";
  };

  config = lib.mkIf cfg.enable {
    systemd.services.inhibit-ssh-sleep = {
      enable = true;
      description = "Inhibit sleep while SSH sessions are active";
      serviceConfig = {
        Type = "simple";
        ExecStart = "${inhibitScript}/bin/inhibit-sleep-ssh";
        Restart = "on-failure";
      };
      wantedBy = [ "multi-user.target" ];
    };
  };
}
