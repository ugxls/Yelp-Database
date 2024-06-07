--Business Questions Queries

-- 1
SELECT COUNT(user_id) AS users_joined,
EXTRACT(YEAR FROM join_date) AS year 
FROM users
WHERE join_date >= '2010-01-01 00:00:00'
GROUP BY year
ORDER BY year;

-- 2
SELECT COUNT(user_id) AS elite_user_count, elite_year
FROM userseliteyears
WHERE elite_year BETWEEN '2012' AND '2021'
GROUP BY elite_year
ORDER BY elite_year;

--3
--Information about the user with the most 5-star reviews
SELECT br.user_id, COUNT(br.user_rating) AS five_star_rating_count, 
u.user_name, u.join_date, u.number_of_fans, 
SUM(br.marked_useful_by_users) AS useful_rating, SUM(br.marked_funny_by_users) AS funny_rating, 
SUM(br.marked_cool_by_users) AS cool_rating
FROM businessreviews br
JOIN users u
ON u.user_id = br.user_id
WHERE user_rating = 5.0
GROUP BY br.user_id, br.user_rating, u.user_name, u.join_date, u.number_of_fans
ORDER BY five_star_rating_count DESC
LIMIT 1;

--Most recent 5-star reviews by Micheal
SELECT review
FROM businessreviews
WHERE user_id = 'vHc-UrI9yfL_pnnc6nJtyQ'
ORDER BY review_date DESC
LIMIT 5;

--4
SELECT b.business_id, bc.category_name,
ROUND(
    SUM(
        CASE
            WHEN bh.closing_time = '00:00' AND bh.opening_time = '00:00' THEN 24 
            WHEN bh.closing_time <= bh.opening_time THEN 24 - EXTRACT(EPOCH FROM (bh.opening_time - bh.closing_time)) / 3600
            ELSE EXTRACT(EPOCH FROM (bh.closing_time - bh.opening_time)) / 3600
        END
    ), 2
) AS total_hours_per_week
FROM 
businesses b
JOIN 
businesscategories bc 
ON b.business_id = bc.business_id
JOIN 
businesshours bh 
ON b.business_id = bh.business_id
WHERE b.business_open = 'True'
GROUP BY b.business_id, bc.category_name;

--5 
SELECT COUNT(business_id) AS businesses_count, state 
FROM businesses
GROUP BY state 
ORDER BY businesses_count DESC
LIMIT 10;

--6
SELECT COUNT(business_id) AS businesses_count, category_name
FROM businesscategories 
GROUP BY category_name
ORDER BY businesses_count DESC
LIMIT 10;

--7
SELECT COUNT(bc.business_id) AS businesses_count, bc.category_name, 
ROUND(AVG(b.average_reviews), 2) AS average_rating
FROM businesscategories bc
JOIN businesses b
ON bc.business_id = b.business_id
GROUP BY category_name
ORDER BY businesses_count DESC
LIMIT 10;

--8
--Top five funniest Restaurant reviews
SELECT br.review, br.marked_funny_by_users, bc.category_name
FROM businessreviews br
JOIN businesscategories bc
ON bc.business_id = br.business_id
WHERE bc.category_name = 'Restaurants'
ORDER BY br.marked_funny_by_users DESC
LIMIT 5;

--Five least funny Restaurant reviews
SELECT br.review, br.marked_funny_by_users, bc.category_name
FROM businessreviews br
JOIN businesscategories bc
ON bc.business_id = br.business_id
WHERE bc.category_name = 'Restaurants'
ORDER BY br.marked_funny_by_users
LIMIT 5;

--9
--Average length of tip_comment for 100 most complimented tips and 100 least complimented tips
SELECT * FROM
(SELECT ROUND(AVG(length_of_tip_comment), 2) AS avg_top_hundred
FROM 
(SELECT LENGTH(tip_comment) AS length_of_tip_comment FROM tips	 
ORDER BY tip_compliments DESC 
LIMIT 100)), 

(SELECT ROUND(AVG(length_of_tip_comment), 2) AS avg_bottom_hundred
FROM 
(SELECT LENGTH(tip_comment) AS length_of_tip_comment FROM tips
ORDER BY tip_compliments 
LIMIT 100));

--10
SELECT b.business_id, bc.category_name, b.average_reviews, b.number_of_reviews, bh.days_of_the_week, 
ROUND(
      SUM(
          CASE
              WHEN bh.closing_time = '00:00' AND bh.opening_time = '00:00' THEN 24 
              WHEN bh.closing_time <= bh.opening_time THEN 24 - (EXTRACT(EPOCH FROM (bh.opening_time - bh.closing_time)) / 3600)
              ELSE EXTRACT(EPOCH FROM (bh.closing_time - bh.opening_time)) / 3600
            END
        ), 2
    ) AS hours_open
FROM 
businesses b
JOIN 
businesscategories bc 
ON b.business_id = bc.business_id
JOIN 
businesshours bh 
ON b.business_id = bh.business_id
WHERE bc.category_name = 'Restaurants' AND b.business_open = 'True'
GROUP BY b.business_id, bc.category_name, b.average_reviews, b.number_of_reviews, bh.days_of_the_week;

--11
SELECT city, COUNT(business_id) AS businesses_count
FROM businesses
GROUP BY city
ORDER BY businesses_count DESC
LIMIT 10;

--12
SELECT category_name, ROUND(AVG(average_reviews),2) AS avg_rating
FROM businesscategories bc
JOIN businesses b
ON bc.business_id = b.business_id
GROUP BY category_name
ORDER BY avg_rating DESC
LIMIT 1;

--13
SELECT average_reviews, COUNT(business_id) AS businesses_count
FROM businesses
GROUP BY average_reviews
ORDER BY average_reviews;

--14
SELECT category_name, ROUND(AVG(b.number_of_reviews), 2) AS avg_reviews
FROM businesscategories bc
JOIN businesses b
ON bc.business_id = b.business_id
GROUP BY category_name
ORDER BY avg_reviews DESC;

--15
SELECT 
    EXTRACT(YEAR FROM review_date) AS review_year,
    COUNT(review_id) AS reviews_count
FROM businessreviews
GROUP BY review_year
ORDER BY review_year;

--16
SELECT b.business_id, b.business_name, ROUND(AVG(br.user_rating), 2) AS avg_user_rating
FROM businesses b
JOIN businessreviews br
ON b.business_id = br.business_id
GROUP BY b.business_id, b.business_name
ORDER BY avg_user_rating DESC
LIMIT 10;