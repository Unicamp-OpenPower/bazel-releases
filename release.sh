#!/usr/bin/env bash
github_version=$(cat github_version.txt)
ftp_version=$(cat ftp_version.txt)
LOCALPATH=$TRAVIS_BUILD_DIR/bazel/output

if [ $github_version != $ftp_version ] && [ ${dist_version} == "18.04" ]
then
  cd $TRAVIS_BUILD_DIR
  git clone https://$USERNAME:$TOKEN@github.com/Unicamp-OpenPower/repository-scrips.git
  cd repository-scrips/
  chmod +x empacotar-deb.sh
  chmod +x empacotar-rpm.sh
  mv empacotar-deb.sh $LOCALPATH
  mv empacotar-rpm.sh $LOCALPATH
  cd $LOCALPATH
  ./empacotar-deb.sh bazel bazel_bin_ppc64le_$github_version $github_version "gcc, default-jdk"
  sudo su
  ./empacotar-rpm.sh bazel bazel_bin_ppc64le_$github_version $github_version "gcc, java-11-openjdk-devel" "Build and test software of any size, quickly and reliably"
fi
