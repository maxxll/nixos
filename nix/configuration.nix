{ config, pkgs, lib, ... }:

{

  imports = [ <nixpkgs/nixos/modules/virtualisation/amazon-image.nix> ];
  ec2.hvm = true;
  
  services = {

  postgresql.enable = false;
  postgresql.authentication = "local all all ident";
  
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