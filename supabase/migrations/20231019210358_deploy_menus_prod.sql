create extension if not exists "uuid-ossp";

CREATE TABLE
    IF NOT EXISTS public.menus (
        menu_id uuid DEFAULT uuid_generate_v4(),
        title text NOT NULL,
        slug text NOT NULL,
        menu_path text,
        icon text,
        hasSubMenu BOOLEAN,
        CONSTRAINT menu_pkey PRIMARY KEY (menu_id)
    );

CREATE TABLE
    IF NOT EXISTS public.submenus (
        submenu_id uuid DEFAULT uuid_generate_v4(),
        title text NOT NULL,
        slug text NOT NULL,
        menu_path text,
        icon text,
        menu_id uuid,
        CONSTRAINT submenu_pkey PRIMARY KEY (submenu_id),
        CONSTRAINT submenu_menu_id_fkey FOREIGN KEY (menu_id) REFERENCES menus (menu_id) ON DELETE CASCADE
    );

ALTER TABLE IF EXISTS public.menus ENABLE ROW LEVEL SECURITY;

ALTER TABLE IF EXISTS public.submenus ENABLE ROW LEVEL SECURITY;

CREATE POLICY "All Can Access Main Menu Items" ON public.menus FOR
SELECT USING (true);

CREATE POLICY "All Can Acess SubMenu Items" ON public.submenus FOR
SELECT USING (true);

CREATE POLICY "All Can Access Personalities" on public.personalities FOR
SELECT USING (true);