docker build -t doganm95/cura-evolved .

docker stop local-doganm95-cura-evolved
docker rm local-doganm95-cura-evolved

docker run `
    --rm `
    -d `
    --name local-doganm95-cura-evolved `
    -p 5801:5800 `
    -p 5900:5900 `
    -v ".\volume\data:/config/xdg/data:rw" `
    -v ".\volume\config:/config/xdg/config" `
    -v ".\volume\input:/app/input" `
    -v ".\volume\output:/app/output" `
    doganm95/cura-evolved



docker stop ghcr-doganm95-cura-evolved
docker rm ghcr-doganm95-cura-evolved

docker run `
    --rm `
    -d `
    --name ghcr-doganm95-cura-evolved `
    -p 5802:5800 `
    -p 5900:5900 `
    -v ".\volume\data:/config/xdg/data:rw" `
    -v ".\volume\config:/config/xdg/config" `
    -v ".\volume\input:/app/input" `
    -v ".\volume\output:/app/output" `
    ghcr.io/doganm95/cura-evolved