{ config, pkgs, ... }:

{
  home.file = {
    # Wallpaper Change
    ".config/hypr/scripts/Wallpaper.sh" = {
      text = ''
        #!/usr/bin/env bash

        DIR="$HOME/Images/wallpapers"
        SCRIPTSDIR="$HOME/.config/hypr/scripts"

        PICS=($(find ''${DIR} -type f \( -name "*.jpg" -o -name "*.jpeg" -o -name "*.png" -o -name "*.gif" \)))
        RANDOMPICS=''${PICS[$RANDOM % ''${#PICS[@]}]}

        # Transition config
        FPS=60
        TYPE="random"
        DURATION=1
        BEZIER=".43,1.19,1,.4"
        SWWW_PARAMS="--transition-fps $FPS --transition-type $TYPE --transition-duration $DURATION --transition-bezier $BEZIER"

        swww query || swww init && swww img ''${RANDOMPICS} $SWWW_PARAMS
      '';
      executable = true;
    };

    # Wallpaper Random Script
    ".config/hypr/scripts/WallpaperRandom.sh" = {
      text = ''
        #!/usr/bin/env bash

        # This script will randomly go through the files of a directory, setting it
        # up as the wallpaper at regular intervals
        #
        # NOTE: this script uses bash (not POSIX shell) for the RANDOM variable

        if [[ $# -lt 1 ]] || [[ ! -d $1 ]]; then
          echo "Usage:
          $0 <dir containing images>"
          exit 1
        fi

        # Edit below to control the images transition
        export SWWW_TRANSITION_FPS=60
        export SWWW_TRANSITION_TYPE=simple

        # This controls (in seconds) when to switch to the next image
        INTERVAL=1800

        while true; do
          find "$1" \
            | while read -r img; do
                echo "$((RANDOM % 1000)):$img"
              done \
            | sort -n | cut -d':' -f2- \
            | while read -r img; do
                swww img "$img" 
                sleep $INTERVAL
              done
        done
      '';
      executable = true;
    };

    # Screenshot/Wallpaper Selection Script
    ".config/hypr/scripts/WallpaperSelect.sh" = {
      text = ''
        #!/usr/bin/env bash

        SCRIPTSDIR="$HOME/.config/hypr/scripts"

        # WALLPAPERS PATH
        DIR="$HOME/Images/wallpapers"

        # Transition config
        FPS=30
        TYPE="wipe"
        DURATION=1
        BEZIER=".43,1.19,1,.4"
        SWWW_PARAMS="--transition-fps $FPS --transition-type $TYPE --transition-duration $DURATION"

        # Check if swaybg is running
        if pidof swaybg > /dev/null; then
          pkill swaybg
        fi

        # Retrieve image files
        PICS=($(ls "''${DIR}" | grep -E ".jpg$|.jpeg$|.png$|.gif$"))
        RANDOM_PIC="''${PICS[$((RANDOM % ''${#PICS[@]}))]}"
        RANDOM_PIC_NAME="''${#PICS[@]}. random"

        # Rofi command
        rofi_command="rofi -dmenu -config ~/.config/rofi/config-wallpaper.rasi"

        menu() {
          for i in "''${!PICS[@]}"; do
            # Displaying .gif to indicate animated images
            if [[ -z $(echo "''${PICS[$i]}" | grep .gif$) ]]; then
              printf "$(echo "''${PICS[$i]}" | cut -d. -f1)\n"
            else
              printf "''${PICS[$i]}\n"
            fi
          done

          printf "$RANDOM_PIC_NAME\n"
        }

        swww query || swww init

        main() {
          choice=$(menu | ''${rofi_command})

          # No choice case
          if [[ -z $choice ]]; then
            exit 0
          fi

          # Random choice case
          if [ "$choice" = "$RANDOM_PIC_NAME" ]; then
            swww img "''${DIR}/''${RANDOM_PIC}" $SWWW_PARAMS
            exit 0
          fi

          # Find the index of the selected file
          pic_index=-1
          for i in "''${!PICS[@]}"; do
            filename=$(basename "''${PICS[$i]}")
            if [[ "$filename" == "$choice"* ]]; then
              pic_index=$i
              break
            fi
          done

          if [[ $pic_index -ne -1 ]]; then
            swww img "''${DIR}/''${PICS[$pic_index]}" $SWWW_PARAMS
          else
            echo "Image not found."
            exit 1
          fi
        }

        # Check if rofi is already running
        if pidof rofi > /dev/null; then
          pkill rofi
          exit 0
        fi

        main
      '';
      executable = true;
    };

    # Zen Browser Workspace Manager Script
    ".config/hypr/scripts/zen-workspace-manager.sh" = {
      text = ''
        #!/usr/bin/env bash

        move_window_to_workspace() {
          local window_address="$1"
          local title="$2"
          
          # Vérifier si c'est une fenêtre zen-beta
          local class=$(hyprctl clients -j | jq -r ".[] | select(.address == \"$window_address\") | .class")
          
          if [[ "$class" != "zen-beta" ]]; then
            return
          fi
          
          # Déterminer le workspace en fonction du titre
          local workspace=""
          if [[ "$title" =~ [Mm]onitor1 ]]; then
            workspace=1
          elif [[ "$title" =~ [Mm]onitor2 ]]; then
            workspace=2
          elif [[ "$title" =~ [Mm]onitor3 ]]; then
            workspace=3
          fi
          
          # Déplacer la fenêtre si un workspace a été trouvé
          if [[ -n "$workspace" ]]; then
            echo "Déplacement de la fenêtre '$title' vers workspace $workspace"
            hyprctl dispatch movetoworkspacesilent "$workspace,address:$window_address"
          fi
        }

        # Écouter les événements Hyprland
        socat -u UNIX-CONNECT:/tmp/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock - | while read -r line; do
          event=$(echo "$line" | cut -d'>' -f1)
          data=$(echo "$line" | cut -d'>' -f2-)
          
          # Événement de changement de titre de fenêtre
          if [[ "$event" == "windowtitle" ]]; then
            window_address="0x$(echo "$data" | cut -d',' -f1)"
            title=$(echo "$data" | cut -d',' -f2-)
            move_window_to_workspace "$window_address" "$title"
          fi
          
          # Événement d'ouverture de fenêtre (au cas où le titre serait déjà bon)
          if [[ "$event" == "openwindow" ]]; then
            window_address="0x$(echo "$data" | cut -d',' -f1)"
            # Petit délai pour laisser le temps au titre de se définir
            sleep 0.5
            title=$(hyprctl clients -j | jq -r ".[] | select(.address == \"$window_address\") | .title")
            move_window_to_workspace "$window_address" "$title"
          fi
        done
      '';
      executable = true;
    };
  };
}