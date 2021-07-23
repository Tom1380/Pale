use crate::db::new_conn;
use crate::helpers::ReturnedId;
use postgres_types::{FromSql, ToSql};
use rocket_contrib::json::Json;
use serde::Serialize;

#[derive(Serialize)]
pub struct Exercise {
    id: i32,
    name: String,
    exercise_type: ExerciseType,
    notes: String,
}

#[derive(Debug, ToSql, FromSql, Serialize)]
#[postgres(name = "exercise_type")]
pub enum ExerciseType {
    #[postgres(name = "reps")]
    Reps,
    #[postgres(name = "isometric")]
    Isometric,
}

// TODO use a request guard for the exercise type.
#[post("/exercise/add/<name>/<exercise_type>")]
pub fn add_exercise(name: String, exercise_type: String) -> Json<ReturnedId> {
    let exercise_type = match exercise_type.as_str() {
        "reps" => ExerciseType::Reps,
        "isometric" => ExerciseType::Isometric,
        _ => panic!(),
    };
    let mut conn = new_conn().unwrap();
    Json(ReturnedId {
        id: conn
            .query(
                // TODO support notes.
                "INSERT INTO exercises (name, type) VALUES ($1, $2) RETURNING id",
                &[&name, &exercise_type],
            )
            .unwrap()
            .get(0)
            .unwrap()
            .get(0),
    })
}
