package;

import tink.http.clients.*;
import shopify.Shopify;

class Playground {
	static function main() {
		var shopify = new Shopify(new SecureNodeClient(), 'my_shop_name', 'api_key', 'api_secret');
		shopify.admin().products().list({})
			.handle(o -> switch o {
				case Success(res):
					trace(res);
					for(product in res.products) trace($type(product));
				case Failure(e):
					trace(e);
			});
	}
}