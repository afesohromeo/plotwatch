BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "notification" (
    "id" bigserial PRIMARY KEY,
    "userId" uuid NOT NULL,
    "projectId" bigint,
    "type" text NOT NULL,
    "payload" json,
    "readAt" timestamp without time zone,
    "createdAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "notification_user_idx" ON "notification" USING btree ("userId", "id");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "progress_update" (
    "id" bigserial PRIMARY KEY,
    "projectId" bigint NOT NULL,
    "stageId" bigint,
    "authorId" uuid NOT NULL,
    "text" text NOT NULL,
    "workersCount" bigint,
    "weather" text,
    "issues" text,
    "createdAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "progress_update_project_idx" ON "progress_update" USING btree ("projectId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "stage_review" (
    "id" bigserial PRIMARY KEY,
    "stageId" bigint NOT NULL,
    "reviewerId" uuid NOT NULL,
    "decision" text NOT NULL,
    "comment" text,
    "createdAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "stage_review_stage_idx" ON "stage_review" USING btree ("stageId");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "notification"
    ADD CONSTRAINT "notification_fk_0"
    FOREIGN KEY("projectId")
    REFERENCES "project"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "progress_update"
    ADD CONSTRAINT "progress_update_fk_0"
    FOREIGN KEY("projectId")
    REFERENCES "project"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "progress_update"
    ADD CONSTRAINT "progress_update_fk_1"
    FOREIGN KEY("stageId")
    REFERENCES "stage"("id")
    ON DELETE SET NULL
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "stage_review"
    ADD CONSTRAINT "stage_review_fk_0"
    FOREIGN KEY("stageId")
    REFERENCES "stage"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR plotwatch
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('plotwatch', '20261009184742821', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261009184742821', "timestamp" = now();

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
