package shopify;

import haxe.crypto.*;
import haxe.io.*;
import tink.http.Client;
import tink.http.Request;
import tink.http.Response;
import tink.http.Header;
import tink.web.proxy.Remote;
import tink.Url;
import tink.url.Host;

using tink.CoreApi;

private typedef Impl = Remote<Root>;

@:forward
abstract Shopify(Impl) to Impl {
	public function new(client, shop, user, pass) {
		client = new AuthClient(client, user, pass);
		client = new JsonClient(client);
		this = new Impl(client, new RemoteEndpoint(new Host('$shop.myshopify.com', 443)));
	}
}

class AuthClient implements ClientObject {
	
	var client:Client;
	var header:HeaderField;
	
	public function new(client, user, pass) {
		this.client = client;
		this.header = new HeaderField(AUTHORIZATION, 'Basic ${Base64.encode(Bytes.ofString('$user:$pass'))}');
	}
	
	public function request(req:OutgoingRequest):Promise<IncomingResponse> {
		return client.request(new OutgoingRequest(req.header.concat([header]), req.body));
	}
}

class JsonClient implements ClientObject {
	var client:Client;
	
	public function new(client) {
		this.client = client;
	}
	
	public function request(req:OutgoingRequest):Promise<IncomingResponse> {
		return client.request(new OutgoingRequest(
			new OutgoingRequestHeader(
				req.header.method,
				Url.make({
					path: req.header.url.path + '.json',
					query: req.header.url.query,
					host: req.header.url.host,
					hosts: req.header.url.hosts,
					auth: req.header.url.auth,
					scheme: req.header.url.scheme,
					hash: req.header.url.hash,
				}),
				req.header.protocol,
				@:privateAccess req.header.fields
			),
			req.body
		));
	}
}