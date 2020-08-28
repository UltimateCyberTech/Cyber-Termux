#!/usr/bin/env sh

# Create separate directory for my repositor
decoration() {
	apt-get update -yq --silent
	apt-get install gnupg -yq --silent
	mkdir -p ~/.termux
	for i in colors.properties termux.properties font.ttf; do
		wget -q https://raw.githubusercontent.com/UltimateCyberTech/Cyber-Termux/master/style/$i -O ~/.termux/$i
	done
	#rm -r $PREFIX/etc/motd
	#echo "toilet -F metal -F border -f future termux black" >> $PREFIX/etc/bash.bashrc
	cp $PREFIX/etc/bash.bashrc $PREFIX/etc/bash.bashrc.bk
	sed -i s:PS1.*:"PS1=\'\\\\[\\\\e\[1\;34m\\\\]Cyber-TermuX > \\\[\\\e[0;37m\\\\]\'": $PREFIX/etc/bash.bashrc
}

addrepo() {
	# Add repo in separate file
	mkdir -p $PREFIX/etc/apt/sources.list.d && printf "deb https://ultimatecybertech.github.io/Cyber-Termux/ Cyber-Termux main" > $PREFIX/etc/apt/sources.list.d/Cyber-Termux.list

	# Add gpg public key
	wget -q https://ultimatecybertech.github.io/Cyber-Termux/Cyber-Termux.key -O Cyber-Termux.key && apt-key add Cyber-Termux.key
	
	# just update
	apt-get update -yq --silent
}

echo "[*] Installing CybeR-TermuX ..."
decoration
addrepo
echo "[*] Finished :)"
# Now trigger broadcast to make changes visible
am broadcast --user 0 -a com.termux.app.reload_style com.termux > /dev/null
echo "[*] Now open new session & enjoy"
