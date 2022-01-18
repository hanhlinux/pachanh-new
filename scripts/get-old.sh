#!/usr/bin/env sh
root="${1}"
tmpdir="${2}"
package="${3}"
infodir="$root/var/lib/pachanh/system/"

source $tmpdir/header
oldfile="$root/$pkg_infodir/filelist"
newfile="$tmpdir/$pkg_infodir/filelist"

tar -C "$tmpdir" -xf "$package" "$pkg_infodir"

(diff "$oldfile" "$newfile" | grep "<" | cut -d "<" -f 2) | tee $tmpdir/oldfiles
