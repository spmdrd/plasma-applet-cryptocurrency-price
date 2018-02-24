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
	property alias cfg_pricePrefix: pricePrefix.text
	property alias cfg_ttLabel: ttLabel.text
	property string cfg_onClickAction: plasmoid.configuration.onClickAction
	property string cfg_icOnClickAction: plasmoid.configuration.icOnClickAction
	property alias cfg_refreshRate: refreshRate.value
	property alias cfg_decPlaces: decPlaces.value
	property alias cfg_controlDecimals: controlDecimals.checked
	property alias cfg_showText: showText.checked
	property alias cfg_showBackground: showBackground.checked
	property alias cfg_showPricePrefix: showPricePrefix.checked
	property alias cfg_showIcon: showIcon.checked
	property string cfg_icon: plasmoid.configuration.icon
	
	GridLayout {
		columns: 2
		
		Label {
			text: i18n("Exchange URL:")
		}
		
		TextField {
			id: xeUrl
			Layout.minimumWidth: theme.mSize(theme.defaultFont).width * 35
		}

		Label {
			text: i18n("JSON Key:")
		}

		TextField {
			id: xeKey
			Layout.minimumWidth: theme.mSize(theme.defaultFont).width * 15
		}
		
		Label {
			text: i18n("Exchange Name:")
		}

        GridLayout {
            columns: 2

            TextField {
                id: ttLabel
                Layout.minimumWidth: theme.mSize(theme.defaultFont).width * 12
            }
            
            Label {
                text: i18n("(Shown on hover)")
            }
        }

		Label {
			text: i18n("Price Prefix:")
		}

        GridLayout {
            columns: 2
            
            TextField {
                id: pricePrefix
                Layout.minimumWidth: theme.mSize(theme.defaultFont).width * 12
            }
            
            CheckBox {
                id: showPricePrefix
                text: i18n("Show Prefix")
                onClicked: {
                    if(!this.checked) {
                            pricePrefix.enabled = false
                        } else {
                            pricePrefix.enabled = true
                        }
                    }
                }
            }
		
		Label {
			text: "Round Decimals:"
		}
		
        GridLayout {
            columns: 2
 
            SpinBox {
                id: decPlaces
                Layout.minimumWidth: theme.mSize(theme.defaultFont).width * 12
                minimumValue: 0
                suffix: i18n(" places")
            }
            
            CheckBox {
			id: controlDecimals
			text: i18n("Enabled")
			onClicked: {
                if(!this.checked) {
                        decPlaces.enabled = false
                    } else {
                        decPlaces.enabled = true
                    }
                }
            }
        }
        
        Label {
			text: i18n("Refresh Frequency:")
		}
		
		SpinBox {
			id: refreshRate
            Layout.minimumWidth: theme.mSize(theme.defaultFont).width * 12
			suffix: i18n(" minutes")
			minimumValue: 1
		}
		
        Label {
			text: i18n("Price On Click:")
		}
		

        GridLayout {
            columns: 3
 
            ExclusiveGroup { id: clickGroup }
        
            RadioButton {
                exclusiveGroup: clickGroup
                checked: cfg_onClickAction == 'refresh'
                text: i18n("Refresh")
                onClicked: {
                    cfg_onClickAction = 'refresh'
                    }
                }

            RadioButton {
                exclusiveGroup: clickGroup
                checked: cfg_onClickAction == 'nothing'
                text: i18n("Do Nothing")
                onClicked: {
                    cfg_onClickAction = 'nothing'
                    }
                }
                
            Label {
                text: ""
            }
        }

        Label {
            text: "Icon On Click:"
        }
        
		ExclusiveGroup { id: icClickGroup }
        
        GridLayout {
            columns: 3
 
           RadioButton {
                id: icRefresh
                exclusiveGroup: icClickGroup
                checked: cfg_icOnClickAction == 'refresh'
                text: i18n("Refresh")
                onClicked: {
                    cfg_icOnClickAction = 'refresh'
                    }
                }

            RadioButton {
                id: icNothing
                exclusiveGroup: icClickGroup
                checked: cfg_icOnClickAction == 'nothing'
                text: i18n("Do Nothing")
                onClicked: {
                    cfg_icOnClickAction = 'nothing'
                    }
                }
                
             RadioButton {
                id: icChoose
                exclusiveGroup: icClickGroup
                checked: cfg_icOnClickAction == 'icchooser'
                text: i18n("Choose Icon")
                onClicked: {
                    cfg_icOnClickAction = 'icchooser'
                    }
                }
            }
            
        Label {
			text: i18n("Icon:")
		}
	
        GridLayout {
            columns: 2
 
            IconPicker {
                id: iconPicker
                currentIcon: cfg_icon
                defaultIcon: ""
                onIconChanged: cfg_icon = iconName
                enabled: true
            }
        
            CheckBox {
                id: showIcon
                text: i18n("Show icon")
                onClicked: {
                    if(!this.checked) {
                        showText.checked = true
                        showText.enabled = false
                        iconPicker.enabled = false
                        icChoose.enabled = false
                        icRefresh.enabled = false
                        icNothing.enabled = false
                    } else {
                        showText.enabled = true
                        iconPicker.enabled = true
                        icChoose.enabled = true
                        icRefresh.enabled = true
                        icNothing.enabled = true
                    }
                }
            }
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
		
        GridLayout {
            columns: 3
 
            CheckBox {
                id: showText
                text: i18n("Show price")
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
                    text: i18n("(Disabled: displays the price only on hover)")
                }
        }
    }
}
