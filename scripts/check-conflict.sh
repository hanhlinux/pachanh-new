#!/usr/bin/env sh
root="${1}"
tmpdir="${2}"
infodir="$root/var/lib/pachanh/system/"

. $tmpdir/pre-install
for x in $contain; do
	if test -d "$infodir/$x"; then
		link="$(readlink $infodir/$x)"
		if test -z "$link"; then 
			echo "$x conflicts with $name. Remove $x? (Y/n)"
			read -r confirm
			case $confirm in 
				Y|y) pachanh -r $name;;
				*)   echo "ERROR: Failed to install package (conflict with $x)"; exit 1;;
			esac
		else
			if test "$link" != "$name"; then 
				echo "$link conflicts with $name ($x). Remove $link? (Y/n)"
				read -r confirm
				case $confirm in 
					Y|y) pachanh -r $link;;
					*)   echo "ERROR: Faileed to install package (conflict with $link)"; exit 1;;
				esac
			fi
		fi
	fi
done