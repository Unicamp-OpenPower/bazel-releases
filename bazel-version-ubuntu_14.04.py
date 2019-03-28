import requests
# find and save the current Github release
html = str(
    requests.get('https://github.com/bazelbuild/bazel/releases/latest')
    .content)
index = html.find('Release ')
github_version = html[index + 8:index + 14]
file = open('github_version.txt', 'w')
file.writelines(github_version)
file.close()

# find and save the current Bazel version on FTP server
html = str(
    requests.get(
        'https://oplab9.parqtec.unicamp.br/pub/ppc64el/bazel/ubuntu_14.04/'
    ).content)
index = html.rfind('_ppc64le_')
ftp_version = html[index + 9:index + 15]
file = open('ftp_version.txt', 'w')
file.writelines(ftp_version)
file.close()

# find and save the oldest Bazel version on FTP server
index = html.find('_ppc64le_')
delete = html[index + 9:index + 15]
file = open('delete_version.txt', 'w')
file.writelines(delete)
file.close()
