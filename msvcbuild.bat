cmake -B build
cmake --build build --config Release
if not exist "%CD%\dist\windows-msvc-v143\bin" mkdir "%CD%\dist\windows-msvc-v143\bin"
if not exist "%CD%\dist\windows-msvc-v143\lib" mkdir "%CD%\dist\windows-msvc-v143\lib"
copy "%CD%\build\Release\lua.exe" "%CD%\dist\windows-msvc-v143\bin\lua.exe"
copy "%CD%\build\Release\luac.exe" "%CD%\dist\windows-msvc-v143\bin\luac.exe"
copy "%CD%\build\Release\*.lib" "%CD%\dist\windows-msvc-v143\lib\"
copy "%CD%\build\Release\*.dll" "%CD%\dist\windows-msvc-v143\lib\"

rmdir /s /q build