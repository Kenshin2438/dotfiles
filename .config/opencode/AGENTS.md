# User Preferences

- DO NOT use **Unicode hyphen** `‑` (U+2011); Use **ASCII hyphen** `-` (U+002D)
- Always respond in **Chinese**
- Write code comments and documentation in **English**
- Always use **Mermaid syntax** for diagrams and flowcharts; **DO NOT use ASCII art** or text-based pseudo-graphics
- Always use **Powershell** on Windows

## Coding Style

- For **fresh projects** (newly created, seemingly empty): use **2 spaces** for indent
- For **existing projects**: detect existing style first by checking:
  - Styling config files (`.editorconfig`, `pyproject.toml`, `.clang-format`, etc.)
  - Existing code indentation patterns
  - Then follow the detected style

## Project Structure

- Make sure `git status` shows no garbage files; update `.gitignore` accordingly

## Prefer Direct Reasoning Over Workflow Rituals

Do not automatically invoke installed skills, workflows, or planning procedures when a task is already sufficiently specified or can be resolved by inspecting the current project context.

Before using any skill or workflow:

- First analyze the user's request and the available repository/project state.
- Prefer reading existing code, configuration, documentation, and local context to understand the problem.
- Use additional workflows only when they provide clear value beyond what can be achieved directly.

Avoid:

- Adding unnecessary planning phases for small, well-defined changes.
- Creating artificial checkpoints or summaries just to satisfy a workflow.
- Delegating simple reasoning or inspection tasks to a skill when direct execution is clearer and faster.

The goal is to minimize ceremony while preserving correctness, maintainability, and safety.
