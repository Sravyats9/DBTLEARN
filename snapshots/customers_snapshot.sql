{% snapshot customers_snapshot %}

    {{
        config(
            target_schema='dbt_sravyats94',  
            unique_key='Cust_Id',            
            strategy='timestamp',            
            updated_at='updated_dtm'         
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
        CURRENT_TIMESTAMP() AS created_at,
        CURRENT_TIMESTAMP() AS updated_dtm
    FROM {{ ref('customers') }}

{% endsnapshot %}
