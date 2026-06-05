import Quickshell
import Quickshell.Io
import Quickshell.Wayland

Scope {

    property alias lock: lock
    LockContext {
        id: lockContext

        onUnlocked: {
            lock.locked = false
        }
    }

    WlSessionLock {
        id: lock
        locked: false
        LockSurface {
            context: lockContext
        }
    }    
}