import Quickshell
import qs.modules.bar
    
Variants {
    model: Quickshell.screens

    Scope {
        id: scope
        required property var modelData
        Bar{}
    }
}
