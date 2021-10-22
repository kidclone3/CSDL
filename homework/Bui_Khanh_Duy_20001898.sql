# 11.
select mov_title, mov_year, dir_fname, dir_lname, act_fname, act_lname, role
from movie, actor, director, movie_direction, movie_cast
where 
mov_time = (select min(mov_time) from movie) and
movie.mov_id = movie_direction.mov_id and
director.dir_id = movie_direction.dir_id and
actor.act_id = movie_cast.act_id and
movie.mov_id = movie_cast.mov_id

# 12.
select distinct mov_year
from movie, rating
where movie.mov_id = rating.mov_id and
rev_stars between 3.0 and 4.0
order by mov_year desc

# 13.
select rev_name, mov_title, rev_stars
from movie, rating, reviewer
where movie.mov_id = rating.mov_id and
rating.rev_id = reviewer.rev_id and
rev_name is not null and
rev_stars is not null
order by rev_name, mov_title, rev_stars

# 14.
select mov_title, max(rev_stars) as max
from movie, rating
where movie.mov_id = rating.mov_id and
rev_stars >= 1
group by mov_title
order by mov_title

# 15.
select mov_title, dir_fname, dir_lname, rev_stars
from movie, rating, movie_direction, director
where rev_stars is not null and
movie.mov_id = movie_direction.mov_id and
director.dir_id = movie_direction.dir_id and
rating.mov_id = movie.mov_id

# 16.
select mov_title, act_fname, act_lname, role
from movie, movie_cast, actor
where movie.mov_id = movie_cast.mov_id and
actor.act_id = movie_cast.act_id and
actor.act_id in 
(select act_id
from movie_cast
group by act_id
having count(*) >= 2
)

# 17.
select dir_fname, dir_lname, mov_title, act_fname, act_lname, role
from movie, movie_cast, actor, director, movie_direction
where 
movie.mov_id = movie_cast.mov_id and
actor.act_id = movie_cast.act_id and
director.dir_id = movie_direction.dir_id and
movie.mov_id = movie_direction.mov_id
and act_fname = 'Claire' and act_lname = 'Danes'

# 18. #Đánh giá: khó vcl. Nhưng rất thú vị.
select act_fname, act_lname, mov_title, role
from actor, movie, movie_cast
where movie_cast.act_id = actor.act_id and movie.mov_id = movie_cast.mov_id and 
(movie_cast.act_id, movie_cast.mov_id) in (
select act_id, movie_cast.mov_id
from movie_cast, movie_direction 
where movie_cast.mov_id = movie_direction.mov_id
and dir_id in (
select dir_id from director, actor
where dir_fname = act_fname and dir_lname = act_lname
)
and act_id in (
select act_id from director, actor
where dir_fname = act_fname and dir_lname = act_lname
)
)

# 19. Sau khi làm c18 thì  câu này dễ.
select act_fname, act_lname from actor, movie_cast
where movie_cast.act_id = actor.act_id and movie_cast.mov_id in (
select mov_id from movie where mov_title = 'Chinatown'
)

# 20. Tương tự câu 19.
select mov_title from movie, movie_cast 
where movie.mov_id = movie_cast.mov_id 
and act_id in (
select act_id from actor where act_fname = 'Harrison' and 
act_lname = 'Ford'
)

# 21.
select mov_title, mov_year, rev_stars, mov_rel_country from movie, rating
where rev_stars = (select max(rev_stars) from rating)
and movie.mov_id = rating.mov_id
