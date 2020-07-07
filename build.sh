#!/usr/bin/env bash

#github_version=$(cat github_version.txt)
github_version=3.3.0
ftp_version=$(cat ftp_version.txt)
#del_version=$(cat delete_version.txt)

#github_version=$ver
#ftp_version=2

if [ $github_version != $ftp_version ]
then
    wget -q https://oplab9.parqtec.unicamp.br/pub/ppc64el/bazel/ubuntu_${dist_version}/bazel_bin_ppc64le_3.2.0
    sudo mv bazel_bin_ppc64le_3.2.0 /usr/local/bin/bazel
    sudo chmod +x /usr/local/bin/bazel
    wget -q https://github.com/bazelbuild/bazel/releases/download/$github_version/bazel-$github_version-dist.zip
    unzip -q bazel-$github_version-dist.zip -d bazel
    cd bazel
    ini=$(pwd)
    #rm $ini/src/conditions/BUILD
    #cd $ini/src/conditions/
    #wget https://raw.githubusercontent.com/bazelbuild/bazel/78a29b0d0dfe350ab9513b6eefa9a2ed46c6c865/src/conditions/BUILD
    #rm $ini/src/main/java/com/google/devtools/build/lib/syntax/BUILD
    #cd $ini/src/main/java/com/google/devtools/build/lib/syntax/
    #wget https://raw.githubusercontent.com/bazelbuild/bazel/78a29b0d0dfe350ab9513b6eefa9a2ed46c6c865/src/main/java/com/google/devtools/build/lib/syntax/BUILD
    rm $ini/tools/jdk/BUILD
    cd $ini/tools/jdk/
    wget https://raw.githubusercontent.com/bazelbuild/bazel/78a29b0d0dfe350ab9513b6eefa9a2ed46c6c865/tools/jdk/BUILD
    cd $ini
    sudo EXTRA_BAZEL_ARGS=--host_javabase=@local_jdk//:jdk ./compile.sh
    sudo mv output/bazel output/bazel_bin_ppc64le_$github_version
fi
