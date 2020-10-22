import QtQuick 2.6
import QtQuick.Controls 1.4
import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.3
import org.kde.plasma.components 2.0 as PlasmaComponents

Item {
	id: root
	Layout.fillWidth: true
	property alias cfg_xeUrlA: xeUrlA.text
	property alias cfg_xeKeyA: xeKeyA.text
	property alias cfg_ttLabel: ttLabel.text
	property string cfg_onClickAction: plasmoid.configuration.onClickAction
	property string cfg_icOnClickAction: plasmoid.configuration.icOnClickAction
	property alias cfg_refreshRate: refreshRate.value
	property alias cfg_pricePrefix: pricePrefix.text
	property alias cfg_priceSuffix: priceSuffix.text
	property alias cfg_decPlaces: decPlaces.value
	property alias cfg_controlDecimals: controlDecimals.checked
	property alias cfg_showPricePrefix: showPricePrefix.checked
	property alias cfg_showPriceSuffix: showPriceSuffix.checked
	property alias cfg_showText: showText.checked
	property alias cfg_showIcon: showIcon.checked
	property alias cfg_showBackground: showBackground.checked
	property alias cfg_showUpdatingIndicator: showUpdatingIndicator.checked
	property string cfg_icon: plasmoid.configuration.icon
	
	GridLayout {
		columns: 2
		
		Label {
			text: i18n("Load Preset:")
		}
		
		ComboBox {
			id: loadPresetCombo
			Layout.minimumWidth: theme.mSize(theme.defaultFont).width * 40
			model: [{
				text: i18n("Bitstamp BTC-USD"),
				url: "https://www.bitstamp.net/api/ticker/",
				key: "last",
				tooltip: "Bitstamp BTC-USD",
				symbol: "$"
			}, {
				text: i18n("Binance ETH-BTC"),
				url: "https://api.binance.com/api/v3/ticker/price?symbol=ETHBTC",
				key: "price",
				tooltip: "Binance ETH-BTC",
				symbol: "Ƀ"
			}, {
				text: i18n("Bitfinex BTC-USD"),
				url: "https://api.bitfinex.com/v1/pubticker/BTCUSD",
				key: "last_price",
				tooltip: "Bitfinex BTC-USD",
				symbol: "$"
			}, {
				text: i18n("bitFlyer BTC-JPY"),
				url: "https://api.bitflyer.com/v1/getticker?product_code=BTC_JPY",
				key: "ltp",
				tooltip: "bitFlyer BTC-JPY",
				symbol: "¥"
			}, {
				text: i18n("Bithumb BTC-KRW"),
				url: "https://api.bithumb.com/public/ticker/BTC",
				key: "data.closing_price",
				tooltip: "Bithumb BTC-KRW",
				symbol: "₩"
			}, {
				text: i18n("Bittrex ETH-BTC"),
				url: "https://bittrex.com/api/v1.1/public/getticker?market=btc-eth",
				key: "result.Last",
				tooltip: "Bittrex ETH-BTC",
				symbol: "Ƀ"
			}, {
				text: i18n("BTCC BTC-USD"),
				url: "https://spotusd-data.btcc.com/data/pro/ticker?symbol=BTCUSD",
				key: "ticker.Last",
				tooltip: "BTCC BTC-USD",
				symbol: "$"
			}, {
				text: i18n("Coinmarketcap BTC-USD"),
				url: "https://api.coinmarketcap.com/v1/ticker/bitcoin/",
				key: "0.price_usd",
				tooltip: "Coinmarketcap BTC-USD",
				symbol: "$"
			}, /*{
				text: i18n("GDAX BTC-USD"),
				url: "https://api.gdax.com/products/BTC-USD/ticker",
				key: "price",
				tooltip: "GDAX BTC-USD",
				symbol: "$"
			}, */{
				text: i18n("Gemini BTC-USD"),
				url: "https://api.gemini.com/v1/pubticker/btcusd",
				key: "last",
				tooltip: "Gemini BTC-USD",
				symbol: "$"
			}, {
				text: i18n("Kraken BTC-USD"),
				url: "https://api.kraken.com/0/public/Ticker?pair=XBTUSD",
				key: "result.XXBTZUSD.c.0",
				tooltip: "Kraken BTC-USD",
				symbol: "$"
			}, {
				text: i18n("Localbitcoins BTC-USD"),
				url: "https://localbitcoins.com/bitcoinaverage/ticker-all-currencies/",
				key: "USD.rates.last",
				tooltip: "Localbitcoins BTC-USD",
				symbol: "$"
			}, {
				text: i18n("Poloniex ETH-BTC"),
				url: "https://poloniex.com/public?command=returnTicker",
				key: "BTC_ETH.last",
				tooltip: "Poloniex ETH-BTC",
				symbol: "Ƀ"
			}]
			
			onActivated: {
					cfg_xeUrlA = loadPresetCombo.model[index].url,
					cfg_xeKeyA = loadPresetCombo.model[index].key,
					cfg_ttLabel = loadPresetCombo.model[index].tooltip,
					cfg_pricePrefix = loadPresetCombo.model[index].symbol
			}
			
			Component.onCompleted: {
				for (var i = 0, length = model.length; i < length; ++i) {
					if (model[i].url === cfg_xeUrlA) {
						currentIndex = i
						return
					}
				}
			}
		}
		
		Label {
			text: i18n("Exchange URL:")
		}
		
		TextField {
			id: xeUrlA
			Layout.minimumWidth: theme.mSize(theme.defaultFont).width * 40
		}
		
		Label {
			text: i18n("JSON Key:")
		}
		
		TextField {
			id: xeKeyA
			Layout.minimumWidth: theme.mSize(theme.defaultFont).width * 18
		}
		
		Label {
			text: i18n("Exchange Name:")
		}
		
		GridLayout {
			columns: 2
			
			TextField {
				id: ttLabel
				Layout.minimumWidth: theme.mSize(theme.defaultFont).width * 18
			}
			
			Label {
				text: i18n("(Shown on hover)")
			}
		}
		
		Label {
			text: i18n("Refresh Rate:")
		}
		
		SpinBox {
			id: refreshRate
			Layout.minimumWidth: theme.mSize(theme.defaultFont).width * 18
			suffix: i18n(" seconds")
			minimumValue: 1
		}
		
		CheckBox {
			id: controlDecimals
			text: i18n("Round Decimals:")
			onClicked: {
				if(!this.checked) {
					decPlaces.enabled = false
				} else {
					decPlaces.enabled = true
				}
			}
		}
		
		SpinBox {
			id: decPlaces
			Layout.minimumWidth: theme.mSize(theme.defaultFont).width * 18
			minimumValue: 0
			suffix: i18n(" places")
		}
		
		CheckBox {
			id: showPricePrefix
			text: i18n("Show Prefix:")
			onClicked: {
				if(!this.checked) {
					pricePrefix.enabled = false
				} else {
					pricePrefix.enabled = true
				}
			}
		}
		
		TextField {
			id: pricePrefix
			Layout.minimumWidth: theme.mSize(theme.defaultFont).width * 12
		}
		
		CheckBox {
			id: showPriceSuffix
			text: i18n("Show Suffix:")
			onClicked: {
				if(!this.checked) {
					priceSuffix.enabled = false
				} else {
					priceSuffix.enabled = true
				}
			}
		}
		
		TextField {
			id: priceSuffix
			Layout.minimumWidth: theme.mSize(theme.defaultFont).width * 12
		}
		
		CheckBox {
			id: showIcon
			text: i18n("Show icon")
			onClicked: {
				if(!this.checked) {
					iconPicker.enabled = false
					icChoose.enabled = false
					icRefresh.enabled = false
					icNothing.enabled = false
				} else {
					iconPicker.enabled = true
					icChoose.enabled = true
					icRefresh.enabled = true
					icNothing.enabled = true
				}
			}
		}
		
		IconPicker {
			id: iconPicker
			currentIcon: cfg_icon
			defaultIcon: ""
			onIconChanged: cfg_icon = iconName
			enabled: true
		}
		
		CheckBox {
			id: showBackground
			text: i18n("Show background")
		}
		
		Label {
			text: i18n("(Disabled: Transparent background)")
		}
		
		CheckBox {
			id: showText
			text: i18n("Show price")
		}
		
		Label {
			text: i18n("(Disabled: Displays the price only on hover)")
		}
		
		CheckBox {
			id: showUpdatingIndicator
			text: i18n("Show Updating Indicator")
		}

		Label {
			text: i18n("(Disabled: Don't show busy indicator and keep the same opacity)")
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
		
		GridLayout {
			columns: 3
			ExclusiveGroup { id: icClickGroup }
			
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
	}
}
