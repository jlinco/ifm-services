create table public.profiles (
  id uuid not null REFERENCES auth.users on delete cascade,
  first_name text,
  last_name text,
  membership text,
  educational_level text,
  primary key (id)
);