# Crypto Currency Price Plasmoid

## About
This is a Plasma applet that shows the current price of bitcoin or any other cryptocurrency from user definable exchange sources and JSON keys.

## Installation
```
plasmapkg2 -i package
```

Use additional `-g` flag to install plasmoid globally, for all users.

## Usage
Choose a preset or enter your preferred Exchange URL and JSON Key (case sensitive) in settings.

Price conversion options can be found in the 'Price Conversion' sub-category.

For icons, i recommend downloading the respective coin images from coinranking.com.

### Example 1 - BTC-USD last price on Bitstamp
Exchange URL: https://www.bitstamp.net/api/ticker/

JSON Key: last

### Example 2 - ETH-USD ask price on Kraken
Exchange URL: https://api.kraken.com/0/public/Ticker?pair=ETHUSD

JSON Key: result.XETHZUSD.a.0

### Example 3 - BTC-ETH last price on Bittrex
Exchange URL: https://bittrex.com/api/v1.1/public/getticker?market=btc-eth

JSON Key: result.Last

### Example 4 - HUSH-USD price on CoinMarketCap
Exchange URL: https://api.coinmarketcap.com/v1/ticker/hush/

JSON Key: 0.price_usd

## Screenshots
![Crypto Currency Price Plasmoid1](https://raw.githubusercontent.com/spmdrd/plasma-applet-cryptocurrency-price/master/cryptocurrency-price-plasmoid1.png)

![Crypto Currency Price Plasmoid (Panel)](https://raw.githubusercontent.com/spmdrd/plasma-applet-cryptocurrency-price/master/cryptocurrency-price-panel.png)

![Crypto Currency Price Plasmoid (Configuration)](https://raw.githubusercontent.com/spmdrd/plasma-applet-cryptocurrency-price/master/cryptocurrency-price-config.png)

## Changelog

### 1.4
- added configuration presets
- added price conversion options
- added option to multiply price by x (e.g. # of coins)
- added option to convert base unit to fiat (e.g. btc to usd)
- added option to convert from fiat to fiat (e.g. usd to eur)
- added suffix option to display custom text after the price
- replaced eval() for json key processing
- json key format has changed due to changes in parsing method
- try to fix invalid/old format json keys with regex
- migrated getRate function to main qml
- fixed logic of show text / show icon options
- some code & ui changes

### 1.3
- added option to control # of decimal places
- added option to control icon click action
- cleaned up settings dialog look and structure
- some minor improvements

### 1.2
- fixed an error in eval function preventing coinmarketcap and other api json keys from being used
- refer to updated examples for new json key usage
- clicking icon now opens icon chooser dialog for easier icon changing

### 1.1
- added showing of custom icons
- added coin labeling
- removed buggy show decimals
- reordered config dialog
- changed plasmoid icon to applications-internet
- updated screenshots

### 1.0
Initial release

## To-Do
- user customizable/saveable presets
- price alarms and notifications
- portfolio management

## Donate
You can buy me a beer if you liked this widget:

BCH: 1DjJavavSFwPgTy8xRdkXQyx8accdec6M5

BTC: 3DoF2iwAB74cbTd1Bs5gxrLXpaacwU7abR

ETH: 0x672fAa0BebAd77ef7AB06A9bd95c78f1944edd8C 

XMR: 48FhvozRjou8V1W4vk1rZ32uGXH587RqZWoqNtVuL1dCj8ur1gWbvBLDY5rUBDuZL1UNXdjqiX8ARFfS89WirTsZ7GXG3Pq
