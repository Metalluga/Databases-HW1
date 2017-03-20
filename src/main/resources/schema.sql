DROP TABLE IF EXISTS votes;
DROP TABLE IF EXISTS posts;
DROP TABLE IF EXISTS threads;
DROP TABLE IF EXISTS forums;
DROP TABLE IF EXISTS users;

CREATE EXTENSION IF NOT EXISTS CITEXT;

CREATE TABLE IF NOT EXISTS users(
  about TEXT,
  email CITEXT NOT NULL UNIQUE,
  fullname TEXT,
  nickname CITEXT UNIQUE PRIMARY KEY
);

CREATE TABLE IF NOT EXISTS forums(
  slug CITEXT PRIMARY KEY NOT NULL,
  title TEXT NOT NULL,
  user_ CITEXT NOT NULL UNIQUE REFERENCES users(nickname)
);

CREATE TABLE IF NOT EXISTS threads(
  author CITEXT NOT NULL REFERENCES users(nickname),
  created TIMESTAMP,
  forum CITEXT NOT NULL REFERENCES forums(slug),
  id SERIAL PRIMARY KEY,
  message TEXT,
  slug CITEXT UNIQUE,
  title TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS votes(
  id SERIAL PRIMARY KEY,
  nickname CITEXT NOT NULL REFERENCES users(nickname),
  voice INT,
  thread INT NOT NULL REFERENCES threads(id),
  UNIQUE (thread, nickname)
);

CREATE TABLE IF NOT EXISTS posts(
  author CITEXT NOT NULL REFERENCES users(nickname),
  created TIMESTAMP,
  forum CITEXT NOT NULL REFERENCES forums(slug),
  id SERIAL PRIMARY KEY,
  isEdited BOOLEAN DEFAULT FALSE,
  message TEXT NOT NULL ,
  parent INTEGER DEFAULT 0,
  thread INTEGER REFERENCES threads(id)
);

