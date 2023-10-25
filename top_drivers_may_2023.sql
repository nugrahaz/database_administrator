SELECT sv.shipping_driver, COUNT(*) AS total_deliveries
FROM deliveries AS d
INNER JOIN shipping_vehicles AS sv ON d.vehicle_id = sv.vehicle_id
WHERE EXTRACT(MONTH FROM d.delivered_time) = 5 AND EXTRACT(YEAR FROM d.delivered_time) = 2023
GROUP BY sv.shipping_driver
ORDER BY total_deliveries DESC
LIMIT 2;