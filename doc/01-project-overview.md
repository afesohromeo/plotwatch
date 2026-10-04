# Project Overview

> **Status:** Draft v0.1, awaiting review
> **Date:** 2026-10-03
> **Product name:** **Plotwatch** (chosen 2026-10-04). "The platform" in this document means Plotwatch.
> **Related documents:** [02-requirements-specification.md](02-requirements-specification.md) · [03-mvp-scope.md](03-mvp-scope.md) · [00-project-context.md](00-project-context.md)

---

## 1. Summary

Plotwatch lets people fund construction projects they cannot supervise in person, and know what they are paying for.

The person funding the build sets up the project as a series of stages, each with its own budget. The person on site documents progress through **verified captures**: photos and videos taken only with the in-app camera, tied to the plot's GPS location, timestamped by the server and fingerprinted so later edits can be detected. The funder reviews each stage against this evidence and releases money one stage at a time. Every payment, expense and receipt goes into a shared ledger, so at any moment both sides can see what was planned, what was paid, what was spent, and what is still unaccounted for.

It is a full-stack product: a **Flutter** app for mobile and web, a **Serverpod** backend, and a **PostgreSQL** database.

---

## 2. The problem

### 2.1 The situation
Millions of people pay for construction they cannot watch:
- **People working abroad** building a family house, a rental property or a retirement home in their home country.
- **People working in a city** building in their home town or village.
- **NGOs, churches and donors** funding schools, clinics, wells and community buildings far from where they are based.
- **Small investors and landlords** renovating or building property remotely.

In each case the money flows one way: from the funder to someone on site, usually a relative, a friend, a contractor or a foreman. Information flows back mostly through WhatsApp photos, phone calls and promises.

### 2.2 What goes wrong
Articles from Kenya, Nigeria, Nepal, Jamaica and elsewhere describe the same failure patterns again and again:

| Pattern | What happens |
|---------|--------------|
| **Ghost progress** | Photos are staged, reused or framed to suggest more work than was done. Sometimes they show a different building entirely. |
| **The vanishing advance** | A large upfront payment is followed by slow or stopped work. |
| **Quantity inflation** | The funder is billed for more materials than were used. |
| **Material substitution** | Cheaper materials are delivered than were billed. |
| **Variation harvesting** | A low initial quote is recovered later through "unavoidable" extras. |
| **Diverted funds** | Building money is spent on other things: vehicles, businesses, living expenses. |

Typical outcome: after years of sending money, the funder visits and finds an abandoned foundation or a building far behind what they were told.

These guides note that the people involved are often *not* dishonest at the start. The setup gives nobody a way to stay accountable: no contract, no independent verification, and no separation between whoever reports the progress and whoever receives the money.

### 2.3 Why existing solutions fall short
| Current approach | Limitation |
|------------------|------------|
| WhatsApp photos and calls | Anyone can resend an old photo or one from another site. There is no structure, no audit trail and no link between money and progress. |
| Relying on family | Trust is personal, not verifiable, and disputes damage relationships. |
| Travelling to inspect | Expensive, infrequent, and only shows one moment in time. |
| Diaspora construction companies (e.g. DiasporaBuild, HoDiaspora, GURI Build) | They solve the problem by selling *their own* contractors and inspectors. The funder trades one form of trust for another, usually at a premium, and can't use them with the builder they already have. |
| Generic construction management software | Designed for professional firms on site, not for a remote funder who needs proof. They don't verify where or when a photo was taken. |

### 2.4 Evidence the problem is real
- Companies already sell diaspora construction oversight as a service. That proves people will pay for it.
- Diaspora real-estate and construction media publish guides on construction fraud for specific countries.
- How much of the money sent home goes into housing varies a lot by country (from under 1% to about 20% in published estimates; 2.6% of recipient households in Kenya's 2025 survey). The diaspora segment alone is a niche in each country. That's why the platform targets **anyone funding a build remotely**, not only people abroad.

Sources are listed in [00-project-context.md §5](00-project-context.md#5-market-research-findings).

---

## 3. The solution

### 3.1 Core idea
**Make progress provable and tie money to proof.**

Three mechanisms work together:

1. **Verified capture.** Evidence can only come from the in-app camera. Each capture records GPS position and accuracy, whether it was taken inside the plot's boundary, the device time and the server time, and a cryptographic fingerprint (hash) of the file. Each capture gets a clear verification badge (Verified / Partially verified / Unverified) and the reasons for it. Old photos, gallery images and photos taken elsewhere can't pass as new progress.

2. **Stage-based funding.** The build is broken into stages (e.g. foundation, walls, roofing), each with a budget and a checklist of evidence it requires. The site manager submits a stage for review. The funder approves it or asks for changes. Money is released one stage at a time, not as one large advance.

3. **A shared ledger.** Every fund release, expense and receipt is recorded. For each stage and for the whole project, both parties see the planned budget, the money released, the money spent with receipts, and the gap between them. The gap is the number that shows misuse early.

### 3.2 How it works: main user journey
1. **Set up.** The funder creates a project, sets the plot's location (map pin or Plus Code) and boundary radius, chooses a currency, and builds a list of stages, starting from a template or from scratch.
2. **Invite.** The funder invites the site manager by link or code. The site manager joins on their phone.
3. **Document.** On site, the site manager posts progress updates using verified captures, logs expenses with photographed receipts, and requests funds for upcoming work.
4. **Monitor.** The funder sees a live activity feed, the verification status of each capture, and progress compared with the budget.
5. **Spot-check.** At any time the funder can send an evidence request ("show me the north wall now"). The site manager must answer with a fresh verified capture within the deadline. This makes staging fake progress much harder.
6. **Review and release.** When a stage is submitted, the funder reviews the evidence against the stage checklist. They approve it and record the fund release, or request changes with comments.
7. **Share.** Any verified capture or stage can be shared through a public verification link, for family members, co-investors or an NGO's donors.

### 3.3 Users and roles
| Role | Who | Main needs |
|------|-----|------------|
| **Funder (owner)** | Person or organization paying for the build | See real progress, control when money is released, catch problems early |
| **Co-funder / viewer** | Spouse, family members, co-investors, donors | Follow progress; sometimes share approval rights |
| **Site manager** | Contractor, foreman, or the relative managing the site | Prove their work, get paid promptly, avoid disputes |
| **Inspector** *(future)* | Independent engineer or verifier | Paid visits; certify stages formally |
| **Organization admin** *(future)* | NGO, developer or contractor firm | Manage many projects and team members; report to donors |
| **Platform admin** | Operator of the platform | Moderation, support, inspector vetting, disputes |

**The site manager benefits too.** An honest contractor gets a verifiable record that protects them from false accusations and gets them paid faster. This matters for adoption: the product must not feel like surveillance to them.

### 3.4 What makes it different
1. **Verification technology instead of hired supervisors.** It works with the builder the funder already trusts, or half-trusts, at a fraction of the cost of an oversight service.
2. **Money tied to proof.** Stages, evidence and payments are linked in one model, not spread across chat apps and notebooks.
3. **Live evidence requests.** On-demand spot checks are a strong deterrent against staged progress.
4. **Shareable proof.** Anyone can check a public verification link without an account.
5. **Built for low bandwidth.** Fingerprint and metadata are sent first, which gives a server timestamp immediately; the heavy file uploads afterwards. Captures queue when the site has no signal.
6. **Multilingual and multi-currency** from the start (English and French first).

---

## 4. Objectives

### 4.1 Product objectives
| # | Objective | How we measure it |
|---|-----------|-------------------|
| O1 | Make it hard to fake construction progress | Share of captures that reach "Verified"; fraud patterns the system can detect (reused photos, wrong location, delayed uploads) |
| O2 | Tie every unit of money to evidence | Share of released funds backed by approved stages and receipts |
| O3 | Be usable by non-technical site managers on low-end Android phones | Time to complete a first progress update; completion rate of evidence requests |
| O4 | Give funders peace of mind without travelling | Weekly active funders; retention through a full build |
| O5 | Become the system of record for a building | Projects that continue into the maintenance phase (future) |

### 4.2 Hackathon objectives (Serverpod 4 hackathon, deadline 2026-10-14)
1. Ship a working Flutter + Serverpod MVP, deployed on Serverpod Cloud.
2. Show a complete loop: project → stages → verified capture → review → fund release recorded → ledger updated in real time.
3. Use Serverpod's strengths visibly: typed endpoints, ORM and relations, authentication, file uploads, real-time streaming, scheduled tasks (future calls).
4. Produce a demo video of 3 minutes or less, a project description and a public repository.
5. Build it so it keeps evolving after the hackathon (clean architecture, tests, documentation).

---

## 5. Scope at a glance

| Area | MVP (hackathon) | After the hackathon |
|------|-----------------|---------------------|
| Projects, stages, templates | ✅ | Gantt-style schedules, dependencies |
| Verified capture (photo) | ✅ | Video, audio notes, device attestation, C2PA credentials |
| Stage review and approval | ✅ | Multiple approvers, approval rules |
| Ledger (recorded releases and expenses) | ✅ | Real payments: escrow, mobile money, bank |
| Evidence requests (spot checks) | ✅ *(should have)* | Random automatic spot checks |
| Real-time activity feed | ✅ | Digest emails, push notifications |
| Public verification link | ✅ *(stretch)* | Donor portals |
| Offline capture queue | ✅ *(stretch)* | Full offline mode |
| Inspectors marketplace | ❌ | ✅ |
| AI (progress summaries, receipt reading, anomaly detection) | ❌ | ✅ |
| Organizations / multi-project dashboards | ❌ | ✅ |
| Maintenance history after completion | ❌ | ✅ |

The detailed list is in [03-mvp-scope.md](03-mvp-scope.md); the full feature set is in [02-requirements-specification.md](02-requirements-specification.md).

---

## 6. Technology

| Layer | Technology |
|-------|------------|
| Client | One Flutter codebase, built as a **mobile app** (Android, iOS) and a **web app** (see §6.1) |
| Backend | Serverpod 4 (Dart) |
| Database | PostgreSQL, through the Serverpod ORM |
| File storage | Serverpod-managed cloud storage for photos, videos and receipts |
| Real-time | Serverpod streaming endpoints |
| Scheduled jobs | Serverpod future calls (reminders, evidence-request deadlines) |
| Hosting | Serverpod Cloud |
| Localization | English and French (flutter_localizations + intl) |

### 6.1 Platforms
We write the client once in Flutter and build it into two kinds of app. Both connect to the same backend and show the same data.

**Mobile app (Android and iOS)**
- **Who uses it:** site managers (required) and funders (optional).
- **Site managers must use the mobile app**, because capturing evidence needs the phone's camera and GPS.
- **Android is the priority:** most site managers are likely to have Android phones, often low- to mid-range ones. The iOS app is built from the same code.
- **Funders** can do everything on the mobile app: dashboard, reviews, approvals, ledger, notifications.

**Web app (in a browser, nothing to install)**
- **Who uses it:** funders, co-funders and viewers, typically on a laptop.
- **What it does:** everything **except capturing evidence**, because a browser can't reliably give us verified camera and GPS data.
- **Why it matters:** family members, co-investors or donors can follow a project without installing anything, and funders get a bigger screen for reviewing photos and the ledger.

**For the hackathon:** the Android app and the web app are built and tested. The iOS app compiles from the same code but is only tested if a Mac and iPhone are available. *(Decision D-4, approved 2026-10-03.)*

The architecture is broken down in detail in [02-requirements-specification.md §6](02-requirements-specification.md#6-system-architecture).

---

## 7. Business model (after the hackathon)

| Revenue stream | Description |
|----------------|-------------|
| Subscription per project | Free tier for one small project; paid tiers by project size or duration |
| Organization plans | NGOs, developers and contractor firms managing many projects |
| Inspection fees | Commission on inspector visits booked through the platform |
| Escrow / payment fees | Small percentage on funds released through integrated payments (requires a licensed partner) |
| Verification API | Businesses (insurers, lenders, logistics) use the verified-capture technology on its own |

---

## 8. Roadmap

| Phase | Focus |
|-------|-------|
| **Phase 0: MVP** (until 2026-10-14) | The core loop described in §3.2, deployed, demo video |
| **Phase 1: Pilot** | Real users (starting with the contact from our research), push notifications, offline mode, PDF reports, polish |
| **Phase 2: Trust** | Device attestation, C2PA content credentials, inspectors marketplace, AI anomaly detection |
| **Phase 3: Money** | Escrow and payment integrations with licensed partners, contracts |
| **Phase 4: Lifecycle** | Maintenance history after handover, organization accounts, verification API |

---

## 9. Key risks

| Risk | Mitigation |
|------|------------|
| Site managers see the app as surveillance and refuse to use it | Present it as protection and faster payment for them; keep the app simple and respectful |
| Poor network on site | Fingerprint and metadata sent first, compressed uploads, offline queue |
| GPS spoofing / fake locations | Detect mock locations, check GPS accuracy, detect reused photos; device attestation later |
| Small audience in each country | Target every remote funder, not only the diaspora; multilingual from the start |
| Competitors offering oversight as a service | Our model (technology on top of the funder's own builder) is cheaper and can partner with them rather than compete |
| Liability when "verified" progress turns out to be bad work | Verification proves *when and where* a photo was taken, not construction quality; say this clearly in the app; inspectors later |
| Payments regulation | No real money movement in the MVP; only record-keeping; licensed partners later |
