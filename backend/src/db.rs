use postgres::{Client, NoTls};

pub fn new_conn() -> Result<Client, postgres::Error> {
	Client::connect(
		"host=localhost user=postgres password='postgres' dbname=pale",
		NoTls,
	)
}
