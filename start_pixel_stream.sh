#!/bin/bash
UNREAL="/opt/Unreal/Engine/Binaries/Linux"
tmux new-session -d -s UNREAL_ENGINE -c $UNREAL
tmux send-keys -t UNREAL_ENGINE "./UnrealEditor /opt/projects/MyProject/MyProject.uproject -prefernvidia -PixelStreamingURL=ws://127.0.0.1:8888 -EditorPixelStreamingStartOnLaunch=true -EditorPixelStreamingUseRemoteSignallingServer=true -RenderOffScreen -EditorPixelStreamingRes=1920x1080" C-m

SIGNAL="/opt/PixelStreamingInfrastructure/SignallingWebServer/platform_scripts/bash"
MATCHMAKER_ADDRESS="10.0.16.15"
MY_IP="0.0.0.0"
tmux new-session -d -s SIGNALLING_SERVER -c $SIGNAL
tmux send-keys -t SIGNALLING_SERVER "./Start_SignallingServer.sh --UseMatchmaker true --MatchmakerAddress $MATCHMAKER_ADDRESS --MatchmakerPort 9999 --PublicIp $MY_IP --HttpPort 80" C-m

check_sessions() {
    tmux has-session -t UNREAL_ENGINE 2>/dev/null && \
    tmux has-session -t SIGNALLING_SERVER 2>/dev/null
}

echo "Started tmux sessions, monitoring..."
while check_sessions; do
    sleep 10
done

echo "One or both tmux sessions have ended. Exiting..."
exit 1
