ALTER TABLE IF EXISTS public.personalities
    ENABLE ROW LEVEL SECURITY;

ALTER TABLE IF EXISTS public.profiles
    ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can insert their own profile"
  ON public.profiles for INSERT
  WITH CHECK ( auth.uid() = id );

CREATE POLICY "User can view their own profile"
  ON public.profiles for SELECT
  USING ( auth.uid() = id );

CREATE POLICY "Users can update their own profile"
  ON public.profiles for UPDATE
  USING ( auth.uid() = id );