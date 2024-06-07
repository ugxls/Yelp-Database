CREATE DATABASE yelp;

CREATE TABLE businesses (
	business_id CHAR(22) PRIMARY KEY,
	business_name TEXT, 
	street_address TEXT,
	city TEXT,
	state VARCHAR(3),
	postal_code VARCHAR(9),
	latitude NUMERIC,
	longitude NUMERIC, 
	average_reviews NUMERIC(2,1),
	number_of_reviews INT,
	business_open BOOLEAN
);

CREATE TABLE businessattributes (
	business_id CHAR(22),
	attribute_name TEXT,
	attribute_value TEXT,
	PRIMARY KEY (business_id, attribute_name),
	CONSTRAINT fk_business_id_attributes FOREIGN KEY (business_id) REFERENCES businesses (business_id)
);

CREATE TABLE businesshours (
	business_id CHAR(22),
	days_of_the_week VARCHAR(10),
	opening_time TIME,
	closing_time TIME,
	PRIMARY KEY (business_id, days_of_the_week),
	CONSTRAINT fk_business_id_hours FOREIGN KEY (business_id) REFERENCES businesses (business_id)
);

CREATE TABLE users (
	user_id CHAR(22) PRIMARY KEY,
	user_name TEXT, 
	number_of_reviews_by_user INT,
	join_date TIMESTAMP,
	useful_votes_sent_by_user INT,
	funny_votes_sent_by_user INT,
	cool_votes_sent_by_user INT,
	number_of_fans INT,
	average_user_reviews_rating NUMERIC(3,2),
	hot_compliments INT, 
	more_compliments INT,
	profile_compliments INT,
	cute_compliments INT,
	list_compliments INT,
	note_compliments INT,
	plain_compliments INT,
	cool_compliments INT,
	funny_compliments INT,
	writer_compliments INT,
	photo_compliments INT		
);

CREATE TABLE businessreviews (
	review_id CHAR(22) PRIMARY KEY,
	user_id CHAR(22), 
	business_id CHAR(22),
	user_rating NUMERIC(2,1),
	marked_useful_by_users SMALLINT,
	marked_funny_by_users SMALLINT,
	marked_cool_by_users SMALLINT,
	review TEXT, 
	review_date TIMESTAMP	,
CONSTRAINT fk_user_id_reviews FOREIGN KEY (user_id) REFERENCES 
users (user_id)
CONSTRAINT fk_business_id_reviews FOREIGN KEY (business_id) REFERENCES businesses (business_id)
);

CREATE TABLE tips (
	user_id CHAR(22),
	business_id CHAR(22),
	tip_comment TEXT,
	tip_date TIMESTAMP,
	tip_compliments SMALLINT,
	PRIMARY KEY (user_id, tip_comment),
	CONSTRAINT fk_user_id_tips FOREIGN KEY (user_id) REFERENCES users (user_id),
	CONSTRAINT fk_business_id_tips FOREIGN KEY (business_id) REFERENCES businesses (business_id)
);

CREATE TABLE businesscategories (
	business_id CHAR(22),
	category_name TEXT,
	PRIMARY KEY (business_id, category_name),
	CONSTRAINT fk_business_id_categories FOREIGN KEY (business_id) REFERENCES businesses (business_id)
);

CREATE TABLE userseliteyears (
	user_id CHAR(22),
	elite_year SMALLINT,
	PRIMARY KEY (user_id, elite_year),
	CONSTRAINT fk_user_id_years FOREIGN KEY (user_id) REFERENCES users (user_id)
);

CREATE TABLE userfriends (
	user_id CHAR(22),
	friend_id CHAR(22),
	PRIMARY KEY (user_id, friend_id),
	CONSTRAINT fk_user_id_friends FOREIGN KEY (user_id) REFERENCES users (user_id)
);