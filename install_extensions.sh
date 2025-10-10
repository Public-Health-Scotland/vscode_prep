echo "Important extensions for VSCode"

# Online installers
URLS=(
  "https://open-vsx.org/api/ms-vscode/js-debug/1.97.1/file/ms-vscode.js-debug-1.97.1.vsix"
  "https://open-vsx.org/api/ms-python/python/2024.14.1/file/ms-python.python-2024.14.1.vsix"
  "https://openvsxorg.blob.core.windows.net/resources/ms-python/debugpy/linux-x64/2025.6.0/ms-python.debugpy-2025.6.0@linux-x64.vsix"
  "https://open-vsx.org/api/njpwerner/autodocstring/0.6.1/file/njpwerner.autodocstring-0.6.1.vsix"
  "https://open-vsx.org/api/ms-toolsai/jupyter/2024.8.1/file/ms-toolsai.jupyter-2024.8.1.vsix"
  "https://open-vsx.org/api/ms-toolsai/jupyter-renderers/1.0.19/file/ms-toolsai.jupyter-renderers-1.0.19.vsix"
  "https://open-vsx.org/api/ms-toolsai/jupyter-keymap/1.1.2/file/ms-toolsai.jupyter-keymap-1.1.2.vsix"
  "https://open-vsx.org/api/ms-toolsai/vscode-jupyter-cell-tags/0.1.9/file/ms-toolsai.vscode-jupyter-cell-tags-0.1.9.vsix"
  "https://open-vsx.org/api/ms-toolsai/vscode-jupyter-slideshow/0.1.6/file/ms-toolsai.vscode-jupyter-slideshow-0.1.6.vsix"
  "https://open-vsx.org/api/vscode-icons-team/vscode-icons/12.13.0/file/vscode-icons-team.vscode-icons-12.13.0.vsix"
  "https://open-vsx.org/api/esbenp/prettier-vscode/11.0.0/file/esbenp.prettier-vscode-11.0.0.vsix"
  "https://open-vsx.org/api/mechatroner/rainbow-csv/3.3.0/file/mechatroner.rainbow-csv-3.3.0.vsix"
  "https://open-vsx.org/api/eamodio/gitlens/2025.10.405/file/eamodio.gitlens-2025.10.405.vsix"
  "https://open-vsx.org/api/formulahendry/code-runner/0.12.2/file/formulahendry.code-runner-0.12.2.vsix"
  "https://openvsxorg.blob.core.windows.net/resources/posit/air-vscode/linux-x64/0.14.0/posit.air-vscode-0.14.0@linux-x64.vsix"
  "https://open-vsx.org/api/posit/shiny/1.1.0/file/posit.shiny-1.1.0.vsix"
  "https://open-vsx.org/api/quarto/quarto/1.123.0/file/quarto.quarto-1.123.0.vsix"
  "https://open-vsx.org/api/ms-pyright/pyright/1.1.400/file/ms-pyright.pyright-1.1.400.vsix"
  "https://openvsxorg.blob.core.windows.net/resources/charliermarsh/ruff/linux-x64/2025.24.0/charliermarsh.ruff-2025.24.0@linux-x64.vsix"
  "https://open-vsx.org/api/posit/shinyuieditor/0.5.0/file/posit.shinyuieditor-0.5.0.vsix"
  "https://open-vsx.org/api/hediet/vscode-drawio/1.6.6/file/hediet.vscode-drawio-1.6.6.vsix"
)

for URL in "${URLS[@]}"; do
  SAVE_LOCATION="/tmp/$(basename $URL)"
  SAVE_LOCATION="${SAVE_LOCATION//@/}"
  curl $URL -L -o $SAVE_LOCATION
  echo "Installing $SAVE_LOCATION"
  /usr/lib/rstudio-server/bin/pwb-code-server/bin/code-server --install-extension $SAVE_LOCATION
  rm -f $SAVE_LOCATION
done

# Offline installers
for file in ./offline_installers/*.vsix
do
  if [ -e "$file" ]
  then
    /usr/lib/rstudio-server/bin/pwb-code-server/bin/code-server --install-extension $file
    echo "Installed: $file"
  else
    echo "No local extensions files detected in this current folder"
    break
  fi
done
echo "Task completed!"