#!/usr/bin/env bash
set -e

github_version=$(cat github_version.txt)
ftp_version=$(cat ftp_version.txt)
REMOTEPATH="/ppc64el/bazel/ubuntu_$dist_version"
ROOTPATH="~/rpmbuild/RPMS/ppc64le"
REPO1="/repository/debian/ppc64el/bazel"
REPO2="/repository/rpm/ppc64le/bazel"

if [ $github_version != $ftp_version ]
then
  # Upload files from LOCALPATH recursively to REMOTEPATH
  lftp -c "open -u $USER,$PASS ftp://oplab9.parqtec.unicamp.br; rm $REMOTEPATH/latest/bazel_bin_ppc64le_$ftp_version"
  lftp -c "open -u $USER,$PASS ftp://oplab9.parqtec.unicamp.br; put -O $REMOTEPATH/latest bazel_bin_ppc64le_$github_version"
  lftp -c "open -u $USER,$PASS ftp://oplab9.parqtec.unicamp.br; put -O $REMOTEPATH bazel_bin_ppc64le_$github_version"
  #lftp -c "open -u $USER,$PASS ftp://oplab9.parqtec.unicamp.br; rm $REMOTEPATH/bazel_bin_ppc64le_$del_version"=

  #Upload files from repository
  if [ ${dist_version} == "20.04" ]
  then
    sudo lftp -c "open -u $USER,$PASS ftp://oplab9.parqtec.unicamp.br; put -O $REPO1 bazel-$github_version-ppc64le.deb"
    sudo lftp -c "open -u $USER,$PASS ftp://oplab9.parqtec.unicamp.br; put -O $REPO2 $ROOTPATH/bazel-$github_version-1.ppc64le.rpm"
  fi
fi
