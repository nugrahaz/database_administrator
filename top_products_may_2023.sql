SELECT p.product_name, COUNT(*) AS total_shipped
FROM deliveries AS d
INNER JOIN Products AS p ON d.product_id = p.product_id
WHERE EXTRACT(MONTH FROM d.delivered_time) = 5 AND EXTRACT(YEAR FROM d.delivered_time) = 2023
GROUP BY p.product_name
ORDER BY total_shipped DESC
LIMIT 10;