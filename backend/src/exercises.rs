use crate::db::new_conn;
use postgres_types::{FromSql, ToSql};

#[derive(Debug, ToSql, FromSql)]
#[postgres(name = "exercise_type")]
pub enum ExerciseType {
    #[postgres(name = "reps")]
    Reps,
    #[postgres(name = "isometric")]
    Isometric,
}

// TODO use a request guard for the exercise type.
#[post("/exercise/add/<name>/<exercise_type>")]
pub fn add_exercise(name: String, exercise_type: String) {
    let exercise_type = match exercise_type.as_str() {
        "reps" => ExerciseType::Reps,
        "isometric" => ExerciseType::Isometric,
        _ => panic!(),
    };
    let mut conn = new_conn().unwrap();
    conn.execute(
        "INSERT INTO exercises (name, type) VALUES ($1, $2)",
        &[&name, &exercise_type],
    )
    .unwrap();
}
