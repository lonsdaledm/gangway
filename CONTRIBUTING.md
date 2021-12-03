# Contributing

- [Contributing](#contributing)
  - [Resources](#resources)
    - [Ansible](#ansible)
    - [Git](#git)
    - [GitHub](#github)
    - [Homebrew](#homebrew)
    - [Jq](#jq)

## Resources

### Ansible

We shift as much of this automation into Ansible in order to have the convenience of Ansible's tags and roles.  Due to this motivation, the bash script should not be assumed to have run before the Ansible script and any dependencies within ansible scripts should be tagged (and commented if the dependency is not obvious).  When running parts of this script, which replaces hours (if not days) of an engineer's time, it is more important to be fully correct than to be fast.

- [User Guide](https://docs.ansible.com/ansible/latest/user_guide/index.html)
- [Docs](https://docs.ansible.com/ansible/latest/index.html)
- [Facts (System Identification)](https://docs.ansible.com/ansible/latest/user_guide/playbooks_vars_facts.html)
- [Advanced YAML Syntax](https://docs.ansible.com/ansible/latest/user_guide/playbooks_advanced_syntax.html)

_:warning: These resources are general Ansible resources - resources specific to a collection will be specified in that section of the docs._

### Git

- [Ansible Module for Git](https://docs.ansible.com/ansible/latest/collections/ansible/builtin/git_module.html)
- [Ansible Module for Git Config](https://docs.ansible.com/ansible/latest/collections/community/general/git_config_module.html#ansible-collections-community-general-git-config-module)

### GitHub

- [CLI Docs](https://cli.github.com/manual/)
- [API Docs for User](https://docs.github.com/en/rest/reference/users#get-the-authenticated-user)
- [API Docs for Orgs](https://docs.github.com/en/rest/reference/orgs#list-organization-members)

### Homebrew

We use Homebrew to automate much of the installation process for applications that don't have their own programmatic installs.  It is generally better to use designated programmatic installs _unless_ the Homebrew formula is supported by the creator of the program (e.g. the GH Cli).

- [Homebrew Docs](https://brew.sh/)
- [Ansible Collection for Homebrew](https://docs.ansible.com/ansible/latest/collections/community/general/homebrew_module.html)
- [Ansible Collection for Homebrew Cask](https://docs.ansible.com/ansible/latest/collections/community/general/homebrew_cask_module.html)
- [Ansible Collection for Homebrew Tap](https://docs.ansible.com/ansible/latest/collections/community/general/homebrew_tap_module.html)

### Jq

Jq is a robust JSON parser on the command line that we install in the bash script.  Any JSON parsing after installation can be done with this tool.

- [Docs](https://stedolan.github.io/jq/manual/)
