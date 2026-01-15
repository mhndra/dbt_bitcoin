{{ config(materialized = 'incremental', incremental_strategy = 'merge', unique_key = 'hash_key') }}

SELECT '{{ invocation_id }}' AS invocation_id, *
FROM {{ source('btc', 'btc_table') }}

{% if is_incremental() %}

WHERE block_timestamp >= (SELECT MAX(block_timestamp) FROM {{ this }} )

{% endif %}