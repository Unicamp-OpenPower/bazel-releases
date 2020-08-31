#!/usr/bin/env bash
github_version=$(cat github_version.txt)
ftp_version=$(cat ftp_version.txt)

if [ $github_version != $ftp_version ]
then
    wget -q https://oplab9.parqtec.unicamp.br/pub/ppc64el/bazel/ubuntu_${dist_version}/bazel_bin_ppc64le_$ftp_version
    sudo mv bazel_bin_ppc64le_$ftp_version /usr/local/bin/bazel
    sudo chmod +x /usr/local/bin/bazel
    wget -q https://github.com/bazelbuild/bazel/releases/download/$github_version/bazel-$github_version-dist.zip
    unzip -q bazel-$github_version-dist.zip -d bazel
    cd bazel
    sudo EXTRA_BAZEL_ARGS=--host_javabase=@local_jdk//:jdk ./compile.sh
    sudo mv output/bazel output/bazel_bin_ppc64le_$github_version
fi
