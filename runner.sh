#! /bin/bash 

echo
echo "Let's check your git configuration..."

email=$(git config --global --get user.email)
name=$(git config --global --get user.name)

if [ "$email" != "git" -a "$name" != "git" -a "$name" -a "$email" ]
then 
    echo
    echo "Git looks like it's all set up!"
fi

if [ ! "$email" -o "$email" = "git" ]
then 
    echo
    echo "What email address is associated with GitHub?"
    read email
    (git config --global --add user.email $email)
    echo
    echo "Git now knows your email is: $email"
fi

if [ ! "$name" -o "$name" = "git" ]
then 
    echo
    echo "What's your name?"
    read name
    (git config --global --add user.name $name)
    echo
    echo "Git now knows your name is: $name"
fi

## When we're ready to start parsing tags in a meaningful way, the following might be helpful...
# echo 
# PS3="Which team are you on? (enter the number)"
# select team in platform pretrade posttrade
# do 
#   break
# done

# PS3="Select the tags that you wish to apply:"
# select tags in frontend backend general
# do 
#   echo $tags
# done


if [[ $(command -v brew) == "" ]]; then
    echo "Installing Hombrew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo "Updating Homebrew"
    brew update
fi

brew install ansible

ansible-pull -U https://github.com/lonsdaledm/gangway