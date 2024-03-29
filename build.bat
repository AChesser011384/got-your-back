rmdir /q /s gyb
rmdir /q /s gyb-64
rmdir /q /s python-src-%1
rmdir /q /s build
rmdir /q /s dist
del /q /f gyb-%1-python-src.zip
del /q /f gyb-%1-windows.zip
del /q /f gyb-%1-windows-x64.zip

\python27-32\python.exe setup.py py2exe
xcopy client_secrets.json gyb\
xcopy cacert.pem gyb\

del gyb\w9xpopen.exe
"%ProgramFiles(x86)%\7-Zip\7z.exe" a -tzip gyb-%1-windows.zip gyb\ -xr!.svn

\python27\python.exe setup-64.py py2exe
xcopy client_secrets.json gyb-64\
xcopy cacert.pem gyb-64\
"%ProgramFiles(x86)%\7-Zip\7z.exe" a -tzip gyb-%1-windows-x64.zip gyb-64\ -xr!.svn

mkdir python-src-%1
mkdir python-src-%1\apiclient
mkdir python-src-%1\httplib2
mkdir python-src-%1\oauth2client
mkdir python-src-%1\uritemplate
xcopy gyb.py python-src-%1\
xcopy gflags.py python-src-%1\
xcopy gflags_validators.py python-src-%1\
xcopy gimaplib.py python-src-%1\
xcopy client_secrets.json python-src-%1\
xcopy cacert.pem python-src-%1\
xcopy /e apiclient\*.* python-src-%1\apiclient
xcopy /e httplib2\*.* python-src-%1\httplib2
xcopy /e oauth2client\*.* python-src-%1\oauth2client
xcopy /e uritemplate\*.* python-src-%1\uritemplate

cd python-src-%1
"%ProgramFiles(x86)%\7-Zip\7z.exe" a -tzip ..\gyb-%1-python-src.zip * -xr!.svn
cd ..