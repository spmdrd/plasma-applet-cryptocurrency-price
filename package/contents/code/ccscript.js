function getRate(xeUrl, xeKey, callback) {
	if (typeof xeUrl === 'undefined') var xeUrl = getDefaultUrl();
	if (typeof xeKey === 'undefined') var xeKey = getDefaultKey();
    if(xeUrl === null) return false;
	if(xeKey === null) return false;
	
	request(xeUrl, function(req) {
	var data = JSON.parse(req.responseText);
    var rate = eval("data" + xeKey); 
    callback(rate);
	});

	return true;
}

function getDefaultUrl() {
		var xeUrl = 'https://api.kraken.com/0/public/Ticker?pair=XBTUSD';
		return xeUrl;
		return null;
}

function getDefaultKey() {
		var xeKey = '.result.XXBTZUSD.c[0]';
		return xeKey;
		return null;
}

function request(xeUrl, callback) {
	var xhr = new XMLHttpRequest();
	xhr.onreadystatechange = (function(xhr) {
		return function() {
			callback(xhr);
		}
	})(xhr);
	xhr.open('GET', xeUrl, true);
	xhr.send();
}
