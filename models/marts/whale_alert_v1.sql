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
    w.outputs_address,
    w.total_sent,
    w.tx_count,
    {{ convert_to_usd('w.total_sent') }} AS total_sent_usd
FROM whales w
ORDER BY total_sent DESC