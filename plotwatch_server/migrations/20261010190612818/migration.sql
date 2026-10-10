BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "activity_event" ADD COLUMN "stageId" bigint;
CREATE INDEX "activity_event_stage_idx" ON "activity_event" USING btree ("projectId", "stageId", "id");

--
-- MIGRATION VERSION FOR plotwatch
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('plotwatch', '20261010190612818', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261010190612818', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20260824182259319', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260824182259319', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_idp
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_idp', '20260924105404509', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260924105404509', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_core
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_core', '20260924105232991', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260924105232991', "timestamp" = now();


COMMIT;
