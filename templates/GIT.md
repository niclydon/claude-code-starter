# Git Conventions

## Identity

All commits must use this identity:

```
__YOUR_NAME__ <__YOUR_EMAIL__>
```

If git warns about auto-detected identity or uses a machine hostname, fix it:
```bash
git config --global user.name "__YOUR_NAME__"
git config --global user.email "__YOUR_EMAIL__"
```

## Commits

- Write concise commit messages (1-2 sentences) focused on **why**, not what
- Prefer specific file staging (`git add file1 file2`) over `git add -A` or `git add .`
- Never skip hooks (`--no-verify`) or bypass signing unless explicitly asked
- Never amend a commit unless explicitly asked — always create new commits
- If a pre-commit hook fails, fix the issue and create a **new** commit (the failed commit didn't happen)

## Branching

- Never force-push to `main` or `master`
- When in doubt about destructive operations (`reset --hard`, `push --force`, `checkout --`), ask first

## History & Sensitive Data

Git history can leak secrets from past commits. Avoid commands that dump file contents from history:

- Do not use `git log -p` or `git log --patch` — diffs may contain historically committed secrets. Use `git log --stat` or `--name-only` instead.
- Do not use `git show <ref>:.env` or `git show <ref>:<sensitive-file>` — retrieves file contents at that commit.
- Do not use `git cat-file -p` or `git cat-file blob` — dumps raw object content.
- Do not use `git format-patch` — patch files contain full diffs.
- `git diff -- .env` or `git diff -- *.key` is also off limits.
- `git archive` produces file dumps that may include sensitive files — don't use it.

Safe alternatives: `git log --oneline`, `git log --stat`, `git show --stat`, `git diff -- <source-file>`.

## Versioning

When committing changes, check for a `VERSION` file in the affected repo. If one exists, increment the version according to the rules defined in that file.
