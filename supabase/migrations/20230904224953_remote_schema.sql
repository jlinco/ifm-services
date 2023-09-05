alter table "public"."profiles" drop constraint "firstname_length";

alter table "public"."profiles" drop constraint "lastname_length";

alter table "public"."profiles" drop column "avatar_url";

alter table "public"."profiles" drop column "firstname";

alter table "public"."profiles" drop column "lastname";

alter table "public"."profiles" add column "first_name" text;

alter table "public"."profiles" add column "last_name" text;


