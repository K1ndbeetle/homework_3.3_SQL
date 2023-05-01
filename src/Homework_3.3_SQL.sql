-- Задание №1
-- 1.1 Создайте таблицу city с колонками city_id и city_name
CREATE TABLE IF NOT EXISTS city
(
    city_id   BIGSERIAL   NOT NULL PRIMARY KEY,
    city_name VARCHAR(50) NOT NULL
);

-- 1.2 Добавьте в таблицу employee колонку city_id
ALTER TABLE employee
    ADD city_id BIGINT NULL;

-- 1.3 Назначьте эту колонку внешним ключом. Свяжите таблицу employee с таблицей city
ALTER TABLE employee
    ADD FOREIGN KEY (city_id) REFERENCES city (city_id);

-- 1.4 Заполните таблицу city и назначьте работникам соответствующие города
INSERT INTO city (city_name)
VALUES ('Rostov-on-Don'),
       ('Moscow'),
       ('Krasnodar'),
       ('Volgograd'),
       ('Saint Petersburg');

UPDATE employee SET city_id = 1 WHERE id = 1;
UPDATE employee SET city_id = 2 WHERE id = 2;
UPDATE employee SET city_id = 2 WHERE id = 4;
UPDATE employee SET city_id = 4 WHERE id = 5;
UPDATE employee SET city_id = 5 WHERE id = 6;


-- Задание №2
-- 2.1 Получите имена и фамилии сотрудников, а также города, в которых они проживают
SELECT first_name AS Имя, last_name AS Фамилия, city_name AS Город_проживания
FROM employee
         INNER JOIN city ON employee.city_id = city.city_id;

-- 2.2 Получите города, а также имена и фамилии сотрудников, которые в них проживают
-- Если в городе никто из сотрудников не живет, то вместо имени должен стоять null
SELECT city_name AS Город_проживания, first_name AS Имя, last_name AS Фамилия
FROM city
         LEFT JOIN employee on city.city_id = employee.city_id;

-- 2.3 Получите имена всех сотрудников и названия всех городов
-- Если в городе не живет никто из сотрудников, то вместо имени должен стоять null
-- Аналогично, если города для какого-то из сотрудников нет в списке, должен быть получен null
SELECT first_name AS Имя, last_name AS Фамилия, city_name AS Город_проживания
FROM employee
         FULL OUTER JOIN city c on employee.city_id = c.city_id;

-- 2.4 Получите таблицу, в которой каждому имени должен соответствовать каждый город
SELECT first_name AS Имя, last_name AS Фамилия, city_name AS Город_проживания
FROM employee
         CROSS JOIN city;

-- 2.5 Получите имена городов, в которых никто не живет
SELECT city_name AS Город_проживания
FROM city
         LEFT JOIN employee on city.city_id = employee.city_id
WHERE employee.first_name IS NULL
  AND employee.last_name  IS NULL;