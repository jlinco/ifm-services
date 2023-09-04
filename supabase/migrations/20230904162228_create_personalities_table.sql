create extension if not exists "uuid-ossp";

create table if not exists public.personalities (
  personality_id uuid DEFAULT uuid_generate_v4(),
  title text not null,
  slug text not null,
  summary text,
  strengths text,
  weaknesses text,
  preferences text,
  features text,
  created_at timestamptz default now(),
  updated_at timestamptz,

  primary key (personality_id),
  constraint title_length check (char_length(title) >= 3)
)