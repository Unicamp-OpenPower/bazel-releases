python3 bazel_version.py
if [ $(cat current_version.txt) != $(cat ftp_version.txt) ]
then
    version=$(cat current_version.txt)
    mkdir work
    cd work
    wget https://github.com/bazelbuild/bazel/releases/download/$version/bazel-$version-dist.zip
    unzip bazel-$version-dist.zip
    EXTRA_BAZEL_ARGS=--host_javabase=@local_jdk//:jdk ./compile.sh
    mv output/bazel output/bazel_bin_ppc64le_$version
    lftp -c "open -u $USER,$PASS ftp://oplab9.parqtec.unicamp.br; put -O /ppc64el/bazel/$OS /home/travis/build/Unicamp-OpenPower/bazel-releases/work/output/bazel_bin_ppc64le_$version" 
    del_version=$(cat delete_version.txt)
    lftp -c "open -u $USER,$PASS ftp://oplab9.parqtec.unicamp.br; rm /ppc64el/bazel/$OS/bazel_bin_ppc64le_$del_version" 
fi
