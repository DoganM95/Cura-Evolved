# Intro

This is currently just a dockerized, usable cura application, that can be connected to using a browser or VNC.

# Features

- Docker image always contains the most recent cura version
- Settings and extensions persist, even after an update of cura
- Web UI available under [localhost:5800](http://localhost:5800) with any browser
- VNC remote connection available under [localhost:5900](http://localhost:5900)

# Goal

The goal is automating the slicing process, so files can be put in an /input folder and automatically processed versions land in an /ouput folder.

The GUI is there, so the user can modify all settings and install extensions to achieve more automation.  
The initial motivation to create this project was cura's incompetence in persisting my user-settings.  
You update cura, settings are gone. You swtich to a new pc, settings gone. You log in to your account, no settings sync.  

# Setup

## Docker container

### Linux

```shell
docker run \ 
  -d \
  --name doganm95-cura-evolved \
  -p 5800:5800 \
  -p 5900:5900 \
  -v "<desired_data_folder>:/config/xdg/data" \
  -v "<desired_config_folder>:/config/xdg/config" \
  -v "<desired_stl_input_folder>:/app/input" \
  -v "<desired_gcode_output_folder>:/app/output" \
  ghcr.io/doganm95/cura-evolved:latest
```
### WIndows

```powershell
docker run `
  -d `
  --name doganm95-cura-evolved `
  -p 5800:5800 `
  -p 5900:5900 `
  -v "<desired_data_folder>:/config/xdg/data" `
  -v "<desired_config_folder>:/config/xdg/config" `
  -v "<desired_stl_input_folder>:/app/input" `
  -v "<desired_gcode_output_folder>:/app/output" `
  ghcr.io/doganm95/cura-evolved:latest
```

## Resources

- https://github.com/Ultimaker/Uranium/wiki/Plugin-Types
- https://github.com/Ultimaker/Uranium/wiki/Plugins
- https://community.ultimaker.com/forum/171-software-plug-ins/
- https://community.ultimaker.com/topic/22243-automatic-slicing/
- https://community.ultimaker.com/topic/30005-plugins-howto/
- https://github.com/Ultimaker/UraniumExampleFileReaderPlugin/blob/master/plugin.json
- https://github.com/Ghostkeeper/SettingsGuide
- https://community.ultimaker.com/topic/26046-writing-a-custom-cura-package/
- https://contribute.ultimaker.com/app/developer/plugins/
- https://community.ultimaker.com/topic/20147-manual-for-developing-cura-plugins/
- https://github.com/Ultimaker/Cura/blob/main/resources/images/cura-icon.png
