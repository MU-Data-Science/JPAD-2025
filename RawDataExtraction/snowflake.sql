
-------------all with birth date-----------------
select distinct t1.patid, t1.birth_date
from "DEID_DEMOGRAPHIC" t1
join "DEID_DIAGNOSIS" t3 on t1.patid = t3.patid
JOIN "DEID_ENCOUNTER" t5 ON t1.patid = t5.patid
where TIMESTAMPDIFF(YEAR, t1.birth_date, '2010-01-01') > 40
 -- AND t3.DX not in ('G30.0', 'G30.1', 'G30.8', 'G30.9', '331.0', '290.0', '290.1', '290.2', '290.3', '290.4',
 -- '290.43', '294.1', '294.20', '294.21', '331.82', 'F01', 'F02', 'F03', 'F00', 'F00.2', 'G31.83')
AND t3.admit_date <= '2023-12-31'
AND t5.patid IN (
    SELECT PATID
    FROM "DEID_ENCOUNTER"
    GROUP BY PATID
    HAVING COUNT(PATID) >= 2 
)

-------------all with age-----------------
select distinct t1.patid, TIMESTAMPDIFF(YEAR, t1.birth_date, '2010-01-01') as AGE --Change time as needed for age
from "DEID_DEMOGRAPHIC" t1
join "DEID_DIAGNOSIS" t3 on t1.patid = t3.patid
JOIN "DEID_ENCOUNTER" t5 ON t1.patid = t5.patid
where TIMESTAMPDIFF(YEAR, t1.birth_date, '2010-01-01') > 40
 -- AND t3.DX not in ('G30.0', 'G30.1', 'G30.8', 'G30.9', '331.0', '290.0', '290.1', '290.2', '290.3', '290.4',
 -- '290.43', '294.1', '294.20', '294.21', '331.82', 'F01', 'F02', 'F03', 'F00', 'F00.2', 'G31.83')
AND t3.admit_date <= '2018-12-31'
AND t5.patid IN (
    SELECT PATID
    FROM "DEID_ENCOUNTER"
    GROUP BY PATID
    HAVING COUNT(PATID) >= 2 
)

--------------case 5 years----------------
select distinct t1.patid
from "DEID_DEMOGRAPHIC" t1
join "DEID_DIAGNOSIS" t3 on t1.patid = t3.patid 
join "DEID_PRESCRIBING" t9 on t1.patid = t9.patid
where (t3.DX in ('G30.0', 'G30.1', 'G30.8', '331.0', '290.0', '290.1', '290.2', '290.3', '290.4',
 '290.43', '294.1', '331.82', 'F01', 'F02', 'F00', 'F00.2', 'G31.83')
OR t1.patid in (
select distinct patid 
from "DEID_PRESCRIBING" 
where (LOWER(raw_rx_med_name) like '%donepezil%'
or LOWER(raw_rx_med_name) like '%galantamine%'
or LOWER(raw_rx_med_name) like '%rivastigmine%'
or LOWER(raw_rx_med_name) like '%memantine%'
or LOWER(raw_rx_med_name) like '%brexpiprazole%'
or LOWER(raw_rx_med_name) like '%aducanumab%')
)
)
AND t3.admit_date >= '2019-01-01' 
And t3.admit_date <= '2023-12-31'
----
AND t1.patid in(select distinct t1.patid
from "DEID_DEMOGRAPHIC" t1
join "DEID_DIAGNOSIS" t3 on t1.patid = t3.patid
JOIN "DEID_ENCOUNTER" t5 ON t1.patid = t5.patid
where TIMESTAMPDIFF(YEAR, t1.birth_date, '2010-01-01') > 40
AND t3.DX not in ('G30.0', 'G30.1', 'G30.8', '331.0', '290.0', '290.1', '290.2', '290.3', '290.4',
 '290.43', '294.1', '331.82', 'F01', 'F02', 'F00', 'F00.2', 'G31.83')
AND t3.admit_date >= '2010-01-01'
AND t3.admit_date <= '2018-12-31'
AND t5.patid IN (
    SELECT PATID
    FROM "DEID_ENCOUNTER"
    GROUP BY PATID
    HAVING COUNT(PATID) >= 2 
)
)

--------------control 5 years-----------------------
select distinct t1.patid
from "DEID_DEMOGRAPHIC" t1
join "DEID_DIAGNOSIS" t3 on t1.patid = t3.patid
JOIN "DEID_ENCOUNTER" t5 ON t1.patid = t5.patid
---
where t1.patid in (select distinct t1.patid
from "DEID_DEMOGRAPHIC" t1
join "DEID_DIAGNOSIS" t3 on t1.patid = t3.patid
JOIN "DEID_ENCOUNTER" t5 ON t1.patid = t5.patid
where TIMESTAMPDIFF(YEAR, t1.birth_date, '2010-01-01') > 40
AND t3.DX not in ('G30.0', 'G30.1', 'G30.8', '331.0', '290.0', '290.1', '290.2', '290.3', '290.4',
'290.43', '294.1', '331.82', 'F01', 'F02', 'F00', 'F00.2', 'G31.83')
AND t3.admit_date <= '2018-12-31'
AND t3.admit_date >= '2010-01-01'
AND t5.patid IN (
    SELECT PATID
    FROM "DEID_ENCOUNTER"
    GROUP BY PATID
    HAVING COUNT(PATID) >= 2 
))
---
AND t1.patid not in (select distinct t1.patid
from "DEID_DEMOGRAPHIC" t1
join "DEID_DIAGNOSIS" t3 on t1.patid = t3.patid 
JOIN "DEID_ENCOUNTER" t5 ON t1.patid = t5.patid
where (t3.DX in ('G30.0', 'G30.1', 'G30.8', '331.0', '290.0', '290.1', '290.2', '290.3', '290.4',
'290.43', '294.1', '331.82', 'F01', 'F02', 'F00', 'F00.2', 'G31.83')
OR t1.patid in (
select distinct patid 
from "DEID_PRESCRIBING" 
where (LOWER(raw_rx_med_name) like '%donepezil%'
or LOWER(raw_rx_med_name) like '%galantamine%'
or LOWER(raw_rx_med_name) like '%rivastigmine%'
or LOWER(raw_rx_med_name) like '%memantine%'
or LOWER(raw_rx_med_name) like '%brexpiprazole%'
or LOWER(raw_rx_med_name) like '%aducanumab%')
)
)
AND t3.admit_date >= '2019-01-01'
And t3.admit_date <= '2023-12-31'
AND t5.patid IN (
    SELECT PATID
    FROM "DEID_ENCOUNTER"
    GROUP BY PATID
    HAVING COUNT(PATID) >= 1 
))


-----diagnosis--------------------------
select t3.patid, t3.raw_diagnosis_name,  t3.DX, t3.admit_date
from "DEID_DIAGNOSIS" t3 
"DEID_DEMOGRAPHIC" t1 on t3.patid = t1.patid
where 
 (LOWER(t3.raw_diagnosis_name) like '%diabetic%'
OR LOWER(t3.raw_diagnosis_name) like '%epilepsy%'
OR LOWER(t3.raw_diagnosis_name) like '%depression%'
OR LOWER(t3.raw_diagnosis_name) like '%obesity%'
OR LOWER(t3.raw_diagnosis_name) like '%stroke%'
OR LOWER(t3.raw_diagnosis_name) like '%anxiety%'
OR LOWER(t3.raw_diagnosis_name) like '%hypertension%'
OR LOWER(t3.raw_diagnosis_name) like '%hyperlipidemia%'
OR LOWER(t3.raw_diagnosis_name) like '%cardiovascular disease%'
OR LOWER(t3.raw_diagnosis_name) like '%sleep disorder%'
OR LOWER(t3.raw_diagnosis_name) like '%headache%'
OR LOWER(t3.raw_diagnosis_name) like '%periodontitis%'
OR LOWER(t3.raw_diagnosis_name) like '%concussion%'
OR LOWER(t3.raw_diagnosis_name) like '%heart disease%'
OR LOWER(t3.raw_diagnosis_name) like '%sleep apnea%'
OR LOWER(t3.raw_diagnosis_name) like '%insomnia%'
OR LOWER(t3.raw_diagnosis_name) like '%senile dementia%'
OR LOWER(t3.raw_diagnosis_name) like '%kidney disease%'
OR LOWER(t3.raw_diagnosis_name) like '%high cholesterol%'
OR LOWER(t3.raw_diagnosis_name) like '%vitamin d deficiency%'
OR LOWER(t3.raw_diagnosis_name) like '%enlarge prostate%'
OR LOWER(t3.raw_diagnosis_name) like '%osteoporsis%'
OR LOWER(t3.raw_diagnosis_name) like '%bone disease%'
OR LOWER(t3.raw_diagnosis_name) like '%depressive disorder%')
AND t3.admit_date < '2019-01-01'

------------Med----------------------------
select distinct patid, rx_start_date, raw_rx_med_name from "DEID_PRESCRIBING" 
where (LOWER(raw_rx_med_name) like '%donepezil%'
or LOWER(raw_rx_med_name) like '%galantamine%'
or LOWER(raw_rx_med_name) like '%rivastigmine%'
or LOWER(raw_rx_med_name) like '%memantine%'
or LOWER(raw_rx_med_name) like '%brexpiprazole%'
or LOWER(raw_rx_med_name) like '%aducanumab%')
and patid in (select distinct PATID from "DEID_DIAGNOSIS" where DX in ('G30.0', 'G30.1', 'G30.8', '331.0', 'G30.9'))

------All Patid---------
select distinct t1.patid
from "DEID_DEMOGRAPHIC" t1
join "DEID_DIAGNOSIS" t3 on t1.patid = t3.patid
JOIN "DEID_ENCOUNTER" t5 ON t1.patid = t5.patid
where TIMESTAMPDIFF(YEAR, t1.birth_date, '2010-01-01') > 40
-- AND t3.DX not in ('G30.0', 'G30.1', 'G30.8', '331.0', 'G30.9', '290.0', '290.1', '290.2', '290.3', '290.4',
-- '290.43', '294.1', '294.20', '294.21', '331.82', 'F01', 'F02', 'F03', 'F00', 'F00.2', 'G31.83')
AND t3.admit_date <= '2023-12-31'
AND t5.patid IN (
    SELECT PATID
    FROM "DEID_ENCOUNTER"
    GROUP BY PATID
    HAVING COUNT(PATID) >= 2 
)

--------All AD Patid---------
select distinct t1.patid
from "DEID_DEMOGRAPHIC" t1
join "DEID_DIAGNOSIS" t3 on t1.patid = t3.patid
JOIN "DEID_ENCOUNTER" t5 ON t1.patid = t5.patid
where t3.DX in ('G30.0', 'G30.1', 'G30.8', '331.0', 'G30.9', '290.0', '290.1', '290.2', '290.3', '290.4',
'290.43', '294.1', '294.20', '294.21', '331.82', 'F01', 'F02', 'F03', 'F00', 'F00.2', 'G31.83')
AND TIMESTAMPDIFF(YEAR, t1.birth_date, '2010-01-01') > 40
AND t3.admit_date >= '2010-01-01'
And t3.admit_date <= '2023-12-31' 
AND t5.patid IN (
    SELECT PATID
    FROM "DEID_ENCOUNTER"
    GROUP BY PATID
    HAVING COUNT(PATID) >= 2 
)

--------ALL AD Patid with AGE--------
WITH MinAdmitDate AS (
    SELECT t3.patid, MIN(admit_date) AS min_admit_date
    FROM  "DEID_DIAGNOSIS" t3
    JOIN "DEID_DEMOGRAPHIC" t1 on t3.patid = t1.patid
    JOIN "DEID_PRESCRIBING" t9 on t1.patid = t9.patid
    WHERE (t3.DX in ('G30.0', 'G30.1', 'G30.8', 'G30.9', '331.0', '290.0', '290.1', '290.2', '290.3', '290.4',
 '290.43', '294.1', '294.20', '294.21', '331.82', 'F01', 'F02', 'F03', 'F00', 'F00.2', 'G31.83')
OR t1.patid in (
select distinct patid 
from "DEID_PRESCRIBING" 
where (LOWER(raw_rx_med_name) like '%donepezil%'
or LOWER(raw_rx_med_name) like '%galantamine%'
or LOWER(raw_rx_med_name) like '%rivastigmine%'
or LOWER(raw_rx_med_name) like '%memantine%'
or LOWER(raw_rx_med_name) like '%brexpiprazole%'
or LOWER(raw_rx_med_name) like '%aducanumab%')
)
)
AND t3.admit_date >= '2019-01-01' 
And t3.admit_date <= '2023-12-31'
----
AND t1.patid in(select distinct t1.patid
from "DEID_DEMOGRAPHIC" t1
join "DEID_DIAGNOSIS" t3 on t1.patid = t3.patid
JOIN "DEID_ENCOUNTER" t5 ON t1.patid = t5.patid
where TIMESTAMPDIFF(YEAR, t1.birth_date, '2010-01-01') > 40
AND t3.DX not in ('G30.0', 'G30.1', 'G30.8', 'G30.9', '331.0', '290.0', '290.1', '290.2', '290.3', '290.4',
 '290.43', '294.1', '294.20', '294.21', '331.82', 'F01', 'F02', 'F03', 'F00', 'F00.2', 'G31.83')
AND t3.admit_date >= '2010-01-01'
AND t3.admit_date <= '2018-12-31'
AND t5.patid IN (
    SELECT PATID
    FROM "DEID_ENCOUNTER"
    GROUP BY PATID
    HAVING COUNT(PATID) >= 2 
)
)
    GROUP BY t3.patid
)
SELECT distinct t1.patid, TIMESTAMPDIFF(YEAR, t1.birth_date, m.min_admit_date) AS AGE
FROM "DEID_DEMOGRAPHIC" t1
JOIN MinAdmitDate m ON t1.patid = m.patid
JOIN "DEID_ENCOUNTER" t5 ON t1.patid = t5.patid
WHERE TIMESTAMPDIFF(YEAR, t1.birth_date, '2010-01-01') > 40
AND t5.patid IN (
        SELECT patid
        FROM "DEID_ENCOUNTER"
        GROUP BY patid
        HAVING COUNT(patid) >= 2
)

-------All non-AD Patients with AGE-------
WITH MinAdmitDate AS (
    SELECT t3.patid, MIN(admit_date) AS min_admit_date
    FROM  "DEID_DIAGNOSIS" t3
    JOIN "DEID_DEMOGRAPHIC" t1 on t3.patid = t1.patid
    JOIN "DEID_PRESCRIBING" t9 on t1.patid = t9.patid
    WHERE t3.patid in (select distinct t1.patid
from "DEID_DEMOGRAPHIC" t1
join "DEID_DIAGNOSIS" t3 on t1.patid = t3.patid
JOIN "DEID_ENCOUNTER" t5 ON t1.patid = t5.patid
where TIMESTAMPDIFF(YEAR, t1.birth_date, '2010-01-01') > 40
AND t3.DX not in ('G30.0', 'G30.1', 'G30.8', '331.0', '290.0', '290.1', '290.2', '290.3', '290.4',
'290.43', '294.1', '331.82', 'F01', 'F02', 'F00', 'F00.2', 'G31.83')
AND t3.admit_date <= '2018-12-31'
AND t3.admit_date >= '2010-01-01'
AND t5.patid IN (
    SELECT PATID
    FROM "DEID_ENCOUNTER"
    GROUP BY PATID
    HAVING COUNT(PATID) >= 2 
))
---
AND t1.patid not in (select distinct t1.patid
from "DEID_DEMOGRAPHIC" t1
join "DEID_DIAGNOSIS" t3 on t1.patid = t3.patid 
JOIN "DEID_ENCOUNTER" t5 ON t1.patid = t5.patid
where (t3.DX in ('G30.0', 'G30.1', 'G30.8', '331.0', '290.0', '290.1', '290.2', '290.3', '290.4',
'290.43', '294.1', '331.82', 'F01', 'F02', 'F00', 'F00.2', 'G31.83')
OR t1.patid in (
select distinct patid 
from "DEID_PRESCRIBING" 
where (LOWER(raw_rx_med_name) like '%donepezil%'
or LOWER(raw_rx_med_name) like '%galantamine%'
or LOWER(raw_rx_med_name) like '%rivastigmine%'
or LOWER(raw_rx_med_name) like '%memantine%'
or LOWER(raw_rx_med_name) like '%brexpiprazole%'
or LOWER(raw_rx_med_name) like '%aducanumab%')
)
)
AND t3.admit_date >= '2019-01-01'
And t3.admit_date <= '2023-12-31'
AND t5.patid IN (
    SELECT PATID
    FROM "DEID_ENCOUNTER"
    GROUP BY PATID
    HAVING COUNT(PATID) >= 1 
))
    GROUP BY t3.patid
)
SELECT distinct t1.patid, TIMESTAMPDIFF(YEAR, t1.birth_date, m.min_admit_date) AS AGE
FROM "DEID_DEMOGRAPHIC" t1
JOIN MinAdmitDate m ON t1.patid = m.patid
JOIN "DEID_ENCOUNTER" t5 ON t1.patid = t5.patid
WHERE TIMESTAMPDIFF(YEAR, t1.birth_date, '2010-01-01') > 40
AND t5.patid IN (
        SELECT patid
        FROM "DEID_ENCOUNTER"
        GROUP BY patid
        HAVING COUNT(patid) >= 2
)

--------encounter type------------
select distinct patid, raw_enc_type
from "DEID_ENCOUNTER"

--------------case 4 years----------------
select distinct t1.patid
from "DEID_DEMOGRAPHIC" t1
join "DEID_DIAGNOSIS" t3 on t1.patid = t3.patid 
join "DEID_PRESCRIBING" t9 on t1.patid = t9.patid
where (t3.DX in ('G30.0', 'G30.1', 'G30.8', 'G30.9', '331.0', '290.0', '290.1', '290.2', '290.3', '290.4',
 '290.43', '294.1', '294.20', '294.21', '331.82', 'F01', 'F02', 'F03', 'F00', 'F00.2', 'G31.83')
OR t1.patid in (
select distinct patid 
from "DEID_PRESCRIBING" 
where (LOWER(raw_rx_med_name) like '%donepezil%'
or LOWER(raw_rx_med_name) like '%galantamine%'
or LOWER(raw_rx_med_name) like '%rivastigmine%'
or LOWER(raw_rx_med_name) like '%memantine%'
or LOWER(raw_rx_med_name) like '%brexpiprazole%'
or LOWER(raw_rx_med_name) like '%aducanumab%')
)
)
AND t3.admit_date >= '2019-01-01' 
And t3.admit_date <= '2022-12-31'
----
AND t1.patid in(select distinct t1.patid
from "DEID_DEMOGRAPHIC" t1
join "DEID_DIAGNOSIS" t3 on t1.patid = t3.patid
JOIN "DEID_ENCOUNTER" t5 ON t1.patid = t5.patid
where TIMESTAMPDIFF(YEAR, t1.birth_date, '2010-01-01') > 40
AND t3.DX not in ('G30.0', 'G30.1', 'G30.8', 'G30.9', '331.0', '290.0', '290.1', '290.2', '290.3', '290.4',
 '290.43', '294.1', '294.20', '294.21', '331.82', 'F01', 'F02', 'F03', 'F00', 'F00.2', 'G31.83')
AND t3.admit_date >= '2010-01-01'
AND t3.admit_date <= '2018-12-31'
AND t5.patid IN (
    SELECT PATID
    FROM "DEID_ENCOUNTER"
    GROUP BY PATID
    HAVING COUNT(PATID) >= 2 
)
)


--------------case 3 years----------------
select distinct t1.patid
from "DEID_DEMOGRAPHIC" t1
join "DEID_DIAGNOSIS" t3 on t1.patid = t3.patid 
join "DEID_PRESCRIBING" t9 on t1.patid = t9.patid
where (t3.DX in ('G30.0', 'G30.1', 'G30.8', 'G30.9', '331.0', '290.0', '290.1', '290.2', '290.3', '290.4',
 '290.43', '294.1', '294.20', '294.21', '331.82', 'F01', 'F02', 'F03', 'F00', 'F00.2', 'G31.83')
OR t1.patid in (
select distinct patid 
from "DEID_PRESCRIBING" 
where (LOWER(raw_rx_med_name) like '%donepezil%'
or LOWER(raw_rx_med_name) like '%galantamine%'
or LOWER(raw_rx_med_name) like '%rivastigmine%'
or LOWER(raw_rx_med_name) like '%memantine%'
or LOWER(raw_rx_med_name) like '%brexpiprazole%'
or LOWER(raw_rx_med_name) like '%aducanumab%')
)
)
AND t3.admit_date >= '2019-01-01' 
And t3.admit_date <= '2021-12-31'
----
AND t1.patid in(select distinct t1.patid
from "DEID_DEMOGRAPHIC" t1
join "DEID_DIAGNOSIS" t3 on t1.patid = t3.patid
JOIN "DEID_ENCOUNTER" t5 ON t1.patid = t5.patid
where TIMESTAMPDIFF(YEAR, t1.birth_date, '2010-01-01') > 40
AND t3.DX not in ('G30.0', 'G30.1', 'G30.8', 'G30.9', '331.0', '290.0', '290.1', '290.2', '290.3', '290.4',
 '290.43', '294.1', '294.20', '294.21', '331.82', 'F01', 'F02', 'F03', 'F00', 'F00.2', 'G31.83')
AND t3.admit_date >= '2010-01-01'
AND t3.admit_date <= '2018-12-31'
AND t5.patid IN (
    SELECT PATID
    FROM "DEID_ENCOUNTER"
    GROUP BY PATID
    HAVING COUNT(PATID) >= 2 
)
)

--------------case 2 years----------------
select distinct t1.patid
from "DEID_DEMOGRAPHIC" t1
join "DEID_DIAGNOSIS" t3 on t1.patid = t3.patid 
join "DEID_PRESCRIBING" t9 on t1.patid = t9.patid
where (t3.DX in ('G30.0', 'G30.1', 'G30.8', 'G30.9', '331.0', '290.0', '290.1', '290.2', '290.3', '290.4',
 '290.43', '294.1', '294.20', '294.21', '331.82', 'F01', 'F02', 'F03', 'F00', 'F00.2', 'G31.83')
OR t1.patid in (
select distinct patid 
from "DEID_PRESCRIBING" 
where (LOWER(raw_rx_med_name) like '%donepezil%'
or LOWER(raw_rx_med_name) like '%galantamine%'
or LOWER(raw_rx_med_name) like '%rivastigmine%'
or LOWER(raw_rx_med_name) like '%memantine%'
or LOWER(raw_rx_med_name) like '%brexpiprazole%'
or LOWER(raw_rx_med_name) like '%aducanumab%')
)
)
AND t3.admit_date >= '2019-01-01' 
And t3.admit_date <= '2020-12-31'
----
AND t1.patid in(select distinct t1.patid
from "DEID_DEMOGRAPHIC" t1
join "DEID_DIAGNOSIS" t3 on t1.patid = t3.patid
JOIN "DEID_ENCOUNTER" t5 ON t1.patid = t5.patid
where TIMESTAMPDIFF(YEAR, t1.birth_date, '2010-01-01') > 40
AND t3.DX not in ('G30.0', 'G30.1', 'G30.8', 'G30.9', '331.0', '290.0', '290.1', '290.2', '290.3', '290.4',
 '290.43', '294.1', '294.20', '294.21', '331.82', 'F01', 'F02', 'F03', 'F00', 'F00.2', 'G31.83')
AND t3.admit_date >= '2010-01-01'
AND t3.admit_date <= '2018-12-31'
AND t5.patid IN (
    SELECT PATID
    FROM "DEID_ENCOUNTER"
    GROUP BY PATID
    HAVING COUNT(PATID) >= 2 
)
)

--------------case 1 year----------------
select distinct t1.patid
from "DEID_DEMOGRAPHIC" t1
join "DEID_DIAGNOSIS" t3 on t1.patid = t3.patid 
join "DEID_PRESCRIBING" t9 on t1.patid = t9.patid
where (t3.DX in ('G30.0', 'G30.1', 'G30.8', 'G30.9', '331.0', '290.0', '290.1', '290.2', '290.3', '290.4',
 '290.43', '294.1', '294.20', '294.21', '331.82', 'F01', 'F02', 'F03', 'F00', 'F00.2', 'G31.83')
OR t1.patid in (
select distinct patid 
from "DEID_PRESCRIBING" 
where (LOWER(raw_rx_med_name) like '%donepezil%'
or LOWER(raw_rx_med_name) like '%galantamine%'
or LOWER(raw_rx_med_name) like '%rivastigmine%'
or LOWER(raw_rx_med_name) like '%memantine%'
or LOWER(raw_rx_med_name) like '%brexpiprazole%'
or LOWER(raw_rx_med_name) like '%aducanumab%')
)
)
AND t3.admit_date >= '2019-01-01' 
And t3.admit_date <= '2019-12-31'
----
AND t1.patid in(select distinct t1.patid
from "DEID_DEMOGRAPHIC" t1
join "DEID_DIAGNOSIS" t3 on t1.patid = t3.patid
JOIN "DEID_ENCOUNTER" t5 ON t1.patid = t5.patid
where TIMESTAMPDIFF(YEAR, t1.birth_date, '2010-01-01') > 40
AND t3.DX not in ('G30.0', 'G30.1', 'G30.8', 'G30.9', '331.0', '290.0', '290.1', '290.2', '290.3', '290.4',
 '290.43', '294.1', '294.20', '294.21', '331.82', 'F01', 'F02', 'F03', 'F00', 'F00.2', 'G31.83')
AND t3.admit_date >= '2010-01-01'
AND t3.admit_date <= '2018-12-31'
AND t5.patid IN (
    SELECT PATID
    FROM "DEID_ENCOUNTER"
    GROUP BY PATID
    HAVING COUNT(PATID) >= 2 
)
)

--------all patient 2010-2018-----------
select distinct t1.patid
from "DEID_DEMOGRAPHIC" t1
join "DEID_DIAGNOSIS" t3 on t1.patid = t3.patid
JOIN "DEID_ENCOUNTER" t5 ON t1.patid = t5.patid
where TIMESTAMPDIFF(YEAR, t1.birth_date, '2010-01-01') > 40
AND t3.DX not in ('G30.0', 'G30.1', 'G30.8', '331.0', 'G30.9', '290.0', '290.1', '290.2', '290.3', '290.4',
'290.43', '294.1', '294.20', '294.21', '331.82', 'F01', 'F02', 'F03', 'F00', 'F00.2', 'G31.83')
AND t3.admit_date >= '2010-01-01'
AND t3.admit_date <= '2018-12-31'
AND t5.patid IN (
    SELECT PATID
    FROM "DEID_ENCOUNTER"
    GROUP BY PATID
    HAVING COUNT(PATID) >= 2 
)


---------VITAL------------------
select t7.patid, t7.diastolic, t7.systolic, t7.measure_date
from "DEID_VITAL" t7
join "DEID_DIAGNOSIS" t3 on t7.patid = t3.patid
AND t7.measure_date = t3.admit_date
where t3.DX in ('G30.0', 'G30.1', 'G30.8', '331.0', 'G30.9', '290.0', '290.1', '290.2', '290.3', '290.4',
'290.43', '294.1', '294.20', '294.21', '331.82', 'F01', 'F02', 'F03', 'F00', 'F00.2', 'G31.83')
AND (LOWER(t3.raw_diagnosis_name) like '%diabetic%'
OR LOWER(t3.raw_diagnosis_name) like '%epilepsy%'
OR LOWER(t3.raw_diagnosis_name) like '%depression%'
OR LOWER(t3.raw_diagnosis_name) like '%obesity%'
OR LOWER(t3.raw_diagnosis_name) like '%stroke%'
OR LOWER(t3.raw_diagnosis_name) like '%anxiety%'
OR LOWER(t3.raw_diagnosis_name) like '%hypertension%'
OR LOWER(t3.raw_diagnosis_name) like '%hyperlipidemia%'
OR LOWER(t3.raw_diagnosis_name) like '%cardiovascular disease%'
OR LOWER(t3.raw_diagnosis_name) like '%sleep disorder%'
OR LOWER(t3.raw_diagnosis_name) like '%headache%'
OR LOWER(t3.raw_diagnosis_name) like '%periodontitis%'
OR LOWER(t3.raw_diagnosis_name) like '%concussion%'
OR LOWER(t3.raw_diagnosis_name) like '%heart disease%'
OR LOWER(t3.raw_diagnosis_name) like '%sleep apnea%'
OR LOWER(t3.raw_diagnosis_name) like '%insomnia%'
OR LOWER(t3.raw_diagnosis_name) like '%senile dementia%'
OR LOWER(t3.raw_diagnosis_name) like '%kidney disease%'
OR LOWER(t3.raw_diagnosis_name) like '%high cholesterol%'
OR LOWER(t3.raw_diagnosis_name) like '%vitamin d deficiency%'
OR LOWER(t3.raw_diagnosis_name) like '%enlarge prostate%'
OR LOWER(t3.raw_diagnosis_name) like '%osteoporsis%'
OR LOWER(t3.raw_diagnosis_name) like '%bone disease%'
OR LOWER(t3.raw_diagnosis_name) like '%depressive disorder%')




