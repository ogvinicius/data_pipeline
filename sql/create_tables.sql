BEGIN;

CREATE TABLE IF NOT EXISTS public.raw_trips
(
    region VARCHAR(50) NOT NULL,
    origin_coord VARCHAR(100) NOT NULL,
    destination_coord VARCHAR(100) NOT NULL,
    datetime timestamp without time zone NOT NULL,
    datasource VARCHAR(50) NOT NULL
);

COMMENT ON TABLE public.raw_trips
    IS 'Table to receive the raw trip''s data, so one might further analyses it ahead.';

CREATE TABLE IF NOT EXISTS public.trips
(
    region character(50) NOT NULL,
    origin_coord point NOT NULL,
    destination_coord point NOT NULL,
    trip_date date NOT NULL,
    trip_datetime timestamp NOT NULL,
	datasource character(50) NOT NULL
);

COMMENT ON TABLE public.trips
    IS 'Table to receive cleaner trip''s data, so one might further analyses it ahead.';

-- Creating the date table to be used as a calendar dimension
CREATE MATERIALIZED VIEW public.dim_date as
SELECT
    date(date_values) as date,
	extract(day from date_values) as day,
	extract(month from date_values) as month,
	extract(year from date_values) as year,
	extract(week from date_values) as week,
	to_char(date_values, 'day') AS day_name
		
FROM
    generate_series('2001-01-01'::date, current_date::date, '1 day') date_values;

CREATE UNIQUE INDEX idx_dim_date_date ON dim_date(date);
CREATE INDEX idx_dim_date_week ON dim_date(week);


END;
