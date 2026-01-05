WITH top_ten AS (
    SELECT *
    FROM {{ ref('whale_alert') }}
    LIMIT 10
)

SELECT *
FROM top_ten