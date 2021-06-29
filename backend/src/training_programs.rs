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
pub fn new_training_program_day(id: u32, name: String) {
    let mut conn = new_conn().unwrap();
    conn.execute(
        "INSERT INTO training_programs_days (training_program_id, name) VALUES ($1, $2)",
        &[&id, &name],
    )
    .unwrap();
}
