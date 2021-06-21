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

CREATE TABLE training_programs_days (
	id SERIAL,
	training_program_id INTEGER NOT NULL REFERENCES training_programs (id),
	name TEXT NOT NULL UNIQUE,
	PRIMARY KEY (id)
);

CREATE TABLE training_programs_days_exercises (
	id SERIAL,
	training_program_day_id INTEGER NOT NULL REFERENCES training_programs_days (id),
	-- Could be 'A', or maybe 'Push', or even 'Back day'.
	exercise_id INTEGER NOT NULL REFERENCES exercises (id),
	sets INTEGER,
	reps INTEGER,
	-- If 0, MAX
	seconds INTEGER,
	-- If 0, MAX
	notes TEXT,
	PRIMARY KEY (id)
);