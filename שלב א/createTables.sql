CREATE TABLE Award
(
  Award_Name VARCHAR(50) NOT NULL,
  Given_By VARCHAR(50) NOT NULL,
  Result VARCHAR(50) NOT NULL,
  Title_ID INT NOT NULL,
  PRIMARY KEY (Award_Name,Given_By,Title_ID ),
  FOREIGN KEY (Title_ID) REFERENCES Title(Title_ID)
);

CREATE TABLE Belongs_to
(
  Title_ID INT NOT NULL,
  Franchise_ID INT NOT NULL,
  PRIMARY KEY (Franchise_ID, Title_ID),
  FOREIGN KEY (Franchise_ID) REFERENCES Franchise(Franchise_ID),
  FOREIGN KEY (Title_ID) REFERENCES Title(Title_ID)
);

CREATE TABLE Episode
(
  Season_Number INT NOT NULL,
  Episode_Number INT NOT NULL,
  Duration INT NOT NULL,
  Date_Aired DATE NOT NULL,
  Title_ID INT NOT NULL,
  PRIMARY KEY (Episode_Number, Season_Number, Title_ID),
  FOREIGN KEY (Season_Number, Title_ID) REFERENCES Season(Season_Number, Title_ID)
);

CREATE TABLE Franchise
(
  Franchise_ID INT NOT NULL,
  Franchise_Name VARCHAR(50) NOT NULL,
  Number_of_titles INT NOT NULL,
  PRIMARY KEY (Franchise_ID)
);

CREATE TABLE Genre
(
  Genre_ID INT NOT NULL,
  Genre_Name VARCHAR(50) NOT NULL,
  PRIMARY KEY (Genre_ID)
);

CREATE TABLE Movie
(
  Release_Date DATE NOT NULL,
  Duration INT NOT NULL,
  Movie_Type VARCHAR(50) NOT NULL,
  Title_ID INT NOT NULL,
  PRIMARY KEY (Title_ID),
  FOREIGN KEY (Title_ID) REFERENCES Title(Title_ID)
);

CREATE TABLE MovieGenre
(
  Title_ID INT NOT NULL,
  Genre_ID INT NOT NULL,
  PRIMARY KEY (Title_ID, Genre_ID),
  FOREIGN KEY (Title_ID) REFERENCES Title(Title_ID),
  FOREIGN KEY (Genre_ID) REFERENCES Genre(Genre_ID)
);
CREATE TABLE Season
(
  Title_ID INT NOT NULL,
  Season_Number INT NOT NULL,
  Number_of_episodes INT NOT NULL,
  current_Status VARCHAR(10) NOT NULL,
  PRIMARY KEY (Season_Number, Title_ID),
  FOREIGN KEY (Title_ID) REFERENCES TV_show(Title_ID)
);

CREATE TABLE Title
(
  Title_ID INT NOT NULL,
  Title_Name VARCHAR(200) NOT NULL,
  Age_Rating INT NOT NULL,
  Sequel_ID INT,
  PRIMARY KEY (Title_ID)
);

CREATE TABLE Tv_show
(
  number_of_seasons INT NOT NULL,
  Title_ID INT NOT NULL,
  FOREIGN KEY (Title_ID) REFERENCES Title (Title_ID)
  PRIMARY KEY (Title_ID)
);

