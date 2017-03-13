{ config, pkgs, lib, ... }:

{

  imports = [ <nixpkgs/nixos/modules/virtualisation/amazon-image.nix> ];
  ec2.hvm = true;
  
    systemd.services.zzz = {
    description = "zzz service";
        script =
        ''
        date >> /var/log/xxx.log
        '';
    };
    
    systemd.timers.zzz = {
    description = "zzz timer";
      timerConfig = {
        OnUnitActiveSec = "1min";      
      };
    };
  
  services = {

  #postgresql.enable = false;
  #postgresql.authentication = "local all all ident";
  
  collectd.enable = true;
  collectd.extraConfig =
      ''
      LoadPlugin memory
      LoadPlugin uptime
      LoadPlugin users
      LoadPlugin cpu
      LoadPlugin vmem
      <Plugin vmem>
      Verbose false
      </Plugin>      
      LoadPlugin write_graphite
      <Plugin write_graphite>
      <Node "Graphite">
      Host "34.252.135.14"
      Port "2003"
      Protocol "tcp"
      LogSendErrors true
      Prefix "collectd."
      Postfix "collectd."
      StoreRates true
      AlwaysAppendDS true
      EscapeCharacter "-"
      </Node>
      </Plugin>      
      '';
  
        logrotate = {
        enable = true;
        config = ''
        /var/log/restart-backends.log {
            missingok
            daily
            rotate 10
            compress
        }
        /var/log/tmp/* {
            missingok
            daily
            rotate 18
            compress
        }
        '';
        };

  cron = {
         enable = true;
         systemCronJobs = [
           "*/1 * * * * root /root/shut.sh"
           ];
      };

  #cron.systemCronJobs = [ "#*/1 * * * * system /root/backup.sh" ];
  #cron.mailto = "maxxl@tut.by";
  #cron.enable = true;
  };

  environment.systemPackages = with pkgs; [ git s3cmd mc cabal-install cabal2nix vim ghc htop logrotate graphite2 postgresql ];
}
