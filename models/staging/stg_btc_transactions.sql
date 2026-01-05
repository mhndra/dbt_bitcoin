{{ config(materialized = 'ephemeral') }}

SELECT *
FROM {{ ref('stg_btc_outputs_col') }}
WHERE is_coinbase = false