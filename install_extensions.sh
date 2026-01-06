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

# Prevent VS Code / code-server "Warning: Ignoring extra certs"
unset NODE_EXTRA_CA_CERTS

# base extensions
BASE_URL=(
  "https://open-vsx.org/api/ms-python/python/2025.16.0/file/ms-python.python-2025.16.0.vsix"
  "https://open-vsx.org/api/ms-python/debugpy/linux-x64/2025.14.1/file/ms-python.debugpy-2025.14.1@linux-x64.vsix"
  "https://open-vsx.org/api/njpwerner/autodocstring/0.6.1/file/njpwerner.autodocstring-0.6.1.vsix"
  "https://open-vsx.org/api/ms-toolsai/jupyter/2025.7.0/file/ms-toolsai.jupyter-2025.7.0.vsix"
  "https://open-vsx.org/api/ms-toolsai/jupyter-renderers/1.0.19/file/ms-toolsai.jupyter-renderers-1.0.19.vsix"
  "https://open-vsx.org/api/ms-toolsai/vscode-jupyter-slideshow/0.1.6/file/ms-toolsai.vscode-jupyter-slideshow-0.1.6.vsix"
  "https://open-vsx.org/api/ms-toolsai/vscode-jupyter-cell-tags/0.1.9/file/ms-toolsai.vscode-jupyter-cell-tags-0.1.9.vsix"
  "https://open-vsx.org/api/ms-toolsai/jupyter-keymap/1.1.2/file/ms-toolsai.jupyter-keymap-1.1.2.vsix"
  "https://open-vsx.org/api/vscode-icons-team/vscode-icons/12.15.0/file/vscode-icons-team.vscode-icons-12.15.0.vsix"
  "https://open-vsx.org/api/esbenp/prettier-vscode/11.0.0/file/esbenp.prettier-vscode-11.0.0.vsix"
  "https://open-vsx.org/api/mechatroner/rainbow-csv/3.3.0/file/mechatroner.rainbow-csv-3.3.0.vsix"
  "https://open-vsx.org/api/eamodio/gitlens/2025.12.604/file/eamodio.gitlens-2025.12.604.vsix"
  "https://open-vsx.org/api/formulahendry/code-runner/0.12.2/file/formulahendry.code-runner-0.12.2.vsix"
  "https://open-vsx.org/api/posit/air-vscode/linux-x64/0.16.0/file/posit.air-vscode-0.16.0@linux-x64.vsix"
  "https://open-vsx.org/api/posit/shiny/1.3.1/file/posit.shiny-1.3.1.vsix"
  "https://open-vsx.org/api/quarto/quarto/1.126.0/file/quarto.quarto-1.126.0.vsix"
  "https://open-vsx.org/api/ms-pyright/pyright/1.1.402/file/ms-pyright.pyright-1.1.402.vsix"
  "https://open-vsx.org/api/charliermarsh/ruff/linux-x64/2025.28.0/file/charliermarsh.ruff-2025.28.0@linux-x64.vsix"
  "https://open-vsx.org/api/posit/shinyuieditor/0.5.0/file/posit.shinyuieditor-0.5.0.vsix"
  "https://open-vsx.org/api/hediet/vscode-drawio/1.6.6/file/hediet.vscode-drawio-1.6.6.vsix"
)

# add java extensions
JAVA_URL=(
  "https://open-vsx.org/api/vscjava/vscode-java-dependency/0.26.3/file/vscjava.vscode-java-dependency-0.26.3.vsix"
  "https://open-vsx.org/api/vscjava/vscode-maven/0.44.0/file/vscjava.vscode-maven-0.44.0.vsix"
  "https://open-vsx.org/api/vscjava/vscode-gradle/3.17.1/file/vscjava.vscode-gradle-3.17.1.vsix"
  "https://open-vsx.org/api/vscjava/vscode-java-test/0.43.2/file/vscjava.vscode-java-test-0.43.2.vsix"
  "https://open-vsx.org/api/redhat/java/linux-x64/1.51.2025121108/file/redhat.java-1.51.2025121108@linux-x64.vsix"
  "https://open-vsx.org/api/vscjava/vscode-java-debug/0.58.3/file/vscjava.vscode-java-debug-0.58.3.vsix"
)

# Check the value of ide
if [ "$ide" == "vscode" ]; then
    # for vscode
    PWB_APP="/usr/lib/rstudio-server/bin/pwb-code-server/bin/code-server"
    echo "You selected VS Code"
elif [ "$ide" == "positron" ]; then
    # for positron
    PWB_APP="/usr/lib/rstudio-server/bin/positron-server/bin/positron-server"
    echo "You selected Positron"

    POSIT_URL=(
      "https://open-vsx.org/api/posit/publisher/linux-x64/1.27.10/file/posit.publisher-1.27.10@linux-x64.vsix"
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

for URL in "${URLS[@]}"; do
  SAVE_LOCATION="/tmp/$(basename $URL)"
  SAVE_LOCATION="${SAVE_LOCATION//@/}"
  curl $URL -L -o $SAVE_LOCATION
  $PWB_APP --install-extension $SAVE_LOCATION
  echo "Installed $SAVE_LOCATION"
  rm -f $SAVE_LOCATION
done

if [[ "$option" == "all" || "$option" == "base" ]]; then
  # Offline installers
  for file in ./offline_installers/*.vsix
  do
    if [ -e "$file" ]
    then
      $PWB_APP --install-extension $file
      echo "Installed: $file"
    fi
  done
fi

echo "Installation completed!"