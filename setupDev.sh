cd ./godot
scons platform=linuxbsd target=editor production=yes use_lto=yes
cd ..
./godot/bin/godot.linuxbsd.editor.x86_64 --dump-extension-api extension_api.json
cd ./godot-cpp
scons platform=linux custom_api_file=../extension_api.json
cd ..
