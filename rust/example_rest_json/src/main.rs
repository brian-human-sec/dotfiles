#[macro_use]
extern crate json;

use actix_web::{error, middleware, web, App, Error, HttpRequest, HttpResponse, HttpServer};
use bytes::BytesMut;
use futures::{Future, Stream};
use json::JsonValue;
use serde_derive::{Deserialize, Serialize};

#[derive(Debug, Serialize, Deserialize)]
struct MyObj {
    name: String,
    number: i32,
}

const MAX_SIZE: usize = 262_144; // max payload size is 256k

fn index_handler(item: web::Json<MyObj>) -> HttpResponse {
    println!("model: {:?}", &item);
    HttpResponse::Ok().json(item.0)
}

fn extract_item(item: web::Json<MyObj>, req: HttpRequest) -> HttpResponse {
    println!("request: {:?}", req);
    println!("model: {:?}", item);

    HttpResponse::Ok().json(item.0) // <- send json response
}

/// This handler manually load request payload and parse json object
fn index_manual( payload: web::Payload,) -> impl Future<Item = HttpResponse, Error = Error> {
    payload
        // `Future::from_err` acts like `?` in that it coerces the error type from
        // the future into the final error type
        .from_err()
        // `fold` will asynchronously read each chunk of the request body and
        // call supplied closure, then it resolves to result of closure
        .fold(BytesMut::new(), move |mut body, chunk| {
            // limit max size of in-memory payload
            if (body.len() + chunk.len()) > MAX_SIZE {
                Err(error::ErrorBadRequest("overflow of max body length"))
            } else {
                body.extend_from_slice(&chunk);
                Ok(body)
            }
        })
        // `Future::and_then` can be used to merge an asynchronous workflow with a
        // synchronous workflow
        .and_then(|body| {
            // body is loaded, now we can deserialize serde-json
            let obj = serde_json::from_slice::<MyObj>(&body)?;
            Ok(HttpResponse::Ok().json(obj))
        })
}

/// This handler manually load request payload and parse json-rust
fn index_mjsonrust(pl: web::Payload) -> impl Future<Item = HttpResponse, Error = Error> {
    pl.concat2().from_err().and_then(|body| {
        // body is loaded, now we can deserialize json-rust
        let result = json::parse(std::str::from_utf8(&body).unwrap()); // return Result
        let injson: JsonValue = match result {
            Ok(v) => v,
            Err(e) => json::object! {"err" => e.to_string() },
        };
        Ok(HttpResponse::Ok()
            .content_type("application/json")
            .body(injson.dump()))
    })
}

fn main() -> std::io::Result<()> {
    std::env::set_var("RUST_LOG", "actix_web=info");
    env_logger::init();

    println!("localhost:8081/manual");

    HttpServer::new(|| {
        App::new()
            .wrap(middleware::Logger::default())
            .data(web::JsonConfig::default().limit(4096)) // <- limit size of the payload (global configuration)
            .service(web::resource("/extractor").route(web::post().to(index_handler)))
            .service( web::resource("/extractor2").data(web::JsonConfig::default().limit(1024)).route(web::post().to_async(extract_item)))
            .service(web::resource("/manual").route(web::post().to_async(index_manual)))
            .service( web::resource("/mjsonrust").route(web::post().to_async(index_mjsonrust)))
            .service(web::resource("/").route(web::post().to(index_handler)))
    })
    .bind("127.0.0.1:8081")?
    .run()
}
