-- models/department.sql

{{ 
    config(
    materialized='table',  
    schema='dbt_sravyats94',  
    alias='department',
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
              "COPY INTO @MYS3_OUTPUT/department FROM
               (SELECT * FROM ANALYTICS.DBT_SRAVYATS94_DBT_SRAVYATS94.department)
               OVERWRITE= TRUE
               "]    
) 
}}

SELECT
        Department_Name,
        Department_ID,
        Department_Staff, 
        Department_Offices,
        Company_Name
FROM {{ ref('department') }}  -- Reference the seed 'department'
