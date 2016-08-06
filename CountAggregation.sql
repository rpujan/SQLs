declare @t table
(
[Action] varchar(100),
LengthInMinutes int
)
insert @t
values('ADD',	 37),
('ADD',	 37),
('ADD',	 25),
('Delete',	 1),
('COPY',	 1),
('COPY',	 3),
('COPY',	 1),
('CUT',	 2),
('ADD',	 24),
('ADD',	 37),
('ADD',	 62),
('ADD',	 50)

-- 1st method --

select action,
count(case when LengthInMinutes  between 0 and 30 then 1 end) [0-30 min],
count(case when LengthInMinutes  between 30 and 60 then 1 end) [30-60 min],
count(case when LengthInMinutes  >60  then 1 end) [60+ min]
from @t group by action



-- 2nd method --
SELECT *
FROM
(
SELECT [Action],
CASE 
WHEN LengthInMinutes BETWEEN 0 AND 30 THEN '0 - 30min'
WHEN LengthInMinutes BETWEEN 31 AND 60 THEN '30 - 60min'
WHEN LengthInMinutes > 60 THEN '60+ min'
END AS Category
FROM @t
)t
PIVOT(COUNT(Category) FOR Category IN ([0 - 30min],[30 - 60min],[60+ min]))p