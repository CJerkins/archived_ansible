#! /bin/bash

# usage run command with ./git_init <project name>
# mkrole will then create role directorys in the project directory
# and setup git for your new role

# mkpy requires python 3.4+, git, and ansible to be installed
 
# define function
addToGitignore () {

    # add filename to .gitignore
    echo "(hit q for quit)" 
    while :
    do

        read -p "Type file name to add to .gitignore: " filename
        # quit when
        if [ $filename = "q" ]
            then
                break
            else
                echo $filename >> .gitignore
        fi


    done

}

rm -rf .git

# get user name
username=`git config user.name`
read -p "Is this your user name, '$username'?(y/n)" answer_username
case $answer_username in
  y)
    # use current found username
    reponame=$username
    ;;
  n)
    read -p "Enter your user name: " username
    if [ "$reponame" = "" ]; then
        break
    fi
    ;;
  *)
    ;;
esac

# get gitlab or github server name
read -p "Enter gitlab server domain name. (Example gitlab.drokdev.pro): " git_server
if [ "$git_server" = "" ]; then
    break
fi


# create project directory
repo_name=$1
curl https://gitlab.cirrus-ss.com/razrdog/boilerplate/raw/master/git_helpers/commit_push.sh > commit_push.sh

# init
git init


# .gitignore
read -p "Do you want to add .gitignore? (y/n)" answer

case $answer in
  y)
    touch .gitignore
    addToGitignore
    ;;
  n)
    continue
    ;;
  *)
    ;;
esac


# setup git
git add .
git remote add origin git@$git_server:$username/$repo_name.git

# Commit and push
read -p "Commit message: " commitMessage
read -p "Do you want to commit and push? (y/n)" answer
case $answer in
  y)
    # commit and push new project to gitlab
    echo "Pushing to remote ..."
    git commit -m "$commitMessage"
    git push -u origin master
    echo " done."
    ;;
  n)
    echo "Make sure to run git commit -m 'Message'"
    echo "And git push -u origin master"
    continue
    ;;
  *)
    ;;
esac


# open in a browser 
read -p "Do you want to open the new repo page in browser?(y/n): " answer_browser

case $answer_browser in
  y)
    echo "Opening in a browser ..."
    open https://$git_server/$username/$repo_name
    ;;
  n)
    continue
    ;;
  *)
    ;;
esac
