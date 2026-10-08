BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "checklist_item" (
    "id" bigserial PRIMARY KEY,
    "stageId" bigint NOT NULL,
    "orderIndex" bigint NOT NULL,
    "label" text NOT NULL,
    "isRequired" boolean NOT NULL
);

-- Indexes
CREATE INDEX "checklist_item_stage_idx" ON "checklist_item" USING btree ("stageId", "orderIndex");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "stage" (
    "id" bigserial PRIMARY KEY,
    "projectId" bigint NOT NULL,
    "orderIndex" bigint NOT NULL,
    "name" text NOT NULL,
    "description" text,
    "budgetMinor" bigint NOT NULL,
    "plannedStart" timestamp without time zone,
    "plannedEnd" timestamp without time zone,
    "status" text NOT NULL,
    "startedAt" timestamp without time zone,
    "submittedAt" timestamp without time zone,
    "approvedAt" timestamp without time zone,
    "approvedBy" uuid,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "stage_project_idx" ON "stage" USING btree ("projectId", "orderIndex");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "checklist_item"
    ADD CONSTRAINT "checklist_item_fk_0"
    FOREIGN KEY("stageId")
    REFERENCES "stage"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "stage"
    ADD CONSTRAINT "stage_fk_0"
    FOREIGN KEY("projectId")
    REFERENCES "project"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR plotwatch
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('plotwatch', '20261008161257025', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261008161257025', "timestamp" = now();

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
