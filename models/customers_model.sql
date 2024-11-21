{{ 
    config(
        materialized='incremental',   
        schema='dbt_sravyats94', 
        alias='customers_model',
        merge_exclude_columns = ['created_dtm']

) 
    
}}

   
    SELECT 
        Cust_Id,
        Cust_FName,
        Cust_LName,
        Cust_DOB,
        Cust_Gender,
        Cust_Address,
        Cust_MOB_Number,
        Cust_Email,
        Cust_Passport_Number,
        Cust_Marital_Status,
        CASE 
            WHEN {{ is_incremental() }} THEN NULL -- Ensure `created_dtm` remains unchanged on updates
            ELSE getdate() -- Set `created_dtm` only for new records
        END AS created_dtm,
        getdate() AS updated_dtm -- Using CURRENT_TIMESTAMP() for both full and incremental loads
    FROM {{ ref('customers') }}

    {% if is_incremental() %}

    -- In incremental mode, only include new or updated records
    
       WHERE Cust_Id NOT IN (SELECT Cust_Id FROM {{ this }})

    {% endif %}

    



       
  