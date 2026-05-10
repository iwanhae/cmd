---
name: pido
description: Delegate tasks to independent subagents for context-isolated execution. Use when you need to perform parallel research or handle complex multi-step refactorings without cluttering your context with repetitive tool logs.
compatibility: Requires bash, python3.
---

# pido — AI Subagent CLI

`pido` (Pi Do) is a utility to delegate tasks to independent subagents. This is useful for long-running research, parallel task execution, or keeping your primary context window clean during complex, multi-step operations.

## Core Features

- **Stream Separation:** Live progress goes to `stderr`, while only the final response is sent to `stdout`.
- **Context Isolation:** Subagents perform their own tool loops (read, edit, test) without bloating your history.

## Usage

The subagent script is located at `scripts/pido`.

### 1. Subagent Execution

Blocks until the subagent completes. Use this to perform complex logic where you only care about the final outcome.

```bash
pido [options] "<prompt>"
```

### 2. Configuration Options

- `--tools <list>`: Comma-separated tools for the subagent (default: `read,bash,grep,find,ls`). **Add `edit` or `write` if the subagent needs to modify files.**

---

## Recommended Workflows

### Isolated Code Refactoring

Use `pido` in the foreground to refactor code. The subagent will handle all the `read` and `edit` turns, and you will only receive the final summary of changes.

```bash
pido --tools "read,bash,edit" "Refactor the stream parser in pido to use argparse." > result_refactoring_argparse.md
```

### Parallel Research & Audit

Dispatch multiple subagents sequentially to analyze different parts of the codebase.

1. `pido "Scan the project for potential SQL injection vulnerabilities."`
2. `pido "Audit the new authentication module for race conditions."`

## Tips

- **Always run in foreground.**
- **Never mix stdout and stderr.** stdout = final response (piping `> file` or `|` is recommended); stderr = progress logs (never pipe).
- **Set `timeout` ≥ 1800 (30 min).**
- **One `pido` per `bash` tool call.**

## Available Scripts

- `pido` — The core subagent wrapper script.
