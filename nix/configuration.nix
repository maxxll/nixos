{ config, pkgs, lib, ... }:

{

    swapDevices = [ { device = "/var/swapfile"; size = 8192; } ];
 
    systemd.services.vvv = {
    description = "my service";    
        script =
        ''
        date >> /var/log/xxx.log
        '';
    };
    
    systemd.timers.vvv = {
    wantedBy = [ "timers.target"];
    description = "my timer";
      timerConfig = {
        OnCalendar="*-*-* *:*:00";      
      };
    };
    
  networking.firewall.allowedTCPPorts = [ 80 2000 3000 22 8080 ];
        
  services = {
  
      nginx = {
      enable = true;
      
      httpConfig =
      '';
      server {
        listen 0.0.0.0.80;
        server_name xxx;
        root /www/
        access_log /var/log/access.log;
        error_log /var/log/error.log;
      }
      '';
      
      };

  
   grafana = {
   enable = true;
   addr = "0.0.0.0";
   port = 3000;
   security = {
     adminUser = "admin";
     adminPassword = "admin";
     };
    };
    
      graphite = {
      web.enable = true;
      carbon = {
        enableCache = true;
        };
        };
        
       
 
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
      Host "127.0.0.1"
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
        '';
        };

  cron = {
         enable = true;
         systemCronJobs = [
           "*/10 * * * * root /root/shut.sh"
           ];
      }; 
 };

  environment.systemPackages = with pkgs; [ git s3cmd mc vim htop logrotate python wget ];
}
