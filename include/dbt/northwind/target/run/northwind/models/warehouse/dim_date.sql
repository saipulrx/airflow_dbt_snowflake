
  create or replace   view dbt_dev.public.dim_date
  
   as (
    with date_range as (
    select
        dateadd(day, seq4(), '2014-01-01') as d
    from
        table(generator(rowcount => 13149)) -- Number of days from 2014-01-01 to 2050-01-01
)
select
    to_char(d, 'YYYY-MM-DD') as id,
    d                       as full_date,
    year(d)                 as year,
    week(d)                 as year_week,
    dayofyear(d)            as year_day,
    year(d)                 as fiscal_year,
    quarter(d)              as fiscal_qtr,
    month(d)                as month,
    to_char(d, 'Month')     as month_name,
    dayofweek(d)            as week_day,
    to_char(d, 'Day')       as day_name,
    case
        when dayofweek(d) in (1, 7) then 0
        else 1
    end                     as day_is_weekday
from
    date_range
  );

