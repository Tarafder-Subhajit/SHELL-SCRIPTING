EXPLANATION: https://youtu.be/OuyNM5-r8P8?si=bTJV3r-rAgJnI2dB


Suppose you are a devops engineer and you are maintaining a github repo daily.Suppose your manager told you to check the list of users who are using this repo daily. For e.g., if someone resigns, revoke the access of that user from the repo.

  For this we will write a Shell Script for Github API Integration. We will check the github api doc.

Check collabolators in github:
-> Go to the Repo (only your repo)
-> Go to settings tab
-> Go to collaborators and teams
-> check the manage access section

Before executing, export github username and token.
$export username="Subhajit Tarafder"
when we login to github, we use username and password. But when we use githubAPI, we use token. 
to find token -> go to settings in github -> dev settings -> personal access tokens -> tokens(classic) -> generate new token -> generate new token(classic) 

Execution : 
$chmod 777 list-users.sh
$./list-users.sh Tarafder-Subhajit SHELL-SCRIPTING

We will get error saying "jq not installed"
$sudo apt install jq -y
