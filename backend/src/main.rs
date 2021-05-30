#![feature(proc_macro_hygiene, decl_macro)]

#[macro_use]
extern crate rocket;
extern crate serde;

use rocket_contrib::json::Json;

fn main() {
    rocket::ignite().mount("/", routes![exercises]).launch();
}

#[get("/exercises/<query>")]
fn exercises(query: String) -> Json<Vec<String>> {
    Json(exercises_search(query))
}

fn exercises_search(query: String) -> Vec<String> {
    let query = without_spaces(&query).to_lowercase();
    let all = vec!["Bench Press", "Archer Chin-ups", "Squat"];

    all.into_iter()
        .filter(|s| without_spaces(s).to_lowercase().starts_with(&query))
        .map(|s| s.to_string())
        .collect()
}

fn without_spaces(s: &str) -> String {
    s.chars().filter(|c| *c != ' ' && *c != '-').collect()
}
