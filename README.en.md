# mattpocock-skills-dsh

[![npm version](https://img.shields.io/npm/v/mattpocock-skills-dsh)](https://www.npmjs.com/package/mattpocock-skills-dsh)
[![GitHub release](https://img.shields.io/github/v/release/gongyijie85/mattpocock-skills-dsh)](https://github.com/gongyijie85/mattpocock-skills-dsh/releases)
[![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)

Matt Pocock's skills for the **DeepSeek Harness (DSH)** — the full promoted set
of [mattpocock/skills](https://github.com/mattpocock/skills) (the "real
engineering" skill collection behind [aihero.dev/skills](https://www.aihero.dev/skills)),
ported to DSH's Cordis plugin architecture.

The plugin registers a skill provider on the **host layer** of the `ctx.skills`
registry, so every agent preset's scope chain merges these skills. Skill bodies
ship inside the package (`skills/<name>/SKILL.md`) and are located via
`import.meta.url` — an assembly fact of the package, never user config.

> **Unofficial port**: skill content adapted from
> [mattpocock/skills](https://github.com/mattpocock/skills) (MIT, © Matt Pocock).
> Upstream ships as a Claude Code plugin; this package is the DSH adaptation.

## Quick start: the seven-lesson workflow

> From Matt Pocock's skills email — the intended way to use this pack is to run
> this workflow end to end. `Sandcastle` is an external tool, not part of this
> package.

> Prompts are disposable. Workflows are reusable. That is the whole
> difference, and these seven lessons are one workflow in the order you
> would actually run it:

| Step | Original | Translation |
| --- | --- | --- |
| 0 | This email. Pick your path. | Pick a path from this email. |
| 1 | `/grill-with-docs`, so the agent is not building from fog | Grill the idea first so the agent isn't building from fog |
| 2 | `/prototype` and `/handoff`, to test the uncertain part in a toy version | Test the uncertain part in a toy version, with a handoff |
| 3 | `/to-spec` and `/to-tickets`, to break big work into reviewable slices | Break big work into reviewable slices |
| 4 | `Sandcastle`, to run AFK agents somewhere safe | Run AFK agents somewhere safe (external tool, not in this pack) |
| 5 | `/code-review`, so each run teaches the next one | Each review teaches the next run |
| 6 | The full loop, start to finish | Run the full loop, start to finish |

## Install & use in DeepSeek Harness

This is a DeepSeek Harness **plugin bundle**. After installing, the skills are
registered in the host skill registry; every agent session in your profile can
see them in the skill catalog and load them with the `skill` tool.

### Prerequisites

- DeepSeek Harness installed, with **pnpm** — the `dsh plugin` command shells
  out to pnpm (check with `pnpm --version`; install from https://pnpm.io)
- The `dsh` CLI. It ships with the Harness, usually started via
  `npx @deepseek-ai/dsh web`. Either install it globally or prefix every
  command with `npx`:

  ```sh
  # Option 1: global install (recommended)
  npm install -g @deepseek-ai/dsh
  dsh --version

  # Option 2: no install, use npx everywhere
  npx @deepseek-ai/dsh --version
  ```

  Every `dsh ...` example below is equivalent to `npx @deepseek-ai/dsh ...`.

### One command, from GitHub

```sh
npx @deepseek-ai/dsh plugin --profile web add github:gongyijie85/mattpocock-skills-dsh
```

### From npm

```sh
dsh plugin --profile web add mattpocock-skills-dsh
```

### From a local folder (development)

```sh
# Folder installs are linked: edits take effect on the next profile restart
dsh plugin --profile web add D:\plugins\mattpocock-skills-dsh
```

### Let DeepSeek Harness install it for you

Open the DeepSeek Harness web UI, start a new conversation, and send:

```
Install the plugin from this link: https://github.com/gongyijie85/mattpocock-skills-dsh
```

The agent will run `dsh plugin add` → restart the profile → verify skill
registration for you.

### Restart and verify

The bundle layer mounts at profile startup, so **restart the profile** (stop
and re-run `dsh web` / `npx @deepseek-ai/dsh web`, then refresh the browser).
Confirm the layer composed:

```sh
dsh --profile web --dump-config     # must contain a `mattpocock-skills-dsh` row
```

The skills then appear in the agent skill catalog, loadable with the `skill`
tool.

### Uninstall

```sh
dsh plugin --profile web remove mattpocock-skills-dsh
# restart the profile afterwards
```

## Skills (full 25 = the upstream promoted set)

### productivity (7)

| Skill | Purpose (official descriptions, see [aihero.dev/skills](https://www.aihero.dev/skills)) | Invocation |
| --- | --- | --- |
| [grill-me](https://aihero.dev/skills-grill-me) | Interview a **loose idea** until you can commit to it — in **rounds**, each round asking only the full **frontier** of questions whose prerequisites are settled | user (points to grilling) |
| [grilling](https://aihero.dev/skills-grilling) | The interview loop that stress-tests a plan/decision/idea before anyone acts: map the subject as a **design tree** and interview branch by branch until nothing is silently assumed | model + user |
| [handoff](https://aihero.dev/skills-handoff) | Compact the conversation into a **handoff document** — one Markdown file in the OS temp dir (not the workspace) a fresh agent can pick up | user |
| [teach](https://aihero.dev/skills-teach) | Turn the directory into a standing teaching workspace and teach one topic across sessions in short self-contained HTML lessons | user |
| [to-questionnaire](https://aihero.dev/skills-to-questionnaire) | Turn a decision you can't settle alone into a **questionnaire** for the person who holds what you're missing | user |
| [wait-what](https://aihero.dev/skills-wait-what) | When a message didn't land: the agent re-pitches it with the missing context, in plain English, using the project's `CONTEXT.md` vocabulary | user |
| [writing-for-agents](https://aihero.dev/skills-writing-for-agents) | The reference for writing agent-facing documents (skills, `AGENTS.md`/`CLAUDE.md`, specs, runtime prompts, READMEs): packaging differs, the writing does not | model + user |

### engineering (18)

| Skill | Purpose (official descriptions, see [aihero.dev/skills](https://www.aihero.dev/skills)) | Invocation |
| --- | --- | --- |
| [ask-matt](https://aihero.dev/skills-ask-matt) | The router over the skills in this repo: describe your situation, get the skill or sequence that fits, plus where the human decisions sit | user |
| [code-review](https://aihero.dev/skills-code-review) | Two-axis review of the diff between `HEAD` and a fixed point: **Standards** (repo conventions) + **Spec** (the originating issue/spec), each axis in its own sub-agent | model + user |
| [codebase-design](https://aihero.dev/skills-codebase-design) | Fixes the deep-module vocabulary: **module, interface, depth, seam, adapter, leverage, locality** — each precisely defined, loose substitutes banned | model + user |
| [diagnosing-bugs](https://aihero.dev/skills-diagnosing-bugs) | Six-phase diagnosis for hard bugs and perf regressions: repro → minimise → rank hypotheses → instrument → fix with a regression test → clean up | model + user |
| [domain-modeling](https://aihero.dev/skills-domain-modeling) | Build and sharpen the project's **ubiquitous language** while designing: challenge conflicting terms, force precise words, stress-test relationships | model + user |
| [grill-with-docs](https://aihero.dev/skills-grill-with-docs) | The same interview as grill-me, pointed at a codebase — and it writes the vocabulary and hard decisions (ADRs + glossary) into the repo as it goes | user |
| [implement](https://aihero.dev/skills-implement) | Build work that is already decided: point at a ticket/spec/agreed plan; drive tdd at the seams, typecheck as you go, run code-review at the end, commit | user |
| [improve-codebase-architecture](https://aihero.dev/skills-improve-codebase-architecture) | Survey the codebase for **deepening opportunities** (shallow → deep modules), write a self-contained HTML report, then grill you through the one you pick | user |
| [prototype](https://aihero.dev/skills-prototype) | Write **throwaway code that answers a question** — does the state model feel right, what should the UI look like. The question comes first | model + user |
| [research](https://aihero.dev/skills-research) | Answer a question from **primary sources** only (official docs, source, specs, first-party APIs) and leave a cited Markdown file in the repo | model + user |
| [resolving-merge-conflicts](https://aihero.dev/skills-resolving-merge-conflicts) | Work an in-progress git merge/rebase hunk by hunk, run the project's checks, finish with a commit | model + user |
| [setup-matt-pocock-skills](https://aihero.dev/skills-setup-matt-pocock-skills) | Answer three questions about one repo (where issues live, triage label names, domain docs location) and record them under `docs/agents/` | user |
| [tdd](https://aihero.dev/skills-tdd) | Build test-first: one failing test, then just enough code to pass, then the next behaviour — with the standards that keep the suite worth keeping | model + user |
| [to-spec](https://aihero.dev/skills-to-spec) | Turn the conversation you just had into a **spec** and publish it to the issue tracker as a single issue | user |
| [to-tickets](https://aihero.dev/skills-to-tickets) | Break a plan/spec/conversation into a set of **tickets**, each declaring its **blocking edges** (the tickets that must finish first) | user |
| [triage](https://aihero.dev/skills-triage) | Move tracker issues through the triage-role state machine, leaving an agent-ready brief, a specific question for the reporter, or a closed issue with a reason | user |
| [wayfinder](https://aihero.dev/skills-wayfinder) | Chart an effort too big for one session as a shared **map of decision tickets** on the tracker, resolve them one at a time until the way is clear | user |
| [wizard](https://aihero.dev/skills-wizard) | Generate an interactive bash script that walks a human through manual steps: opens each URL, says what to click/copy, captures results into `.env` and GitHub secrets | model + user |

> Note: `/clear` and `/compact` are Claude Code native commands referenced by
> upstream, not skills in this pack. In DSH they map to "start a fresh session"
> and "carry the summary into a new session manually" — see the port note in
> `skills/ask-matt/PHASE-BOUNDARIES.md`.

## Adaptation notes (vs upstream mattpocock/skills)

- **Format**: upstream already uses standard `SKILL.md` (YAML frontmatter:
  `name` + `description`, optional `whenToUse`), so DSH consumes it directly;
  bodies are essentially unchanged.
- **Invocation semantics**: upstream `disable-model-invocation: true`
  (user-invoked only, e.g. `grill-me`, `wait-what`) maps to DSH
  `invocation.modelInvocable: false`; everything else stays model+user.
- **Tool naming**: `grill-me`'s "Call the Skill tool with 'grilling'" was
  adapted to DSH's `skill` tool; `grilling`'s "dispatch a sub-agent" maps to the
  DSH `subagent` tool — the original wording was already generic, so it's
  unchanged.
- **Dropped aux files**: each skill's `agents/openai.yaml` is a Codex
  invocation policy DSH doesn't need; `writing-for-agents`'s relative reference
  `SKILL-MECHANICS.md` ships with the package and resolves via `resourceBase`.
- **Relative references**: in-skill files (e.g. `SKILL-MECHANICS.md`) resolve
  through `resourceBase`, which points at the skill's own directory.

## How it works

- **Bundle layer** — `cordis.patch.yml` inserts one row
  (`- id: mattpocock-skills-dsh, name: mattpocock-skills-dsh`) over the
  dsh-base layer. Later layers (profile `cordis.patch.yml`, `--patch`
  overlays) can still address this row by id.
- **Provider** — `lib/index.js` calls `ctx.skills.registerProvider(...)`:
  - `list()` scans the package's `skills/` directory, treating each
    `<name>/SKILL.md` as a candidate and parsing `name`, `description`,
    `whenToUse` and `disable-model-invocation` from the YAML frontmatter.
  - `get()` reads the winning candidate's body on demand and returns the full
    skill definition with `resourceBase` pointing at the skill directory.
- **Zero runtime dependencies** — Node built-ins only, consuming the injected
  `ctx.skills` service.

## Adding your own skills

Drop a new `skills/<kebab-name>/SKILL.md` into the package — it must start
with YAML frontmatter (`name` + `description`, optional `whenToUse` and
`disable-model-invocation`). No code changes needed: `list()` discovers it
automatically.

## License

MIT. Skill content adapted from
[mattpocock/skills](https://github.com/mattpocock/skills) (MIT), © Matt Pocock;
DSH port © mattpocock-skills-dsh contributors. See [LICENSE](LICENSE).
