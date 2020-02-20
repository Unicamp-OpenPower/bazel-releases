#!/usr/bin/env bash

github_version=$(cat github_version.txt)
ftp_version=$(cat ftp_version.txt)
#del_version=$(cat delete_version.txt)

#github_version=$ver
#ftp_version=2

if [ $github_version != $ftp_version ]
then
    wget -q https://oplab9.parqtec.unicamp.br/pub/ppc64el/bazel/ubuntu_${dist_version}/bazel_bin_ppc64le_2.0.0
    sudo mv bazel_bin_ppc64le_2.0.0 /usr/local/bin/bazel
    sudo chmod +x /usr/local/bin/bazel
    wget -q https://github.com/bazelbuild/bazel/releases/download/$github_version/bazel-$github_version-dist.zip
    unzip -q bazel-$github_version-dist.zip -d bazel
    #rm bazel/src/main/java/com/google/devtools/build/lib/syntax/BUILD
    #mv BUILD bazel/src/main/java/com/google/devtools/build/lib/syntax/
    cd bazel
    sudo EXTRA_BAZEL_ARGS=--host_javabase=@local_jdk//:jdk ./compile.sh
    sudo mv output/bazel output/bazel_bin_ppc64le_$github_version
fi
