{{ config(materialized = 'incremental', incremental_strategy = 'append') }}

WITH flattened_outputs AS (

    SELECT
        sb.hash_key,
        sb.block_number,
        sb.block_timestamp,
        sb.is_coinbase,
        o.value:address::STRING AS outputs_address,
        o.value:value::FLOAT AS outputs_value
    FROM {{ ref('stg_btc') }} sb,
    LATERAL FLATTEN(INPUT => outputs) o
    WHERE outputs_address IS NOT NULL

    {% if is_incremental() %}

    AND sb.block_timestamp >= (SELECT MAX(block_timestamp) FROM {{ this }} )

    {% endif %}

)

SELECT
    hash_key,
    block_number,
    block_timestamp,
    is_coinbase,
    outputs_address,
    outputs_value
FROM flattened_outputs