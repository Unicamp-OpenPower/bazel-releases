#!/usr/bin/env bash

set -e

github_version=$(cat github_version.txt)
ftp_version=$(cat ftp_version.txt)

if [ $github_version != $ftp_version ]
then
    FTP_HOST='oplab9.parqtec.unicamp.br'
    LOCALPATH=$TRAVIS_BUILD_DIR/bazel/output
    REMOTEPATH="/ppc64el/bazel/ubuntu_$dist_version"
    ROOTPATH="/root/rpmbuild/RPMS/ppc64le"
    REPO1="/repository/debian/ppc64el/bazel"
    REPO2="/repository/rpm/ppc64le/bazel"

    # Upload files from LOCALPATH recursively to REMOTEPATH
    lftp -f "
    set dns:order "inet"
    set xfer:use-temp-file yes
    set xfer:temp-file-name *.tmp
    open ftp://$FTP_HOST
    user $USER $PASS
    mirror -R --continue --reverse --no-empty-dirs --no-perms -I bazel_bin_ppc64le* $LOCALPATH $REMOTEPATH
    bye
    "

    #Upload files from repository
    if [ ${dist_version} == "18.04" ]
    then
      sudo lftp -f "
      set dns:order "inet"
      set xfer:use-temp-file yes
      set xfer:temp-file-name *.tmp
      open ftp://$FTP_HOST
      user $USER $PASS
      mirror -R --continue --reverse --no-empty-dirs --no-perms -I bazel-$github_version-ppc64le.deb $LOCALPATH $REPO1
      mirror -R --continue --reverse --no-empty-dirs --no-perms -I bazel-* $ROOTPATH $REPO2
      bye
      "
    fi
fi
