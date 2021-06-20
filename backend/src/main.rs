#![feature(proc_macro_hygiene, decl_macro)]

#[macro_use]
extern crate rocket;

use fuzzy_matcher::skim::SkimMatcherV2;
use fuzzy_matcher::FuzzyMatcher;
use rocket_contrib::json::Json;
use serde::Serialize;

mod db;
mod exercises;

fn main() {
    rocket::ignite()
        .mount(
            "/",
            routes![exercises, all_exercises, exercises::add_exercise],
        )
        .launch();
}

#[get("/exercises")]
fn all_exercises() -> Json<Vec<ExerciseSearchFuzzyMatch>> {
    Json(exercises_search("".to_string()))
}

#[get("/exercises/<query>")]
fn exercises(query: String) -> Json<Vec<ExerciseSearchFuzzyMatch>> {
    Json(exercises_search(query))
}

// Get all exercises that match fuzzily with the query, sort them by similarity to the query.
fn exercises_search(query: String) -> Vec<ExerciseSearchFuzzyMatch> {
    let query = query.to_lowercase();
    let matcher = SkimMatcherV2::default();
    let exercises = vec![
        "Bench Press",
        "Archer Chin-up",
        "Squat",
        "Dumbbell Curl",
        "Overhead Press",
        "Hip Thrust",
        "Trap Bar Deadlift",
        "Pendlay Row",
        "Ring Archer Pushups",
    ];

    let mut v: Vec<_> = exercises
        .into_iter()
        .map(|exercise| (exercise, matcher.fuzzy_indices(exercise, &query)))
        .filter(|(_exercise, match_results)| match_results.is_some())
        .map(|(exercise, match_results)| (exercise, match_results.unwrap()))
        .collect();
    v.sort_by(|(_, rating1), (_, rating2)| rating1.cmp(rating2));
    v.reverse();
    v.into_iter()
        .map(
            |(exercise, (_match_rating, match_indices))| ExerciseSearchFuzzyMatch {
                exercise: exercise.to_string(),
                indices: match_indices,
            },
        )
        .take(20)
        .collect()
}

#[derive(Serialize)]
struct ExerciseSearchFuzzyMatch {
    exercise: String,
    indices: Vec<usize>,
}
