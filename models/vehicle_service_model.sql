-- models/vehicle_service_model.sql

{{ 
    config(
    materialized='table',  
    schema='dbt_sravyats94',  
    alias='vehicle_service_model',
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
              "COPY INTO @MYS3_OUTPUT/vehicle_service FROM
               (SELECT * FROM ANALYTICS.DBT_SRAVYATS94_DBT_SRAVYATS94.VEHICLE_SERVICE_MODEL)
               OVERWRITE= TRUE
               "]    
) 
}}

SELECT
        Department_Name,
        Vehicle_Service_Company_Name,
        Vehicle_Service_Address,
        Vehicle_Service_Contact,
        Vehicle_Service_Incharge,
        Vehicle_Service_Type,
        Department_Id,
        Company_Name
FROM {{ ref('vehicle_service') }}  -- Reference the seed 'vehicle_service'