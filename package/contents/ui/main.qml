import QtQuick 2.6
import QtQuick.Layouts 1.3
import QtQuick.Controls 1.4
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.components 2.0 as PlasmaComponents
import "../code/ccscript.js" as CCScript

Item {
	id: root
	
	Layout.fillHeight: true
	
	property string cryptoRate: '...'
	property bool showIcon: plasmoid.configuration.showIcon
	property bool showText: plasmoid.configuration.showText
	property bool updatingRate: false
	
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
		
		Layout.fillWidth: false
		Layout.minimumWidth: minWidth

		MouseArea {
			id: mouseArea
			anchors.fill: parent
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
			opacity: root.updatingRate ? 0.2 : mouseArea.containsMouse ? 0.8 : 1.0
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
			opacity: root.updatingRate ? 0.2 : mouseArea.containsMouse ? 0.8 : 1.0
			
			fontSizeMode: Text.Fit
			minimumPixelSize: cryptoIcon.width * 0.7
			font.pixelSize: 72			
			text: root.cryptoRate
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
		onShowDecimalsChanged: {
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
				if(!plasmoid.configuration.showDecimals) rate = Math.floor(rate);
				
				var rateText = Number(rate);
				
				if(!plasmoid.configuration.showDecimals) rateText = rateText.replace(Qt.locale().decimalPoint + '00', '');
				
				root.cryptoRate = rateText;
				
				var toolTipSubText = '<b>' + i18n(plasmoid.configuration.ttLabel) + '</b>';
				toolTipSubText += '<br />';
				toolTipSubText += '<b>' + root.cryptoRate + '</b>';
				
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
