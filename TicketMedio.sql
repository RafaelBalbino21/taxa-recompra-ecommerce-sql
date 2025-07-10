	WITH table_pagos AS (
	    SELECT
	        ocd.customer_unique_id,
	        ooid.order_id,
	        price AS valor_gasto_semfrete,
	        order_purchase_timestamp
	    FROM olist_order_items_dataset ooid
	    LEFT JOIN olist_orders_dataset ood ON ood.order_id = ooid.order_id
	    LEFT JOIN olist_customers_dataset ocd ON ocd.customer_id = ood.customer_id
	    WHERE order_status != 'canceled' AND order_status != 'unavailable'
	)
	
	SELECT
	    SUM(valor_gasto_semfrete) / COUNT(DISTINCT order_id) AS ticket_medio
	FROM table_pagos