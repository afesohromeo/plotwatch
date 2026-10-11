BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "ledger_entry" (
    "id" bigserial PRIMARY KEY,
    "projectId" bigint NOT NULL,
    "stageId" bigint,
    "kind" text NOT NULL,
    "amountMinor" bigint NOT NULL,
    "occurredOn" timestamp without time zone NOT NULL,
    "recordedBy" uuid NOT NULL,
    "method" text,
    "reference" text,
    "confirmedBy" uuid,
    "confirmedAt" timestamp without time zone,
    "category" text,
    "description" text,
    "vendor" text,
    "receiptPath" text,
    "receiptSha256" text,
    "note" text,
    "reversesId" bigint,
    "createdAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "ledger_entry_project_idx" ON "ledger_entry" USING btree ("projectId", "id");
CREATE UNIQUE INDEX "ledger_entry_reverses_idx" ON "ledger_entry" USING btree ("reversesId");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "ledger_entry"
    ADD CONSTRAINT "ledger_entry_fk_0"
    FOREIGN KEY("projectId")
    REFERENCES "project"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "ledger_entry"
    ADD CONSTRAINT "ledger_entry_fk_1"
    FOREIGN KEY("stageId")
    REFERENCES "stage"("id")
    ON DELETE SET NULL
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR plotwatch
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('plotwatch', '20261011213734153', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261011213734153', "timestamp" = now();

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
