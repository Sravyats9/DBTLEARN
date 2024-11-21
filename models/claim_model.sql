 {{config(
    materialized='table',  
    schema='dbt_sravyats94',  
    alias='claim_model',
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
              "COPY INTO @MYS3_OUTPUT/claim FROM
               (SELECT * FROM ANALYTICS.DBT_SRAVYATS94_DBT_SRAVYATS94.claim_model)
               OVERWRITE= TRUE
               "]  
 )}}
     SELECT
        Claim_Id,
        Agreement_Id,
        Claim_Amount,
        Incident_Id, 
        Damage_Type,
        Date_Of_Claim,
        Claim_Status,
        Cust_Id
      FROM {{ ref('claim') }}