# Get the first argument
ide=$1
option=$2

# Check arg count
if [[ $# -ne 2 ]]; then
  echo "Error: exactly 2 arguments required (ide and option)." >&2
  echo "Usage: $0 <ide> <option>"
  echo "Examples:"
  echo "  $0 vscode base"
  echo "  $0 positron base"
  echo "  $0 vscode java"
  echo "  $0 positron java"
  echo "  $0 vscode all"
  echo "  $0 positron all"
  exit 2
fi

# base extensions
BASE_URL=(
  "vscode-icons-team.vscode-icons"
  "ms-python.python"
  "ms-python.debugpy"
  "njpwerner.autodocstring"
  "ms-toolsai.jupyter"
  "ms-toolsai.jupyter-renderers"
  "ms-toolsai.vscode-jupyter-slideshow"
  "ms-toolsai.vscode-jupyter-cell-tags"
  "ms-toolsai.jupyter-keymap"
  "esbenp.prettier-vscode"
  "eamodio.gitlens"
  "posit.air-vscode"
  "posit.shiny"
  "quarto.quarto"
  "meta.pyrefly"
  "charliermarsh.ruff"
  "hediet.vscode-drawio"
  "github.vscode-pull-request-github"
  "aykutsarac.jsoncrack-vscode"
)

# add java extensions
JAVA_URL=(
  "vscjava.vscode-java-dependency"
  "vscjava.vscode-maven"
  "vscjava.vscode-gradle"
  "vscjava.vscode-java-test"
  "redhat.java"
  "vscjava.vscode-java-debug"
)

# Check the value of ide
if [ "$ide" == "vscode" ]; then
    # for vscode
    PWB_APP="/usr/lib/rstudio-server/bin/pwb-code-server/bin/vscode-server"
    echo "You selected VS Code"
    
    VS_URL=(
      "formulahendry.code-runner"
      "mechatroner.rainbow-csv"
      "reditorsupport.r"
    )

    BASE_URL=( "${BASE_URL[@]}" "${VS_URL[@]}" )
elif [ "$ide" == "positron" ]; then
    # for positron
    PWB_APP="/usr/lib/rstudio-server/bin/positron-server/bundled/bin/positron-server"
    echo "You selected Positron"

    POSIT_URL=(
      "posit.assistant"
      "posit.publisher"
    )

    BASE_URL=( "${BASE_URL[@]}" "${POSIT_URL[@]}" )
else
    echo "Not supported IDE: $ide"
    exit 1
fi

if [ "$option" == "all" ]; then
  echo "All extensions for Python/R/Java"
  URLS=( "${BASE_URL[@]}" "${JAVA_URL[@]}" )
elif [ "$option" == "base" ]; then
  echo "Extensions only for Python/R"
  URLS=( "${BASE_URL[@]}" )
elif [ "$option" == "java" ]; then
  echo "Extensions only for Java"
  URLS=( "${JAVA_URL[@]}" )
else
  echo "Unknown extensions option: $option"
  exit 1
fi

export NODE_OPTIONS="--no-deprecation"
export NODE_EXTRA_CA_CERTS="/etc/ssl/certs/ca-certificates.crt"

for ext in "${URLS[@]}"; do
  $PWB_APP --install-extension "$ext" --force
done

echo "Installation completed!"