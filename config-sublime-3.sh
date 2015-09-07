#!/bin/bash
ST=~/.config/sublime-text-3
mkdir -p $ST/{Installed\ Packages,Packages/User}
curl http://sublime.wbond.net/Package%20Control.sublime-package > $ST/Installed\ Packages/Package\ Control.sublime-package
cp home/stephen/.config/* ~/.config/
