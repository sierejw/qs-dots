import Quickshell
import qs.modules.bar
import qs.modules.menus
import qs.modules.bar.components
    
Variants {
    model: Quickshell.screens

    Scope {
        id: scope
        required property var modelData
        Bar{}
        
        //PowerMenu{}
    }
}
