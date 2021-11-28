create table landmarks (
    id uuid default gen_random_uuid(),
    name text not null,
    description text,
    point double precision[],
    geopoint geography(point, 4326),
    location jsonb not null default '{}',
    primary key (id)
);

create or replace function array_to_geography() returns trigger as $$
begin
    new.geopoint = st_setsrid(st_point(new.point[1], new.point[2]), 4326)::geography;
    new.location = json_build_object('longitude', new.point[1], 'latitude', new.point[2]);
    return new;
end;
$$ language plpgsql;

create trigger trigger_array_to_geography
before insert or update on landmarks
for each row execute procedure array_to_geography();

create or replace function public.geo_landmarks(
    latitude double precision,
    longitude double precision,
    radius integer
)
returns setof public.landmarks
language sql stable as $$

    select 
        id,
        name,
        description,
        point,
        geopoint,
        case
            when point is null then '{}'::jsonb
            else json_build_object(
                'longitude',
                point[1],
                'latitude',
                point[2],
                'distance',
                st_distance(st_point(longitude, latitude)::geography, geopoint)
            )::jsonb
        end as location
    from
        landmarks
    where
        st_dwithin(geopoint, st_point(longitude, latitude)::geography, radius)
    order by
        st_distance(st_point(longitude, latitude)::geography, geopoint),
        name asc
    ;

$$;
