mkdir "$1.app"
echo Created app folder
cd "$1.app"
mkdir Contents
echo Created Contents folder
cd Contents
mkdir MacOS
echo Created MacOS folder
mkdir Resources
echo Created Resources folder
cat > info.plist << EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>CFBundleDevelopmentRegion</key>
	<string>English</string>
	<key>CFBundleGetInfoString</key>
	<string>1.0, Copyright © 2021 Steven Livingston, All Rights Reserved.</string>
	<key>CFBundleIdentifier</key>
	<string>com.$1.$1</string>
	<key>CFBundleInfoDictionaryVersion</key>
	<string>6.0</string>
	<key>CFBundleName</key>
	<string>$1</string>
	<key>CFBundlePackageType</key>
	<string>BNDL</string>
	<key>CFBundleShortVersionString</key>
	<string>1.0</string>
	<key>CFBundleSignature</key>
	<string>????</string>
	<key>CFBundleVersion</key>
	<string>1.0</string>
	<key>NSHumanReadableCopyright</key>
	<string>Copyright © 2021 Steven Livingston, All Rights Reserved.</string>
	<key>NSPrincipalClass</key>
	<string>ShellScript</string>
	<key>CFBundleExecutable</key>
	<string>main.command</string>
	<key>CFBundleIconFile</key>
	<string>app</string>
	<key>NSMainNibFile</key>
	<string>main.nib</string>
</dict>
</plist>
EOF
echo Created information plist file
cd MacOS
printf "#!/bin/sh\nPATH=\$(dirname \$0)\n\$PATH/$1/dist/$1-release/$1-mac" > main.command
echo Created main.command file with open script
chmod u+x main.command
echo Made main.command executable and gave correct permissions
neu create $1 > /dev/null
echo Created Neutralino project
cd "$1/app"
cat > settings.json << EOF
{
  "appname": "$1",
  "appport": "0",
  "url": "$2",
  "mode": "window",
  "window": {
    "title": "$1",
    "width": "1000",
    "height": "700",
    "fullscreen": false,
    "alwaysontop": false,
    "iconfile": "neutralino.png",
    "enableinspector": false,
    "borderlesswindow": false
  }
}
EOF
echo Re-wrote settings file
cd ..
neu release > /dev/null
echo Created release for project
cd "dist/$1-release"
chmod a+rx "$1-mac"
echo Made release executable and gave correct permissions
rm "$1-linux"
rm "$1-win.exe"
cd ..
rm "$1-release.zip"
cd ..
rm -rf .github
rm -rf app
rm -rf node_modules
rm -rf src
rm -rf storage
rm .gitignore
rm "$1-linux"
rm "$1-mac"
rm "$1-win.exe"
rm LICENSE
rm neutralino.png
rm package-lock.json
rm package.json
rm README.md
rm webpack.config.js
echo Cleaned up file
cd ../../..