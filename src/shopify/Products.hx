package shopify;

interface Products {
	
	@:get('/')
	function list(query:{
		?ids:String,
		?limit:Int,
		?page:Int,
		// ... TODO
	}):{
		products:Array<{
			body_html:String,
			created_at:String,
			handle:String,
			id:Int,
			// ... TODO
		}>
	}
}