-- models/insurance_company.sql

{{ 
    config(
    materialized='table',  
    schema='dbt_sravyats94',  
    alias='insurance_company',
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
              "COPY INTO @MYS3_OUTPUT/insurance_company FROM
               (SELECT * FROM ANALYTICS.DBT_SRAVYATS94_DBT_SRAVYATS94.insurance_company)
               OVERWRITE= TRUE
               "]    
) 
}}

SELECT
    Company_Name,
    Company_Address, 
    Company_Contact_Number, 
    Company_Fax,
    Company_Email, 
    Company_Website,
    Company_Location,
    Company_Department_Name, 
    Company_Office_Name,
FROM {{ ref('insurance_company') }}  -- Reference the seed 'insurance_company'
