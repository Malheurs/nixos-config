{
  home.file = {
    ".config/hypr/kanagawa.conf".text = ''
      # CONFIGURATION GÉNÉRALE
      general {
          gaps_in = 2
          gaps_out = 3
          border_size = 3
          col.active_border = rgba(E5C07CFF)
          col.inactive_border = rgba(3B4152FF)
          layout = master
          resize_on_border = true
          allow_tearing = true
      }

      # CONFIGURATION GROUPES
      group {
          col.border_active = rgba(E5C07CFF)
          col.border_inactive = rgba(3B4152FF)
          col.border_locked_active = rgba(E5C07CFF)
          col.border_locked_inactive = rgba(3B4152FF)
      }

      # CONFIGURATION CURSEUR
      cursor {
          inactive_timeout = 15
      }

      # CONFIGURATION DÉCORATIONS
      decoration {
          rounding = 10

          blur {
              enabled = true
              size = 6
              passes = 3
              new_optimizations = true
              ignore_opacity = true
              xray = false
          }
      }
    '';
  };
}
