use crate::db::new_conn;

// TODO implement notes as request guard.
#[post("/training_program/new/<name>")]
pub fn new_training_program(name: String) {
	let mut conn = new_conn().unwrap();
	conn.execute("INSERT INTO training_programs (name) VALUES ($1)", &[&name])
		.unwrap();
}
