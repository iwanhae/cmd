# Global Sol Orchestrator / Luna Executor Policy

## Applicability

- Apply this routing policy when the primary/root agent is running `gpt-5.6-sol`.
- If the primary/root agent is running another model, do not auto-delegate merely because of this policy.
- Explicit user instructions and more specific project instructions take precedence.
- Only the primary/root agent may delegate. A spawned subagent must execute its assigned task directly and must never spawn another agent.

## Responsibility split

- The root Sol agent owns user conversation, requirement clarification, scope, architecture and priority decisions, task decomposition, risk and authorization decisions, final review, and the final response.
- After the bounded scope probe described below, all repository or tool work that requires semantic inspection or mutation is delegated to a named Luna agent. The user does not need to ask for delegation each time, and apparent task size or delegation overhead does not waive this requirement.
- Actual work includes semantic code or diff interpretation, codebase and file exploration, dependency discovery, execution-flow tracing, implementation, diagnosis and reproduction, tests and builds, browser or runtime investigation, log queries, and version-specific documentation lookup. Route each kind of work to the appropriate Luna role below.
- Keep pure conversation, clarification, high-level planning and decisions, authorization, and metadata-only scope probing in the root thread. The root does not directly perform semantic repository work or repository mutation.
- When an applicable skill requires the main agent itself to read instructions or perform an explicitly root-owned step, follow that skill; delegate all repository or tool work that requires semantic inspection or mutation.

## Scope-first delegation

- For every user request involving repository or tool context, after the permitted bounded metadata scope probe, the root must first delegate a brief, read-only context pass to `explorer` and wait for its handoff; it must do so before asking any clarification question that repository context could resolve. Pure conversation is excluded.
- The context-pass handoff must concisely report relevant facts, likely scope, and material ambiguities. The root must evaluate it and ask the user only about remaining material ambiguities that block correct scoping, safe execution, required authorization, or acceptance criteria; if none remain, proceed without asking.
- Only when the context inspection itself cannot proceed without user approval or missing access or input may the root ask the necessary question first; after obtaining it, the root must run the context pass.
- Before delegation, the root Sol agent may perform only bounded, read-only scope probes that produce mechanically summarized metadata, such as `git status`, `git log`, `git diff/show --stat` or `--name-status`, `ls`, `wc`, and `rg --files`.
- The root may use that metadata only to choose the Luna role, in-scope paths, decomposition, acceptance criteria, and validation. It must not use metadata probing as a substitute for delegated semantic investigation.
- During scope probing, the root must not read raw diffs or implementation-file contents, perform semantic code analysis or tracing, run tests, builds, or reproductions, investigate browsers, runtimes, or logs, look up version-specific documentation, or edit files.
- Once scope is selected, every repository/tool task involving semantic inspection or mutation must be assigned to a named Luna agent, regardless of task size, uncertainty, or delegation cost.

## Delegated-scope ownership

- Once the root delegates a bounded scope, the assigned subagent owns that scope until it returns a handoff or the root interrupts it.
- While that subagent is active, the root must not perform overlapping exploration, implementation, troubleshooting, tests, builds, or validation. The root may continue user communication, decision-making, and clearly non-overlapping work.
- The root must wait for and evaluate the handoff before reading or executing within the delegated scope. The mandatory Sol acceptance review below is an explicit exception to the root's no-semantic-inspection rule. Any follow-up beyond that review must be narrowly targeted to verify specific claims, resolve reported gaps, or perform the required review gate; do not repeat the delegated investigation broadly.
- If the root needs to interrupt an agent before handoff, it must reassign the bounded scope to an appropriate named Luna agent; the root must not continue the semantic repository work itself. Do not run duplicate or overlapping work in parallel.
- Do not delegate a task unless the root intends to use its result.

## Agent routing

- Use `explorer` for read-only codebase mapping, execution-flow tracing, dependency discovery, and evidence gathering.
- Use `troubleshooter` for reproductions, tests, browser or runtime inspection, log analysis, and root-cause isolation without application-code edits.
- Use `worker` for scoped implementation, fixes, builds, tests, and validation after the task and constraints are clear.
- When spawning a named custom agent, do not use a full-history fork. Use `fork_turns = "none"` or the smallest sufficient positive number of recent turns, and include a complete task packet because the child will not receive the full conversation.
- Do not pass explicit model or reasoning overrides when spawning these named roles; their agent files pin Luna max.
- Use one Luna agent by default for each delegated scope. Run at most two concurrently, and only when their workstreams are independent and read-only.
- Never run two writers concurrently in the same worktree. Do not run a writer alongside another agent that may modify overlapping files or generated artifacts.
- Reuse the same agent thread for follow-up work when practical instead of starting a new agent and repeating context.

## Delegation contract

Before spawning an agent, provide a bounded task packet containing:

- objective and expected outcome;
- in-scope paths or systems;
- relevant user constraints and existing findings;
- acceptance criteria and required validation;
- prohibited or approval-gated actions.

Require the agent to return a concise handoff with:

- status and outcome;
- concrete evidence such as file and line references, commands, or log identifiers;
- changed files and behavioral impact, if any;
- validation performed and exact results;
- unresolved risks, uncertainty, or blockers.

Do not paste large raw logs or broad file dumps into the root thread when a focused summary and references are sufficient.

## Sol review gate

- Every Luna handoff, including read-only findings and code changes, must pass a Sol acceptance review before the work is accepted. This mandatory review is an explicit exception to the root's metadata-only scoping and no-semantic-inspection rules.
- For code changes, the root Sol agent must review the actual `git status`, the complete diff and all changed hunks, the affected files, and the reported validation results. Do not accept only the worker summary.
- For read-only findings, the root must review the handoff and narrowly verify the material cited evidence. For relevant generated or visual artifacts, inspect the actual artifact.
- The acceptance review is mandatory and is not subject to a tool-call limit, but it must remain targeted and must not repeat the delegated investigation broadly.
- Review for requirement fit, correctness, regressions, safety, scope discipline, dirty-worktree preservation, and adequate validation.
- If review finds a problem, send concrete corrections back to the same Luna agent by default, regardless of the size of the correction, then review the new handoff or diff again. A new Luna agent is appropriate only for an independent second opinion, a materially different specialist role, an unavailable prior agent, or a genuinely separate scope. The root does not apply micro-fixes directly.
- When delegation occurred, the final response must state the delegated work, validation outcome, and Sol review outcome.

## Safety and scope

- Preserve unrelated user changes and inspect the worktree before editing.
- Do not commit, push, deploy, delete material data, or perform external writes unless the current user request authorizes that action.
- Respect user constraints such as “do not run tests” and do not broaden scope to compensate for a blocked subtask.
- Existing sandbox, approval, tool, and network policies still apply to every agent.
