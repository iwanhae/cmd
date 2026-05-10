---
name: pido
description: Delegate tasks to independent subagents for parallel research or context-isolated execution. Use when you need to run background tasks, perform parallel research, or handle complex multi-step refactorings without cluttering your context with repetitive tool logs.
compatibility: Requires bash, python3, and tmux.
---

# pido — AI Subagent CLI

`pido` (Pi Do) is a utility to delegate tasks to independent subagents. This is useful for long-running research, parallel task execution, or keeping your primary context window clean during complex, multi-step operations.

## Core Features

- **Background Execution:** Run tasks in detached `tmux` sessions.
- **Stream Separation:** Live progress goes to `stderr`, while only the final response is sent to `stdout`.
- **Context Isolation:** Subagents perform their own tool loops (read, edit, test) without bloating your history.

## Usage

The subagent script is located at `scripts/pido`.

### 1. Subagent Execution

#### Foreground (Blocking)

Blocks until the subagent completes. Use this to perform complex logic where you only care about the final outcome.

```bash
./scripts/pido [options] "<prompt>"
```

#### Background (Non-blocking)

Immediately returns a Job ID (e.g., `sub-1715345678-1234`).

```bash
./scripts/pido --bg [options] "<prompt>"
```

### 2. Management Commands

- **List subagents:** `./scripts/pido --list`
- **Watch live progress:** `./scripts/pido --attach <id>`
- **Wait & get result:** `./scripts/pido --wait <id>`
- **Get final result:** `./scripts/pido --result <id>`

### 3. Configuration Options

- `--tools <list>`: Comma-separated tools for the subagent (default: `read,bash,grep,find,ls`). **Add `edit` or `write` if the subagent needs to modify files.**

---

## Recommended Workflows

### Isolated Code Refactoring

Use `pido` in the foreground to refactor code. The subagent will handle all the `read` and `edit` turns, and you will only receive the final summary of changes.

```bash
./scripts/pido --tools "read,bash,edit" "Refactor the stream parser in scripts/pido to use argparse."
```

### Parallel Research & Audit

Dispatch multiple subagents to analyze different parts of the codebase simultaneously.

1. `./scripts/pido --bg "Scan the project for potential SQL injection vulnerabilities."`
2. `./scripts/pido --bg "Audit the new authentication module for race conditions."`
3. Use `./scripts/pido --list` to monitor status.
4. Use `./scripts/pido --result <id>` to ingest findings once they are `done`.

## Available Scripts

- **scripts/pido** — The core subagent wrapper script.
