INSERT INTO `addon_account` (name, label, shared) VALUES
  ('society_salims','Salims Pizzeria',1)
;

INSERT INTO `jobs` (name, label, whitelisted) VALUES
  ('salims','Salims Pizzeria', 1)
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
  ('salims',0,'recruit','Provanställd',10,'{}','{}'),
  ('salims',1,'worker','Arbetare',25,'{}','{}'),
  ('salims',2,'chef','Chef',40,'{}','{}'),
  ('salims',3,'boss','VD',0,'{}','{}')
;

INSERT INTO `addon_account_data` (`account_name`, `money`, `owner`) VALUES
('society_salims', 1000, NULL);