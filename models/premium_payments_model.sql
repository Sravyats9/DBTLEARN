-- models/premium_payments.sql

{{ 
    config(
    materialized='table',  
    schema='dbt_sravyats94',  
    alias='premium_payments',
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
              "COPY INTO @MYS3_OUTPUT/premium_payments FROM
               (SELECT * FROM ANALYTICS.DBT_SRAVYATS94_DBT_SRAVYATS94.premium_payments)
               OVERWRITE= TRUE
               "]      
) 
}}
   SELECT
    Premium_Payment_Id,
    Policy_Number,
    Premium_Payment_Amount, 
    Premium_Payment_Schedule,
    Receipt_Id,
    Cust_Id
    FROM {{ ref('premium_payments') }}