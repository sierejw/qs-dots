import Quickshell
import "modules/bar"
import "modules/lock"
Scope {

    Lock{
        id: lock
    }
    
    Bar {
        lock: lock
    }
    
}