begin;

CREATE EXTENSION "basejump-supabase_test_helpers";

select plan(1);

-- check that table has personality_id column
SELECT has_column(
  'public',
  'personalities',
  'personality_id',
  'personality_id should exist'
);

-- test policies
-- select policies_are(
--   'public',
--   'personalities',
--   ARRAY [
--     'Enable read access for all users' -- Test that all can read personalities
--   ]
-- );

select * from finish();

-- rollback transaction completing test scenario

ROLLBACK;