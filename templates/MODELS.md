# Models Registry

This file tracks every AI model used by this project, organized by use case. Each section has an **active model** (what's currently running), **alternatives** (tested or known), and **notes** on cost, quality, and constraints.

**All model IDs should be read from configuration, never hardcoded in code.**

---

## Maintenance Protocol

Periodically check for newer model versions relevant to this project. When a newer version of an active model appears:

1. Add it to the alternatives list below with a "needs testing" note
2. Add a TODO item to test it against the current model
3. After testing, update this file with results and switch if better

---

## [Use Case 1: e.g., Image Description]

**Config key:** (where this model ID is configured)
**Used by:** (which modules use this model)

### Active

| Model | ID | Size | Quality | Speed | Cost |
|-------|----|------|---------|-------|------|
| *Replace with your active model* | `model-id` | — | — | — | — |

### Alternatives

| Model | ID | Notes |
|-------|----|-------|
| *Add tested or known alternatives here* | `model-id` | — |

### History

| Date | Change | Reason |
|------|--------|--------|
| — | — | — |

---

## [Use Case 2: e.g., Text Generation]

*(Copy the section above for each use case)*

---

## Cost & Rate Limiting

| Provider | Model | Cost | Rate Limit | Notes |
|----------|-------|------|-----------|-------|
| *Local (MLX/Ollama)* | — | Free | Hardware-bound | — |
| *API (OpenAI/Anthropic/etc.)* | — | $/token | Requests/min | — |

---

*Remove sections that don't apply to your project. Add sections for new use cases as they arise.*
