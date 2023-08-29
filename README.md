# Intro
The goal is to run cura in a docker container, so files can be put in an /input folder and automatically processed versions land in an /ouput folder.
Processing in this context includes but is not limited to  
- automatically positioning the stl in the best way possible on the print bed
- slicing it
- saving the file

The GUI is there, so the user can modify all settings and install extensions to achieve more automation.
The initial motivation to create this project was cura's incompetence in persisting my user-settings. You update cura, settings are gone. you swtich to a new pc, settings gone. you log in to your account, no settings sync. This hopefully solves it.

# Features
- Docker build command automatically gets the latest version available from cura github releases
- Web UI available under [localhost:5800](http://localhost:5800) with any browser
- VNC remote connection available under [localhost:5900](http://localhost:5900)
