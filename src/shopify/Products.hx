package shopify;

interface Products {
	
	@:get('/')
	function list(query:{
		?ids:String,
		?limit:Int,
		?page:Int,
		// ... TODO
	}):{products:Array<Product>};
	
	@:post('/')
	function create(body:{
		product: {
			title:String,
			body_html:String,
			vendor:String,
			product_type:String,
			tags:String,
		}
	}):{product:Product};
	
	@:delete('/$id')
	function delete(id:Float):{};
}

typedef Product = {
	body_html:String,
	created_at:String,
	handle:String,
	id:Float,
	// ... TODO: more fields
}