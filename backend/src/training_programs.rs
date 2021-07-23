use crate::db::new_conn;
use crate::helpers::ReturnedId;
use rocket_contrib::json::Json;
use serde::Serialize;

// TODO implement notes as request guard.
#[post("/training_program/new/<name>")]
pub fn new_training_program(name: String) -> Json<ReturnedId> {
    let mut conn = new_conn().unwrap();

    Json(ReturnedId {
        id: conn
            .query(
                // TODO support notes.
                "INSERT INTO training_programs (name) VALUES ($1) RETURNING id",
                &[&name],
            )
            .unwrap()
            .get(0)
            .unwrap()
            .get(0),
    })
}

// TODO implement notes as request guard.
#[post("/training_program/<id>/days/new/<name>")]
pub fn new_training_program_day(id: i32, name: String) -> Json<ReturnedId> {
    let mut conn = new_conn().unwrap();

    Json(ReturnedId {
        id: conn
            .query(
                // TODO support notes.
                 "INSERT INTO training_programs_days (training_program_id, name) VALUES ($1, $2) RETURNING id",
                  &[&id, &name],
            )
            .unwrap()
            .get(0)
            .unwrap()
            .get(0),
    })
}

#[post("/training_program_days/<day_id>/add_exercise/<exercise_id>")]
pub fn add_exercise_to_training_program(day_id: i32, exercise_id: i32) -> Json<ReturnedId> {
    let mut conn = new_conn().unwrap();

    Json(ReturnedId {
        id: conn
            .query(
                // TODO support notes.
                         "INSERT INTO training_programs_days_exercises (training_program_day_id, exercise_id, sets, reps) VALUES ($1, $2, 3, 8) RETURNING id",

                 &[&day_id, &exercise_id],
            )
            .unwrap()
            .get(0)
            .unwrap()
            .get(0),
    })
}

#[get("/training_program_days/<day_id>")]
pub fn get_training_program_day(day_id: i32) -> Json<TrainingProgramDay> {
    let mut conn = new_conn().unwrap();
    let notes: Option<String> = conn
        .query(
            "SELECT notes FROM training_programs_days WHERE id = $1",
            &[&day_id],
        )
        .unwrap()
        .get(0)
        .unwrap()
        .get(0);

    let exercises = conn
        .query(
            "SELECT
	id,
	training_program_day_id,
	exercise_id,
	sets,
	reps,
	seconds,
	notes
FROM
	training_programs_days_exercises
WHERE
	training_program_day_id = $1",
            &[&day_id],
        )
        .unwrap()
        .into_iter()
        .map(|row| TrainingProgramDayExercise {
            id: row.get(0),
            exercise_id: row.get(2),
            sets: row.get(3),
            reps: row.get(4),
            seconds: row.get(5),
            notes: row.get(6),
        })
        .collect();

    Json(TrainingProgramDay { exercises, notes })
}

#[derive(Serialize)]
pub struct TrainingProgramDay {
    exercises: Vec<TrainingProgramDayExercise>,
    notes: Option<String>,
}

#[derive(Serialize)]
pub struct TrainingProgramDayExercise {
    id: i32,
    exercise_id: i32,
    sets: i32,
    reps: Option<i32>,
    seconds: Option<i32>,
    notes: Option<String>,
}
