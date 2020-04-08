CREATE FUNCTION public.set_current_timestamp_updated_at() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  _new record;
BEGIN
  _new := NEW;
  _new."updated_at" = NOW();
  RETURN _new;
END;
$$;
CREATE TABLE public.basket_lines (
    product_id integer NOT NULL,
    basket_id integer NOT NULL,
    quantity character varying
);
CREATE TABLE public.basket_types (
    id integer NOT NULL,
    name character varying NOT NULL,
    price money NOT NULL
);
CREATE SEQUENCE public.basket_types_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.basket_types_id_seq OWNED BY public.basket_types.id;
CREATE TABLE public.baskets (
    id integer NOT NULL,
    "validFrom" date DEFAULT now(),
    "validThrough" date,
    type_id integer NOT NULL
);
CREATE SEQUENCE public.baskets_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.baskets_id_seq OWNED BY public.baskets.id;
CREATE TABLE public.orders (
    "firstName" character varying NOT NULL,
    "lastName" character varying NOT NULL,
    city character varying NOT NULL,
    zip bpchar NOT NULL,
    id integer NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    phone character varying NOT NULL,
    comments text NOT NULL,
    "needSalt" boolean NOT NULL,
    "needPepper" boolean NOT NULL,
    street character varying NOT NULL,
    email character varying NOT NULL
);
CREATE SEQUENCE public.orders_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.orders_id_seq OWNED BY public.orders.id;
CREATE TABLE public.products (
    id integer NOT NULL,
    name character varying NOT NULL,
    description text NOT NULL
);
CREATE SEQUENCE public.products_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.products_id_seq OWNED BY public.products.id;
ALTER TABLE ONLY public.basket_types ALTER COLUMN id SET DEFAULT nextval('public.basket_types_id_seq'::regclass);
ALTER TABLE ONLY public.baskets ALTER COLUMN id SET DEFAULT nextval('public.baskets_id_seq'::regclass);
ALTER TABLE ONLY public.orders ALTER COLUMN id SET DEFAULT nextval('public.orders_id_seq'::regclass);
ALTER TABLE ONLY public.products ALTER COLUMN id SET DEFAULT nextval('public.products_id_seq'::regclass);
ALTER TABLE ONLY public.basket_lines
    ADD CONSTRAINT basket_lines_pkey PRIMARY KEY (product_id, basket_id);
ALTER TABLE ONLY public.basket_types
    ADD CONSTRAINT basket_types_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.baskets
    ADD CONSTRAINT baskets_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);
CREATE TRIGGER set_public_orders_updated_at BEFORE UPDATE ON public.orders FOR EACH ROW EXECUTE FUNCTION public.set_current_timestamp_updated_at();
COMMENT ON TRIGGER set_public_orders_updated_at ON public.orders IS 'trigger to set value of column "updated_at" to current timestamp on row update';
ALTER TABLE ONLY public.basket_lines
    ADD CONSTRAINT basket_lines_basket_id_fkey FOREIGN KEY (basket_id) REFERENCES public.baskets(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public.basket_lines
    ADD CONSTRAINT basket_lines_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public.baskets
    ADD CONSTRAINT baskets_type_id_fkey FOREIGN KEY (type_id) REFERENCES public.basket_types(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
