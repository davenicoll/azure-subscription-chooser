# Azure subscription chooser

<img src="screen-capture.gif" width="800" height="589" alt="accessibility text">

An interactive bash script enabling you to change Azure subscription quickly without leaving the CLI. The chooser script can also be called by another script, enabling you to easily use the chooser from your own scripts -

### Example 

``` shell
SUBSCRIPTION=`. ".subscription-chooser.sh"`
if [ -z $SUBSCRIPTION ]; then echo "You chose nothing!"; else; echo "You chose $SUBSCRIPTION"; fi
```

### Dependencies

`whiptail` is required to create the menu, but most distros have it installed by default.
