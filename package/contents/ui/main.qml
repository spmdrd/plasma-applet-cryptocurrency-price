import QtQuick 2.6
import QtQuick.Layouts 1.3
import QtQuick.Controls 1.4
import QtQuick.Dialogs 1.2
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.components 2.0 as PlasmaComponents
import org.kde.kquickcontrolsaddons 2.0 as KQuickAddons
import "../code/ccscript.js" as CCScript

Item {
	id: root
	
	Layout.fillHeight: true
	
	property string cryptoRate: '...'
	property bool showPricePrefix: plasmoid.configuration.showPricePrefix
	property bool showIcon: plasmoid.configuration.showIcon
	property bool showText: plasmoid.configuration.showText
	property bool controlDecimals: plasmoid.configuration.controlDecimals
	property bool updatingRate: false
	property bool useCustomIcon: plasmoid.configuration.showIcon && plasmoid.configuration.icon != ''
	
	Plasmoid.preferredRepresentation: Plasmoid.compactRepresentation
	Plasmoid.toolTipTextFormat: Text.RichText
	Plasmoid.backgroundHints: plasmoid.configuration.showBackground ? "StandardBackground" : "NoBackground"
	
	Plasmoid.compactRepresentation: Item {
		property int textMargin: cryptoIcon.height * 0.25
		property int minWidth: {
			if(root.showIcon && root.showText) {
				return cryptoValue.paintedWidth + cryptoIcon.width + textMargin;
			}
			else if(root.showIcon) {
				return cryptoIcon.width;
			} else {
				return cryptoValue.paintedWidth
			}
		}
		
		signal iconChanged(string iconName)
		
		Layout.fillWidth: false
		Layout.minimumWidth: minWidth

        KQuickAddons.IconDialog {
            id: iconDialog
            onIconNameChanged: {
                iconChanged(iconName)
                plasmoid.configuration.icon = iconName
            }
        }
    
        MouseArea {
			id: mouseAreaValue
			anchors.fill: cryptoValue
			hoverEnabled: true
			onClicked: {
				switch(plasmoid.configuration.onClickAction) {
					case 'nothing':
						action_nothing();
						break;
					
					case 'refresh':
					default:
						action_refresh();
						break;
				}
			}
		}
		
		MouseArea {
			id: mouseAreaIcon
			anchors.fill: cryptoIcon
			hoverEnabled: true
//			onClicked: iconDialog.open();
		}
		
		MouseArea {
			id: mouseAreaIcon2
			anchors.fill: cryptoIcon2
			hoverEnabled: true
			onClicked: {
				switch(plasmoid.configuration.icOnClickAction) {
					case 'nothing':
						action_nothing();
						break;
					
					case 'refresh':
						action_refresh();
						break;
                        
					case 'icchooser':
					default:
						iconDialog.open();
						break;
				}
			}
        }
		
		BusyIndicator {
			width: parent.height
			height: parent.height
			anchors.horizontalCenter: root.showIcon ? cryptoIcon.horizontalCenter : cryptoValue.horizontalCenter
			running: updatingRate
			visible: updatingRate
		}
		
		Image {
			id: cryptoIcon
			width: parent.height * 0.9
			height: parent.height * 0.9
			anchors.top: parent.top
			anchors.left: parent.left
			anchors.topMargin: parent.height * 0.05
			anchors.leftMargin: root.showText ? parent.height * 0.05 : 0
			
			source: "../images/blank.svg"
			visible: root.showIcon
			opacity: root.useCustomIcon ? 0.0 : root.updatingRate ? 0.2 : mouseAreaIcon.containsMouse ? 0.8 : 1.0
        }
		
		PlasmaCore.IconItem {
			id: cryptoIcon2
			width: parent.height * 0.9
			height: parent.height * 0.9
			anchors.top: parent.top
			anchors.left: parent.left
			anchors.topMargin: parent.height * 0.05
			anchors.leftMargin: root.showText ? parent.height * 0.05 : 0
			
			source: plasmoid.configuration.icon
			visible: root.showIcon
			opacity: root.updatingRate ? 0.2 : mouseAreaIcon2.containsMouse ? 0.8 : 1.0
		}
		
		PlasmaComponents.Label {
			id: cryptoValue
			height: parent.height
			anchors.left: root.showIcon ? cryptoIcon.right : parent.left
			anchors.right: parent.right
			anchors.leftMargin: root.showIcon ? textMargin : 0
			
			horizontalAlignment: root.showIcon ? Text.AlignLeft : Text.AlignHCenter
			verticalAlignment: Text.AlignVCenter
			
			visible: root.showText
			opacity: root.updatingRate ? 0.2 : mouseAreaValue.containsMouse ? 0.8 : 1.0
			
			fontSizeMode: Text.Fit
			minimumPixelSize: cryptoIcon.width * 0.7
			font.pixelSize: 72			
			text: root.showPricePrefix ? (plasmoid.configuration.pricePrefix + root.cryptoRate) : root.cryptoRate
		}
	}
	
	Component.onCompleted: {
		plasmoid.setAction('refresh', i18n("Refresh"), 'view-refresh')
		plasmoid.setAction('nothing', i18n("Do Nothing"), 'internet-services')
	}
	
	Connections {
		target: plasmoid.configuration
		
		onXeUrlChanged: {
			cryptoTimer.restart();
		}
		onXeKeyChanged: {
			cryptoTimer.restart();
		}
		onRefreshRateChanged: {
			cryptoTimer.restart();
		}
	}
	
	Timer {
		id: cryptoTimer
		interval: plasmoid.configuration.refreshRate * 60 * 1000
		running: true
		repeat: true
		triggeredOnStart: true
		onTriggered: {
			root.updatingRate = true;
			
			var result = CCScript.getRate(plasmoid.configuration.xeUrl, plasmoid.configuration.xeKey, function(rate) {
				
				if(!plasmoid.configuration.controlDecimals) {
                    var rateText = Number(rate);
                } else {
				var rateText = Number(rate).toFixed(plasmoid.configuration.decPlaces);
                }
				
				root.cryptoRate = rateText;
				
				var toolTipSubText = '<b>' + i18n(plasmoid.configuration.ttLabel) + '</b>';
				toolTipSubText += '<br />';
				root.showPricePrefix? toolTipSubText += '<b>' + plasmoid.configuration.pricePrefix + root.cryptoRate + '</b>' : toolTipSubText += '<b>' + root.cryptoRate + '</b>'
				
				plasmoid.toolTipSubText = toolTipSubText;
				
				root.updatingRate = false;
			});
		}
	}
	
	function action_refresh() {
		cryptoTimer.restart();
	}
	
	function action_nothing() {
		return;
	}
}
