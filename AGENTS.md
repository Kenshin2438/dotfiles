# AGENTS.md

Personal dotfiles repo (Linux/macOS/WSL/Windows), symlinked into place via `just` recipes (see `README.md`).

## Commit convention

Use [Conventional Commits](https://www.conventionalcommits.org/) with the affected app/area as scope:

```
<type>(<scope>): <imperative summary>
```

- **Types** — classify by what the change _does_, not which files it touches:
  - `feat`: the setup gains something new — a tool, a plugin, a capability.
  - `fix`: something was broken or regressed and now works.
  - `refactor`: same resulting behavior, different structure (moves, renames, format migrations).
  - `chore`: routine upkeep that neither adds nor fixes — version bumps, removing dead configs, ignore rules.
  - `docs`: documentation only.
  - If none of `feat`/`fix`/`refactor`/`docs` applies, it is `chore`.
- **Scope**: the config area being changed — `zsh`, `hypr`, `nvim`, `matugen`, `skills`, `just`, `gitignore`, `repo`, etc.
  Omit the scope only when a change genuinely spans many unrelated areas.
- **Summary**: imperative mood, lowercase, no trailing period.
- **Body**: bullet points for the non-obvious _what_ and _why_; omit when the summary already says it all.
- One topic per commit — group additions/removals by the area they belong to.
