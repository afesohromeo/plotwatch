/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member
// ignore_for_file: dead_code, unnecessary_type_check

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:plotwatch_server/src/generated/activity_type.dart' as _idpi4lil;
import 'package:plotwatch_server/src/generated/evidence.dart' as _icm5mt5e;
import 'package:plotwatch_server/src/generated/invitation.dart' as _ikzhqv9e;
import 'package:plotwatch_server/src/generated/member_view.dart' as _ig1yf1bz;
import 'package:plotwatch_server/src/generated/site_proposal.dart' as _iarrohmg;
import 'package:plotwatch_server/src/generated/stage_draft.dart' as _ieegu8zj;
import 'package:plotwatch_server/src/generated/stage_review_view.dart'
    as _i09iu71f;
import 'package:serverpod/protocol.dart' as _isp;
import 'package:serverpod/serverpod.dart' as _is;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _iacs;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart'
    as _iais;
import 'activity_entry.dart' as _iczfg34g;
import 'activity_event.dart' as _iwse5pgb;
import 'activity_page.dart' as _i8grwdd2;
import 'activity_type.dart' as _iorr0e24;
import 'app_error_code.dart' as _imu8gbx5;
import 'app_exception.dart' as _it4z223c;
import 'audit_log.dart' as _itixckla;
import 'checklist_item.dart' as _ifywsnp6;
import 'checklist_item_draft.dart' as _iuwh2s2t;
import 'evidence.dart' as _iptmmm0p;
import 'evidence_commit.dart' as _it2d46ly;
import 'evidence_commit_result.dart' as _i6593me7;
import 'evidence_status.dart' as _itwc15qq;
import 'invitation.dart' as _ix00wubs;
import 'invitation_preview.dart' as _i8l83u67;
import 'invitation_status.dart' as _ifbgrtog;
import 'live_signal.dart' as _ipp2ty4v;
import 'media_variant.dart' as _ibclxgv9;
import 'member_status.dart' as _iolegqnm;
import 'member_view.dart' as _iwpqxdug;
import 'my_profile.dart' as _i1hmtol2;
import 'notification.dart' as _irt10kca;
import 'notification_page.dart' as _iw4dnqzf;
import 'notification_type.dart' as _igc0nsfd;
import 'progress_update.dart' as _i4ejzj19;
import 'progress_update_draft.dart' as _i0gnznij;
import 'project.dart' as _ifiazq2p;
import 'project_details.dart' as _irbn6ip5;
import 'project_member.dart' as _i7o7d07j;
import 'project_overview.dart' as _iy1z8w9e;
import 'project_role.dart' as _i46wx1t7;
import 'project_sort.dart' as _i7c3tk4z;
import 'project_status.dart' as _iqsxbscs;
import 'project_summary.dart' as _ivxocntb;
import 'project_summary_page.dart' as _i4o32k29;
import 'project_type.dart' as _irluonl0;
import 'review_decision.dart' as _idrjy6ic;
import 'site.dart' as _iz8v5x4v;
import 'site_proposal.dart' as _ira79kry;
import 'site_proposal_status.dart' as _i8b5g94r;
import 'stage.dart' as _igkbma1f;
import 'stage_brief.dart' as _is1lynby;
import 'stage_draft.dart' as _i7mtby60;
import 'stage_plan.dart' as _iwmsx3av;
import 'stage_review.dart' as _ie5kygoh;
import 'stage_review_view.dart' as _ibz5bd0v;
import 'stage_status.dart' as _iblg1lql;
import 'stage_view.dart' as _iobwm8xj;
import 'user_settings.dart' as _iy88a0nt;
import 'verification_check.dart' as _i92h88x8;
import 'verification_check_name.dart' as _io670pev;
import 'verification_level.dart' as _i5zqa56i;
import 'weather.dart' as _ifjsehv5;
export 'activity_entry.dart';
export 'activity_event.dart';
export 'activity_page.dart';
export 'activity_type.dart';
export 'app_error_code.dart';
export 'app_exception.dart';
export 'audit_log.dart';
export 'checklist_item.dart';
export 'checklist_item_draft.dart';
export 'evidence.dart';
export 'evidence_commit.dart';
export 'evidence_commit_result.dart';
export 'evidence_status.dart';
export 'invitation.dart';
export 'invitation_preview.dart';
export 'invitation_status.dart';
export 'live_signal.dart';
export 'media_variant.dart';
export 'member_status.dart';
export 'member_view.dart';
export 'my_profile.dart';
export 'notification.dart';
export 'notification_page.dart';
export 'notification_type.dart';
export 'progress_update.dart';
export 'progress_update_draft.dart';
export 'project.dart';
export 'project_details.dart';
export 'project_member.dart';
export 'project_overview.dart';
export 'project_role.dart';
export 'project_sort.dart';
export 'project_status.dart';
export 'project_summary.dart';
export 'project_summary_page.dart';
export 'project_type.dart';
export 'review_decision.dart';
export 'site.dart';
export 'site_proposal.dart';
export 'site_proposal_status.dart';
export 'stage.dart';
export 'stage_brief.dart';
export 'stage_draft.dart';
export 'stage_plan.dart';
export 'stage_review.dart';
export 'stage_review_view.dart';
export 'stage_status.dart';
export 'stage_view.dart';
export 'user_settings.dart';
export 'verification_check.dart';
export 'verification_check_name.dart';
export 'verification_level.dart';
export 'weather.dart';

class Protocol extends _is.DatabaseSerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._().._registerHostProtocols();

  static List<_isp.TableDefinition> get targetTableDefinitions => [
    _isp.TableDefinition(
      name: 'activity_event',
      dartName: 'ActivityEvent',
      schema: 'public',
      module: 'plotwatch',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'projectId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'actorId',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isp.ColumnDefinition(
          name: 'type',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:ActivityType',
        ),
        _isp.ColumnDefinition(
          name: 'targetType',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'targetId',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'stageId',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'payload',
          columnType: _isp.ColumnType.json,
          isNullable: true,
          dartType: 'Map<String,String>?',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'activity_event_fk_0',
          columns: ['projectId'],
          referenceTable: 'project',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'activity_event_project_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'projectId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'activity_event_stage_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'projectId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'stageId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'audit_log',
      dartName: 'AuditLog',
      schema: 'public',
      module: 'plotwatch',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'actorId',
          columnType: _isp.ColumnType.uuid,
          isNullable: true,
          dartType: 'UuidValue?',
        ),
        _isp.ColumnDefinition(
          name: 'projectId',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'action',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'entityType',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'entityId',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'before',
          columnType: _isp.ColumnType.json,
          isNullable: true,
          dartType: 'Map<String,String>?',
        ),
        _isp.ColumnDefinition(
          name: 'after',
          columnType: _isp.ColumnType.json,
          isNullable: true,
          dartType: 'Map<String,String>?',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'audit_log_project_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'projectId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'checklist_item',
      dartName: 'ChecklistItem',
      schema: 'public',
      module: 'plotwatch',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'stageId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'orderIndex',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'label',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'isRequired',
          columnType: _isp.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'checklist_item_fk_0',
          columns: ['stageId'],
          referenceTable: 'stage',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'checklist_item_stage_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'stageId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'orderIndex',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'evidence',
      dartName: 'Evidence',
      schema: 'public',
      module: 'plotwatch',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'projectId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'stageId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'checklistItemId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'capturedBy',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isp.ColumnDefinition(
          name: 'status',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:EvidenceStatus',
        ),
        _isp.ColumnDefinition(
          name: 'sha256',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'photoPath',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'thumbPath',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'fileSizeBytes',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'deviceCapturedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'serverCommittedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'finalizedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'lat',
          columnType: _isp.ColumnType.doublePrecision,
          isNullable: true,
          dartType: 'double?',
        ),
        _isp.ColumnDefinition(
          name: 'lng',
          columnType: _isp.ColumnType.doublePrecision,
          isNullable: true,
          dartType: 'double?',
        ),
        _isp.ColumnDefinition(
          name: 'accuracyM',
          columnType: _isp.ColumnType.doublePrecision,
          isNullable: true,
          dartType: 'double?',
        ),
        _isp.ColumnDefinition(
          name: 'altitudeM',
          columnType: _isp.ColumnType.doublePrecision,
          isNullable: true,
          dartType: 'double?',
        ),
        _isp.ColumnDefinition(
          name: 'isMockLocation',
          columnType: _isp.ColumnType.boolean,
          isNullable: true,
          dartType: 'bool?',
        ),
        _isp.ColumnDefinition(
          name: 'capturedInApp',
          columnType: _isp.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
        _isp.ColumnDefinition(
          name: 'distanceFromSiteM',
          columnType: _isp.ColumnType.doublePrecision,
          isNullable: true,
          dartType: 'double?',
        ),
        _isp.ColumnDefinition(
          name: 'deviceModel',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'osVersion',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'appVersion',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'verificationLevel',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:VerificationLevel',
        ),
        _isp.ColumnDefinition(
          name: 'checks',
          columnType: _isp.ColumnType.json,
          isNullable: true,
          dartType: 'List<protocol:VerificationCheck>?',
        ),
        _isp.ColumnDefinition(
          name: 'caption',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'retractedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'retractedReason',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'evidence_fk_0',
          columns: ['projectId'],
          referenceTable: 'project',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.cascade,
          matchType: null,
        ),
        _isp.ForeignKeyDefinition(
          constraintName: 'evidence_fk_1',
          columns: ['stageId'],
          referenceTable: 'stage',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.restrict,
          matchType: null,
        ),
        _isp.ForeignKeyDefinition(
          constraintName: 'evidence_fk_2',
          columns: ['checklistItemId'],
          referenceTable: 'checklist_item',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.restrict,
          matchType: null,
        ),
      ],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'evidence_project_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'projectId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'evidence_stage_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'stageId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'evidence_item_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'checklistItemId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'invitation',
      dartName: 'Invitation',
      schema: 'public',
      module: 'plotwatch',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'projectId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'role',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:ProjectRole',
        ),
        _isp.ColumnDefinition(
          name: 'canApprove',
          columnType: _isp.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
        _isp.ColumnDefinition(
          name: 'code',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'status',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:InvitationStatus',
        ),
        _isp.ColumnDefinition(
          name: 'expiresAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'createdBy',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isp.ColumnDefinition(
          name: 'acceptedBy',
          columnType: _isp.ColumnType.uuid,
          isNullable: true,
          dartType: 'UuidValue?',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'invitation_fk_0',
          columns: ['projectId'],
          referenceTable: 'project',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'invitation_code_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'code',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'invitation_project_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'projectId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'notification',
      dartName: 'AppNotification',
      schema: 'public',
      module: 'plotwatch',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'userId',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isp.ColumnDefinition(
          name: 'projectId',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'type',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:NotificationType',
        ),
        _isp.ColumnDefinition(
          name: 'payload',
          columnType: _isp.ColumnType.json,
          isNullable: true,
          dartType: 'Map<String,String>?',
        ),
        _isp.ColumnDefinition(
          name: 'readAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'notification_fk_0',
          columns: ['projectId'],
          referenceTable: 'project',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'notification_user_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'userId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'progress_update',
      dartName: 'ProgressUpdate',
      schema: 'public',
      module: 'plotwatch',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'projectId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'stageId',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'authorId',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isp.ColumnDefinition(
          name: 'text',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'workersCount',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'weather',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'protocol:Weather?',
        ),
        _isp.ColumnDefinition(
          name: 'issues',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'progress_update_fk_0',
          columns: ['projectId'],
          referenceTable: 'project',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.cascade,
          matchType: null,
        ),
        _isp.ForeignKeyDefinition(
          constraintName: 'progress_update_fk_1',
          columns: ['stageId'],
          referenceTable: 'stage',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.setNull,
          matchType: null,
        ),
      ],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'progress_update_project_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'projectId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'project',
      dartName: 'Project',
      schema: 'public',
      module: 'plotwatch',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'name',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'description',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'type',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:ProjectType',
        ),
        _isp.ColumnDefinition(
          name: 'status',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:ProjectStatus',
        ),
        _isp.ColumnDefinition(
          name: 'currencyCode',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'plannedStart',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'plannedEnd',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'updatedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'project_member',
      dartName: 'ProjectMember',
      schema: 'public',
      module: 'plotwatch',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'projectId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'authUserId',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isp.ColumnDefinition(
          name: 'role',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:ProjectRole',
        ),
        _isp.ColumnDefinition(
          name: 'canApprove',
          columnType: _isp.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
        _isp.ColumnDefinition(
          name: 'status',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:MemberStatus',
        ),
        _isp.ColumnDefinition(
          name: 'joinedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'removedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'project_member_fk_0',
          columns: ['projectId'],
          referenceTable: 'project',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'project_member_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'projectId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'authUserId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'project_member_user_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'authUserId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'site',
      dartName: 'Site',
      schema: 'public',
      module: 'plotwatch',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'projectId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'centerLat',
          columnType: _isp.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _isp.ColumnDefinition(
          name: 'centerLng',
          columnType: _isp.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _isp.ColumnDefinition(
          name: 'plusCode',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'radiusM',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'addressText',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'timezone',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'validatedProposalId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'validatedBy',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isp.ColumnDefinition(
          name: 'validatedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'updatedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'site_fk_0',
          columns: ['projectId'],
          referenceTable: 'project',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'site_project_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'projectId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'site_proposal',
      dartName: 'SiteProposal',
      schema: 'public',
      module: 'plotwatch',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'projectId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'proposedBy',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isp.ColumnDefinition(
          name: 'lat',
          columnType: _isp.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _isp.ColumnDefinition(
          name: 'lng',
          columnType: _isp.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _isp.ColumnDefinition(
          name: 'accuracyM',
          columnType: _isp.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _isp.ColumnDefinition(
          name: 'proposedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'status',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:SiteProposalStatus',
        ),
        _isp.ColumnDefinition(
          name: 'decidedBy',
          columnType: _isp.ColumnType.uuid,
          isNullable: true,
          dartType: 'UuidValue?',
        ),
        _isp.ColumnDefinition(
          name: 'decidedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'rejectReason',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'site_proposal_fk_0',
          columns: ['projectId'],
          referenceTable: 'project',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'site_proposal_project_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'projectId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'status',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'stage',
      dartName: 'Stage',
      schema: 'public',
      module: 'plotwatch',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'projectId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'orderIndex',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'name',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'description',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'budgetMinor',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'plannedStart',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'plannedEnd',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'status',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:StageStatus',
        ),
        _isp.ColumnDefinition(
          name: 'startedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'submittedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'approvedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'approvedBy',
          columnType: _isp.ColumnType.uuid,
          isNullable: true,
          dartType: 'UuidValue?',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'updatedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'stage_fk_0',
          columns: ['projectId'],
          referenceTable: 'project',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'stage_project_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'projectId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'orderIndex',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'stage_review',
      dartName: 'StageReview',
      schema: 'public',
      module: 'plotwatch',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'stageId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'reviewerId',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isp.ColumnDefinition(
          name: 'decision',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:ReviewDecision',
        ),
        _isp.ColumnDefinition(
          name: 'comment',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'stage_review_fk_0',
          columns: ['stageId'],
          referenceTable: 'stage',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'stage_review_stage_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'stageId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'user_settings',
      dartName: 'UserSettings',
      schema: 'public',
      module: 'plotwatch',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'authUserId',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isp.ColumnDefinition(
          name: 'countryCode',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'locale',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'updatedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'user_settings_auth_user_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'authUserId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    ..._iais.Protocol.targetTableDefinitions,
    ..._iacs.Protocol.targetTableDefinitions,
    ..._isp.Protocol.targetTableDefinitions,
  ];

  static String? getClassNameFromObjectJson(dynamic data) {
    if (data is! Map) return null;
    final className = data['__className__'] as String?;
    return className;
  }

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;

    final dataClassName = getClassNameFromObjectJson(data);
    if (dataClassName != null && dataClassName != getClassNameForType(t)) {
      try {
        return deserializeByClassName({
          'className': dataClassName,
          'data': data,
        });
      } on _is.DeserializationClassNameNotFoundException catch (_) {
        // If the className is not recognized (e.g., older client receiving
        // data with a new subtype), fall back to deserializing without the
        // className, using the expected type T.
      }
    }

    if (t == _iczfg34g.ActivityEntry) {
      return _iczfg34g.ActivityEntry.fromJson(data) as T;
    }
    if (t == _iwse5pgb.ActivityEvent) {
      return _iwse5pgb.ActivityEvent.fromJson(data) as T;
    }
    if (t == _i8grwdd2.ActivityPage) {
      return _i8grwdd2.ActivityPage.fromJson(data) as T;
    }
    if (t == _iorr0e24.ActivityType) {
      return _iorr0e24.ActivityType.fromJson(data) as T;
    }
    if (t == _imu8gbx5.AppErrorCode) {
      return _imu8gbx5.AppErrorCode.fromJson(data) as T;
    }
    if (t == _it4z223c.AppException) {
      return _it4z223c.AppException.fromJson(data) as T;
    }
    if (t == _itixckla.AuditLog) {
      return _itixckla.AuditLog.fromJson(data) as T;
    }
    if (t == _ifywsnp6.ChecklistItem) {
      return _ifywsnp6.ChecklistItem.fromJson(data) as T;
    }
    if (t == _iuwh2s2t.ChecklistItemDraft) {
      return _iuwh2s2t.ChecklistItemDraft.fromJson(data) as T;
    }
    if (t == _iptmmm0p.Evidence) {
      return _iptmmm0p.Evidence.fromJson(data) as T;
    }
    if (t == _it2d46ly.EvidenceCommit) {
      return _it2d46ly.EvidenceCommit.fromJson(data) as T;
    }
    if (t == _i6593me7.EvidenceCommitResult) {
      return _i6593me7.EvidenceCommitResult.fromJson(data) as T;
    }
    if (t == _itwc15qq.EvidenceStatus) {
      return _itwc15qq.EvidenceStatus.fromJson(data) as T;
    }
    if (t == _ix00wubs.Invitation) {
      return _ix00wubs.Invitation.fromJson(data) as T;
    }
    if (t == _i8l83u67.InvitationPreview) {
      return _i8l83u67.InvitationPreview.fromJson(data) as T;
    }
    if (t == _ifbgrtog.InvitationStatus) {
      return _ifbgrtog.InvitationStatus.fromJson(data) as T;
    }
    if (t == _ipp2ty4v.LiveSignal) {
      return _ipp2ty4v.LiveSignal.fromJson(data) as T;
    }
    if (t == _ibclxgv9.MediaVariant) {
      return _ibclxgv9.MediaVariant.fromJson(data) as T;
    }
    if (t == _iolegqnm.MemberStatus) {
      return _iolegqnm.MemberStatus.fromJson(data) as T;
    }
    if (t == _iwpqxdug.MemberView) {
      return _iwpqxdug.MemberView.fromJson(data) as T;
    }
    if (t == _i1hmtol2.MyProfile) {
      return _i1hmtol2.MyProfile.fromJson(data) as T;
    }
    if (t == _irt10kca.AppNotification) {
      return _irt10kca.AppNotification.fromJson(data) as T;
    }
    if (t == _iw4dnqzf.NotificationPage) {
      return _iw4dnqzf.NotificationPage.fromJson(data) as T;
    }
    if (t == _igc0nsfd.NotificationType) {
      return _igc0nsfd.NotificationType.fromJson(data) as T;
    }
    if (t == _i4ejzj19.ProgressUpdate) {
      return _i4ejzj19.ProgressUpdate.fromJson(data) as T;
    }
    if (t == _i0gnznij.ProgressUpdateDraft) {
      return _i0gnznij.ProgressUpdateDraft.fromJson(data) as T;
    }
    if (t == _ifiazq2p.Project) {
      return _ifiazq2p.Project.fromJson(data) as T;
    }
    if (t == _irbn6ip5.ProjectDetails) {
      return _irbn6ip5.ProjectDetails.fromJson(data) as T;
    }
    if (t == _i7o7d07j.ProjectMember) {
      return _i7o7d07j.ProjectMember.fromJson(data) as T;
    }
    if (t == _iy1z8w9e.ProjectOverview) {
      return _iy1z8w9e.ProjectOverview.fromJson(data) as T;
    }
    if (t == _i46wx1t7.ProjectRole) {
      return _i46wx1t7.ProjectRole.fromJson(data) as T;
    }
    if (t == _i7c3tk4z.ProjectSort) {
      return _i7c3tk4z.ProjectSort.fromJson(data) as T;
    }
    if (t == _iqsxbscs.ProjectStatus) {
      return _iqsxbscs.ProjectStatus.fromJson(data) as T;
    }
    if (t == _ivxocntb.ProjectSummary) {
      return _ivxocntb.ProjectSummary.fromJson(data) as T;
    }
    if (t == _i4o32k29.ProjectSummaryPage) {
      return _i4o32k29.ProjectSummaryPage.fromJson(data) as T;
    }
    if (t == _irluonl0.ProjectType) {
      return _irluonl0.ProjectType.fromJson(data) as T;
    }
    if (t == _idrjy6ic.ReviewDecision) {
      return _idrjy6ic.ReviewDecision.fromJson(data) as T;
    }
    if (t == _iz8v5x4v.Site) {
      return _iz8v5x4v.Site.fromJson(data) as T;
    }
    if (t == _ira79kry.SiteProposal) {
      return _ira79kry.SiteProposal.fromJson(data) as T;
    }
    if (t == _i8b5g94r.SiteProposalStatus) {
      return _i8b5g94r.SiteProposalStatus.fromJson(data) as T;
    }
    if (t == _igkbma1f.Stage) {
      return _igkbma1f.Stage.fromJson(data) as T;
    }
    if (t == _is1lynby.StageBrief) {
      return _is1lynby.StageBrief.fromJson(data) as T;
    }
    if (t == _i7mtby60.StageDraft) {
      return _i7mtby60.StageDraft.fromJson(data) as T;
    }
    if (t == _iwmsx3av.StagePlan) {
      return _iwmsx3av.StagePlan.fromJson(data) as T;
    }
    if (t == _ie5kygoh.StageReview) {
      return _ie5kygoh.StageReview.fromJson(data) as T;
    }
    if (t == _ibz5bd0v.StageReviewView) {
      return _ibz5bd0v.StageReviewView.fromJson(data) as T;
    }
    if (t == _iblg1lql.StageStatus) {
      return _iblg1lql.StageStatus.fromJson(data) as T;
    }
    if (t == _iobwm8xj.StageView) {
      return _iobwm8xj.StageView.fromJson(data) as T;
    }
    if (t == _iy88a0nt.UserSettings) {
      return _iy88a0nt.UserSettings.fromJson(data) as T;
    }
    if (t == _i92h88x8.VerificationCheck) {
      return _i92h88x8.VerificationCheck.fromJson(data) as T;
    }
    if (t == _io670pev.VerificationCheckName) {
      return _io670pev.VerificationCheckName.fromJson(data) as T;
    }
    if (t == _i5zqa56i.VerificationLevel) {
      return _i5zqa56i.VerificationLevel.fromJson(data) as T;
    }
    if (t == _ifjsehv5.Weather) {
      return _ifjsehv5.Weather.fromJson(data) as T;
    }
    if (t == _is.getType<_iczfg34g.ActivityEntry?>()) {
      return (data != null ? _iczfg34g.ActivityEntry.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_iwse5pgb.ActivityEvent?>()) {
      return (data != null ? _iwse5pgb.ActivityEvent.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_i8grwdd2.ActivityPage?>()) {
      return (data != null ? _i8grwdd2.ActivityPage.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_iorr0e24.ActivityType?>()) {
      return (data != null ? _iorr0e24.ActivityType.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_imu8gbx5.AppErrorCode?>()) {
      return (data != null ? _imu8gbx5.AppErrorCode.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_it4z223c.AppException?>()) {
      return (data != null ? _it4z223c.AppException.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_itixckla.AuditLog?>()) {
      return (data != null ? _itixckla.AuditLog.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ifywsnp6.ChecklistItem?>()) {
      return (data != null ? _ifywsnp6.ChecklistItem.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_iuwh2s2t.ChecklistItemDraft?>()) {
      return (data != null ? _iuwh2s2t.ChecklistItemDraft.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_iptmmm0p.Evidence?>()) {
      return (data != null ? _iptmmm0p.Evidence.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_it2d46ly.EvidenceCommit?>()) {
      return (data != null ? _it2d46ly.EvidenceCommit.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_i6593me7.EvidenceCommitResult?>()) {
      return (data != null
              ? _i6593me7.EvidenceCommitResult.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_itwc15qq.EvidenceStatus?>()) {
      return (data != null ? _itwc15qq.EvidenceStatus.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_ix00wubs.Invitation?>()) {
      return (data != null ? _ix00wubs.Invitation.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i8l83u67.InvitationPreview?>()) {
      return (data != null ? _i8l83u67.InvitationPreview.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_ifbgrtog.InvitationStatus?>()) {
      return (data != null ? _ifbgrtog.InvitationStatus.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_ipp2ty4v.LiveSignal?>()) {
      return (data != null ? _ipp2ty4v.LiveSignal.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ibclxgv9.MediaVariant?>()) {
      return (data != null ? _ibclxgv9.MediaVariant.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_iolegqnm.MemberStatus?>()) {
      return (data != null ? _iolegqnm.MemberStatus.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_iwpqxdug.MemberView?>()) {
      return (data != null ? _iwpqxdug.MemberView.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i1hmtol2.MyProfile?>()) {
      return (data != null ? _i1hmtol2.MyProfile.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_irt10kca.AppNotification?>()) {
      return (data != null ? _irt10kca.AppNotification.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_iw4dnqzf.NotificationPage?>()) {
      return (data != null ? _iw4dnqzf.NotificationPage.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_igc0nsfd.NotificationType?>()) {
      return (data != null ? _igc0nsfd.NotificationType.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_i4ejzj19.ProgressUpdate?>()) {
      return (data != null ? _i4ejzj19.ProgressUpdate.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_i0gnznij.ProgressUpdateDraft?>()) {
      return (data != null
              ? _i0gnznij.ProgressUpdateDraft.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_ifiazq2p.Project?>()) {
      return (data != null ? _ifiazq2p.Project.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_irbn6ip5.ProjectDetails?>()) {
      return (data != null ? _irbn6ip5.ProjectDetails.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_i7o7d07j.ProjectMember?>()) {
      return (data != null ? _i7o7d07j.ProjectMember.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_iy1z8w9e.ProjectOverview?>()) {
      return (data != null ? _iy1z8w9e.ProjectOverview.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_i46wx1t7.ProjectRole?>()) {
      return (data != null ? _i46wx1t7.ProjectRole.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i7c3tk4z.ProjectSort?>()) {
      return (data != null ? _i7c3tk4z.ProjectSort.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_iqsxbscs.ProjectStatus?>()) {
      return (data != null ? _iqsxbscs.ProjectStatus.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_ivxocntb.ProjectSummary?>()) {
      return (data != null ? _ivxocntb.ProjectSummary.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_i4o32k29.ProjectSummaryPage?>()) {
      return (data != null ? _i4o32k29.ProjectSummaryPage.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_irluonl0.ProjectType?>()) {
      return (data != null ? _irluonl0.ProjectType.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_idrjy6ic.ReviewDecision?>()) {
      return (data != null ? _idrjy6ic.ReviewDecision.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_iz8v5x4v.Site?>()) {
      return (data != null ? _iz8v5x4v.Site.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ira79kry.SiteProposal?>()) {
      return (data != null ? _ira79kry.SiteProposal.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i8b5g94r.SiteProposalStatus?>()) {
      return (data != null ? _i8b5g94r.SiteProposalStatus.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_igkbma1f.Stage?>()) {
      return (data != null ? _igkbma1f.Stage.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_is1lynby.StageBrief?>()) {
      return (data != null ? _is1lynby.StageBrief.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i7mtby60.StageDraft?>()) {
      return (data != null ? _i7mtby60.StageDraft.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_iwmsx3av.StagePlan?>()) {
      return (data != null ? _iwmsx3av.StagePlan.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ie5kygoh.StageReview?>()) {
      return (data != null ? _ie5kygoh.StageReview.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ibz5bd0v.StageReviewView?>()) {
      return (data != null ? _ibz5bd0v.StageReviewView.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_iblg1lql.StageStatus?>()) {
      return (data != null ? _iblg1lql.StageStatus.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_iobwm8xj.StageView?>()) {
      return (data != null ? _iobwm8xj.StageView.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_iy88a0nt.UserSettings?>()) {
      return (data != null ? _iy88a0nt.UserSettings.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i92h88x8.VerificationCheck?>()) {
      return (data != null ? _i92h88x8.VerificationCheck.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_io670pev.VerificationCheckName?>()) {
      return (data != null
              ? _io670pev.VerificationCheckName.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_i5zqa56i.VerificationLevel?>()) {
      return (data != null ? _i5zqa56i.VerificationLevel.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_ifjsehv5.Weather?>()) {
      return (data != null ? _ifjsehv5.Weather.fromJson(data) : null) as T;
    }
    if (t == Map<String, String>) {
      return (data as Map).map(
            (k, v) => MapEntry(deserialize<String>(k), deserialize<String>(v)),
          )
          as T;
    }
    if (t == _is.getType<Map<String, String>?>()) {
      return (data != null
              ? (data as Map).map(
                  (k, v) =>
                      MapEntry(deserialize<String>(k), deserialize<String>(v)),
                )
              : null)
          as T;
    }
    if (t == List<_iczfg34g.ActivityEntry>) {
      return (data as List)
              .map((e) => deserialize<_iczfg34g.ActivityEntry>(e))
              .toList()
          as T;
    }
    if (t == List<_i92h88x8.VerificationCheck>) {
      return (data as List)
              .map((e) => deserialize<_i92h88x8.VerificationCheck>(e))
              .toList()
          as T;
    }
    if (t == _is.getType<List<_i92h88x8.VerificationCheck>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i92h88x8.VerificationCheck>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_irt10kca.AppNotification>) {
      return (data as List)
              .map((e) => deserialize<_irt10kca.AppNotification>(e))
              .toList()
          as T;
    }
    if (t == List<_is1lynby.StageBrief>) {
      return (data as List)
              .map((e) => deserialize<_is1lynby.StageBrief>(e))
              .toList()
          as T;
    }
    if (t == _is.getType<List<_is1lynby.StageBrief>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_is1lynby.StageBrief>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_ivxocntb.ProjectSummary>) {
      return (data as List)
              .map((e) => deserialize<_ivxocntb.ProjectSummary>(e))
              .toList()
          as T;
    }
    if (t == List<_iuwh2s2t.ChecklistItemDraft>) {
      return (data as List)
              .map((e) => deserialize<_iuwh2s2t.ChecklistItemDraft>(e))
              .toList()
          as T;
    }
    if (t == List<_iobwm8xj.StageView>) {
      return (data as List)
              .map((e) => deserialize<_iobwm8xj.StageView>(e))
              .toList()
          as T;
    }
    if (t == List<_ifywsnp6.ChecklistItem>) {
      return (data as List)
              .map((e) => deserialize<_ifywsnp6.ChecklistItem>(e))
              .toList()
          as T;
    }
    if (t == List<_idpi4lil.ActivityType>) {
      return (data as List)
              .map((e) => deserialize<_idpi4lil.ActivityType>(e))
              .toList()
          as T;
    }
    if (t == _is.getType<List<_idpi4lil.ActivityType>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_idpi4lil.ActivityType>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_icm5mt5e.Evidence>) {
      return (data as List)
              .map((e) => deserialize<_icm5mt5e.Evidence>(e))
              .toList()
          as T;
    }
    if (t == List<_ikzhqv9e.Invitation>) {
      return (data as List)
              .map((e) => deserialize<_ikzhqv9e.Invitation>(e))
              .toList()
          as T;
    }
    if (t == List<_ig1yf1bz.MemberView>) {
      return (data as List)
              .map((e) => deserialize<_ig1yf1bz.MemberView>(e))
              .toList()
          as T;
    }
    if (t == List<_ieegu8zj.StageDraft>) {
      return (data as List)
              .map((e) => deserialize<_ieegu8zj.StageDraft>(e))
              .toList()
          as T;
    }
    if (t == _is.getType<List<_ieegu8zj.StageDraft>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_ieegu8zj.StageDraft>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_iarrohmg.SiteProposal>) {
      return (data as List)
              .map((e) => deserialize<_iarrohmg.SiteProposal>(e))
              .toList()
          as T;
    }
    if (t == List<int>) {
      return (data as List).map((e) => deserialize<int>(e)).toList() as T;
    }
    if (t == List<_i09iu71f.StageReviewView>) {
      return (data as List)
              .map((e) => deserialize<_i09iu71f.StageReviewView>(e))
              .toList()
          as T;
    }
    try {
      return _iais.Protocol().deserialize<T>(data, t);
    } on _is.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _iacs.Protocol().deserialize<T>(data, t);
    } on _is.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _isp.Protocol().deserialize<T>(data, t);
    } on _is.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _iczfg34g.ActivityEntry => 'ActivityEntry',
      _iwse5pgb.ActivityEvent => 'ActivityEvent',
      _i8grwdd2.ActivityPage => 'ActivityPage',
      _iorr0e24.ActivityType => 'ActivityType',
      _imu8gbx5.AppErrorCode => 'AppErrorCode',
      _it4z223c.AppException => 'AppException',
      _itixckla.AuditLog => 'AuditLog',
      _ifywsnp6.ChecklistItem => 'ChecklistItem',
      _iuwh2s2t.ChecklistItemDraft => 'ChecklistItemDraft',
      _iptmmm0p.Evidence => 'Evidence',
      _it2d46ly.EvidenceCommit => 'EvidenceCommit',
      _i6593me7.EvidenceCommitResult => 'EvidenceCommitResult',
      _itwc15qq.EvidenceStatus => 'EvidenceStatus',
      _ix00wubs.Invitation => 'Invitation',
      _i8l83u67.InvitationPreview => 'InvitationPreview',
      _ifbgrtog.InvitationStatus => 'InvitationStatus',
      _ipp2ty4v.LiveSignal => 'LiveSignal',
      _ibclxgv9.MediaVariant => 'MediaVariant',
      _iolegqnm.MemberStatus => 'MemberStatus',
      _iwpqxdug.MemberView => 'MemberView',
      _i1hmtol2.MyProfile => 'MyProfile',
      _irt10kca.AppNotification => 'AppNotification',
      _iw4dnqzf.NotificationPage => 'NotificationPage',
      _igc0nsfd.NotificationType => 'NotificationType',
      _i4ejzj19.ProgressUpdate => 'ProgressUpdate',
      _i0gnznij.ProgressUpdateDraft => 'ProgressUpdateDraft',
      _ifiazq2p.Project => 'Project',
      _irbn6ip5.ProjectDetails => 'ProjectDetails',
      _i7o7d07j.ProjectMember => 'ProjectMember',
      _iy1z8w9e.ProjectOverview => 'ProjectOverview',
      _i46wx1t7.ProjectRole => 'ProjectRole',
      _i7c3tk4z.ProjectSort => 'ProjectSort',
      _iqsxbscs.ProjectStatus => 'ProjectStatus',
      _ivxocntb.ProjectSummary => 'ProjectSummary',
      _i4o32k29.ProjectSummaryPage => 'ProjectSummaryPage',
      _irluonl0.ProjectType => 'ProjectType',
      _idrjy6ic.ReviewDecision => 'ReviewDecision',
      _iz8v5x4v.Site => 'Site',
      _ira79kry.SiteProposal => 'SiteProposal',
      _i8b5g94r.SiteProposalStatus => 'SiteProposalStatus',
      _igkbma1f.Stage => 'Stage',
      _is1lynby.StageBrief => 'StageBrief',
      _i7mtby60.StageDraft => 'StageDraft',
      _iwmsx3av.StagePlan => 'StagePlan',
      _ie5kygoh.StageReview => 'StageReview',
      _ibz5bd0v.StageReviewView => 'StageReviewView',
      _iblg1lql.StageStatus => 'StageStatus',
      _iobwm8xj.StageView => 'StageView',
      _iy88a0nt.UserSettings => 'UserSettings',
      _i92h88x8.VerificationCheck => 'VerificationCheck',
      _io670pev.VerificationCheckName => 'VerificationCheckName',
      _i5zqa56i.VerificationLevel => 'VerificationLevel',
      _ifjsehv5.Weather => 'Weather',
      _ => null,
    };
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;

    if (data is Map<String, dynamic> && data['__className__'] is String) {
      return (data['__className__'] as String).replaceFirst('plotwatch.', '');
    }

    switch (data) {
      case _iczfg34g.ActivityEntry():
        return 'ActivityEntry';
      case _iwse5pgb.ActivityEvent():
        return 'ActivityEvent';
      case _i8grwdd2.ActivityPage():
        return 'ActivityPage';
      case _iorr0e24.ActivityType():
        return 'ActivityType';
      case _imu8gbx5.AppErrorCode():
        return 'AppErrorCode';
      case _it4z223c.AppException():
        return 'AppException';
      case _itixckla.AuditLog():
        return 'AuditLog';
      case _ifywsnp6.ChecklistItem():
        return 'ChecklistItem';
      case _iuwh2s2t.ChecklistItemDraft():
        return 'ChecklistItemDraft';
      case _iptmmm0p.Evidence():
        return 'Evidence';
      case _it2d46ly.EvidenceCommit():
        return 'EvidenceCommit';
      case _i6593me7.EvidenceCommitResult():
        return 'EvidenceCommitResult';
      case _itwc15qq.EvidenceStatus():
        return 'EvidenceStatus';
      case _ix00wubs.Invitation():
        return 'Invitation';
      case _i8l83u67.InvitationPreview():
        return 'InvitationPreview';
      case _ifbgrtog.InvitationStatus():
        return 'InvitationStatus';
      case _ipp2ty4v.LiveSignal():
        return 'LiveSignal';
      case _ibclxgv9.MediaVariant():
        return 'MediaVariant';
      case _iolegqnm.MemberStatus():
        return 'MemberStatus';
      case _iwpqxdug.MemberView():
        return 'MemberView';
      case _i1hmtol2.MyProfile():
        return 'MyProfile';
      case _irt10kca.AppNotification():
        return 'AppNotification';
      case _iw4dnqzf.NotificationPage():
        return 'NotificationPage';
      case _igc0nsfd.NotificationType():
        return 'NotificationType';
      case _i4ejzj19.ProgressUpdate():
        return 'ProgressUpdate';
      case _i0gnznij.ProgressUpdateDraft():
        return 'ProgressUpdateDraft';
      case _ifiazq2p.Project():
        return 'Project';
      case _irbn6ip5.ProjectDetails():
        return 'ProjectDetails';
      case _i7o7d07j.ProjectMember():
        return 'ProjectMember';
      case _iy1z8w9e.ProjectOverview():
        return 'ProjectOverview';
      case _i46wx1t7.ProjectRole():
        return 'ProjectRole';
      case _i7c3tk4z.ProjectSort():
        return 'ProjectSort';
      case _iqsxbscs.ProjectStatus():
        return 'ProjectStatus';
      case _ivxocntb.ProjectSummary():
        return 'ProjectSummary';
      case _i4o32k29.ProjectSummaryPage():
        return 'ProjectSummaryPage';
      case _irluonl0.ProjectType():
        return 'ProjectType';
      case _idrjy6ic.ReviewDecision():
        return 'ReviewDecision';
      case _iz8v5x4v.Site():
        return 'Site';
      case _ira79kry.SiteProposal():
        return 'SiteProposal';
      case _i8b5g94r.SiteProposalStatus():
        return 'SiteProposalStatus';
      case _igkbma1f.Stage():
        return 'Stage';
      case _is1lynby.StageBrief():
        return 'StageBrief';
      case _i7mtby60.StageDraft():
        return 'StageDraft';
      case _iwmsx3av.StagePlan():
        return 'StagePlan';
      case _ie5kygoh.StageReview():
        return 'StageReview';
      case _ibz5bd0v.StageReviewView():
        return 'StageReviewView';
      case _iblg1lql.StageStatus():
        return 'StageStatus';
      case _iobwm8xj.StageView():
        return 'StageView';
      case _iy88a0nt.UserSettings():
        return 'UserSettings';
      case _i92h88x8.VerificationCheck():
        return 'VerificationCheck';
      case _io670pev.VerificationCheckName():
        return 'VerificationCheckName';
      case _i5zqa56i.VerificationLevel():
        return 'VerificationLevel';
      case _ifjsehv5.Weather():
        return 'Weather';
    }
    className = _iais.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_auth_idp.$className';
    }
    className = _iacs.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_auth_core.$className';
    }
    className = _isp.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.') ? className : 'serverpod.$className';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'ActivityEntry') {
      return deserialize<_iczfg34g.ActivityEntry>(data['data']);
    }
    if (dataClassName == 'ActivityEvent') {
      return deserialize<_iwse5pgb.ActivityEvent>(data['data']);
    }
    if (dataClassName == 'ActivityPage') {
      return deserialize<_i8grwdd2.ActivityPage>(data['data']);
    }
    if (dataClassName == 'ActivityType') {
      return deserialize<_iorr0e24.ActivityType>(data['data']);
    }
    if (dataClassName == 'AppErrorCode') {
      return deserialize<_imu8gbx5.AppErrorCode>(data['data']);
    }
    if (dataClassName == 'AppException') {
      return deserialize<_it4z223c.AppException>(data['data']);
    }
    if (dataClassName == 'AuditLog') {
      return deserialize<_itixckla.AuditLog>(data['data']);
    }
    if (dataClassName == 'ChecklistItem') {
      return deserialize<_ifywsnp6.ChecklistItem>(data['data']);
    }
    if (dataClassName == 'ChecklistItemDraft') {
      return deserialize<_iuwh2s2t.ChecklistItemDraft>(data['data']);
    }
    if (dataClassName == 'Evidence') {
      return deserialize<_iptmmm0p.Evidence>(data['data']);
    }
    if (dataClassName == 'EvidenceCommit') {
      return deserialize<_it2d46ly.EvidenceCommit>(data['data']);
    }
    if (dataClassName == 'EvidenceCommitResult') {
      return deserialize<_i6593me7.EvidenceCommitResult>(data['data']);
    }
    if (dataClassName == 'EvidenceStatus') {
      return deserialize<_itwc15qq.EvidenceStatus>(data['data']);
    }
    if (dataClassName == 'Invitation') {
      return deserialize<_ix00wubs.Invitation>(data['data']);
    }
    if (dataClassName == 'InvitationPreview') {
      return deserialize<_i8l83u67.InvitationPreview>(data['data']);
    }
    if (dataClassName == 'InvitationStatus') {
      return deserialize<_ifbgrtog.InvitationStatus>(data['data']);
    }
    if (dataClassName == 'LiveSignal') {
      return deserialize<_ipp2ty4v.LiveSignal>(data['data']);
    }
    if (dataClassName == 'MediaVariant') {
      return deserialize<_ibclxgv9.MediaVariant>(data['data']);
    }
    if (dataClassName == 'MemberStatus') {
      return deserialize<_iolegqnm.MemberStatus>(data['data']);
    }
    if (dataClassName == 'MemberView') {
      return deserialize<_iwpqxdug.MemberView>(data['data']);
    }
    if (dataClassName == 'MyProfile') {
      return deserialize<_i1hmtol2.MyProfile>(data['data']);
    }
    if (dataClassName == 'AppNotification') {
      return deserialize<_irt10kca.AppNotification>(data['data']);
    }
    if (dataClassName == 'NotificationPage') {
      return deserialize<_iw4dnqzf.NotificationPage>(data['data']);
    }
    if (dataClassName == 'NotificationType') {
      return deserialize<_igc0nsfd.NotificationType>(data['data']);
    }
    if (dataClassName == 'ProgressUpdate') {
      return deserialize<_i4ejzj19.ProgressUpdate>(data['data']);
    }
    if (dataClassName == 'ProgressUpdateDraft') {
      return deserialize<_i0gnznij.ProgressUpdateDraft>(data['data']);
    }
    if (dataClassName == 'Project') {
      return deserialize<_ifiazq2p.Project>(data['data']);
    }
    if (dataClassName == 'ProjectDetails') {
      return deserialize<_irbn6ip5.ProjectDetails>(data['data']);
    }
    if (dataClassName == 'ProjectMember') {
      return deserialize<_i7o7d07j.ProjectMember>(data['data']);
    }
    if (dataClassName == 'ProjectOverview') {
      return deserialize<_iy1z8w9e.ProjectOverview>(data['data']);
    }
    if (dataClassName == 'ProjectRole') {
      return deserialize<_i46wx1t7.ProjectRole>(data['data']);
    }
    if (dataClassName == 'ProjectSort') {
      return deserialize<_i7c3tk4z.ProjectSort>(data['data']);
    }
    if (dataClassName == 'ProjectStatus') {
      return deserialize<_iqsxbscs.ProjectStatus>(data['data']);
    }
    if (dataClassName == 'ProjectSummary') {
      return deserialize<_ivxocntb.ProjectSummary>(data['data']);
    }
    if (dataClassName == 'ProjectSummaryPage') {
      return deserialize<_i4o32k29.ProjectSummaryPage>(data['data']);
    }
    if (dataClassName == 'ProjectType') {
      return deserialize<_irluonl0.ProjectType>(data['data']);
    }
    if (dataClassName == 'ReviewDecision') {
      return deserialize<_idrjy6ic.ReviewDecision>(data['data']);
    }
    if (dataClassName == 'Site') {
      return deserialize<_iz8v5x4v.Site>(data['data']);
    }
    if (dataClassName == 'SiteProposal') {
      return deserialize<_ira79kry.SiteProposal>(data['data']);
    }
    if (dataClassName == 'SiteProposalStatus') {
      return deserialize<_i8b5g94r.SiteProposalStatus>(data['data']);
    }
    if (dataClassName == 'Stage') {
      return deserialize<_igkbma1f.Stage>(data['data']);
    }
    if (dataClassName == 'StageBrief') {
      return deserialize<_is1lynby.StageBrief>(data['data']);
    }
    if (dataClassName == 'StageDraft') {
      return deserialize<_i7mtby60.StageDraft>(data['data']);
    }
    if (dataClassName == 'StagePlan') {
      return deserialize<_iwmsx3av.StagePlan>(data['data']);
    }
    if (dataClassName == 'StageReview') {
      return deserialize<_ie5kygoh.StageReview>(data['data']);
    }
    if (dataClassName == 'StageReviewView') {
      return deserialize<_ibz5bd0v.StageReviewView>(data['data']);
    }
    if (dataClassName == 'StageStatus') {
      return deserialize<_iblg1lql.StageStatus>(data['data']);
    }
    if (dataClassName == 'StageView') {
      return deserialize<_iobwm8xj.StageView>(data['data']);
    }
    if (dataClassName == 'UserSettings') {
      return deserialize<_iy88a0nt.UserSettings>(data['data']);
    }
    if (dataClassName == 'VerificationCheck') {
      return deserialize<_i92h88x8.VerificationCheck>(data['data']);
    }
    if (dataClassName == 'VerificationCheckName') {
      return deserialize<_io670pev.VerificationCheckName>(data['data']);
    }
    if (dataClassName == 'VerificationLevel') {
      return deserialize<_i5zqa56i.VerificationLevel>(data['data']);
    }
    if (dataClassName == 'Weather') {
      return deserialize<_ifjsehv5.Weather>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _iais.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _iacs.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod.')) {
      data['className'] = dataClassName.substring(10);
      return _isp.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

  void _registerHostProtocols() {
    _iais.Protocol().registerHostProtocol('plotwatch', this);
    _iacs.Protocol().registerHostProtocol('plotwatch', this);
  }

  @override
  _is.Table? getTableForType(Type t) {
    {
      var table = _iais.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    {
      var table = _iacs.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    {
      var table = _isp.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    switch (t) {
      case _iwse5pgb.ActivityEvent:
        return _iwse5pgb.ActivityEvent.t;
      case _itixckla.AuditLog:
        return _itixckla.AuditLog.t;
      case _ifywsnp6.ChecklistItem:
        return _ifywsnp6.ChecklistItem.t;
      case _iptmmm0p.Evidence:
        return _iptmmm0p.Evidence.t;
      case _ix00wubs.Invitation:
        return _ix00wubs.Invitation.t;
      case _irt10kca.AppNotification:
        return _irt10kca.AppNotification.t;
      case _i4ejzj19.ProgressUpdate:
        return _i4ejzj19.ProgressUpdate.t;
      case _ifiazq2p.Project:
        return _ifiazq2p.Project.t;
      case _i7o7d07j.ProjectMember:
        return _i7o7d07j.ProjectMember.t;
      case _iz8v5x4v.Site:
        return _iz8v5x4v.Site.t;
      case _ira79kry.SiteProposal:
        return _ira79kry.SiteProposal.t;
      case _igkbma1f.Stage:
        return _igkbma1f.Stage.t;
      case _ie5kygoh.StageReview:
        return _ie5kygoh.StageReview.t;
      case _iy88a0nt.UserSettings:
        return _iy88a0nt.UserSettings.t;
    }
    return null;
  }

  @override
  List<_isp.TableDefinition> getTargetTableDefinitions() =>
      targetTableDefinitions;

  @override
  String getModuleName() => 'plotwatch';

  /// Maps any `Record`s known to this [Protocol] to their JSON representation
  ///
  /// Throws in case the record type is not known.
  ///
  /// This method will return `null` (only) for `null` inputs.
  Map<String, dynamic>? mapRecordToJson(Record? record) {
    if (record == null) {
      return null;
    }
    try {
      return _iais.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _iacs.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
