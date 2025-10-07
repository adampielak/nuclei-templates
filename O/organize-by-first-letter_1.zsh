#!/usr/bin/env zsh
# Move files (not directories) into subfolders based on the first character.
# A-Z -> "A".."Z", digits -> "0-9", anything else -> "_"

# Use zsh semantics and enable extended glob for qualifiers like .N
emulate -L zsh
set -e
set -u
set -o pipefail
setopt extended_glob

# Work in given directory or current one
dir="${1:-.}"
[[ -d "$dir" ]] || { print -u2 -- "Error: not a directory: $dir"; exit 2; }
cd -- "$dir"

# Iterate only regular files; .N makes empty matches expand to nothing
for f in *(.N); do
  # Safety: skip if not a file (race)
  [[ -f "$f" ]] || continue

  # First character (zsh substring [start,end])
  first="${f[1,1]}"

  # Decide target folder using case (robust for patterns)
  case "$first" in
    [[:alpha:]]) folder="${(U)first}" ;;  # uppercase A-Z
    [0-9])       folder="0-9" ;;
    *)           folder="_" ;;
  esac

  # Create target directory if missing
  [[ -d "$folder" ]] || mkdir -p -- "$folder"

  target="$folder/$f"

  # Resolve name conflicts by appending numeric suffix before extension
  if [[ -e "$target" ]]; then
    name_no_ext="${f%.*}"
    ext="${f##*.}"
    if [[ "$name_no_ext" == "$f" ]]; then
      # no extension
      i=1
      while [[ -e "$folder/${name_no_ext}_$i" ]]; do (( i++ )); done
      target="$folder/${name_no_ext}_$i"
    else
      # has extension
      i=1
      while [[ -e "$folder/${name_no_ext}_$i.$ext" ]]; do (( i++ )); done
      target="$folder/${name_no_ext}_$i.$ext"
    fi
  fi

  # Move the file
  mv -- "$f" "$target"
done

print -- "Done."
