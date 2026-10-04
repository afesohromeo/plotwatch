# Plotwatch: Agent Instructions

Serverpod 4 hackathon project: a Flutter + Serverpod app that lets people fund construction they can't supervise in person, through verified photo evidence, stage-based approvals and a shared ledger.

---

## Start here
All project documentation is in [`doc/`](doc/). **Read [`doc/00-project-context.md`](doc/00-project-context.md) first.** It holds the decision history, research, current status and next steps, and links to the other documents:

- `doc/01-project-overview.md`: problem, solution, objectives
- `doc/02-requirements-specification.md`: full requirements and architecture
- `doc/03-mvp-scope.md`: what we build for the hackathon (deadline: before 2026-10-14)

---

## Engineering standards (binding)
All Flutter code must follow [`_standards/`](_standards/README.md). Start with `README.md` and `10_ai_agent_guide.md`, and check `09_normalization_rules.md` before proposing code. In short: Clean Architecture + flutter_bloc (BLoC pattern, Freezed), `ResponsiveScaffoldWrapper` on every page, GoRouter named routes, no hardcoded text, infinite-scroll pagination.

For this Serverpod project, **`_standards/14_serverpod_adaptation.md` overrides files 01–13 where stated** (generated models, error codes, page models, server-side conventions).

**Precedence when guidance conflicts:** `_standards/` (with 14 on top) **>** project docs in `doc/` **>** skills in `.claude/skills/` **>** generic best practices.

---

## How to work on this project
- **Documentation first.** For every feature or fix: present the plan, wait for approval, save the approved plan in `doc/`, then implement.
- **Don't fast-track.** Decisions marked pending in `doc/03-mvp-scope.md §7` need the user's approval.
- **TDD:** no production code without a failing test first. Permissions are enforced and tested on the server.
- **Evidence before claims:** run tests/builds and read the output before saying something works.
- Keep `doc/00-project-context.md` up to date when decisions are made or milestones are reached.

---

## MCP servers
Registered for this folder in the user's local Claude Code config (not in the repo, because the stitch entry contains an API key).

| Server | Purpose |
|--------|---------|
| **dart** | Dart/Flutter tooling: analysis, pub, tests, running apps. Registered as `cmd /c dart mcp-server` because `dart` is a `.bat` on Windows. |
| **stitch** | Google Stitch: AI-generated UI screens and design systems |

Prefer MCP tools over shell commands when they overlap.

---

## Agent tooling
`.claude/skills/` and `.claude/knowledge/` are installed locally and **not committed** (gitignored): they are third-party content, and the hackathon requires the submission to be the entrant's own work. Only this file and `.claude/settings.json` are in the repository. A fresh clone needs the skills reinstalled from their sources:

| Skill set | Source |
|-----------|--------|
| Superpowers | [obra/superpowers](https://github.com/obra/superpowers) |
| Stitch | Google Stitch skill set, [google-labs-code/stitch-skills](https://github.com/google-labs-code/stitch-skills) |
| Flutter | Flutter skill set, [flutter/skills](https://github.com/flutter/skills) |

All three were copied from PlusLocate on 2026-10-03. The Stitch and Flutter upstream repositories were identified afterwards; the copies don't record their exact source.

---

## Skills
Skills live in `.claude/skills/` (copied from PlusLocate on 2026-10-03). Before a task, check whether a skill applies and read its `SKILL.md`, **but apply the precedence rule above**: where a skill contradicts `_standards/` or this project's decisions, follow the standards. Known conflicts are noted in the tables.

### Superpowers (`.claude/skills/superpowers/`)
| Skill | When to use | Project note |
|-------|-------------|--------------|
| brainstorming | Before creative work (features, components) | Save specs in **`doc/`**, not `docs/superpowers/specs/` |
| writing-plans | After spec approval, before code | Plans go in **`doc/`** (e.g. `doc/04-implementation-plan.md`) |
| executing-plans | Executing plans with review checkpoints | |
| subagent-driven-development | Executing plans with a fresh subagent per task | |
| test-driven-development | Before writing any implementation code | |
| systematic-debugging | Any bug, test failure or unexpected behaviour | |
| verification-before-completion | Before claiming work is complete | |
| requesting-code-review / receiving-code-review | After tasks / when receiving feedback | |
| using-git-worktrees | Feature work needing isolation | |
| finishing-a-development-branch | When implementation is complete | |
| dispatching-parallel-agents | 2+ independent tasks | |
| writing-skills | Creating or editing skills | |

### Flutter (`.claude/skills/flutter/`)
| Skill | When to use | Project note |
|-------|-------------|--------------|
| flutter-apply-architecture-best-practices | Structuring code | ⚠️ **Overridden:** teaches MVVM/ViewModels. Use `_standards/01`, `02`, `14` (Clean Architecture + BLoC). |
| flutter-build-responsive-layout | Adaptive UI | Use within `ResponsiveScaffoldWrapper` / `ResponsiveLayout` (`_standards/06`) |
| flutter-fix-layout-issues | Overflow / constraint errors | |
| flutter-add-widget-test | Widget tests | |
| flutter-add-integration-test | Integration tests / user flows | |
| flutter-add-widget-preview | Widget previews | |
| flutter-implement-json-serialization | JSON ↔ models | ⚠️ **Mostly not applicable:** shared models are generated by Serverpod (`_standards/14 §1`) |
| flutter-setup-declarative-routing | go_router setup | Follow `_standards/07` (named routes, auth guard, `NoTransitionPage`) |
| flutter-setup-localization | i18n setup | Follow `_standards/12` (ARB location, `LocalizationService`, workflow) |
| flutter-use-http-package | REST calls | ⚠️ **Not applicable:** the app talks to the backend through the generated Serverpod client (`_standards/14 §2`) |

### Stitch (`.claude/skills/stitch/`), needs the stitch MCP server
| Skill | When to use |
|-------|-------------|
| stitch-design | Main entry point: generate/edit screens, prompt enhancement, DESIGN.md |
| taste-design | Premium DESIGN.md with strict typography standards |
| design-md | Synthesize DESIGN.md from an existing Stitch project |
| enhance-prompt | Turn vague UI ideas into Stitch-ready prompts |
| stitch-loop | Multi-page iterative generation |
| react-components / shadcn-ui / remotion | Web/React and video tooling (not used by this Flutter project unless decided otherwise) |

**Stitch rules:** enhance prompts before generating; check for `.stitch/DESIGN.md` first; prefer editing screens over regenerating. **This project has no Stitch project yet.** Create a new one when UI design starts and save its `.stitch/metadata.json`. Don't reuse PlusLocate's Stitch project.

Consolidated skill overviews: `.claude/knowledge/{superpowers,flutter,stitch}-skills/artifacts/skills-reference.md`.
