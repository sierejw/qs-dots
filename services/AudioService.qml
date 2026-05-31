pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Services.Pipewire

Singleton {
    id: root
    
    readonly property PwNode sink: Pipewire.defaultAudioSink
    readonly property real volume: sink?.audio?.volume ?? 0
    readonly property bool muted: !!sink?.audio?.muted

    PwObjectTracker {
        objects: [root.sink]
    }

    function setVolume(newVolume: real): void {
        if (sink?.ready && sink?.audio) {
            sink.audio.muted = false;
            sink.audio.volume = newVolume;
        }
    }

    function getSoundIcon(): string {
        if (root.muted)
            return "\ueee8";
        if (root.volume >= 0.5)
            return "\uf028";
        if (root.volume > 0)
            return "\uf027";
        return "\uf026";
    }
}