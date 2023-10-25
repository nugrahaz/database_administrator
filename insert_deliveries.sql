INSERT INTO app.deliveries
(delivery_id, product_id, store_id, operator_id, vehicle_id, qty, sending_time, delivered_time, received_by)
VALUES(nextval('app.deliveries_delivery_id_seq'::regclass), 53, 4, 2, 3, 6, '2023-05-02 9:00:00', '2023-05-02 14:00:00', 'Jamal');