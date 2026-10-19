
USE SalesDB;

-- Demonstrate rounding a number to different decimal places
SELECT
    3.516           AS original_number,
    ROUND(3.516, 2) AS round_2,
    ROUND(3.516, 1) AS round_1,
    ROUND(3.516, 0) AS round_0
    --absolute value--
    SELECT
    -10      AS original_number,
    ABS(-10) AS absolute_value_negative,
    ABS(10)  AS absolute_value_positive;

--CEILING AND FLOOR--
SELECT CEILING(3.2) AS c_pos, FLOOR(3.2) AS f_pos,
       CEILING(-3.2) AS c_neg, FLOOR(-3.2) AS f_neg;

       --INTERGER DIVISION--
       SELECT 7 / 2 AS int_div, 7 / 2.0 AS dec_div, 7 % 2 AS remainder;