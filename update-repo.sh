#!/bin/bash
echo "[*] Generating Packages index..."
dpkg-scanpackages packages /dev/null > Packages
gzip -9c Packages > Packages.gz

echo "[*] Generating Release file..."
cat <<EOR > Release
Origin: NiksonOS Repository
Label: NiksonOS
Suite: stable
Codename: trixie
Architectures: amd64 arm64 all
Components: main
Description: Official custom APT repository for NiksonOS security tools
EOR

apt-ftparchive release . >> Release

echo "[*] Signing the Release file with GPG..."
rm -f Release.gpg InRelease
gpg --default-key "niksonos@gmail.com" -abs -o Release.gpg Release
gpg --default-key "niksonos@gmail.com" --clearsign -o InRelease Release

echo "[+] Repository updated and signed successfully!"
