CREATE DATABASE guilds;

use guilds;
CREATE TABLE bosslist(
	Num INT NOT NULL,
	Name VARCHAR(25) NOT NULL PRIMARY KEY,
	Raid VARCHAR(25) NOT NULL
);

use guilds;
CREATE TABLE progression(
	Raid VARCHAR(25) NOT NULL PRIMARY KEY,
	Difficulty VARCHAR(10) NOT NULL,
	Bosses INT NOT NULL,
	Killed INT NOT NULL
);

use guilds;
CREATE TABLE bosses (
	Raid VARCHAR(25) NOT NULL,
	BossNum INT NOT NULL,
	Heroic INT,
	Mythic INT
);

USE guilds;
INSERT INTO bosslist
VALUES ('1', 'Taloc', 'Uldir'),
		('2','MOTHER', 'Uldir'),
		('3', 'Zekvoz', 'Uldir'),
		('4', 'Vectis', 'Uldir'),
		('1', 'Champion of the Light', 'Battle of Dazaralor'),
		('2', 'Grong', 'Battle of Dazaralor'),
		('3', 'Jadfire Masters', 'Battle of Dazaralor'),
		('4', 'Opulence', 'Battle of Dazaralor'),
		('1', 'Restless Cabal', 'Cruicible of Storms'),
		('2', 'Uunat', 'Cruicible of Storms');

USE guilds;
INSERT INTO bosses
VALUES ('Uldir', '1', '2', '2'),
		('Uldir', '2', '2', '2'),
		('Uldir', '3', '2', '2'),
		('Uldir', '4', '2', '1'),
		('Battle of Dazaralor', '1', '2', '1'),
		('Battle of Dazaralor', '2', '2', '1'),
		('Battle of Dazaralor', '3', '2', '1'),
		('Battle of Dazaralor', '4', '2', '1'),
		('Cruicible of Storms', '1', '1', '1'),
		('Cruicible of Storms', '2', '1', '1');

USE guilds;
INSERT INTO progression
VALUES ('Uldir', 'Mythic', '8', '3'),
		('Battle of Dazaralor', 'Heroic', '9', '4'),
		('Cruicible of Storms', 'Heroic', '2', '0');


USE guilds;
SELECT b.Raid, b.BossNum, bl.Name, b.Heroic, b.Mythic
FROM bosses b
JOIN bosslist bl
ON b.BossNum = bl.Num AND
	b.Raid = bl.Raid
ORDER BY Raid, BossNum;

USE guilds;
SELECT Raid, Name
FROM bosslist
WHERE Num IN (
	SELECT Num
	FROM bosses
	GROUP BY Heroic
	HAVING Heroic > 1
)
ORDER BY Raid DESC;

USE guilds;
ALTER TABLE bosses
ADD Normal INT NOT NULL DEFAULT 1;

USE guilds;
UPDATE bosses
SET Normal = '2';

USE guilds;
UPDATE bosses
SET Mythic = '2'
WHERE BossNum = 1 AND
	Raid = 'Battle of Dazaralor';

USE guilds;
ALTER TABLE progression
ADD lastKill date;

USE guilds;
UPDATE progression
SET lastKill = 'April 17, 2019'
WHERE raid = 'Battle of Dazaralor';

USE guilds;
UPDATE progression
SET lastKill = 'April 18, 2019',
Killed = 1
WHERE raid = 'Cruicible of Storms';

USE guilds;
UPDATE progression
SET lastKill = 'December 6, 2018'
WHERE raid = 'Uldir';

USE guilds;
SELECT *
FROM progression;

CREATE VIEW guild_progression AS
SELECT bosses.Raid, bosslist.Name, bosses.BossNum,
	bosses.Heroic, bosses.Mythic, bosses.Normal
FROM bosses
LEFT JOIN bosslist
ON bosses.BossNum = bosslist.Num;

USE guilds;
SELECT raid, difficulty, bosses, killed, lastKill, DATEDIFF(DAY, LastKill, '2019-8-14') AS daysSince
FROM progression;

USE guilds;
SELECT COUNT(Heroic) AS HeroicBosses, COUNT(Mythic) AS MythicBosses,
		COUNT(Normal) AS NormalBosses
FROM bosses
WHERE Raid = 'Uldir';

