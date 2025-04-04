INSERT INTO Title (Title_Id, Name, Age_Rating, Sequel_ID) VALUES
    (1, 'The Prestige', 13, NULL),
    (2, 'John Wick', 16, 3),
    (3, 'John Wick: Chapter 2', 16, 4),
	(4, 'John Wick: Chapter 3 - Parabellum', 16, NULL),
	(5, 'Made in Abyss', 16, 6),
	(6, 'Made in Abyss: Dawn of the Deep Soul', 16, 7),
	(7, 'Made in Abyss: The Golden City of the Scorching Sun', 16, NULL),
	(8, 'Breaking Bad', 18, 9),
	(9, 'Breaking Bad Season 2', 18, NULL),
	(10, 'Everything Everywhere All At Once', 14, NULL);

INSERT INTO Movie (Release_Date, Duration, Movie_type, Title_Id) VALUES
    ('2006-10-20', 130, 'Mid budget', 1),
    ('2014-10-24', 101, 'Blockbuster', 2),
    ('2017-02-10', 122, 'Blockbuster', 3),
	('2019-05-17', 130, 'Blockbuster', 4),
	('2020-01-01', 113, 'Foreign', 6),
	('2022-02-02', 139, 'Arthouse', 9);

INSERT INTO TV_show (Number_of_seasons, Title_Id) VALUES
    (5, 1),
    (7, 1),
    (8, 5);

INSERT INTO Genre (Genre_ID, Genre_name) VALUES
    (1, 'Action'),
    (2, 'Comedy'),
    (3, 'Drama'),
	(4, 'Horror'),
	(5, 'Anime');

INSERT INTO Franchise (Franchise_Name, Number_of_titles, Franchise_ID) VALUES
    ('Marvel', 30, 1),
    ('Star Wars', 3, 2),
    ('DC', 4, 3);

INSERT INTO Award (Award_Name, Given_By, Res, Title_Id) VALUES
    ('Best Picture', 'Academy', 'Win', 1),
    ('Best Actor', 'Golden Globes', 'Nomination', 2),
    ('Best Director', 'BAFTA', 'Win', 3);

INSERT INTO MovieGenre (Title_Id, Genre_ID) VALUES
    (1, 3),
    (2, 1),
	(3, 1),
	(5, 4),
	(5, 5),
	(8, 3),
	(9, 3);

INSERT INTO Part_of (Franchise_ID, Title_Id) VALUES
    (2, 3),
    (3, 3),
    (4, 3),
	(5, 2),
	(6, 2),
	(7, 2);

INSERT INTO Season (Season_Number, Number_of_episodes, Status, Title_Id) VALUES
    (1, 7, 'Completed', 8),
    (2, 13, 'Ongoing', 9),
    (1, 12, 'Completed', 5),
	(2, 12, 'Upcoming', 7);

INSERT INTO Episode (Episode_Number, Duration, Date_Aired, Season_Number, Title_Id) VALUES
    (1, 45, '2008-01-20', 1, 8),
    (2, 50, '2008-01-27', 2, 8),
    (3, 40, '2008-02-10', 3, 8);
