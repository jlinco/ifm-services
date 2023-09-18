CREATE TABLE IF NOT EXISTS public.personalities
(
    personality_id uuid NOT NULL DEFAULT uuid_generate_v4(),
    title text COLLATE pg_catalog."default" NOT NULL,
    slug text COLLATE pg_catalog."default" NOT NULL,
    summary text COLLATE pg_catalog."default",
    strengths text COLLATE pg_catalog."default",
    weaknesses text COLLATE pg_catalog."default",
    preferences text COLLATE pg_catalog."default",
    features text COLLATE pg_catalog."default",
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone,
    CONSTRAINT personalities_pkey PRIMARY KEY (personality_id),
    CONSTRAINT title_length CHECK (char_length(title) >= 3)
)
TABLESPACE pg_default;
ALTER TABLE IF EXISTS public.personalities
    OWNER to postgres;

GRANT ALL ON TABLE public.personalities TO anon;

GRANT ALL ON TABLE public.personalities TO authenticated;

GRANT ALL ON TABLE public.personalities TO postgres;

GRANT ALL ON TABLE public.personalities TO service_role;

CREATE TABLE IF NOT EXISTS public.profiles
(
    id uuid NOT NULL,
    membership text COLLATE pg_catalog."default",
    educational_level text COLLATE pg_catalog."default",
    first_name text COLLATE pg_catalog."default",
    last_name text COLLATE pg_catalog."default",
    CONSTRAINT profiles_pkey PRIMARY KEY (id),
    CONSTRAINT profiles_id_fkey FOREIGN KEY (id)
        REFERENCES auth.users (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE
)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.profiles
    OWNER to postgres;

GRANT ALL ON TABLE public.profiles TO anon;

GRANT ALL ON TABLE public.profiles TO authenticated;

GRANT ALL ON TABLE public.profiles TO postgres;

GRANT ALL ON TABLE public.profiles TO service_role;

-- Define RLS for tables
ALTER TABLE IF EXISTS public.personalities
    ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Enable read access for all users"
    ON public.personalities
    AS PERMISSIVE
    FOR SELECT
    TO public
    USING (true);

