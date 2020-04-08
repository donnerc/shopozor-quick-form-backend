--
-- PostgreSQL database dump
--

-- Dumped from database version 12.2 (Debian 12.2-2.pgdg100+1)
-- Dumped by pg_dump version 12.2 (Debian 12.2-2.pgdg100+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Data for Name: basket_types; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.basket_types (id, name, price) FROM stdin;
3	Moyen	$60.00
12	Petit	$30.00
13	Grand	$90.00
\.


--
-- Data for Name: baskets; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.baskets (id, "validFrom", "validThrough", type_id, created_at, updated_at) FROM stdin;
3	2020-04-08	\N	3	2020-04-08 20:15:50.87478+00	2020-04-08 20:15:55.623377+00
12	2020-04-08	\N	3	2020-04-08 20:15:50.87478+00	2020-04-08 20:15:55.623377+00
13	2020-04-08	\N	3	2020-04-08 20:15:50.87478+00	2020-04-08 20:15:55.623377+00
14	2020-04-08	\N	3	2020-04-08 20:15:50.87478+00	2020-04-08 20:15:55.623377+00
11	2020-04-08	\N	3	2020-04-08 20:15:50.87478+00	2020-04-08 20:15:55.623377+00
15	2020-04-08	\N	3	2020-04-08 20:15:50.87478+00	2020-04-08 20:15:55.623377+00
16	2020-04-08	\N	3	2020-04-08 20:16:58.190984+00	2020-04-08 20:16:58.190984+00
17	2020-04-08	\N	3	2020-04-08 20:17:04.357343+00	2020-04-08 20:17:04.357343+00
\.


--
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.products (id, name, description) FROM stdin;
8	Oranges	\N
9	Haricots séchés	\N
1	Pommes	\N
2	Poires	\N
\.


--
-- Data for Name: basket_lines; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.basket_lines (product_id, basket_id, quantity) FROM stdin;
8	3	\N
9	3	\N
1	11	\N
2	11	\N
1	12	\N
2	12	\N
1	13	\N
2	13	\N
1	14	\N
2	14	\N
1	15	2kg
8	15	1kg
9	15	1.5kg
\.


--
-- Data for Name: json_baskets; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.json_baskets (id, created_at, updated_at, products, type_id) FROM stdin;
1	2020-04-08 20:48:13.079544+00	2020-04-08 20:48:13.079544+00	[{"name": "Pommes", "quantity": "1kg"}, {"name": "2 Bouteilles de 500ml d'huile de caméline"}, {"name": "Fenouils"}, {"name": "1 paque de graines de tourneslo"}]	3
\.


--
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.orders ("firstName", "lastName", city, zip, id, created_at, updated_at, phone, comments, "needSalt", "needPepper", street, email, basket_id) FROM stdin;
Cédric	Donner	Bulle	1630	2	2020-04-08 21:06:27.089642+00	2020-04-08 21:06:27.089642+00	+41768220510	\N	f	t	Chemin des Combes 26	cedonner@gmail.com	1
\.


--
-- Name: basket_types_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.basket_types_id_seq', 13, true);


--
-- Name: baskets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.baskets_id_seq', 17, true);


--
-- Name: json_baskets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.json_baskets_id_seq', 1, true);


--
-- Name: orders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.orders_id_seq', 2, true);


--
-- Name: products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.products_id_seq', 9, true);


--
-- PostgreSQL database dump complete
--

