PGDMP  
    4            	    {            postgres    16.0    16.0 7               0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false                       0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false                       0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false                       1262    5    postgres    DATABASE        CREATE DATABASE postgres WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_Indonesia.1252';
    DROP DATABASE postgres;
                postgres    false                       0    0    DATABASE postgres    COMMENT     N   COMMENT ON DATABASE postgres IS 'default administrative connection database';
                   postgres    false    4889                        2615    16436    app    SCHEMA        CREATE SCHEMA app;
    DROP SCHEMA app;
                postgres    false                       0    0 
   SCHEMA app    ACL     +   GRANT USAGE ON SCHEMA app TO backend_user;
                   postgres    false    7                        3079    16384 	   adminpack 	   EXTENSION     A   CREATE EXTENSION IF NOT EXISTS adminpack WITH SCHEMA pg_catalog;
    DROP EXTENSION adminpack;
                   false                       0    0    EXTENSION adminpack    COMMENT     M   COMMENT ON EXTENSION adminpack IS 'administrative functions for PostgreSQL';
                        false    2            �            1255    16726    generate_shipment_id(date)    FUNCTION     t  CREATE FUNCTION public.generate_shipment_id(target_date date) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
DECLARE
    delivery_id VARCHAR;
BEGIN
    delivery_id := TO_CHAR(target_date, 'YYMMDD');
    delivery_id := delivery_id || LPAD((SELECT COALESCE(MAX(SUBSTRING(delivery_id, 7)::INT, 0) + 1, 1) FROM deliveries), 3, '0');
    RETURN delivery_id;
END;
$$;
 =   DROP FUNCTION public.generate_shipment_id(target_date date);
       public          postgres    false            �            1259    16470 
   deliveries    TABLE     8  CREATE TABLE app.deliveries (
    delivery_id integer NOT NULL,
    product_id integer,
    store_id integer,
    operator_id integer,
    vehicle_id integer,
    qty integer,
    sending_time timestamp without time zone,
    delivered_time timestamp without time zone,
    received_by character varying(255)
);
    DROP TABLE app.deliveries;
       app         heap    postgres    false    7                       0    0    TABLE deliveries    ACL     K   GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE app.deliveries TO backend_user;
          app          postgres    false    226            �            1259    16469    deliveries_delivery_id_seq    SEQUENCE     �   CREATE SEQUENCE app.deliveries_delivery_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE app.deliveries_delivery_id_seq;
       app          postgres    false    7    226                       0    0    deliveries_delivery_id_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE app.deliveries_delivery_id_seq OWNED BY app.deliveries.delivery_id;
          app          postgres    false    225            �            1259    16454 	   operators    TABLE     k   CREATE TABLE app.operators (
    operator_id integer NOT NULL,
    operator_name character varying(255)
);
    DROP TABLE app.operators;
       app         heap    postgres    false    7                       0    0    TABLE operators    ACL     J   GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE app.operators TO backend_user;
          app          postgres    false    222            �            1259    16453    operators_operator_id_seq    SEQUENCE     �   CREATE SEQUENCE app.operators_operator_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE app.operators_operator_id_seq;
       app          postgres    false    222    7                        0    0    operators_operator_id_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE app.operators_operator_id_seq OWNED BY app.operators.operator_id;
          app          postgres    false    221            �            1259    16438    products    TABLE     �   CREATE TABLE app.products (
    product_id integer NOT NULL,
    product_name character varying(255),
    unit character varying(50)
);
    DROP TABLE app.products;
       app         heap    postgres    false    7            !           0    0    TABLE products    ACL     I   GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE app.products TO backend_user;
          app          postgres    false    218            �            1259    16437    products_product_id_seq    SEQUENCE     �   CREATE SEQUENCE app.products_product_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE app.products_product_id_seq;
       app          postgres    false    7    218            "           0    0    products_product_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE app.products_product_id_seq OWNED BY app.products.product_id;
          app          postgres    false    217            �            1259    16461    shipping_vehicles    TABLE     �   CREATE TABLE app.shipping_vehicles (
    vehicle_id integer NOT NULL,
    no_polisi character varying(20),
    shipping_driver character varying(255),
    shipping_co_driver character varying(255)
);
 "   DROP TABLE app.shipping_vehicles;
       app         heap    postgres    false    7            #           0    0    TABLE shipping_vehicles    ACL     R   GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE app.shipping_vehicles TO backend_user;
          app          postgres    false    224            �            1259    16460     shipping_vehicles_vehicle_id_seq    SEQUENCE     �   CREATE SEQUENCE app.shipping_vehicles_vehicle_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 4   DROP SEQUENCE app.shipping_vehicles_vehicle_id_seq;
       app          postgres    false    224    7            $           0    0     shipping_vehicles_vehicle_id_seq    SEQUENCE OWNED BY     _   ALTER SEQUENCE app.shipping_vehicles_vehicle_id_seq OWNED BY app.shipping_vehicles.vehicle_id;
          app          postgres    false    223            �            1259    16445    store_destinations    TABLE     �   CREATE TABLE app.store_destinations (
    store_id integer NOT NULL,
    store_name character varying(255),
    store_address text
);
 #   DROP TABLE app.store_destinations;
       app         heap    postgres    false    7            %           0    0    TABLE store_destinations    ACL     S   GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE app.store_destinations TO backend_user;
          app          postgres    false    220            �            1259    16444    store_destinations_store_id_seq    SEQUENCE     �   CREATE SEQUENCE app.store_destinations_store_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 3   DROP SEQUENCE app.store_destinations_store_id_seq;
       app          postgres    false    220    7            &           0    0    store_destinations_store_id_seq    SEQUENCE OWNED BY     ]   ALTER SEQUENCE app.store_destinations_store_id_seq OWNED BY app.store_destinations.store_id;
          app          postgres    false    219            l           2604    16473    deliveries delivery_id    DEFAULT     z   ALTER TABLE ONLY app.deliveries ALTER COLUMN delivery_id SET DEFAULT nextval('app.deliveries_delivery_id_seq'::regclass);
 B   ALTER TABLE app.deliveries ALTER COLUMN delivery_id DROP DEFAULT;
       app          postgres    false    226    225    226            j           2604    16457    operators operator_id    DEFAULT     x   ALTER TABLE ONLY app.operators ALTER COLUMN operator_id SET DEFAULT nextval('app.operators_operator_id_seq'::regclass);
 A   ALTER TABLE app.operators ALTER COLUMN operator_id DROP DEFAULT;
       app          postgres    false    221    222    222            h           2604    16441    products product_id    DEFAULT     t   ALTER TABLE ONLY app.products ALTER COLUMN product_id SET DEFAULT nextval('app.products_product_id_seq'::regclass);
 ?   ALTER TABLE app.products ALTER COLUMN product_id DROP DEFAULT;
       app          postgres    false    217    218    218            k           2604    16464    shipping_vehicles vehicle_id    DEFAULT     �   ALTER TABLE ONLY app.shipping_vehicles ALTER COLUMN vehicle_id SET DEFAULT nextval('app.shipping_vehicles_vehicle_id_seq'::regclass);
 H   ALTER TABLE app.shipping_vehicles ALTER COLUMN vehicle_id DROP DEFAULT;
       app          postgres    false    224    223    224            i           2604    16448    store_destinations store_id    DEFAULT     �   ALTER TABLE ONLY app.store_destinations ALTER COLUMN store_id SET DEFAULT nextval('app.store_destinations_store_id_seq'::regclass);
 G   ALTER TABLE app.store_destinations ALTER COLUMN store_id DROP DEFAULT;
       app          postgres    false    220    219    220                      0    16470 
   deliveries 
   TABLE DATA           �   COPY app.deliveries (delivery_id, product_id, store_id, operator_id, vehicle_id, qty, sending_time, delivered_time, received_by) FROM stdin;
    app          postgres    false    226   �=                 0    16454 	   operators 
   TABLE DATA           <   COPY app.operators (operator_id, operator_name) FROM stdin;
    app          postgres    false    222   �>                 0    16438    products 
   TABLE DATA           ?   COPY app.products (product_id, product_name, unit) FROM stdin;
    app          postgres    false    218   �>                 0    16461    shipping_vehicles 
   TABLE DATA           d   COPY app.shipping_vehicles (vehicle_id, no_polisi, shipping_driver, shipping_co_driver) FROM stdin;
    app          postgres    false    224   �A                 0    16445    store_destinations 
   TABLE DATA           N   COPY app.store_destinations (store_id, store_name, store_address) FROM stdin;
    app          postgres    false    220   B       '           0    0    deliveries_delivery_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('app.deliveries_delivery_id_seq', 13, true);
          app          postgres    false    225            (           0    0    operators_operator_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('app.operators_operator_id_seq', 2, true);
          app          postgres    false    221            )           0    0    products_product_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('app.products_product_id_seq', 60, true);
          app          postgres    false    217            *           0    0     shipping_vehicles_vehicle_id_seq    SEQUENCE SET     K   SELECT pg_catalog.setval('app.shipping_vehicles_vehicle_id_seq', 3, true);
          app          postgres    false    223            +           0    0    store_destinations_store_id_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('app.store_destinations_store_id_seq', 4, true);
          app          postgres    false    219            v           2606    16475    deliveries deliveries_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY app.deliveries
    ADD CONSTRAINT deliveries_pkey PRIMARY KEY (delivery_id);
 A   ALTER TABLE ONLY app.deliveries DROP CONSTRAINT deliveries_pkey;
       app            postgres    false    226            r           2606    16459    operators operators_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY app.operators
    ADD CONSTRAINT operators_pkey PRIMARY KEY (operator_id);
 ?   ALTER TABLE ONLY app.operators DROP CONSTRAINT operators_pkey;
       app            postgres    false    222            n           2606    16443    products products_pkey 
   CONSTRAINT     Y   ALTER TABLE ONLY app.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (product_id);
 =   ALTER TABLE ONLY app.products DROP CONSTRAINT products_pkey;
       app            postgres    false    218            t           2606    16468 (   shipping_vehicles shipping_vehicles_pkey 
   CONSTRAINT     k   ALTER TABLE ONLY app.shipping_vehicles
    ADD CONSTRAINT shipping_vehicles_pkey PRIMARY KEY (vehicle_id);
 O   ALTER TABLE ONLY app.shipping_vehicles DROP CONSTRAINT shipping_vehicles_pkey;
       app            postgres    false    224            p           2606    16452 *   store_destinations store_destinations_pkey 
   CONSTRAINT     k   ALTER TABLE ONLY app.store_destinations
    ADD CONSTRAINT store_destinations_pkey PRIMARY KEY (store_id);
 Q   ALTER TABLE ONLY app.store_destinations DROP CONSTRAINT store_destinations_pkey;
       app            postgres    false    220            w           2606    16486 &   deliveries deliveries_operator_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY app.deliveries
    ADD CONSTRAINT deliveries_operator_id_fkey FOREIGN KEY (operator_id) REFERENCES app.operators(operator_id);
 M   ALTER TABLE ONLY app.deliveries DROP CONSTRAINT deliveries_operator_id_fkey;
       app          postgres    false    226    222    4722            x           2606    16476 %   deliveries deliveries_product_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY app.deliveries
    ADD CONSTRAINT deliveries_product_id_fkey FOREIGN KEY (product_id) REFERENCES app.products(product_id);
 L   ALTER TABLE ONLY app.deliveries DROP CONSTRAINT deliveries_product_id_fkey;
       app          postgres    false    226    218    4718            y           2606    16481 #   deliveries deliveries_store_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY app.deliveries
    ADD CONSTRAINT deliveries_store_id_fkey FOREIGN KEY (store_id) REFERENCES app.store_destinations(store_id);
 J   ALTER TABLE ONLY app.deliveries DROP CONSTRAINT deliveries_store_id_fkey;
       app          postgres    false    4720    226    220            z           2606    16491 %   deliveries deliveries_vehicle_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY app.deliveries
    ADD CONSTRAINT deliveries_vehicle_id_fkey FOREIGN KEY (vehicle_id) REFERENCES app.shipping_vehicles(vehicle_id);
 L   ALTER TABLE ONLY app.deliveries DROP CONSTRAINT deliveries_vehicle_id_fkey;
       app          postgres    false    4724    224    226                       826    16502    DEFAULT PRIVILEGES FOR TABLES    DEFAULT ACL     v   ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA app GRANT SELECT,INSERT,DELETE,UPDATE ON TABLES TO backend_user;
          app          postgres    false    7               �   x���M�0���)z����Ht��t�Q&�x{�P1.,�ټ�e^�'��hE�"vL�w�i�Sv������f���j�r���4����9;އ��#Z�l�����=hH}m>�,��o-�%g�e���2��,+�H��~[[����Y���o���nx����:Ͷ.��"�4d��         &   x�3�t��MLQpL/-�2�t�,)�L�+������ ��m         �  x�}��v�0���Zu�_�,���IH9%�M7��aqd�	o����l	6^h��kf$����U
2� Q�xo->�����rl/�A����!�LQYR;��\][����)+�Sd
F~K��41�S*�$�njh�� �"'s�UM�}�-�ն��/�d%f�@�&{���ѹ��I�@պ��i�S��-�+F�p(�,qe��YE�*V՞L�#/B*�uN:�K�ے��[��Y��U?���bzw\��9�ȕת[�+�}+�x�Ǯظ6Ӱ\|��G���|��Ö�������(�ΠF���N}�x�E��%0c�3/7�_�P��h�����̎)�VxZn)t��d���˖��6��u�8YR�6d��XcB�f�A�4F�a�����w+�C�f�8��Z���)[ҡ懽 Ω�i�2��qӲP���r�o�~K�hlp;۔@��K9�S�TU���O�K�e�������4S��EJ�K�}��I�KX��Y��c�$��5���2Jf�-�%�{NQ���b/7��G�3&^r�A��k�@���J�i�R����������*��f�0Xj��Z˃&�a�9��C��&:��(0]�˓L�g,�@8(��4p���6�e��b���6�0)�p#�k�?�ƝhG�t�Ƣ������������Mt�O���W�g�3���Ū�WYQ�Z6�h�������/��         ^   x�3�t2426qw�t��M,Vp��ML�t�K�TǪ,�2�t2624�
��H,�TN,(-)J�tILI�KWpj�2��យ����X���+F��� )'         ~   x�Mͱ� F���	��/@7��������Ŕv�۫��'G+�.����^y�:�1	;	<� Ka�ɨG��oXv�Z��a�Ҝ4d;t�ȓak욑y(���s���o,A�Q�~���Y��DD�`0�     