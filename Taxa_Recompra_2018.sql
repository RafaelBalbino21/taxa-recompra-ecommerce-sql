WITH comprasporcliente AS (
SELECT
ocd.customer_unique_id,
COUNT(ocd.customer_id) AS compras,
ood.order_status,
ood.order_purchase_timestamp
FROM olist_customers_dataset ocd
LEFT JOIN olist_orders_dataset ood ON ood.customer_id = ocd.customer_id
WHERE order_status != 'canceled' AND order_status != 'unavailable' AND order_purchase_timestamp LIKE '2018%'
GROUP BY customer_unique_id)

SELECT
COUNT(customer_unique_id) AS clientes_totais,
SUM(CASE WHEN compras > 1 THEN 1 ELSE 0 END) AS clientes_with_recompras,
(SUM(CASE WHEN compras > 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(customer_unique_id)) AS taxa_de_recompra
FROM comprasporcliente