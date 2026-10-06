BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "activity_event" (
    "id" bigserial PRIMARY KEY,
    "projectId" bigint NOT NULL,
    "actorId" uuid NOT NULL,
    "type" text NOT NULL,
    "targetType" text NOT NULL,
    "targetId" bigint,
    "payload" json,
    "createdAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "activity_event_project_idx" ON "activity_event" USING btree ("projectId", "id");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "audit_log" (
    "id" bigserial PRIMARY KEY,
    "actorId" uuid,
    "projectId" bigint,
    "action" text NOT NULL,
    "entityType" text NOT NULL,
    "entityId" bigint,
    "before" json,
    "after" json,
    "createdAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "audit_log_project_idx" ON "audit_log" USING btree ("projectId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "invitation" (
    "id" bigserial PRIMARY KEY,
    "projectId" bigint NOT NULL,
    "role" text NOT NULL,
    "canApprove" boolean NOT NULL DEFAULT false,
    "code" text NOT NULL,
    "status" text NOT NULL,
    "expiresAt" timestamp without time zone NOT NULL,
    "createdBy" uuid NOT NULL,
    "acceptedBy" uuid,
    "createdAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "invitation_code_idx" ON "invitation" USING btree ("code");
CREATE INDEX "invitation_project_idx" ON "invitation" USING btree ("projectId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "project" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "description" text,
    "type" text NOT NULL,
    "status" text NOT NULL,
    "currencyCode" text NOT NULL,
    "plannedStart" timestamp without time zone,
    "plannedEnd" timestamp without time zone,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "project_member" (
    "id" bigserial PRIMARY KEY,
    "projectId" bigint NOT NULL,
    "authUserId" uuid NOT NULL,
    "role" text NOT NULL,
    "canApprove" boolean NOT NULL DEFAULT false,
    "status" text NOT NULL,
    "joinedAt" timestamp without time zone NOT NULL,
    "removedAt" timestamp without time zone
);

-- Indexes
CREATE UNIQUE INDEX "project_member_idx" ON "project_member" USING btree ("projectId", "authUserId");
CREATE INDEX "project_member_user_idx" ON "project_member" USING btree ("authUserId");

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
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "site_project_idx" ON "site" USING btree ("projectId");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "activity_event"
    ADD CONSTRAINT "activity_event_fk_0"
    FOREIGN KEY("projectId")
    REFERENCES "project"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "invitation"
    ADD CONSTRAINT "invitation_fk_0"
    FOREIGN KEY("projectId")
    REFERENCES "project"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "project_member"
    ADD CONSTRAINT "project_member_fk_0"
    FOREIGN KEY("projectId")
    REFERENCES "project"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

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
-- MIGRATION VERSION FOR plotwatch
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('plotwatch', '20261006173234507', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261006173234507', "timestamp" = now();

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
