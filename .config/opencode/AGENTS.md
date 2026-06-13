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
