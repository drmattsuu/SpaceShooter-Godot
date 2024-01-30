A Godot project

Setup instructions

Requirements:
- A python 3 environment
- Scons toolset

An example setup may look like;

Linux
```
python -m venv ~/venv/pygodot
~/venv/pygodot/bin/activate
python -m pip install scons

sh ./setupDev.sh
scons platform=linux arch=x86_64 target=template_release
```

Windows
```
"C:\Program Files\Python310\python.exe" -m venv c:\venv\pygodot
C:\venv\pygodot\Scripts\activate.bat
python.exe -m pip install scons

setupDev.bat
scons platform=windows arch=x86_64 target=template_release
```