import QtQuick 2.6
import QtQuick.Layouts 1.3
import QtQuick.Controls 1.4
import QtQuick.Dialogs 1.2
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.components 2.0 as PlasmaComponents
import org.kde.kquickcontrolsaddons 2.0 as KQuickAddons

Item {
	id: root
	
	Layout.fillHeight: true
	
	property string cryptoRate: '...'
	property string cryptoRateA: '...'
	property string cryptoRateB: '...'
	property string cryptoRateC: '...'
	property bool showPricePrefix: plasmoid.configuration.showPricePrefix
	property bool showPriceSuffix: plasmoid.configuration.showPriceSuffix
	property bool showIcon: plasmoid.configuration.showIcon
	property bool showText: plasmoid.configuration.showText
	property bool showUpdatingIndicator: plasmoid.configuration.showUpdatingIndicator
	property bool controlDecimals: plasmoid.configuration.controlDecimals
	property bool updatingRate: false
	property bool useCustomIcon: plasmoid.configuration.showIcon && plasmoid.configuration.icon != ''
	property bool multiFixed: plasmoid.configuration.multiFixed
	property bool multiExternalB: plasmoid.configuration.multiExternalB
	property bool multiExternalC: plasmoid.configuration.multiExternalC
	
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
				return cryptoValue.paintedWidth;
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
			enabled: root.showIcon
		}
		
		MouseArea {
			id: mouseAreaIcon2
			anchors.fill: cryptoIcon2
			hoverEnabled: true
			enabled: root.showIcon
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
			visible: showUpdatingIndicator && updatingRate
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
			opacity: root.useCustomIcon ? 0.0 : showUpdatingIndicator && root.updatingRate ? 0.2 : mouseAreaIcon.containsMouse ? 0.8 : 1.0
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
			opacity: showUpdatingIndicator && root.updatingRate ? 0.2 : mouseAreaIcon2.containsMouse ? 0.8 : 1.0
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
			opacity: showUpdatingIndicator && root.updatingRate ? 0.2 : mouseAreaValue.containsMouse ? 0.8 : 1.0
			fontSizeMode: Text.Fit
			minimumPixelSize: cryptoIcon.width * 0.7
			font.pixelSize: 72

			text: {
				// calculate cryptoRate based on checked options
				root.cryptoRate = root.cryptoRateA;
				
				if (plasmoid.configuration.multiExternalB) { // if base to fiat checked
					root.cryptoRate = root.cryptoRate * root.cryptoRateB;
				}
				
				if (plasmoid.configuration.multiExternalC) { // if fiat to fiat checked
					root.cryptoRate = root.cryptoRate * root.cryptoRateC;
				}
				
				if (plasmoid.configuration.multiFixed) { // if multiply by x checked
					root.cryptoRate = root.cryptoRate * plasmoid.configuration.multiFixedInput;
				}
				
				if (root.controlDecimals) { // if round decimals checked
					root.cryptoRate = Number(root.cryptoRate).toFixed(plasmoid.configuration.decPlaces);
				}
				
				// for the tooltip 
				if (plasmoid.configuration.ttLabel != "") { // if tooltip label not empty
					var toolTipSubText = '<b>' + i18n(plasmoid.configuration.ttLabel) + '</b>';
					toolTipSubText += '<br />'; // +ttLabel
					
					if (root.showPricePrefix) { // if show price prefix enabled
						if (root.showPriceSuffix) { // if show price suffix enabled
							toolTipSubText += '<b>' + plasmoid.configuration.pricePrefix + root.cryptoRate + plasmoid.configuration.priceSuffix + '</b>'; // +pricePrefix +cryptoRate +priceSuffix
						} else {
							toolTipSubText += '<b>' + plasmoid.configuration.pricePrefix + root.cryptoRate + '</b>'; // +pricePrefix +cryptoRate
						}
					} else {
						if (root.showPriceSuffix) { // if show price suffix enabled
							toolTipSubText += '<b>' + root.cryptoRate + plasmoid.configuration.priceSuffix + '</b>'; // +cryptoRate +priceSuffix
						} else {
							toolTipSubText += '<b>' + root.cryptoRate + '</b>'; +cryptoRate
						}
					}
				} else {
					if (root.showPricePrefix) { // if show price prefix enabled
						if (root.showPriceSuffix) { // if show price suffix enabled
							toolTipSubText = '<b>' + plasmoid.configuration.pricePrefix + root.cryptoRate + plasmoid.configuration.priceSuffix + '</b>'; // +pricePrefix +cryptoRate +priceSuffix
						} else {
							toolTipSubText = '<b>' + plasmoid.configuration.pricePrefix + root.cryptoRate + '</b>'; // +pricePrefix +cryptoRate
						}
					} else {
						if (root.showPriceSuffix) { // if show price suffix enabled
							toolTipSubText = '<b>' + root.cryptoRate + plasmoid.configuration.priceSuffix + '</b>'; // +cryptoRate +priceSuffix
						} else {
							toolTipSubText = '<b>' + root.cryptoRate + '</b>'; // +cryptoRate
						}
					}
				}
				plasmoid.toolTipSubText = toolTipSubText;
				
				// final text to be displayed
				if (root.showText) { // if show price enabled
					if (root.showPricePrefix) { // if show price prefix enabled
						if (root.showPriceSuffix) { // if show price suffix enabled
							(plasmoid.configuration.pricePrefix + root.cryptoRate + 	plasmoid.configuration.priceSuffix)
						} else {
							(plasmoid.configuration.pricePrefix + root.cryptoRate)
						}
					} else {
						if (root.showPriceSuffix) { // if show price suffix enabled
							(root.cryptoRate + plasmoid.configuration.priceSuffix)
						} else {
							root.cryptoRate
						}
					}
				}
			}
		}
	}

	Component.onCompleted: {
		plasmoid.setAction('refresh', i18n("Refresh"), 'view-refresh')
		plasmoid.setAction('nothing', i18n("Do Nothing"), 'internet-services')
	}

	Connections {
		target: plasmoid.configuration
		
		onXeUrlAChanged: {
			cryptoTimer.restart();
		}
		onXeKeyAChanged: {
			cryptoTimer.restart();
		}
		onXeUrlBChanged: {
			cryptoTimer.restart();
		}
		onXeKeyBChanged: {
			cryptoTimer.restart();
		}
		onXeUrlCChanged: {
			cryptoTimer.restart();
		}
		onXeKeyCChanged: {
			cryptoTimer.restart();
		}
		onDecPlacesChanged: {
			cryptoTimer.restart();
		}
	}

	Timer {
		id: cryptoTimer
		interval: plasmoid.configuration.refreshRate * 1000
		running: true
		repeat: true
		triggeredOnStart: true
		
		function getRate(url, key, callback) {
			if (url != "") {
				// attempt to correct invalid or old format keys
				var key = key.replace(/\[/g, '\.');
				var key = key.replace(/\]/g, '');
				var key = key.replace(/^\./, '');
				var key = key.replace(/\.\./g, '\.');
				
				var xhr = new XMLHttpRequest();
				xhr.onreadystatechange = function() {
					if (xhr.readyState == 4 && xhr.status == 200) {
						var rate = JSON.parse(xhr.responseText);
						var keys = key.split(".");
						for (var x = 0; x < keys.length; x++) {
							rate = rate[keys[x]];
						}
						
/*						if (!rate || isNaN(rate)) { // old method using eval()
							try {
								var rate = eval("data" + key);
							} catch (err) {
								console.log("---------error: " + err.message);
							}
						}*/
						
						callback(rate);
					}
				};
				xhr.open('GET', url, true);
				xhr.timeout = 5000;
				xhr.send(null);
			}
		}
		
		onTriggered: {
			root.updatingRate = true;
			
			if (plasmoid.configuration.multiExternalB) { // fetch if base to fiat enabled
				var resultB = getRate(plasmoid.configuration.xeUrlB, plasmoid.configuration.xeKeyB, function(rate) {
					root.cryptoRateB = rate;
				});
			}
			
			if (plasmoid.configuration.multiExternalC) { // fetch if fiat to fiat enabled
				var resultC = getRate(plasmoid.configuration.xeUrlC, plasmoid.configuration.xeKeyC, function(rate) {
					root.cryptoRateC = rate;
				});
			}
			
			var resultA = getRate(plasmoid.configuration.xeUrlA, plasmoid.configuration.xeKeyA, function(rate) { // fetch main rate
				root.cryptoRateA = rate;
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
