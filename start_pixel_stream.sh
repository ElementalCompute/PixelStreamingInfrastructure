#!/bin/bash
UNREAL="/home/aceh/Downloads/Unreal/Engine/Binaries/Linux"
tmux new-session -d -s UNREAL_ENGINE -c $UNREAL
tmux send-keys -t UNREAL_ENGINE "./UnrealEditor ~/Documents/Unreal\ Projects/MyProject/MyProject.uproject -prefernvidia -PixelStreamingURL=ws://127.0.0.1:8888 -EditorPixelStreamingStartOnLaunch=true -EditorPixelStreamingUseRemoteSignallingServer=true -RenderOffScreen -EditorPixelStreamingRes=1920x1080" C-m

SIGNAL="~/PixelStreamingInfrastructure/SignallingWebServer/platform_scripts/bash"
MATCHMAKER_ADDRESS="10.0.16.15"
MY_IP=ifconfig | sed -En 's/127.0.0.1//;s/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p'
tmux new-session -d -s SIGNALLING_SERVER -c $SIGNAL
tmux send-keys -t SIGNALLING_SERVER "./Start_SignallingServer.sh --UseMatchmaker true --MatchmakerAddress $MATCHMAKER_ADDRESS --MatchmakerPort 9999 --PublicIp $MY_IP --HttpPort 80 --nosudo" C-m
