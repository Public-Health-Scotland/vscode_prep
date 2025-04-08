!/bin/bash
echo "Important extensions for VSCode"

# URLs of the VSIX files
URLS=(
  "https://open-vsx.org/api/ms-python/python/2024.14.1/file/ms-python.python-2024.14.1.vsix"
  "https://open-vsx.org/api/ms-toolsai/jupyter/2024.8.1/file/ms-toolsai.jupyter-2024.8.1.vsix"
  "https://open-vsx.org/api/vscode-icons-team/vscode-icons/12.12.0/file/vscode-icons-team.vscode-icons-12.12.0.vsix"
  "https://open-vsx.org/api/esbenp/prettier-vscode/11.0.0/file/esbenp.prettier-vscode-11.0.0.vsix"
  "https://open-vsx.org/api/mechatroner/rainbow-csv/3.3.0/file/mechatroner.rainbow-csv-3.3.0.vsix"
  "https://open-vsx.org/api/eamodio/gitlens/2025.4.705/file/eamodio.gitlens-2025.4.705.vsix"
  "https://open-vsx.org/api/formulahendry/code-runner/0.12.2/file/formulahendry.code-runner-0.12.2.vsix"
  "https://open-vsx.org/api/johnpapa/vscode-peacock/4.2.2/file/johnpapa.vscode-peacock-4.2.2.vsix"
)

# Download and install each VSIX file
for URL in "${URLS[@]}"; do
  SAVE_LOCATION="/tmp/$(basename $URL)"
  echo "Downloading $URL to $SAVE_LOCATION"
  curl $URL -L -o $SAVE_LOCATION
  echo "Installing $SAVE_LOCATION"
  /usr/lib/rstudio-server/bin/pwb-code-server/bin/code-server --install-extension $SAVE_LOCATION
done
