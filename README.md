# Azure subscription chooser

<img src="screen-capture.gif" width="800" height="589" alt="accessibility text">

An interactive bash script enabling you to change Azure subscription quickly without leaving the CLI. The script can be run standalone (`./azure-subscription-chooser.sh`), or called from another script like a function...

### Example 

``` shell
SUBSCRIPTION=`. ".subscription-chooser.sh"`
if [ -z $SUBSCRIPTION ]; then echo "You chose nothing!"; else; echo "You chose $SUBSCRIPTION"; fi
```

### Dependencies

`whiptail` is required to create the menu, as most distros have it installed already. https://en.wikibooks.org/wiki/Bash_Shell_Scripting/Whiptail

#### Install whiptail on macOS

`whiptail` isn't installed on macOS, but can be installed with `brew` (https://command-not-found.com/whiptail)

```
brew install newt
```
