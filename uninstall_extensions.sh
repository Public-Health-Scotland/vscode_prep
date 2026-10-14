ide=$1

# Usage if no ide provided
if [ -z "$ide" ]; then
    echo "Usage: $0 <ide>"
    echo "Examples:"
    echo "  $0 vscode"
    echo "  $0 positron"
    exit 1
fi

# Check the value of ide
if [ "$ide" == "vscode" ]; then
    # for vscode
    PWB_APP="/usr/lib/rstudio-server/bin/pwb-code-server/bin/vscode-server"
elif [ "$ide" == "positron" ]; then
    # for positron
    PWB_APP="/usr/lib/rstudio-server/bin/positron-server/bundled/bin/positron-server"
else
    echo "Unknown IDE: $ide"
    exit 1
fi

# helper to get extensions ID
list_extension_ids() {
  "$PWB_APP" --list-extensions 2>/dev/null \
  | grep -E '^[a-z0-9.-]+\.[a-z0-9.-]+$|^[a-f0-9]{40,}$' 
}

export NODE_OPTIONS="--no-deprecation"
JUPYTER_REMOVED=false

for ext in $(list_extension_ids); do
  # Skip Jupyter child extensions if parent already removed
  if [ "$JUPYTER_REMOVED" = true ]; then
      case "$ext" in
          ms-toolsai.jupyter-renderers|\
          ms-toolsai.vscode-jupyter-slideshow|\
          ms-toolsai.vscode-jupyter-cell-tags|\
          ms-toolsai.jupyter-keymap)
              echo "Skipping $ext (removed with ms-toolsai.jupyter)"
              continue
              ;;
      esac
  fi
  if ! "$PWB_APP" --uninstall-extension "$ext"; then
    echo "*WARN: uninstall failed for $ext" >&2
  fi
  if [ "$ext" = "ms-toolsai.jupyter" ]; then
      JUPYTER_REMOVED=true
  fi
done
echo "Extensions removal completed!"