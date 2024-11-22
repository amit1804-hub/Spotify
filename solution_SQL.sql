-- SQL

**create table spotify**
(
Artist	varchar(350),
Track	varchar(350),
Album	varchar(350),
Album_type	varchar(50),
Danceability	float,
Energy	float,
Loudness	float,
Speechiness float,
Acousticness	float,
Instrumentalness	float,
Liveness	float,
Valence	float,
Tempo	float,
Duration_min	float,
Title	VARCHAR(255),
Channel	VARCHAR(255),
Views	FLOAT,
Likes	int,
Comments	int,
Licensed	BOOLEAN,
official_video	BOOLEAN,
Stream	bigint,
EnergyLiveness	float,
most_playedon VARCHAR(50)

);


```
select * from spotify;

-- EDA

select count(distinct channel) from spotify; 

select count(distinct album) from spotify; 

select distinct album_type from spotify; 

select min(duration_min)   from spotify
group by 2; 

delete from spotify
where duration_min = 0.51;
```

-- -------------------------------
-- Data Analysis Easy Level -- 
-- -------------------------------


-- Q.1 Retrieve the names of all tracks that have more than 1 billion streams.
```
select * from spotify
where stream > 1000000000;
 ``` 
-- Q.2 List all albums along with their respective artists.
```
select  album,artist,count(*)
from spotify
group by 1,2
order by 3 desc ;
 ```
-- Q.3 Get the total number of comments for tracks where licensed = TRUE.
```

select track,
	sum(comments) as total_comments 
from spotify
	where licensed = 'true'
group by 1;
```  
 --Q.4 Find all tracks that belong to the album type single.
```
select * from spotify
where album_type  ilike 'single';
```
-- Q.5 Count the total number of tracks by each artist.
``` 
select artist,count(*) as total_track
from spotify
group by 1
order by 2 desc ;
```

-- -------------------------------
-- Medium Level question
-- -------------------------------

-- Q.6 Calculate the average danceability of tracks in each album.

select album ,avg(danceability) as avg_danceability
from spotify
group by 1
order by 2 desc
 

--Q.7 Find the top 5 tracks with the highest energy values.

SELECT track ,
max(energy) as total_no_energy 
FROM  spotify 
group by 1
order by 1 desc
limit 5 ;
 
-- Q .8 List all tracks along with their views and likes where official_video = TRUE.

select track,
		sum(views) as total_views ,
		sum(likes) as total_likes,
		official_video
from spotify
where official_video ='true'
group by 1 ,4
order by 1 desc
limit 5;
 
-- Q.9 For each album, calculate the total views of all associated tracks.

select album,
	   track,
	   sum(views) as total_views
from spotify
group by 1,2
order by 3 desc

-- Q.10 Retrieve the track names that have been streamed on Spotify more than YouTube.


select * from 
(select 
	track ,
	coalesce (sum(case when most_playedon = 'Youtube' then stream end),0) as stream_on_youtube,
    coalesce(sum(case when most_playedon = 'Spotify' then stream end),0) as stream_on_spotify
from spotify
group by 1
) as t1
where
		stream_on_spotify > stream_on_youtube
      and 
        stream_on_youtube <> 0 ;

-- -------------------------------
-- Advanced Level
-- -------------------------------

-- Q .11 Find the top 3 most-viewed tracks for each artist using window functions.


with t1
as (
	select 
	artist,
	track,
	sum(views) as total_views,
	dense_rank() over(partition by artist order by sum(views) desc ) as rank
	from spotify 
	group by 1,2
)
select * from t1
where rank <= 3 ; 
 
-- Q .12 Write a query to find tracks where the liveness score is above the average.

 select 
	track ,
	liveness
from spotify
where liveness > ( select avg(liveness) from spotify) ;

-- Q .13 Use a WITH clause to calculate the difference between the highest and lowest energy values for tracks in each album


with t1 as
(
select 
 album,
max(energy) highest_energy,
min(energy) lowest_energy
from spotify
group by 1
) 
select album,
highest_energy - lowest_energy  as energy
from  t1 
 order by energy  desc


 







select * from spotify 








