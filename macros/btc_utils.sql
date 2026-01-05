{% macro convert_to_usd(column_name) %}

{{ column_name }} * (
    SELECT price
    FROM {{ ref('btc_usd_max') }}
    WHERE DATE(snapped_at) = CURRENT_DATE()
)

{% endmacro %}