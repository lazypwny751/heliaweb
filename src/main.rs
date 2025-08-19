use actix_web::{get, post, web, App, HttpResponse, HttpServer, Responder, middleware::Logger};

fn init_logger() {
    unsafe { 
    	std::env::set_var("RUST_LOG", "actix_web=info");
	}
    env_logger::init();
}

#[get("/")]
async fn hello() -> impl Responder {
    HttpResponse::Ok().body("Hello world!")
}

#[post("/echo")]
async fn echo(req_body: String) -> impl Responder {
    HttpResponse::Ok().body(req_body)
}

async fn manual_hello() -> impl Responder {
    HttpResponse::Ok().body("Hey there!")
}

#[actix_web::main]
async fn main() -> std::io::Result<()> {
	init_logger();

    HttpServer::new(|| {
        App::new()
			.wrap(Logger::default())
            .service(hello)
            .service(echo)
            .route("/hey", web::get().to(manual_hello))
    })
    .bind(("127.0.0.1", 8080))?
    .run()
    .await
}
