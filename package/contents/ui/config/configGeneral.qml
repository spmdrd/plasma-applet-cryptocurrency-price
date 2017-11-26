import QtQuick 2.6
import QtQuick.Controls 1.4
import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.3
import org.kde.plasma.components 2.0 as PlasmaComponents
import "../../code/ccscript.js" as CCScript

Item {
	id: configGeneral
	Layout.fillWidth: true
	property alias cfg_xeUrl: xeUrl.text
	property alias cfg_xeKey: xeKey.text
	property alias cfg_coinLabel: coinLabel.text
	property alias cfg_ttLabel: ttLabel.text
	property string cfg_onClickAction: plasmoid.configuration.onClickAction
	property alias cfg_refreshRate: refreshRate.value
	property alias cfg_showIcon: showIcon.checked
	property string cfg_icon: plasmoid.configuration.icon
	property alias cfg_showText: showText.checked
	property alias cfg_showBackground: showBackground.checked
	property alias cfg_showCoinLabel: showCoinLabel.checked

	GridLayout {
		columns: 2
		
		Label {
			text: i18n("Exchange URL:")
		}
		
		TextField {
			id: xeUrl
			Layout.minimumWidth: theme.mSize(theme.defaultFont).width * 30
		}

		Label {
			text: i18n("JSON Key:")
		}

		TextField {
			id: xeKey
			Layout.minimumWidth: theme.mSize(theme.defaultFont).width * 30
		}
		
		Label {
			text: i18n("Coin Label:")
		}

		TextField {
			id: coinLabel
			Layout.minimumWidth: theme.mSize(theme.defaultFont).width * 10
		}
		
		Label {
			text: i18n("Tooltip Label:")
		}

		TextField {
			id: ttLabel
			Layout.minimumWidth: theme.mSize(theme.defaultFont).width * 10
		}
		
		Label {
			text: i18n("Refresh rate:")
		}
		
		SpinBox {
			id: refreshRate
			suffix: i18n(" minutes")
			minimumValue: 1
		}
		
		Label {
			text: ""
		}
		
		CheckBox {
			id: showBackground
			text: i18n("Show background")
		}
		
		Label {
			text: ""
		}
		
		CheckBox {
			id: showText
			text: i18n("Show text (Disabled: displays the rate only on hover)")
			onClicked: {
				if(!this.checked) {
					showIcon.checked = true
					showIcon.enabled = false
					showCoinLabel.checked = false
					showCoinLabel.enabled = false
				} else {
					showIcon.enabled = true
					showCoinLabel.enabled = true
					showCoinLabel.checked = true
				}
			}
		}
		
		Label {
			text: ""
		}
		
		CheckBox {
			id: showCoinLabel
			text: i18n("Show Coin Label")
		}
		
		Label {
			text: ""
		}
		
		CheckBox {
			id: showIcon
			text: i18n("Show icon")
			onClicked: {
				if(!this.checked) {
					showText.checked = true
					showText.enabled = false
				} else {
					showText.enabled = true
				}
			}
		}
		
		PlasmaComponents.Label {
			text: i18n("Icon:")
		}
		
		IconPicker {
			currentIcon: cfg_icon
			defaultIcon: ""
			onIconChanged: cfg_icon = iconName
			enabled: true
		}

		Label {
			text: i18n("On click:")
		}
		
		ExclusiveGroup { id: clickGroup }
		
		RadioButton {
			Layout.row: 10
			Layout.column: 1
			exclusiveGroup: clickGroup
			checked: cfg_onClickAction == 'refresh'
			text: i18n("Refresh")
			onClicked: {
				cfg_onClickAction = 'refresh'
			}
		}

		RadioButton {
			Layout.row: 11
			Layout.column: 1
			exclusiveGroup: clickGroup
			checked: cfg_onClickAction == 'nothing'
			text: i18n("Do Nothing")
			onClicked: {
				cfg_onClickAction = 'nothing'
			}
		}
	}
}
