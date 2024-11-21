-- models/incident.sql

{{ 
    config(
    materialized='table',  
    schema='dbt_sravyats94',  
    alias='incident_model',

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

              "COPY INTO @MYS3_OUTPUT/incident FROM
               (SELECT * FROM ANALYTICS.DBT_SRAVYATS94_DBT_SRAVYATS94.incident)
               OVERWRITE= TRUE
               "]    
) 
}}

SELECT
 Incident_Id, 
 Incident_Type, 
 Incident_Date, 
 Description

FROM {{ ref('incident') }}

