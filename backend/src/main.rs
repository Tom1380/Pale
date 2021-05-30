#![feature(proc_macro_hygiene, decl_macro)]

#[macro_use]
extern crate rocket;
extern crate serde;
use fuzzy_matcher::skim::SkimMatcherV2;
use fuzzy_matcher::FuzzyMatcher;

use rocket_contrib::json::Json;

fn main() {
    rocket::ignite().mount("/", routes![exercises]).launch();
}

#[get("/exercises/<query>")]
fn exercises(query: String) -> Json<Vec<String>> {
    Json(exercises_search(query))
}

// Get all exercises that match fuzzily with the query, sort them by similarity to the query.
fn exercises_search(query: String) -> Vec<String> {
    let query = query.to_lowercase();
    let matcher = SkimMatcherV2::default();
    let all = vec!["Bench Press", "Archer Chin-ups", "Squat"];

    let mut v: Vec<_> = all
        .into_iter()
        .map(|exercise| (exercise.to_string(), matcher.fuzzy_match(exercise, &query)))
        .filter(|(_exercise, match_rating)| match_rating.is_some())
        .collect();
    v.sort_by(|(_, rating1), (_, rating2)| rating1.cmp(rating2));
    v.reverse();
    v.into_iter()
        .map(|(exercise, _match_rating)| exercise)
        .collect()
}
