from pandasql import sqldf
import pandas as pd

# load csv files

DEID_DIAGNOSIS = pd.read_csv(r'C:\Users\Administrator\Documents\Data_April_2024\DEID_DIAGNOSIS.csv')

sql_query = """

select distinct patid,
                group_concat(raw_diagnosis_name, ',') as Diagnosis,
                group_concat(DX, ',') as DX
from DEID_DIAGNOSIS
group by PATID

"""
result = pysqldf(sql_query)
result.to_csv('new_DEID_DIAGNOSIS.csv, index=False)
