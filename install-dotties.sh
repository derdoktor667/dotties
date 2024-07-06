#! /bin/bash

# Definieren Sie den Pfad zum Git-Repository und den Zielordner
source_files=$PWD
target_folder=$HOME

# Liste der zu kopierenden Dateien (Pfade relativ zum Repository)
declare -a files_to_copy=(
  ".config/alacritty/alacritty.toml"
  ".bashrc"
)

# Funktion, um die Hilfe anzuzeigen
show_help() {
  echo "Verwendung: $0 [--force] [--help]"
  echo "Kopiert ausgewählte Dateien aus einem Git-Repository in einen Zielordner."
  echo
  echo "Optionen:"
  echo "  --run      Notwendig um überhaupt was zu tun"
  echo "  --force    Überschreibt bestehende Dateien im Zielordner."
  echo "  --help     Zeigt diese Hilfe an und listet die zu kopierenden Dateien auf."
  echo
  echo "Zu kopierende Dateien:"
  for file in "${files_to_copy[@]}"; do
    echo "  - $file"
  done
}

copy_files() {
# Wechseln Sie in das Git-Repository
cd "$source_files" || { echo "Konnte nicht in das Source Dir wechseln"; exit 1; }

# Kopieren Sie die ausgewählten Dateien
for file in "${files_to_copy[@]}"; do
  # Erstellen Sie den Pfad des Zielordners, der die Ordnerstruktur beibehält
  target_path="$target_folder/${file}"

  # Erstellen Sie die notwendigen Ordner im Zielordner
  mkdir -p "$(dirname "$target_path")"

  # Kopieren Sie die Datei, überschreiben Sie sie bei Verwendung von --force
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

# Überprüfen Sie die übergebenen Switches
case "$1" in
  --force)
    force_copy=true
    copy_files
    ;;
  --help)
    show_help
    exit 0
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
