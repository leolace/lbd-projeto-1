BEGIN;

-- =========================================================
-- ORDEM DE CARGA RESPEITANDO FKs
-- =========================================================

-- TABELAS BÁSICAS / DOMÍNIO

\copy seasons (id, year) FROM 'csvs/seasons.csv' WITH (FORMAT csv, HEADER true);

\copy continents (id, code, name) FROM 'csvs/continents.csv' WITH (FORMAT csv, HEADER true);

\copy time_zones (id, name, gmt_offset, dst_offset, raw_offset) FROM 'csvs/time_zones.csv' WITH (FORMAT csv, HEADER true);

\copy language_names (id, name) FROM 'csvs/language_names.csv' WITH (FORMAT csv, HEADER true);

\copy feature_codes (id, feature_class, feature_code, name, description) FROM 'csvs/feature_codes.csv' WITH (FORMAT csv, HEADER true);

\copy airport_types (id, type) FROM 'csvs/airport_types.csv' WITH (FORMAT csv, HEADER true);

\copy status (id, status) FROM 'csvs/status.csv' WITH (FORMAT csv, HEADER true);

\copy countries (id, code, name, wikipedia_link, keywords, continent_id) FROM 'csvs/countries.csv' WITH (FORMAT csv, HEADER true);

\copy iso_language_codes (id, iso_639_3, iso_639_2, iso_639_1, language_id) FROM 'csvs/iso_language_codes.csv' WITH (FORMAT csv, HEADER true);

-- CIDADES / AEROPORTOS

\copy cities (id, name, ascii_name, alternate_names, latitude, longitude, feature_code_id, country_id, time_zone_id, cc2, admin1_code, admin2_code, admin3_code, admin4_code, population, elevation, dem, modification_date) FROM 'csvs/cities.csv' WITH (FORMAT csv, HEADER true);

\copy airports (id, ident, airport_type_id, name, latitude_deg, longitude_deg, elevation_ft, city_id, scheduled_service, icao_code, iata_code, gps_code, local_code, home_link, wikipedia_link, keywords) FROM 'csvs/airports.csv' WITH (FORMAT csv, HEADER true);

-- F1: ENTIDADES PRINCIPAIS

\copy circuits (id, circuit_ref, name, lat, long, city_id, wikipedia_url) FROM 'csvs/circuits.csv' WITH (FORMAT csv, HEADER true);

\copy constructors (id, constructor_ref, name, nationality, country_id, wikipedia_url) FROM 'csvs/constructors.csv' WITH (FORMAT csv, HEADER true);

\copy drivers (id, driver_ref, given_name, family_name, nationality, date_of_birth) FROM 'csvs/drivers.csv' WITH (FORMAT csv, HEADER true);

\copy races (id, race_ref, season_id, round, race_name, race_date, race_time, circuit_id) FROM 'csvs/races.csv' WITH (FORMAT csv, HEADER true);

\copy qualifying (id, race_id, driver_id, constructor_id, position, q1, q2, q3) FROM 'csvs/qualifying.csv' WITH (FORMAT csv, HEADER true);

\copy results (id, race_id, driver_id, constructor_id, grid, position, position_order, points, laps, status_id) FROM 'csvs/results.csv' WITH (FORMAT csv, HEADER true);

-- STANDINGS

\copy standings (id, season_id, round, position, points, wins) FROM 'csvs/standings.csv' WITH (FORMAT csv, HEADER true);

\copy driver_standings (standing_id, driver_id) FROM 'csvs/driver_standings.csv' WITH (FORMAT csv, HEADER true);

\copy constructor_standings (standing_id, constructor_id) FROM 'csvs/constructor_standings.csv' WITH (FORMAT csv, HEADER true);

-- RELACIONAMENTOS AUXILIARES

\copy country_languages (country_id, language_id) FROM 'csvs/country_languages.csv' WITH (FORMAT csv, HEADER true);

COMMIT;

-- =========================================================
-- AJUSTE DAS SEQUENCES DAS COLUNAS IDENTITY
-- =========================================================

SELECT setval(pg_get_serial_sequence('seasons', 'id'), COALESCE((SELECT MAX(id) FROM seasons), 1), true);
SELECT setval(pg_get_serial_sequence('continents', 'id'), COALESCE((SELECT MAX(id) FROM continents), 1), true);
SELECT setval(pg_get_serial_sequence('countries', 'id'), COALESCE((SELECT MAX(id) FROM countries), 1), true);
SELECT setval(pg_get_serial_sequence('time_zones', 'id'), COALESCE((SELECT MAX(id) FROM time_zones), 1), true);
SELECT setval(pg_get_serial_sequence('language_names', 'id'), COALESCE((SELECT MAX(id) FROM language_names), 1), true);
SELECT setval(pg_get_serial_sequence('iso_language_codes', 'id'), COALESCE((SELECT MAX(id) FROM iso_language_codes), 1), true);
SELECT setval(pg_get_serial_sequence('feature_codes', 'id'), COALESCE((SELECT MAX(id) FROM feature_codes), 1), true);
SELECT setval(pg_get_serial_sequence('airport_types', 'id'), COALESCE((SELECT MAX(id) FROM airport_types), 1), true);
SELECT setval(pg_get_serial_sequence('status', 'id'), COALESCE((SELECT MAX(id) FROM status), 1), true);
SELECT setval(pg_get_serial_sequence('airports', 'id'), COALESCE((SELECT MAX(id) FROM airports), 1), true);
SELECT setval(pg_get_serial_sequence('circuits', 'id'), COALESCE((SELECT MAX(id) FROM circuits), 1), true);
SELECT setval(pg_get_serial_sequence('constructors', 'id'), COALESCE((SELECT MAX(id) FROM constructors), 1), true);
SELECT setval(pg_get_serial_sequence('drivers', 'id'), COALESCE((SELECT MAX(id) FROM drivers), 1), true);
SELECT setval(pg_get_serial_sequence('races', 'id'), COALESCE((SELECT MAX(id) FROM races), 1), true);
SELECT setval(pg_get_serial_sequence('qualifying', 'id'), COALESCE((SELECT MAX(id) FROM qualifying), 1), true);
SELECT setval(pg_get_serial_sequence('results', 'id'), COALESCE((SELECT MAX(id) FROM results), 1), true);
SELECT setval(pg_get_serial_sequence('standings', 'id'), COALESCE((SELECT MAX(id) FROM standings), 1), true);
