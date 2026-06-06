import Quickshell
import qs.modules.bar
import qs.modules.lock
Scope {

    Lock{
        id: lock
    }
    
    Bar {
        lock: lock
    }
    
}