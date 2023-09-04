create table if not exists public.profiles (
  id uuid not null REFERENCES auth.users on delete cascade,
  firstname text,
  lastname text,
  membership text,
  educational_level text,
  avatar_url text,

  primary key (id),
  constraint firstname_length check (char_length(firstname) >= 3),
  constraint lastname_length check (char_length(lastname) >= 3)
);

-- alter table profiles
--   enable row level security;

-- create policy "Public pro"