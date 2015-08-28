#!/bin/bash

addons[541738]=advanced-locationbar
addons[287841]=awesome-screenshot
addons[416156]=bookmark-duplicate-cleaner
addons[432114]=cacert
addons[271]=colorzilla
addons[620266]=disable-hello-pocket-reader
addons[457521]=down-for-everyone
addons[201]=downthemall
addons[417674]=duplicate-tabs-closer
addons[1843]=firebug
addons[1117]=foxclocks
addons[748]=greasemonkey
addons[8542]=lastpass
addons[6984]=lazarus-form-recovery
addons[525044]=onetab
addons[5064]=redirector
addons[115]=reloadevery
addons[249342]=restartless-restart
addons[7865]=rightbar
addons[2108]=stylish
addons[599152]=tab-memory-usage
addons[502644]=the-fox-only-better
addons[473193]=the-addon-bar-restored
addons[5890]=tree-style-tab
addons[607454]=ublock-origin
addons[335135]=version-in-add-on-bar
addons[10229]=wappalyzer
addons[60]=web-developer
addons[nucleus]=https://github.rackspace.com/Nucleus/Nucleus-Extension/archive/master.zip

# http://unix.stackexchange.com/a/91944

if [[ $# -eq 0 ]]; then
    ids=${!addons[@]}
else
    ids=$@
fi

for id in ${ids[@]}; do
    if [[ $id -eq 0 ]]; then
        # echo NUCLEUS ${addons[$id]}
        #git clone https://github.rackspace.com/Nucleus/Nucleus-Extension
        git clone git@github.rackspace.com:Nucleus/Nucleus-Extension.git
        cd Nucleus-Extension
        git archive --format=zip -o ../addon-Nucleus-Extension-latest.xpi -v HEAD
        cd ../
        # Install it
        rm -rf Nucleus-Extension
    else
        # echo $id ${addons[$id]}
        wget https://addons.mozilla.org/firefox/downloads/latest/${id}/platform:2/addon-${id}-latest.xpi
    fi
done

cat << HERE > install.rdf
<RDF xmlns="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
     xmlns:em="http://www.mozilla.org/2004/em-rdf#">

  <Description about="urn:mozilla:install-manifest">
    <em:id>multi@package.com</em:id>
    <em:type>32</em:type>
    <em:targetApplication>
      <Description>
        <!-- Firefox -->
        <em:id>{ec8030f7-c20a-464f-9b0e-13a3a9e97384}</em:id>
        <em:minVersion>$(firefox -v 2>/dev/null | awk '{split($NF,v,"."); print v[1]".0"}')</em:minVersion>
        <em:maxVersion>$(firefox -v 2>/dev/null | awk '{split($NF,v,"."); print v[1]".*"}')</em:maxVersion>
      </Description>
    </em:targetApplication>
  </Description>
</RDF>
HERE

zip multipackage.xpi addon*latest.xpi install.rdf

rm -f addon*latest.xpi install.rdf

firefox multipackage.xpi

echo "Once the multipackage is installed, you will want to"
echo "rm -rf $(pwd)/multipackage.xpi"
echo "to clean it up."
