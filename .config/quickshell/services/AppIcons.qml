pragma Singleton
pragma ComponentBehavior: Bound

import Quickshell

Singleton {
    function guessIcon(appClass) {
        if (!appClass)
            return "image-missing";
        const lowercased = appClass.toLowerCase();
        const entry = DesktopEntries.byId(appClass) ?? DesktopEntries.byId(lowercased);
        if (entry?.icon)
            return entry.icon;
        const candidates = [appClass, lowercased, appClass.split(".").pop(), lowercased.replace(/_/g, "-"), `${lowercased}-browser`, `${lowercased}-launcher`];
        for (const candidate of candidates) {
            if (Quickshell.iconPath(candidate, true).length > 0)
                return candidate;
        }
        return "image-missing";
    }
}
