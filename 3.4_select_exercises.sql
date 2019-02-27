USE albums_db;

DESCRIBE albums;

SELECT name FROM albums WHERE artist = 'Pink Floyd';
-- The Dark Side of the Moon, The Wall

SELECT release_date FROM albums 
WHERE name = "Sgt. Pepper's Lonely Hearts Club Band";
-- 1967

SELECT genre FROM albums WHERE name = 'Nevermind';
-- grunge, alternative rock

SELECT name,release_date FROM albums WHERE release_date BETWEEN 1990 AND 1999;
-- The bodyguard, jagged little pill, come on over, falling into you, let's talk about love
-- dangerous, the immaculate collection, titanic, metallica, nevermind, supernatural

SELECT name, sales FROM albums WHERE sales < 20.0;
-- 13 album names

SELECT name FROM albums WHERE genre LIKE '%rock%';
-- have to use like to get all genres with the word rock in it
