# How to use GitHub

If you already setup PAT in R studio you don't need to setup again.

## Option 1: Using your terminal
If you are working in a project which already is on GitHub. Follow these steps:

- Open a terminal (if it isn't already open)
- If you want to check which files have change, run this command: `git status`
![alt text](img/image-4.png)
- You can add all your changes using this command: `git add .`
- It's time to create your commit, use this command: `git commit -m "your_message"`
- Finally, you can push those changes to your repo using, don't forget the branch name: `git push origin branch_name`

Note: Files/folders listed in .gitignore will have a gray colour in your Explorer section and they will stay there no matter which branch you create/move. (.e.g .env file):
![alt text](img/image-5.png)

## Other important GitHub commands.
- If you want to create a new branch: `git checkout -b demo`
- If you want to move to another branch (e.g. back to main):` git checkout main`
- If you want to list branches you copied in your local folder, the asteric indicates your current branch: `git branch`
![alt text](img/image.png)
- If you want to locally delete a branch, don't forget to move to another branch before deletion: `git branch -d demo`
![alt text](img/image-2.png)
- If you want to list changes in the current branch: `git status`
![alt text](img/image-3.png)
- If you want to restore a file, you can use the listed changes from git status command to copy file path. For example I will restore README.md file from GitHub folder: `git restore GitHub/README.md`
