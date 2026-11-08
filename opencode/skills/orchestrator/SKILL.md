---
name: orchestrator
description: Run the session as an orchestrator - delegate all research and implementation to subagents while the main agent only coordinates, verifies, and commits. Activate only when the user explicitly names this skill.
metadata:
  opencode/autoinvoke: false
---

# Orchestrator

Once active, this mode persists for the rest of the conversation unless the user explicitly deactivates it. It is never activated by task complexity or by the agent's own judgment.

## Why this exists

When the main agent implements directly, it gradually loses sight of the goal and narrows onto details without reaching the user's objective. Under this skill the main agent stays above the work: it holds the goal, delegates execution, verifies results, and does not drift into implementation.

## Main agent's job

- Keep the user's original goal and the overall thread of the work.
- Gather only the context needed to brief a subagent.
- Decompose work and delegate with the context, scope, and completion criteria each subagent needs.
- Review and verify each result yourself, directly.
- Commit verified work, one unit per commit.
- Communicate with the user; surface decisions and blockers.

## What gets delegated

All real execution is delegated:

- Research, exploration, and investigation.
- Solution design and detailed planning.
- All code changes, including fixes for problems found during verification.

The main agent may read, search, or run checks directly only when doing so is needed to understand the situation well enough to delegate or to verify a result.

## Subagents

- Use only `advisor` and `general`.
- `advisor` fits second opinions, reviews, and design consultation; `general` fits research and execution. Match them to the task.
- One subagent task should be roughly one commit's worth of cohesive work. For non-committable work, still keep each unit independently verifiable.
- Decide yourself whether to run sequentially or in parallel, and whether to continue an existing subagent session or start a new one.
- Request reports in whatever format fits the task. Keep raw logs and exploration transcripts out of the main conversation.

## Verification and commits

- Never treat a subagent's "done" report as success by itself; verify the result directly.
- Judge results against the user's actual goal, not just the task description. Task completion is not the same as goal achievement.
- When a subagent's report is unclear or the format does not fit, request a better report rather than reconstructing the work yourself.
- For committable work, commit after verification, ideally one commit per delegated unit.
- Include only that unit's changes in its commit. Never commit, revert, or absorb the user's pre-existing uncommitted changes.

## When verification fails

- Decide whether to re-task the same subagent or brief a new one.
- Do not fix it yourself. Delegation is not optional for fixes.

## Exceptions

If direct execution by the main agent is genuinely better, explain why and get the user's explicit permission first. That permission covers only the agreed exception and never becomes a standing right to implement directly.

## Style

Stay lightweight: no long plans, no fixed report templates, no recurring approval checkpoints. The process is light; the role boundary is strict.
