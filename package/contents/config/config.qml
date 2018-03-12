import QtQuick 2.6

import org.kde.plasma.configuration 2.0

ConfigModel {
    ConfigCategory {
         name: i18n("General")
         icon: "preferences-desktop"
         source: "config/configGeneral.qml"
    }
    ConfigCategory {
        name: i18n("Price Conversion")
        icon: "preferences-other"
        source: "config/configConversion.qml"
    }
}
