# Claude Code Starter Kit

A modular set of instruction files for [Claude Code](https://claude.ai/code) that apply universal standards across all projects in a parent directory.

Drop these files into your root projects folder (e.g., `~/Projects/`) and every repo underneath inherits them automatically — Claude Code loads `CLAUDE.md` from parent directories at launch.

## What's included

| File | Auto-loaded | Purpose |
|------|-------------|---------|
| `CLAUDE.md` | Yes (parent dir) | Universal core — who you are, how Claude should work with you, `@imports` the modules below |
| `LOGGING.md` | Yes (via @import) | Tiered logging framework (minimal/normal/verbose/debug) with examples for TypeScript, Swift, Python, and Shell |
| `GIT.md` | Yes (via @import) | Git identity, commit conventions, branching rules, history safety |
| `SECURITY.md` | Yes (via @import) | Private repos, credential handling, sensitive file rules, database access guardrails, circumvention prevention |
| `.claudeignore.template` | No (copy per-repo) | Template for `.claudeignore` — prevents Claude from loading secrets, certs, DB files into context |

### Design principles

- **Under 250 lines total** — keeps context overhead low so Claude follows instructions reliably
- **Modular** — each `.md` file covers one concern. Remove or add modules as needed.
- **`@import` based** — the root `CLAUDE.md` pulls in modules. Per-repo `CLAUDE.md` files add project-specific context on top.
- **Behavioral, not mechanical** — rules Claude follows as instructions, no hook scripts or infrastructure required. Lightweight and portable.

## Quick start

```bash
# Clone into your projects root
cd ~/Projects   # or wherever your repos live
git clone https://github.com/YOUR_USERNAME/claude-code-starter.git _starter

# Run setup — prompts for your name and email, copies files into place
bash _starter/setup.sh

# Clean up the starter repo (files are already copied)
rm -rf _starter
```

Or do it manually:

```bash
cd ~/Projects
# Copy the files
cp _starter/templates/CLAUDE.md .
cp _starter/LOGGING.md .
cp _starter/templates/GIT.md .
cp _starter/templates/SECURITY.md .
cp _starter/.claudeignore.template .

# Edit CLAUDE.md, GIT.md, and SECURITY.md to replace the placeholder values
```

## After setup

Your projects folder should look like:

```
~/Projects/
├── CLAUDE.md                ← universal core (auto-loaded for all repos below)
├── LOGGING.md               ← logging standards (loaded via @import)
├── GIT.md                   ← git conventions (loaded via @import)
├── SECURITY.md              ← security rules (loaded via @import)
├── .claudeignore.template   ← copy into repos that need it
├── my-app/
│   ├── CLAUDE.md            ← project-specific instructions
│   └── .claudeignore        ← copied from template, customized
├── another-repo/
│   └── CLAUDE.md
```

Per-repo `CLAUDE.md` files only need project-specific content — build commands, architecture, tech stack. The universal rules are inherited from the parent directory.

## Customization

**Add a module:** Create a new `.md` file in the root and add `@YOUR_FILE.md` to `CLAUDE.md`.

**Remove a module:** Delete the `@import` line from `CLAUDE.md` and optionally delete the file.

**Optional reference files:** For files that shouldn't load in every session (e.g., a DNS inventory, AWS account reference), list them in the "Optional References" section of `CLAUDE.md` without an `@import`. Per-repo `CLAUDE.md` files can selectively `@import` them when needed.

**`.claudeignore`:** The template comments out `*.sql`, `*.csv`, `*.xlsx` by default — uncomment them if your projects don't need Claude to read those formats. Copy and customize per-repo.

## How it works

Claude Code automatically loads `CLAUDE.md` files from parent directories when you start a session. A `CLAUDE.md` at `~/Projects/` is loaded for every repo inside that folder. The `@filename.md` syntax imports additional files — they're expanded inline at load time.

This means:
- **Root files = universal rules** that apply everywhere
- **Per-repo files = project-specific rules** that layer on top
- **`@import` = modular composition** without duplicating content

More on Claude Code memory: [code.claude.com/docs](https://code.claude.com/docs)

## Credits

Built by [@niclydon](https://github.com/niclydon). Inspired by community best practices and [Anthropic's official guidance](https://code.claude.com/docs/en/best-practices).
