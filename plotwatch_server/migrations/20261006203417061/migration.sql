BEGIN;

--
-- ACTION DROP TABLE
--
DROP TABLE "site" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "site" (
    "id" bigserial PRIMARY KEY,
    "projectId" bigint NOT NULL,
    "centerLat" double precision NOT NULL,
    "centerLng" double precision NOT NULL,
    "plusCode" text NOT NULL,
    "radiusM" bigint NOT NULL,
    "addressText" text,
    "timezone" text,
    "validatedProposalId" bigint NOT NULL,
    "validatedBy" uuid NOT NULL,
    "validatedAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "site_project_idx" ON "site" USING btree ("projectId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "site_proposal" (
    "id" bigserial PRIMARY KEY,
    "projectId" bigint NOT NULL,
    "proposedBy" uuid NOT NULL,
    "lat" double precision NOT NULL,
    "lng" double precision NOT NULL,
    "accuracyM" double precision NOT NULL,
    "proposedAt" timestamp without time zone NOT NULL,
    "status" text NOT NULL,
    "decidedBy" uuid,
    "decidedAt" timestamp without time zone,
    "rejectReason" text
);

-- Indexes
CREATE INDEX "site_proposal_project_idx" ON "site_proposal" USING btree ("projectId", "status");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "site"
    ADD CONSTRAINT "site_fk_0"
    FOREIGN KEY("projectId")
    REFERENCES "project"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "site_proposal"
    ADD CONSTRAINT "site_proposal_fk_0"
    FOREIGN KEY("projectId")
    REFERENCES "project"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR plotwatch
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('plotwatch', '20261006203417061', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261006203417061', "timestamp" = now();

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
