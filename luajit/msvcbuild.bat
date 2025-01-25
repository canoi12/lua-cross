@echo "DIR: %CD%"
cd /d "%CD%\source\src"
call msvcbuild.bat;

cd "%CD%\..\.."

if not exist "%CD%\dist\x86-windows-msvc\v143\bin" mkdir "%CD%\dist\x86-windows-msvc\v143\bin"
if not exist "%CD%\dist\x86-windows-msvc\v143\lib" mkdir "%CD%\dist\x86-windows-msvc\v143\lib"
copy "%CD%\source\src\luajit.exe" "%CD%\dist\x86-windows-msvc\v143\bin\luajit.exe"
copy "%CD%\source\src\luajit.lib" "%CD%\dist\x86-windows-msvc\v143\lib\"
copy "%CD%\source\src\lua51.lib" "%CD%\dist\x86-windows-msvc\v143\lib\"
copy "%CD%\source\src\lua51.dll" "%CD%\dist\x86-windows-msvc\v143\bin\"
copy "%CD%\source\src\lua51.exp" "%CD%\dist\x86-windows-msvc\v143\lib\"