-- models/vehicle.sql

{{ 
    config(
    materialized='table',  
    schema='dbt_sravyats94',  
    alias='vehicle_model',
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
              "COPY INTO @MYS3_OUTPUT/vehicle FROM
               (SELECT * FROM ANALYTICS.DBT_SRAVYATS94_DBT_SRAVYATS94.VEHICLE_MODEL)
               OVERWRITE= TRUE
               "]      
) 
}}

SELECT
         Vehicle_Id,Policy_Id,
         Dependent_NOK_Id ,
         Vehicle_Registration_Number,
         Vehicle_Value,Vehicle_Type,
         Vehicle_Size,
         Vehicle_Number_Of_Seat,
         Vehicle_Manufacturer,
         Vehicle_Engine_Number,
         Vehicle_Chasis_Number,
         Vehicle_Number,
         Vehicle_Model_Number,
         Cust_Id 
FROM {{ ref('vehicle') }}  -- Reference the seed 'vehicle_service'