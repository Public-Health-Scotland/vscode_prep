# **vscode_prep**
This repo helps to prepare your vscode 1.102.0 (Python and/or R) in the new Posit. These steps are also compatible with Positron (2025.08.1 build 11).

## 1. Clone this repo
- If you want to clone this repo, launch a vs code/Positron session and open a terminal using ctrl + shift + '
- If you do not want to clone this repo you can skip this section and create your .sh files manually.
- Run the command in terminal `git clone https://github.com/Public-Health-Scotland/vscode_prep.git`
- There are more useful GitHub commands here [View GitHub Folder README](GitHub/README.md)
- Then you have to open your project folder using vs code/Positron. Go to the left hand menu and click on the explorer. You will see an Open Folder button. Click that button and you will see a dropdown list. You can click on vscode_prep folder and then click OK

## 2. Clean old extensions
- You can skip this section if you have never installed any extensions in your IDE
- Open a terminal on vscode (ctrl + shift + ') if you haven't opened one yet.
- You can use uninstall_extensions.sh from this repo in order to remove all extensions. It is recommended if you have previously installed extensions.
- Make sure uninstall_extensions.sh has executable permissions, run this command: `ls -l uninstall_extensions.sh`. You should see "x" on the left hand side permissions file details section.
- Execute in terminal depending on your IDE to uninstall all installed extensions: 
| IDE       | Command                                 |
|-----------|-----------------------------------------|
| vs code   | `bash uninstall_extensions.sh vscode`   |
| positron  | `bash uninstall_extensions.sh positron` |
- You will see **Extensions removal completed!** in your terminal.

## Extensions for vscode
There are some extensions which will help to improve your development experience. The script called “install_extensions.sh” will automate the installation process. You can modify this file depending on your needs. These are the most used extensions you can find in the script:

| Extension          | Description                                      |
|--------------------|--------------------------------------------------|
| ms-python.python   | Python support                                   |
| ms-python.debugpy  | Python debbuger                                  |
| ms-pyright.pyright | Fast static type checker for Python              | 
| quarto.quarto      | Support for Quarto documents and publishing      | 
| autodocstring      | autogenerate functions documentation             | 
| ms-toolsai.jupyter | Jupyter Notebooks support                        | 
| jupyter-renderers  | improves plot support in notebooks               | 
| prettier-vscode    | Formatter for many type of files extensions      | 
| rainbow-csv        | It helps to see your CSV files in a nicer way    | 
| gitlens            | It gives you more details about you GitHub repo  | 
| code-runner        | It gives you more details about you GitHub repo  | 
| Air - R            | Support for R language                           | 
| shiny              | Support for shiny projects                       | 
| Ruff               | Fast Python linter and formatter                 | 
| shiny UIEditor     | Posit extension to blue print shiny apps.        | 
| draw.io            | useful extension to create workflow diagrams     | 

## How to run this bash
- Open a terminal on vscode (ctrl + shift + ') if you haven't opened one yet.
- Make sure “install_extensions.sh” has executable permissions `ls -l install_extensions.sh`. You should see "x" on the left hand side permissions file details section.
![alt text](./img/image-7.png)
- If you cannot see the x you should change the permissions using `chmod +x install_extensions.sh`
- Run in your terminal: 
| IDE       | Command                                    |
|-----------|--------------------------------------------|
| vs code   | `bash install_extensions.sh vscode base`   |
| positron  | `bash install_extensions.sh positron base` |

- You will see **Installation completed!** in your terminal. So, it means everything worked ok.
- You need to reload your vs code/Positron to make sure loading extensions. Press ctrl + shift + p and search Developer reload window
![alt text](img/image-19.png)
- (More extensions) There are some other extensions installers in this repo. One of them is jsoncrack. It would be installed from offline_installers folder because it was downloaded from the Official microsoft marketplace. This folder content is part of the bash script install_extensions.sh offline section bash file installer.

## More guides
This repository also have other useful guides.

| Topic    | Location                                     | Description                                   |
|----------|----------------------------------------------|-----------------------------------------------|
| Python   | [View Python README](./Python/README.md)     | How to create a virtual environment and use it |
| Positron | [View Positron README](./Positron/README.md) | How to prepare Positron IDE                   |
| GitHub   | [View GitHub README](./GitHub/README.md)     | How to use GitHub with vs code/Positron       |

# **Frequently asked questions**

**How can I use the vscode-icons?**
- Go to the left hand side bar and click on extensions. Then, click on the vscode-icons (Positron compatible), click on set file icon theme and finally click on VSCode icons.
![alt text](./img/image-6.png)

**How do I navigate to a folder on the stats drive to open a file?**
- It is easy if you create a shortcut (symbolic link). You need to open a terminal and run this command: ln -s /conf/my_path /mnt/homes/your_user/name_for_your_shortcut
- You must initialise your VS Code and go to the menu (top left) or simply press ctrl + k + o. I recommend opening a folder because projects need to be organised, and you can easily access all those files in the Explorer tab.
- If you have a venv you have to open your folder, open a terminal and activate your venv.

**How do I specify where I want to save a script?**
- If you previously opened a folder, you can add files in the same folder using the Explorer tab. There are two options (new folder and new file). You can add .py (normal scripts) or .ipynb (jupyter notebook).
![alt text](./img/image.png)

**Is there an environment like there is with R where I can see what I've created?**
- If you are running a .ipynb file extension you can use Jupyter variable windows. You should go to the menu (top left) and select terminal – new terminal. After that, you click on Jupyter variables tab.
![alt text](./img/image-1.png)
- You can use the extension code runner to run chunks of code. You need to select the lines of code and choose "run code" on the right-click menu or press ctrl + alt + n
![alt text](./img/image-2.png)

**Can I use question mark to ask about functions?**
- You can use question mark (?) and double question mark (??) after the function to get some informatio like this:
![alt text](./img/image-14.png)
Only available in Jupyter notebooks (VS code) or Positron console tab

**Can I export a Jupyter notebook in HTML format?**
- Yes, you can. Press ctr + shift + p and search Export to html
![alt text](./img/image-15.png)
- If you are working with Plotly you will need to add these lines of code at the beginnin of your Notebook: 
`import plotly.io as pio
pio.renderers.default = 'notebook_connected'`

**How can I use JSON crack extension?**
- If you have a JSON file in your project and you can see the structure in a easy way, you neeed to open the file and go to the right-hand side corner. Press the JC icon:
![alt text](./img/image-4.png)
- You will have a result like this:
![alt text](./img/image-5.png)

**How can I format my files?**
- Tou need to select all your code using `ctrl + a`
- Right clic and choose Format document with
- If it's a Python file, you will see the option "Ruff". Otherwise, you will see Prettier. 
- Clic on it and you will see your script being formatted.
![alt text](./img/image-8.png)
![alt text](./img/image-9.png)

**How can I create a diagrama using draw.io?**
- You need to create a new file with the following extension .drawio.svg
![alt text](img/image-24.png)
- If you already installed drawio extension you will be able to open that file
- You can find different icons. Search by words in the textbox
![alt text](img/image-25.png)
- You can add your diagraman to a README.md file like this:
![Diagram](diagrams/my_diagram.drawio.svg)
