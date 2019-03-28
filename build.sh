github_version=$(cat github_version.txt)
ftp_version=$(cat ftp_version.txt)
del_version=$(cat delete_version.txt)

if [ $github_version != $ftp_version ]
then
    sudo mkdir work
    cd work
    sudo wget https://github.com/bazelbuild/bazel/releases/download/$github_version/bazel-$github_version-dist.zip
    sudo unzip bazel-$github_version-dist.zip
    sudo EXTRA_BAZEL_ARGS=--host_javabase=@local_jdk//:jdk ./compile.sh
    sudo mv output/bazel output/bazel_bin_ppc64le_$github_version
    if [[ $github_version > $ftp_version ]]
    then
        lftp -c "open -u $USER,$PASS ftp://oplab9.parqtec.unicamp.br; put -O /ppc64el/bazel/$OS/latest /home/travis/build/Unicamp-OpenPower/bazel-releases/work/output/bazel_bin_ppc64le_$github_version" 
        lftp -c "open -u $USER,$PASS ftp://oplab9.parqtec.unicamp.br; rm /ppc64el/bazel/$OS/latest/bazel_bin_ppc64le_$ftp_version" 
    fi
    lftp -c "open -u $USER,$PASS ftp://oplab9.parqtec.unicamp.br; put -O /ppc64el/bazel/$OS /home/travis/build/Unicamp-OpenPower/bazel-releases/work/output/bazel_bin_ppc64le_$github_version" 
    lftp -c "open -u $USER,$PASS ftp://oplab9.parqtec.unicamp.br; rm /ppc64el/bazel/$OS/bazel_bin_ppc64le_$del_version" 
fi
