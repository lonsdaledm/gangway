#! /bin/bash 

export HOMEBREW_NO_ENV_HINTS=true

echo "Let's get your computer set up!"
sleep 1

echo
echo "This process will ask a few questions before performing a few provisional installations.  Once you see a message that says, 'Feel free to step away from your computer', you won't need to provide any more input as the process completes."
sleep 2

echo
echo "Let's check your git configuration..."
sleep 0.5

email=$(git config --global --get user.email)
name=$(git config --global --get user.name)

if [ "$email" != "git" -a "$name" != "git" -a "$name" -a "$email" ]
then 
    echo
    echo "Git looks like it's already set up!"
    echo
    echo "We'll run a few preliminary tasks and then need some more input from you."
    sleep 1
fi

if [ ! "$email" -o "$email" = "git" ]
then 
    echo
    echo "What email address is associated with GitHub?"
    read email;
    $(git config --global --add user.email "$email")
    echo
    echo "Git now knows your email is: $email"
    sleep 0.5
fi

if [ ! "$name" -o "$name" = "git" ]
then 
    echo
    echo "What's your name?"
    read name;
    $(git config --global --add user.name "$name")
    echo
    echo "Git now knows your name is: $name"
    sleep 0.5
fi

# If Homebrew is not installed install it, otherwise update it
if [[ $(command -v brew) == "" ]]
then
    echo
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Homebrew on M1 macs installs to /opt/homebrew instead of /usr/local, so won't be picked up
    # without some help
    if [[ $(command -v brew) == "" ]] && sysctl -n machdep.cpu.brand_string 2> /dev/null | grep -q "^Apple M1"
    then
        # Modify both the bash and zsh profiles to make sure the configuration gets picked up
        # regardless of shell
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> tee -a ~/.profile
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> tee -a ~/.zprofile
        eval "$(/opt/homebrew/bin/brew shellenv)"

        # Many casks require Rosetta to be installed before they can run
        sudo softwareupdate --install-rosetta
    fi
else
    echo
    echo "Updating Homebrew..."
    brew update > /dev/null
fi

echo
echo "Homebrew is ready for use"
sleep 1

# If the GH cli is not installed, install it
if [[ $(command -v gh) == "" ]]
then
    echo
    echo "Installing script dependencies..."
    brew install --quiet gh jq ansible
fi

sleep 1
echo
echo "Dependencies installed..."

if [[ "$(gh config list)" != *"ssh"* ]]
then
    echo
    echo "Signing you into the GitHub CLI..."
    echo "You don't need to use this CLI in your day-to-day work, but it is key to ensuring that this script is successful."
    sleep 2
    # This command will prompt the user to connect to GH via a web browser, generating an SSH key as needed
    gh auth login
fi

# Before we go any further, make sure that the user is actually in our GH organization
GH_USER=$(gh api /user | jq ".login")
GH_ORG_USER_MEMBER=$(gh api /orgs/lonsdaledm/members | jq ".[] | .login" | grep "$GH_USER")

if [ ! "$GH_ORG_USER_MEMBER" ]
then
    echo
    echo "You haven't yet been added to the LIT GitHub team.  Please try again later..."
    sleep 0.5
    exit
fi

sleep 0.5
echo
echo "You should be good to step away from your computer at this point."

ansible-pull -U https://github.com/lonsdaledm/gangway