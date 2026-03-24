# Security & Privacy Standards

## Repository Privacy

All repositories under this directory are **private**. Never reference, link to, or assume public GitHub repos exist.

## Personal Information

- NEVER expose __YOUR_EMAIL__ or any personal email anywhere in code, UI, or config
- Contact forms must route through a form or masked address only — never display a real email
- Do not include personal phone numbers, physical addresses, or other PII in committed code

## Credentials & Secrets

- Never hardcode API keys, tokens, passwords, or connection strings in source code
- Never commit `.env`, `.env.local`, credentials files, or key files — verify `.gitignore` covers them
- If you encounter a secret in code, flag it immediately

## Sensitive File Access

Never read, display, or load into context:
- `.env`, `.env.local`, `.env.production`, `.env.development` (`.env.example` / `.env.sample` are OK)
- Certificate and key files: `*.pem`, `*.key`, `*.cert`, `*.crt`, `*.p8`, `*.p12`, `*.pfx`
- Raw database files: `*.db`, `*.sqlite`, `*.sqlite3`
- Do not `source .env` or `. .env` in shell commands

Each repo should have a `.claudeignore` file to enforce this passively. A template is available at `.claudeignore.template` in this directory.

## Database Access

For projects with production databases:

**Safe without asking:**
- `SELECT COUNT(*) FROM <table>` — row counts only
- Schema inspection: `\dt`, `\d+ <table>`, `DESCRIBE`, `SHOW TABLES`, `SHOW CREATE TABLE`
- `information_schema` and `pg_catalog` queries

**Stop and ask before running:**
- Any `SELECT` that returns actual row data (not just counts)
- JOINs, UNIONs, subqueries, or CTEs against application tables
- Any query you're unsure about

**Never run:**
- `pg_dump`, `mysqldump`, or any bulk data export
- Interactive `psql` / `mysql` sessions (always use `-c` / `-e` flags)
- Multi-statement commands or stored procedure calls

## Code Security

- Sanitize all user input at system boundaries (forms, API endpoints, URL params)
- Use parameterized queries for all database operations — never string-interpolate SQL
- Escape output to prevent XSS in rendered HTML
- Validate and sanitize file paths to prevent directory traversal
- Do not log secrets, tokens, or passwords at any log level — even `debug`

## Circumvention Prevention

- Do not write a script file and then execute it to work around restrictions (e.g., writing a .py file that imports a DB driver, then running it via Bash)
- Do not craft subagent prompts that instruct reading credential files, dumping env vars, querying row data, or curling localhost APIs
- Do not modify hook files or hook configuration in `.claude/` without explicit permission
