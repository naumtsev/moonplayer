#!/bin/sh

export PATH=/c/Qt/5.12.9/msvc2017_64/bin:$PATH

# Copy binary files
mkdir moonplayer
cp src/Release/moonplayer.exe src/scripts/update-parsers.ps1 libmpv/mpv-1.dll moonplayer/

# Bundle Qt
windeployqt moonplayer/moonplayer.exe --qmldir src/qml

# Bundle OpenSSL
curl -Lo openssl.7z http://download.qt.io/online/qtsdkrepository/windows_x86/desktop/tools_openssl_x64/qt.tools.openssl.win_x64/1.1.1-4openssl_1.1.1d_prebuild_x64.7z
7z e openssl.7z -omoonplayer Tools/OpenSSL/Win_x64/bin/*.dll

# Bundle ffmpeg
curl -Lo ffmpeg.7z https://www.gyan.dev/ffmpeg/builds/packages/ffmpeg-4.3.1-2020-11-08-essentials_build.7z
7z e ffmpeg.7z -omoonplayer ffmpeg-4.3.1-2020-11-08-essentials_build/bin/ffmpeg.exe

# Bundle hlsdl
curl -Lo hlsdl.7z https://rwijnsma.home.xs4all.nl/files/hlsdl/hlsdl-0.26-2bc52ab-win32-static-xpmod-sse.7z
7z e hlsdl.7z -omoonplayer hlsdl.exe

# Create installer
iscc scripts/win_installer.iss
mv scripts/Output/mysetup.exe ./MoonPlayer_${TRAVIS_TAG#v}_win_x64.exe
