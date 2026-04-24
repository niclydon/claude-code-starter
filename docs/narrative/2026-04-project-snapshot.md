# claude-code-starter — Project Snapshot (April 2026)

## What it is

`claude-code-starter` is a small, self-contained kit that bootstraps a new
parent projects directory with the CLAUDE.md instruction stack that Claude
Code reads automatically when a session starts inside any subdirectory. The
README opens with a one-line frame that captures the scope cleanly: "A
modular set of instruction files for Claude Code that apply universal
standards across all projects in a parent directory." The kit is explicitly
behavioral, not mechanical. There are no hooks, no daemons, no MCP servers,
no settings.json wiring. It is just markdown plus a single Bash setup
script, and the leverage comes from Claude Code's built-in convention of
walking up the directory tree and loading every CLAUDE.md it finds, plus
the `@filename.md` import syntax that expands sibling files inline at
load time.

The repo lives at `/home/niclydon/projects/claude-code-starter` and is the
extracted, sanitized, public-facing version of the same instruction stack
Nic actually runs at `~/projects/CLAUDE.md` on the laptop and on Furnace.
The published kit is a strict subset. The personal stack at the projects
root is several times longer and includes Forge serving topology, the
two-Nexus disambiguation, the four chat surfaces table, Broadside ingestion
weights, the workshop capture protocol, and other private context that
would not generalize. The starter trims all of that out and keeps only the
universal scaffolding any solo developer using Claude Code could adopt
verbatim on day one.

## Layout

The repository root contains five working files plus a templates directory
and a `.remember/` scratch folder that is gitignored:

- `README.md` — 95 lines, the user-facing explainer. Includes a quick-start
  block, a manual-install fallback, an "after setup" tree showing the
  intended `~/Projects/` layout, a customization section covering how to
  add or remove modules, and a closing "How it works" section that names
  the underlying mechanism (parent-directory `CLAUDE.md` auto-load plus
  `@import` expansion).
- `LOGGING.md` — 125 lines. The single universal module that ships
  unedited. Defines a four-tier log-level convention (`minimal`, `normal`,
  `verbose`, `debug`) with concrete logger sketches for TypeScript, Swift,
  Python, and Bash, plus a ten-rule list that all four implementations
  share, plus a four-step troubleshooting protocol that ends on "never
  debug blind".
- `setup.sh` — 114 lines. Interactive installer. Prompts for full name,
  email, and role; copies templates into the parent directory of the
  starter clone; runs a placeholder substitution pass with `sed` that
  swaps `__YOUR_NAME__`, `__YOUR_EMAIL__`, and `__YOUR_ROLE__` into the
  installed copies. Has a small dual-`sed` invocation that handles the BSD
  vs GNU `-i` argument difference between macOS and Linux. Asks before
  overwriting an existing file at the destination.
- `.claudeignore.template` — 50 lines. Per-repo template (not auto-loaded;
  copied into individual repos as needed). Blocks `.env*`, key/cert files,
  database files, `node_modules/`, build output, and editor metadata.
  `*.sql`, `*.csv`, and `*.xlsx` are commented out by default with a note
  to uncomment if the consuming project does not need Claude to read those
  formats.
- `templates/` — four files that the setup script either string-substitutes
  or copies verbatim into the target parent directory:
  - `templates/CLAUDE.md` (20 lines) — the root entry point. Three sections
    only: an Owner line that fills in name and role, a Standards section
    that imports `@LOGGING.md`, `@GIT.md`, `@SECURITY.md`, and `@MODELS.md`,
    and a four-bullet "Working With Me" block.
  - `templates/GIT.md` (45 lines) — git identity, commit conventions,
    branching rules, history-safety rules around `git log -p` /
    `git show <ref>:<file>` / `git format-patch` / `git archive` because
    those commands can leak historically committed secrets, and a closing
    versioning rule that says to bump a `VERSION` file if one exists in
    the affected repo.
  - `templates/SECURITY.md` (60 lines) — repo-privacy default, personal-
    info handling, credential rules, sensitive file blocklist, a
    three-tier database-access policy (safe / ask / never), input-handling
    rules, and a circumvention-prevention section that explicitly forbids
    workaround patterns like writing a Python file to bypass a restriction
    and then executing it from Bash.
  - `templates/MODELS.md` (59 lines) — the most recent addition. A
    skeleton registry for tracking every AI model a project uses by use
    case: active model, alternatives, test history, cost, rate limits.
    Opens with the rule "All model IDs should be read from configuration,
    never hardcoded in code."

## Current state

The kit is functional and has been used at least once (it shipped Nic's
own root instruction stack at `~/projects/`, which is a strict superset
of what this kit installs). All three commits in the history are clean
and authored by `niclydon <niclydon@gmail.com>`. The tree on disk at
`/home/niclydon/projects/claude-code-starter/` matches the README's
documented layout exactly; there is no drift between docs and reality.

The `.remember/` directory at the root is the only working-state artefact.
It contains empty `logs/` and `tmp/` subdirectories and a `.gitignore`
that hides them. This is consistent with the `remember:remember` skill's
session-state convention rather than anything project-specific.

There is no `CHANGES.md`, no `CLAUDE.md` at the repo root (the kit
installs one for the parent directory but does not carry one for itself),
no `docs/` tree before this snapshot, no test suite, and no CI. For a
five-file markdown kit with one shell script, that absence is appropriate
rather than a gap.

## Recent work

Three commits, all dated within a few hours of each other on March 24
2026 (timestamps are in the future relative to the listed authoring
context, which is consistent with the rest of Nic's repos in this tree):

1. `14a2d26` — Initial commit. Scaffolded the kit with seven files:
   `.claudeignore.template`, `LOGGING.md`, `README.md`, `setup.sh`,
   `templates/CLAUDE.md`, `templates/GIT.md`, `templates/SECURITY.md`.
   509 insertions total. Co-authored with Claude Opus 4.6 (1M context).
2. `7c718b8` — Added `templates/MODELS.md` and wired it into both the
   root template's `@import` block and the setup script's install list.
   The commit message frames the rationale: "Template for tracking
   AI/LLM models by use case: active model, alternatives, test history,
   cost, rate limits. Encourages config-driven model selection over
   hardcoded IDs." 61 insertions across three files.
3. `3a074da` — One-line README polish. The credits line at the bottom
   originally read "Built by Nic Lydon"; this commit swapped it for
   "Built by [@niclydon](https://github.com/niclydon)" so the public
   page links to the GitHub profile instead of a bare name.

The rhythm matches the design philosophy stated in the README itself:
"Under 250 lines total — keeps context overhead low so Claude follows
instructions reliably." Each commit added or trimmed exactly what the
goal required and nothing else.

## Open items

Nothing is broken and nothing is half-finished, but a few things are
visible to a future reader:

- The README's `Quick start` block uses `https://github.com/YOUR_USERNAME/claude-code-starter.git`
  as the clone URL placeholder. Once the repo is published under
  `niclydon/claude-code-starter`, that placeholder should be replaced
  with the real URL so the copy-paste install actually works.
- `setup.sh` has a small portability hack for the BSD vs GNU `sed -i`
  argument shape (it tries `sed -i ''` first and falls back to plain
  `sed -i` if that fails). It works, but it relies on the first call
  silently failing with `2>/dev/null` and the second call succeeding.
  A clean rewrite using `sed` with a temp-file write would be more
  legible if the script ever grows.
- The kit has diverged from Nic's own root stack in scope (intentionally),
  but there is no automation that keeps the universal subset of the
  personal stack in sync with the public starter. If `LOGGING.md` or
  `SECURITY.md` evolves at `~/projects/`, someone has to remember to
  port the universal parts back into this repo manually.
- `templates/MODELS.md` has placeholder section headers like
  `## [Use Case 1: e.g., Image Description]` with example tables. A
  consumer running `setup.sh` ends up with a `MODELS.md` full of bracket
  placeholders at their projects root and has to edit it before the file
  is useful. This is the same pattern as `__YOUR_NAME__` substitution but
  is not handled by the script. Worth documenting in the README's
  "After setup" section so a new user knows to fill it in (or to remove
  the file if they have no AI/LLM models in any project).
- There is no published license file, no GitHub Actions workflow, no
  release tagging, and no `VERSION` file. For a personal-use kit that
  is appropriate; if the kit is ever promoted as a community resource,
  those would all be reasonable adds.
