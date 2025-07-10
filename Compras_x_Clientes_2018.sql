				WITH table123 AS (
				    SELECT
				        ocd.customer_unique_id,
				        COUNT(ocd.customer_id) AS compras,
				        ood.order_status,
				        ood.order_purchase_timestamp
				    FROM
				        olist_customers_dataset ocd
				    LEFT JOIN
				        olist_orders_dataset ood ON ood.customer_id = ocd.customer_id
				    WHERE
				        order_status != 'canceled' AND order_status != 'unavailable' AND order_purchase_timestamp LIKE '2018%'
				    GROUP BY
				        customer_unique_id)
				SELECT
				    compras,
				    COUNT(customer_unique_id)
				FROM	
				    table123
				GROUP BY
				    compras