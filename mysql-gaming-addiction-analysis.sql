CREATE DATABASE gaming_addiction;
USE gaming_addiction;

#Consultas básicas
#1. Mostrar todos los jugadores
select * from gaming_players;

#2. Mostrar nombre del usuario, país y plataforma
select user_id,
       country,
       platform
from gaming_players;

#3.Mostrar los jugadores mayores de 25 años
select *
from gaming_players
where age > 25;

#4. Mostrar los jugadores que juegan en PC
select *
from gaming_players
where platform = "PC";

#5. Mostrar los jugadores ordenados por horas de juego diarias
select user_id,
       daily_playtime_hours
from gaming_players
order by daily_playtime_hours desc;

#6. ¿Cuantos jugadores por país?
select country,
	   count(*) as total_jugadores
from gaming_players
group by country;

#7. Promedio de horas jugadas por género
select gender,
       round((avg(daily_playtime_hours)),2) as promedio_horas
from gaming_players
group by gender;

#8. Mostrar los jugadores con mayor puntaje de adicción
select user_id,
       addiction_score
from gaming_players
order by addiction_score desc
limit 10;

#9.¿Cuánto gasta cada plataforma en promedio?
select platform,
	   round((avg(monthly_spending_usd)),2) as gasto_promedio
from gaming_players
group by platform;

#10. Cantidad de jugadores por severidad de adicción
select addiction_severity,
       count(*) as total
from gaming_players
group by addiction_severity;

#11. Mostrar los jugadores cuyo puntaje de adicción es superior al promedio
select user_id,
       addiction_score
from gaming_players
where addiction_score >
(
     select avg(addiction_score)
     from gaming_players
);

#12. Mostrar el país con mayor promedio de horas de juego
select country,
       round((avg(daily_playtime_hours)),2) as promedio
from gaming_players
group by country
order by promedio desc 
limit 1;

#13. Ranking de los jugadores que mas gastan
select user_id,
       monthly_spending_usd,
       rank() over(order by monthly_spending_usd desc) as ranking
from gaming_players
limit 10;

#14. Mostrar los jugadores cuyo gasto mensual es mayor al promedio de su plataforma
select user_id,
       platform,
       monthly_spending_usd
from gaming_players p
where monthly_spending_usd >
(
	select avg(monthly_spending_usd)
	from gaming_players
	where platform = p.platform
); 

# Obtener el promedio de adicción por país y mostrar solo aquellos
#países cuyo promedio superior a 10
select country,
       round((avg(addiction_score)),2) as promedio_adiccion
from gaming_players
group by country
having avg(addiction_score) > 35;

#16. Mostrar la cantidad de jugadores por plataforma, ordenando de mayor a menor

select platform,
count(*) as cantidad_jugadores
from gaming_players
group by platform
order by cantidad_jugadores desc;

#17. Mostrar los jugadores que gastab mas de 100 USD al mes y juegan mas de 6 horas diarias
select user_id,
monthly_spending_usd,
daily_playtime_hours
from gaming_players
where monthly_spending_usd > 100
and daily_playtime_hours > 6;

#18.Mostrar el promedio del puntaje de adicción por país, 
#considerando solo los países con mas de 30 jugadores
select country,
count(*) as total_jugadores,
avg(addiction_score) as promedio_adiccion
from gaming_players
group by country
having count(*) > 30
order by promedio_adiccion desc;

#19. Mostrar los jugadores cuyo gasto mensual sea superior el gasto promedio de todos los jugadores
select user_id,
monthly_spending_usd
from gaming_players
where monthly_spending_usd >
(
      select avg(monthly_spending_usd)
      from gaming_players 
);

#20. Mostrar la edad promedio, el promedio de horas jugadas y el gasto promedio
#mensual para cada nivel de severidad de adicción

select
addiction_severity,
round(avg(age),2) as edad_promedio,
round(avg(daily_playtime_hours),2) as promedio_horas,
round(avg(monthly_spending_usd),2) as gasto_promedio
from gaming_players
group by addiction_severity
order by promedio_horas desc;


