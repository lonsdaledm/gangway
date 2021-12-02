#! /bin/bash 

echo "Let's get your computer set up!"
sleep 0.5
echo
echo "This process will ask a few questions before performing a few provisional installations.  Once you see a message that says, 'Feel free to step away from your computer', you won't need to provide any more input as the process completes."

sleep 0.5
echo
echo "Let's check your git configuration..."

email=$(git config --global --get user.email)
name=$(git config --global --get user.name)

if [ "$email" != "git" -a "$name" != "git" -a "$name" -a "$email" ]
then 
    echo
    echo "Git looks like it's already set up!"
    sleep 0.5
    echo "We'll run a few preliminary tasks and then need some more input from you."
fi

if [ ! "$email" -o "$email" = "git" ]
then 
    echo
    echo "What email address is associated with GitHub?"
    read email;
    $(git config --global --add user.email "$email")
    echo
    echo "Git now knows your email is: $email"
fi

if [ ! "$name" -o "$name" = "git" ]
then 
    echo
    echo "What's your name?"
    read name;
    $(git config --global --add user.name "$name")
    echo
    echo "Git now knows your name is: $name"
fi

# If Homebrew is not installed install it, otherwise update it
if [[ $(command -v brew) == "" ]]
then
    echo "Installing Homebrew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" > /dev/null
else
    echo "Updating Homebrew"
    brew update
fi

# If the GH cli is not installed, install it
if [[ $(command -v gh) == "" ]]
then
    echo "Installing GitHub CLI"
    brew install --quiet gh
fi

if [[ "$(gh config list)" != *"ssh"* ]]
then
    # This command will prompt the user to connect to GH via a web browser, generating an SSH key as needed
    echo "Signing you into the GitHub CLI..."
    echo "You don't need to use this CLI in your day-to-day work, but it is key to ensuring that this script works appropriately."
    sleep 2
    gh auth login
fi




# If ansible is not installed, install it
if [[ $(command -v ansible) == "" ]]; then
    echo "Installing Ansible"
    brew install --quiet ansible
fi

sleep 0.5
echo
echo "You should be good to step away from your computer at this point."

ansible-pull -U https://github.com/lonsdaledm/gangway