/*
  P3_RSS_Agregator.sql - First Version RSS Agregator
     
   Author:  Grace, George Wong, Ed Brovick
  
  Here are a few notes on things below that may not be self evident:
  
  INDEXES: You'll see indexes below for example:
  
  INDEX SurveyID_index(SurveyID)
  
  Any field that has highly unique data that is either searched on or used as a join should be indexed, which speeds up a  
  search on a tall table, but potentially slows down an add or delete
  
  TIMESTAMP: MySQL currently only supports one date field per table to be automatically updated with the current time.  We'll use a 
  field in a few of the tables named LastUpdated:
  
  LastUpdated TIMESTAMP DEFAULT 0 ON UPDATE CURRENT_TIMESTAMP
  
  The other date oriented field we are interested in, DateAdded we'll do by hand on insert with the MySQL function NOW().
  
  CASCADES: In order to avoid orphaned records in deletion of a Survey, we'll want to get rid of the associated Q & A, etc. 
  We therefore want a 'cascading delete' in which the deletion of a Survey activates a 'cascade' of deletions in an 
  associated table.  Here's what the syntax looks like:  
  
  FOREIGN KEY (SurveyID) REFERENCES wn16_surveys(SurveyID) ON DELETE CASCADE
  
  The above is from the Questions table, which stores a foreign key, SurveyID in it.  This line of code tags the foreign key to 
  identify which associated records to delete.
  
  Be sure to check your cascades by deleting a survey and watch all the related table data disappear!
  
  
*/


SET foreign_key_checks = 0; #turn off constraints temporarily

#since constraints cause problems, drop tables first, working backward
DROP TABLE IF EXISTS wn16_P3_User;
DROP TABLE IF EXISTS wn16_P3_Categories;
DROP TABLE IF EXISTS wn16_P3_subCategories;
DROP TABLE IF EXISTS wn16_P3_Articles;
DROP TABLE IF EXISTS wn16_P3_Source;

  
#all tables must be of type InnoDB to do transactions, foreign key constraints
# The User Table is all all users and adminstators
CREATE TABLE wn16_P3_User(
    UserID INT UNSIGNED NOT NULL AUTO_INCREMENT,
    Username VARCHAR(16) Default '', 
    Role VARCHAR(32) Default '',
    Fname VARCHAR(32) Default '', 
    Lname VARCHAR(32) Default '', 
    Email VARCHAR(60) Default '',
    Datejoined DATETIME,
    LastUpdated TIMESTAMP DEFAULT 0 on Update CURRENT_TIMESTAMP,
    pwd VARCHAR (16),
    PRIMARY KEY (UserID)
    )ENGINE=INNODB;
    

#assigning first survey to AdminID == 1
#INSERT INTO wn16_surveys VALUES (NULL,1,'Our First Survey','Description of Survey',NOW(),NOW()); 

#foreign key field must match size and type, hence SurveyID is INT UNSIGNED
CREATE TABLE wn16_P3_Categories(
    CategoryID INT UNSIGNED NOT NULL AUTO_INCREMENT,
    Categoryname VARCHAR(64) Default '',
    PRIMARY KEY (CategoryID)
)ENGINE=INNODB;

#INSERT INTO wn16_questions VALUES (NULL,1,'Do You Like Our Website?','We really want to know!',NOW(),NOW());
#INSERT INTO wn16_questions VALUES (NULL,1,'Do You Like Cookies?','We like cookies!',NOW(),NOW());
#INSERT INTO wn16_questions VALUES (NULL,1,'Favorite Toppings?','We like chocolate!',NOW(),NOW());

CREATE TABLE wn16_P3_subCategories(
    subCategoryID INT UNSIGNED NOT NULL AUTO_INCREMENT,
    CategoryID INT UNSIGNED DEFAULT 0,
    subCategoryName TEXT DEFAULT '',
    PRIMARY KEY (subCategoryID),
    FOREIGN KEY (CategoryID) REFERENCES wn16_P3_Categories(CategoryID) ON DELETE CASCADE
    )ENGINE=INNODB;
    

CREATE TABLE wn16_P3_Articles(
    ArticleID INT UNSIGNED NOT NULL AUTO_INCREMENT,
    #subCategoryID REFERENCES wn16_P3_subCategories(subCategoryID),
    subCategoryID INT UNSIGNED,
    SourceID INT UNSIGNED,
    Title VARCHAR(64) Default '',
    Content VARCHAR(256) Default '',
    Description VARCHAR(512) Default '',
    Time_Stamp TIMESTAMP DEFAULT 0 on Update CURRENT_TIMESTAMP,
    PRIMARY KEY (ArticleID),
    FOREIGN KEY (subCategoryID) REFERENCES wn16_P3_subCategories(subCategoryID) ON DELETE CASCADE,
    FOREIGN KEY (SourceID) REFERENCES win16_P3_Source(SourceID) ON DELETE CASCADE
    )ENGINE=INNODB;
    
CREATE TABLE wn16_P3_Source(
    SourceID INT UNSIGNED NOT NULL AUTO_INCREMENT,
    Sitename VARCHAR(128) Default '',
    URL VARCHAR(256),
    PRIMARY KEY (SourceID)
    ) ENGINE=INNODB;
    

    
    

# Answers for question number 1
#INSERT INTO wn16_answers VALUES (NULL,1,'Yes', '',NOW(),NOW());
#INSERT INTO wn16_answers VALUES (NULL,1,'No', '',NOW(),NOW());

# Answers for question number 2
#INSERT INTO wn16_answers VALUES (NULL,2,'Yes', '',NOW(),NOW());
#INSERT INTO wn16_answers VALUES (NULL,2,'No', '',NOW(),NOW());


# Answers for question number 3
#INSERT INTO wn16_answers VALUES (NULL,3,'Whip Cream', '',NOW(),NOW());
#INSERT INTO wn16_answers VALUES (NULL,3,'Chocaolate', '',NOW(),NOW());
#INSERT INTO wn16_answers VALUES (NULL,2,'Pineapple', '',NOW(),NOW());
#INSERT INTO wn16_answers VALUES (NULL,2,'Strawberry', '',NOW(),NOW());

/*
Add additional tables here


*/
#SET foreign_key_checks = 1; #turn foreign key check back on