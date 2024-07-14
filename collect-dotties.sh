#! /bin/bash

# =============================================================================
# Name:         collect-dotties.sh
# Info:         ...collects configured files and foo
# Author:       derdoktor667
# Date:         $(date +%Y-%m-%d)
# Version:      0.1
# =============================================================================

# ...getting settings
source "$PWD/targets.conf"

source_files=$HOME
target_folder=$PWD

# 
show_help() {
    echo "Verwendung: $0 [--force] [--help]"
    echo "Kopiert ausgewählte Dateien aus einem Git-Repository in einen Zielordner."
    echo
    echo "Optionen:"
    echo "  --run      Notwendig um überhaupt was zu tun"
    echo "  --force    Überschreibt bestehende Dateien im Zielordner. OHNE --run möglich"
    echo "  --help     Zeigt diese Hilfe an und listet die zu kopierenden Dateien auf."
    echo
    echo "Zu kopierende Dateien:"
    for file in "${files_to_copy[@]}"; do
        echo "  - $file"
    done
}

copy_files() {
    # 
    cd "$source_files" || { echo "Konnte nicht in das Source Dir wechseln"; exit 1; }
    
    # 
    for file in "${files_to_copy[@]}"; do
        # 
        target_path="$target_folder/${file}"
        
        #
        mkdir -p "$(dirname "$target_path")"
        
        #
        if [[ $force_copy == true ]]; then
            cp "$source_files/$file" "$target_path"
            echo "Die Datei $file wurde überschrieben."
        else
            if [ ! -f "$target_path" ]; then
                cp "$source_files/$file" "$target_path"
            else
                echo "Die Datei $file existiert bereits am Zielort und wird nicht überschrieben."
            fi
        fi
    done
    
    echo "Das Kopieren der ausgewählten Dateien ist abgeschlossen."
}

#
case "$1" in
    --collect)
    ;;
    --force)
        force_copy=true
        copy_files
    ;;
    --help)
        show_help
        exit 0
    ;;
    --install)
    ;;
    --run)
        force_copy=false
        copy_files
    ;;
    *)
        show_help
        exit 0
    ;;
esac
