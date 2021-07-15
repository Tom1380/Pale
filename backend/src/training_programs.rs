use crate::db::new_conn;

// TODO implement notes as request guard.
#[post("/training_program/new/<name>")]
pub fn new_training_program(name: String) {
    let mut conn = new_conn().unwrap();
    conn.execute("INSERT INTO training_programs (name) VALUES ($1)", &[&name])
        .unwrap();
}

// TODO implement notes as request guard.
#[post("/training_program/<id>/days/new/<name>")]
pub fn new_training_program_day(id: i32, name: String) {
    let mut conn = new_conn().unwrap();
    conn.execute(
        "INSERT INTO training_programs_days (training_program_id, name) VALUES ($1, $2)",
        &[&id, &name],
    )
    .unwrap();
}

#[post("/training_program_days/<day_id>/add_exercise/<exercise_id>")]
pub fn add_exercise_to_training_program(day_id: i32, exercise_id: i32) {
    let mut conn = new_conn().unwrap();
    conn.execute(
        // TODO get sets, reps, time from headers.
        "INSERT INTO training_programs_days_exercises (training_program_day_id, exercise_id, sets, reps) VALUES ($1, $2, 3, 8)",
        &[&day_id, &exercise_id]).unwrap();
}
