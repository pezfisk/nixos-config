{ config, pkgs, lib, ... }:

{
  programs.waybar = {
    enable = true;
    systemd.enable = true;

    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 34;
        spacing = 8;

        modules-left = [ "hyprland/workspaces" ];
        modules-center = [ "clock" ];
        modules-right = [ "pulseaudio" "network" "cpu" "memory" "battery" "tray" ];

        "hyprland/workspaces" = {
          format = "{icon}";
          format-icons = {
            "1" = "一";
            "2" = "二";
            "3" = "三";
            "4" = "四";
            "5" = "五";
            default = "○";
            active = "●";
          };
          persistent-workspaces = {
            "*" = 5;
          };
        };

        clock = {
          format = "{:%H:%M}";
          format-alt = "{:%A, %B %d, %Y}";
          tooltip-format = "<tt><small>{calendar}</small></tt>";
          calendar = {
            mode = "year";
            mode-mon-col = 3;
            weeks-pos = "right";
            on-scroll = 1;
            format = {
              months = "<span color='#ffead3'><b>{}</b></span>";
              days = "<span color='#ecc6d9'><b>{}</b></span>";
              weeks = "<span color='#99ffdd'><b>W{}</b></span>";
              weekdays = "<span color='#ffcc66'><b>{}</b></span>";
              today = "<span color='#ff6699'><b><u>{}</u></b></span>";
            };
          };
        };

        cpu = {
          format = "  {usage}%";
          tooltip = false;
        };

        memory = {
          format = "  {}%";
        };

        battery = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{icon}  {capacity}%";
          format-charging = "  {capacity}%";
          format-plugged = "  {capacity}%";
          format-icons = [ "" "" "" "" "" ];
        };

        network = {
          format-wifi = "  {signalStrength}%";
          format-ethernet = "  Connected";
          format-disconnected = "  Disconnected";
          tooltip-format = "{ifname}: {ipaddr}";
        };

        pulseaudio = {
          format = "{icon}  {volume}%";
          format-muted = "  Muted";
          format-icons = {
            headphone = "";
            hands-free = "";
            headset = "";
            phone = "";
            portable = "";
            car = "";
            default = [ "" "" "" ];
          };
          on-click = "pavucontrol";
        };

        tray = {
          icon-size = 16;
          spacing = 10;
        };
      };
    };

    style = ''
      * {
        border: none;
        border-radius: 0;
        font-family: "JetBrainsMono Nerd Font", "Font Awesome 6 Free", sans-serif;
        font-size: 14px;
        min-height: 0;
      }

      window#waybar {
        background-color: rgba(17, 17, 27, 0.95);
        color: #cdd6f4;
        transition-property: background-color;
        transition-duration: 0.3s;
      }

      tooltip {
        background: rgba(30, 30, 46, 0.95);
        border: 1px solid rgba(137, 180, 250, 0.5);
        border-radius: 8px;
        color: #cdd6f4;
      }

      tooltip label {
        color: #cdd6f4;
      }

      #workspaces button {
        padding: 0 8px;
        color: #6c7086;
        background-color: transparent;
        transition: all 0.3s ease;
      }

      #workspaces button:hover {
        background: rgba(137, 180, 250, 0.2);
        color: #89b4fa;
      }

      #workspaces button.active {
        color: #89b4fa;
        background: rgba(137, 180, 250, 0.15);
        border-bottom: 2px solid #89b4fa;
      }

      #clock,
      #battery,
      #cpu,
      #memory,
      #network,
      #pulseaudio,
      #tray {
        padding: 0 12px;
        margin: 4px 0;
        background-color: rgba(30, 30, 46, 0.6);
        border-radius: 8px;
      }

      #clock {
        color: #89b4fa;
        font-weight: bold;
      }

      #battery {
        color: #a6e3a1;
      }

      #battery.charging {
        color: #a6e3a1;
      }

      #battery.warning:not(.charging) {
        color: #fab387;
        animation: blink 2s linear infinite;
      }

      #battery.critical:not(.charging) {
        color: #f38ba8;
        animation: blink 1s linear infinite;
      }

      @keyframes blink {
        to {
          opacity: 0.5;
        }
      }

      #cpu {
        color: #f9e2af;
      }

      #memory {
        color: #cba6f7;
      }

      #network {
        color: #94e2d5;
      }

      #network.disconnected {
        color: #f38ba8;
      }

      #pulseaudio {
        color: #f5c2e7;
      }

      #pulseaudio.muted {
        color: #6c7086;
      }

      #tray {
        padding: 0 8px;
      }

      #tray > .passive {
        -gtk-icon-effect: dim;
      }

      #tray > .needs-attention {
        -gtk-icon-effect: highlight;
        background-color: #f38ba8;
      }
    '';
  };
}

