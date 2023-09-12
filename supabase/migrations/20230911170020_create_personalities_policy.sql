alter table personalities enable row level security;

CREATE POLICY "Enable read access for all users" ON "public"."personalities"
AS PERMISSIVE FOR SELECT
TO public
USING (true);