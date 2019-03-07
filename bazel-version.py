import requests

# find and save the current Bazel release
html = str(
    requests.get('https://github.com/bazelbuild/bazel/releases').content)
index = html.find('tree/')
current_version = html[index + 5:index + 11]
file = open('current_version.txt', 'w')
file.writelines(current_version)
file.close()

# find and save the current Bazel version on FTP server
html = str(
    requests.get(
        'https://oplab9.parqtec.unicamp.br/pub/ppc64el/bazel/ubuntu_16.04/'
    ).content)
index = html.find('[D')
ftp_version = html[index - 160:index - 154]
file = open('ftp_version.txt', 'w')
file.writelines(ftp_version)
file.close()

# find and save the last Bazel version on FTP server
index = html.find('bazel_b')
delete = html[index + 18:index + 24]
file = open('delete_version.txt', 'w')
file.writelines(delete)
file.close()
