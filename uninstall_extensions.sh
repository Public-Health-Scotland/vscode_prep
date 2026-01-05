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

for ext in $($PWB_APP --list-extensions); do
    $PWB_APP --uninstall-extension "$ext"
done