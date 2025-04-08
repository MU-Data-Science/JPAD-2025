from pandasql import sqldf
import pandas as pd

# load csv files

DEID_DEMOGRAPHIC = pd.read_csv(r'C:\Users\Administrator\Documents\Data_April_2024\DEID_DEMOGRAPHIC.csv')

#Merge the DataFrames on PATID

merged_df = pd.merge(DEID_DIAGNOSIS, DEID_DEMOGRAPHIC, on='PATID', how='left')
merged_df = pd.merge(merged_df, DEID_VITAL, on='PATID', how='left')
merged_df = pd.merge(merged_df, DEID_ENCOUNTER, on='PATID', how='left')
merged_df = pd.merge(merged_df, DEID_PRESCRIBING, on='PATID', how='left')
merged_df = pd.merge(merged_df, DEID_OBS_CLIN_Smoking, on='PATID', how='left')
merged_df = pd.merge(merged_df, AGE, on='PATID', how='left')


#Save merged_df to a new csv file
merged_df.to_csv('ADdata.csv', index=False)
