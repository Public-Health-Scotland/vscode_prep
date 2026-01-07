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
    PWB_APP="/usr/lib/rstudio-server/bin/pwb-code-server/bin/code-server"
elif [ "$ide" == "positron" ]; then
    # for positron
    PWB_APP="/usr/lib/rstudio-server/bin/positron-server/bin/positron-server"
else
    echo "Unknown IDE: $ide"
    exit 1
fi

# vs code extensions which is never uninstalled
ONLY_ID="b907bd27103da661e0bd06d35d07bc8e79bbf27a"

# helper to get extensions ID
list_extension_ids() {
  "$PWB_APP" --list-extensions 2>/dev/null \
  | grep -E '^[a-z0-9.-]+\.[a-z0-9.-]+$|^[a-f0-9]{40,}$' \
  | grep -v -F "$ONLY_ID"
}

while (( $(list_extension_ids | wc -l) > 0 )); do
  for ext in $(list_extension_ids); do
    if ! "$PWB_APP" --uninstall-extension "$ext"; then
      echo "*WARN: uninstall failed for $ext" >&2
    fi
  done
done
echo "Extensions removal completed!"