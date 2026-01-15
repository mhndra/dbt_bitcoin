WITH whales AS (
    SELECT
        outputs_address,
        SUM(outputs_value) AS total_sent,
        COUNT(*) AS tx_count
    FROM {{ ref('stg_btc_transactions') }}
    WHERE outputs_value > 10
    GROUP BY outputs_address
    ORDER BY total_sent DESC
)

SELECT 
    '{{ invocation_id }}' AS invocation_id,
    w.outputs_address,
    w.total_sent,
    w.tx_count
FROM whales w
ORDER BY total_sent DESC