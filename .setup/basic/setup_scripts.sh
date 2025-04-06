BIN_DIR="$HOME/.local/bin"
if [ ! -d "$BIN_DIR" ]; then
	mkdir "$BIN_DIR"
fi
for file in ~/scripts/*; do
    [ -f "$file" ] || continue  # Skip directories
    filename=$(basename "$file")
    name_no_ext="${filename%.*}"
    ln -sf "$file" "$BIN_DIR/$name_no_ext"
done
