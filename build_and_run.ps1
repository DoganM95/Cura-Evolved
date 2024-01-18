docker build -t doganm95/cura-evolved .

docker run -d `
    --name doganm95-cura-evolved `
    -p 5800:5800 `
    -p 5900:5900 `
    -v ".\volume\data:/config/xdg/data:rw" `
    -v ".\volume\config:/config/xdg/config" `
    -v ".\volume\input:/app/input" `
    -v ".\volume\output:/app/output" `
    doganm95/cura-evolved