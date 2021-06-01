CREATE TYPE EXERCISE_TYPE AS ENUM ('reps', 'isometric');

CREATE TABLE exercises (
	id SERIAL,
	name TEXT UNIQUE,
	type EXERCISE_TYPE,
	PRIMARY KEY (id)
);