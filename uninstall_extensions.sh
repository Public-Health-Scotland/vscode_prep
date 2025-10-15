# for vscode
# PWB_APP="/usr/lib/rstudio-server/bin/pwb-code-server/bin/code-server"
# for positron
PWB_APP="/usr/lib/rstudio-server/bin/positron-server/bin/positron-server"
for ext in $($PWB_APP --list-extensions); do
    $PWB_APP --uninstall-extension "$ext"
done