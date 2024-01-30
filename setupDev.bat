cd .\godot
scons platform=windows target=editor production=yes arch=x86_64
cd ..
.\godot\bin\godot.windows.editor.x86_64.exe --dump-extension-api extension_api.json
cd .\godot-cpp
scons platform=windows arch=x86_64 custom_api_file=..\extension_api.json
cd ..