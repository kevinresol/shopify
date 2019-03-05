package;

import tink.http.clients.*;
import shopify.Shopify;

class Playground {
	static function main() {
		var shopify = new Shopify(new SecureNodeClient(), Sys.getEnv('SHOPIFY_SHOP_NAME'), Sys.getEnv('SHOPIFY_API_KEY'), Sys.getEnv('SHOPIFY_API_SECRET'));
		
		// Create a product
		// shopify.admin().products().create({
		// 	product: {
		// 		title: 'Burton Custom Freestyle 151',
		// 		body_html: '<strong>Good snowboard!</strong>',
		// 		vendor: 'Burton',
		// 		product_type: 'Snowboard',
		// 		tags: 'Barnes & Noble, John\'s Fav, "Big Air"',
		// 	}
		// })
		// 	.handle(o -> switch o {
		// 		case Success(res):
		// 			trace($type(res.product));
		// 		case Failure(e):
		// 			trace(e);
		// 	});
			
		// Delete a product
		// shopify.admin().products().delete(1746220482594)
		// 	.handle(o -> switch o {
		// 		case Success(res):
		// 			trace(res);
		// 		case Failure(e):
		// 			trace(e);
		// 	});
			
		// List products
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