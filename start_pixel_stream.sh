#!/bin/bash
UNREAL="/home/aceh/Downloads/Unreal/Engine/Binaries/Linux"
tmux new-session -d -s UNREAL_ENGINE -c $UNREAL
tmux send-keys -t UNREAL_ENGINE "./UnrealEditor ~/Documents/Unreal\ Projects/MyProject/MyProject.uproject -prefernvidia -PixelStreamingURL=ws://127.0.0.1:8888 -EditorPixelStreamingStartOnLaunch=true -EditorPixelStreamingUseRemoteSignallingServer=true -RenderOffScreen -EditorPixelStreamingRes=1920x1080" C-m

SIGNAL="~/PixelStreamingInfrastructure/SignallingWebServer/platform_scripts/bash"
tmux new-session -d -s SIGNALLING_SERVER -c $SIGNAL
tmux send-keys -t SIGNALLING_SERVER "./Start_SignallingServer.sh --UseMatchmaker true --MatchmakerAddress 10.0.16.15 --MatchmakerPort 9999 --PublicIp 10.0.16.19 --HttpPort 80 --nosudo" C-m
