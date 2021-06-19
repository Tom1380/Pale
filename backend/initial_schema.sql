CREATE TYPE EXERCISE_TYPE AS ENUM ('reps', 'isometric');

CREATE TABLE exercises (
	id SERIAL,
	name TEXT UNIQUE NOT NULL,
	type EXERCISE_TYPE NOT NULL,
	notes TEXT,
	PRIMARY KEY (id)
);

CREATE TABLE training_programs (
	id SERIAL,
	name TEXT UNIQUE NOT NULL,
	notes TEXT,
	PRIMARY KEY (id)
);

CREATE TABLE training_programs_exercises (
	id SERIAL,
	training_program_id INTEGER NOT NULL REFERENCES training_programs (id),
	-- Could be 'A', or maybe 'Push', or even 'Back day'.
	day_name TEXT NOT NULL,
	exercise_id INTEGER NOT NULL REFERENCES exercises (id),
	sets INTEGER,
	reps INTEGER,
	-- If 0, MAX
	seconds INTEGER,
	-- If 0, MAX
	notes TEXT,
	PRIMARY KEY (id)
);