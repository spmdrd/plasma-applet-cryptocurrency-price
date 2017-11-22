# Crypto Currency Price Plasmoid

## About
This is a Plasma applet that shows the current price of any cryptocurrency from user definable exchanges and JSON keys.

Credits to Maciej Gierej, author of the bitcoin price applet that this applet is derived from:

https://github.com/MakG10/plasma-applet-bitcoin-price

## Installation
```
plasmapkg2 -i package
```

Use additional `-g` flag to install plasmoid globally, for all users.

## Usage
Enter the Exchange URL and JSON Key in settings. The tooltip label is shown on hover.

The 'show icon' function is still a WIP but you can manually replace the blank.svg image with one of your own for now.

### Example 1 - BTC-USD last price on Bitstamp
Exchange URL: https://www.bitstamp.net/api/ticker/

JSON Key: last

### Example 2 - ETH-USD ask price on Kraken
Exchange URL: https://api.kraken.com/0/public/Ticker?pair=ETHUSD

JSON Key: result.XETHZUSD.a[0]

### Example 3 - BTC-ETH last price on Bittrex
Exchange URL: https://bittrex.com/api/v1.1/public/getticker?market=btc-eth

JSON Key: result.Last

## Screenshots
![Crypto Currency Price Plasmoid1](https://raw.githubusercontent.com/spmdrd/plasma-applet-cryptocurrency-price/master/cryptocurrency-price-plasmoid1.png)

![Crypto Currency Price Plasmoid](https://raw.githubusercontent.com/spmdrd/plasma-applet-cryptocurrency-price/master/cryptocurrency-price-plasmoid2.png)

![Crypto Currency Price Plasmoid (Panel)](https://raw.githubusercontent.com/spmdrd/plasma-applet-cryptocurrency-price/master/cryptocurrency-price-panel.png)

![Crypto Currency Price Plasmoid (Configuration)](https://raw.githubusercontent.com/spmdrd/plasma-applet-cryptocurrency-price/master/cryptocurrency-price-config.png)

## Changelog

### 1.0
Initial release

## To Do
- show a label instead of icon for the currency type of the rate (e.g. USD, BTC)
- 'Show custom icon' option in settings
- show additional fields for ask, bid, last in the hover tooltip
- Allow controlling # of decimal places

## Donate
You can buy me a beer if you liked this widget:

BCH: 1DjJavavSFwPgTy8xRdkXQyx8accdec6M5

BTC: 3DoF2iwAB74cbTd1Bs5gxrLXpaacwU7abR

ETH: 0x672fAa0BebAd77ef7AB06A9bd95c78f1944edd8C 

XMR: 48FhvozRjou8V1W4vk1rZ32uGXH587RqZWoqNtVuL1dCj8ur1gWbvBLDY5rUBDuZL1UNXdjqiX8ARFfS89WirTsZ7GXG3Pq
