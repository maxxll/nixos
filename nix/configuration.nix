{ config, pkgs, lib, ... }:

{
 
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
    
    services.grafana = {
   enable = true;
   addr = "0.0.0.0";
   port = 3000;
   security = {
     adminUser = "admin";
     adminPassword = "admin";
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
      Host "localhost"
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
 };

  environment.systemPackages = with pkgs; [ git s3cmd mc vim htop logrotate ];
}
