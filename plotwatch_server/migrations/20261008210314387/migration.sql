BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "evidence" (
    "id" bigserial PRIMARY KEY,
    "projectId" bigint NOT NULL,
    "stageId" bigint NOT NULL,
    "checklistItemId" bigint NOT NULL,
    "capturedBy" uuid NOT NULL,
    "status" text NOT NULL,
    "sha256" text NOT NULL,
    "photoPath" text NOT NULL,
    "thumbPath" text,
    "fileSizeBytes" bigint,
    "deviceCapturedAt" timestamp without time zone NOT NULL,
    "serverCommittedAt" timestamp without time zone NOT NULL,
    "finalizedAt" timestamp without time zone,
    "lat" double precision,
    "lng" double precision,
    "accuracyM" double precision,
    "altitudeM" double precision,
    "isMockLocation" boolean,
    "capturedInApp" boolean NOT NULL,
    "distanceFromSiteM" double precision,
    "deviceModel" text NOT NULL,
    "osVersion" text NOT NULL,
    "appVersion" text NOT NULL,
    "verificationLevel" text NOT NULL,
    "checks" json,
    "caption" text,
    "retractedAt" timestamp without time zone,
    "retractedReason" text
);

-- Indexes
CREATE INDEX "evidence_project_idx" ON "evidence" USING btree ("projectId");
CREATE INDEX "evidence_stage_idx" ON "evidence" USING btree ("stageId");
CREATE INDEX "evidence_item_idx" ON "evidence" USING btree ("checklistItemId");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "evidence"
    ADD CONSTRAINT "evidence_fk_0"
    FOREIGN KEY("projectId")
    REFERENCES "project"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "evidence"
    ADD CONSTRAINT "evidence_fk_1"
    FOREIGN KEY("stageId")
    REFERENCES "stage"("id")
    ON DELETE RESTRICT
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "evidence"
    ADD CONSTRAINT "evidence_fk_2"
    FOREIGN KEY("checklistItemId")
    REFERENCES "checklist_item"("id")
    ON DELETE RESTRICT
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR plotwatch
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('plotwatch', '20261008210314387', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261008210314387', "timestamp" = now();

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
