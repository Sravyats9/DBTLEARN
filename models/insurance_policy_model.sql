-- models/insurance_policy_model.sql

{{ 
    config(
    materialized='table',  
    schema='dbt_sravyats94',  
    alias='insurance_policy_model',
    post_hook=["
            USE ROLE ACCOUNTADMIN",
            "CREATE OR REPLACE FILE FORMAT FILE_FORMAT_CSV
             type = csv
             field_delimiter = '|'
             skip_header = 1
             empty_field_as_null = TRUE",
             "CREATE OR REPLACE STAGE MYS3_OUTPUT
              URL = 's3://sravyapractice1/output/'
              STORAGE_INTEGRATION = s3_int
              FILE_FORMAT = FILE_FORMAT_CSV",
              "COPY INTO @MYS3_OUTPUT/insurance_policy FROM
               (SELECT * FROM ANALYTICS.DBT_SRAVYATS94_DBT_SRAVYATS94.insurance_policy_model)
               OVERWRITE= TRUE
               "]      
) 
}}
  SELECT
  Agreement_id,
  Department_Name,
  Policy_Number,
  Start_Date,
  Expiry_Date,
  Term_Condition_Description,
  Application_Id,
  Cust_Id
  FROM {{ ref('insurance_policy') }}