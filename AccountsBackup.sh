#!/bin/bash
# script to backup GNUCash files to dropbox

today=`date +%d%b%y`

tar zcvf /Users/john/Documents/GNUCash-$today.tar.gz /Users/john/Documents/Accounts/
gpg -s -e -r 48A59E2B /Users/john/Documents/GNUCash-$today.tar.gz
mv /Users/john/Documents/GNUCash-$today.tar.gz /Users/john/Dropbox/Home/Accounts/
