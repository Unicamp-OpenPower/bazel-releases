#github_version=$(cat github_version.txt)
#ftp_version=$(cat ftp_version.txt)
#del_version=$(cat delete_version.txt)


#github_version=0.28.0
#github_version=0.27.2
#github_version=0.27.1
#github_version=0.27.0
#github_version=0.26.1
#github_version=0.26.0
#github_version=0.25.3
#github_version=0.25.2
#github_version=0.25.1
github_version=0.25.0
ftp_version=1

if [ $github_version != $ftp_version ]
then
    mkdir work
    cd work
    wget https://github.com/bazelbuild/bazel/releases/download/$github_version/bazel-$github_version-dist.zip
    unzip bazel-$github_version-dist.zip
    sudo EXTRA_BAZEL_ARGS=--host_javabase=@local_jdk//:jdk ./compile.sh
    sudo mv output/bazel output/bazel_bin_ppc64le_$github_version
#    if [[ $github_version > $ftp_version ]]
#    then
#        lftp -c "open -u $USER,$PASS ftp://oplab9.parqtec.unicamp.br; put -O /ppc64el/bazel/ubuntu_16.04/latest /home/travis/build/Unicamp-OpenPower/bazel-releases/work/output/bazel_bin_ppc64le_$github_version" 
#        lftp -c "open -u $USER,$PASS ftp://oplab9.parqtec.unicamp.br; rm /ppc64el/bazel/ubuntu_16.04/latest/bazel_bin_ppc64le_$ftp_version" 
#    fi
    lftp -c "open -u $USER,$PASS ftp://oplab9.parqtec.unicamp.br; put -O /ppc64el/bazel/ubuntu_16.04 /home/travis/build/Unicamp-OpenPower/bazel-releases/work/output/bazel_bin_ppc64le_$github_version" 
#    lftp -c "open -u $USER,$PASS ftp://oplab9.parqtec.unicamp.br; rm /ppc64el/bazel/ubuntu_16.04/bazel_bin_ppc64le_$del_version" 
fi
