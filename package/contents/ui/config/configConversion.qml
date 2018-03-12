import QtQuick 2.6
import QtQuick.Controls 1.4
import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.3
import org.kde.plasma.components 2.0 as PlasmaComponents

Item {
	id: root
	Layout.fillWidth: true
	
	property alias cfg_multiFixed: multiFixed.checked
	property alias cfg_multiFixedInput: multiFixedInput.value
	property alias cfg_multiExternalB: multiExternalB.checked
	property alias cfg_xeUrlB: xeUrlB.text
	property alias cfg_xeKeyB: xeKeyB.text
	property alias cfg_multiExternalC: multiExternalC.checked
	property alias cfg_xeUrlC: xeUrlC.text
	property alias cfg_xeKeyC: xeKeyC.text
	
	GridLayout {
		columns: 2
		
		CheckBox {
			id: multiFixed
			text: i18n("Multiply price by")
			onClicked: {
				if(!this.checked) {
					multiFixedInput.enabled = false
				} else {
					multiFixedInput.enabled = true
				}
			}
		}
		
		GridLayout {
			columns: 2
			
			SpinBox {
				id: multiFixedInput
				Layout.minimumWidth: theme.mSize(theme.defaultFont).width * 18
				decimals: 8
				stepSize: 0.00000001
				maximumValue: 9999999999.99999999
			}
			
			Label {
				text: i18n("(e.g. # of coins)")
			}
		}
		
		CheckBox {
			id: multiExternalB
			text: i18n("Base Unit to FIAT:")
			onClicked: {
				if(!this.checked) {
					xeUrlB.enabled = false
					xeKeyB.enabled = false
					} else {
					xeUrlB.enabled = true
					xeKeyB.enabled = true
				}
			}
		}
		
		Label {
		text: i18n("(e.g. convert a price shown in BTC to USD)")
		}
		
		Label {
			text: i18n("Base Price URL:")
		}
		
		TextField {
			id: xeUrlB
			Layout.minimumWidth: theme.mSize(theme.defaultFont).width * 40
		}
		
		Label {
			text: i18n("JSON Key:")
		}
		
		TextField {
			id: xeKeyB
			Layout.minimumWidth: theme.mSize(theme.defaultFont).width * 18
		}
		
		CheckBox {
			id: multiExternalC
			text: i18n("FIAT to FIAT:")
			onClicked: {
				if(!this.checked) {
					xeUrlC.enabled = false
					xeKeyC.enabled = false
				} else {
					xeUrlC.enabled = true
					xeKeyC.enabled = true
				}
			}
		}
		
		Label {
		text: i18n("(e.g. convert a price shown in USD to EUR)")
		}
		
		Label {
			text: i18n("FIAT Rate URL:")
		}
		
		TextField {
			id: xeUrlC
			Layout.minimumWidth: theme.mSize(theme.defaultFont).width * 40
		}
		
		Label {
			text: i18n("JSON Key:")
		}
		
		TextField {
			id: xeKeyC
			Layout.minimumWidth: theme.mSize(theme.defaultFont).width * 18
		}
	}
}
 
