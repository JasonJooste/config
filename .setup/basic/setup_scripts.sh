BIN_DIR="$HOME/.local/bin"
SCRIPTS_DIR="$HOME/scripts"
if [ ! -d "$BIN_DIR" ]; then
	mkdir "$BIN_DIR"
fi
for file in "$SCRIPTS_DIR/*"; do
    [ -f "$file" ] || continue  # Skip directories
    filename=$(basename "$file")
    name_no_ext="${filename%.*}"
    ln -sf "$file" "$BIN_DIR/$name_no_ext"
done
# Make the tagcopy venv. I'll look into building them in an actual project if there are more
python3.10 -m venv "$SCRIPTS_DIR/tagcopy_venv"
"$SCRIPTS_DIR/tagcopy_venv/bin/pip" install python-xmp-toolkit==2.0.2
