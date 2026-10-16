#!/usr/bin/env bash

set -euo pipefail

install_skills() {
  local repository="$1"
  shift

  npx skills@latest add "$repository" \
    --skill "$@" \
    --global \
    --agent '*' \
    -y
}

install_skills auaa-x/engineering-skills \
  engineering-principles instruction-curator

install_skills mattpocock/skills \
  codebase-design code-review diagnosing-bugs prototype tdd

install_skills vercel-labs/agent-skills \
  vercel-react-best-practices vercel-composition-patterns

printf '\nEngineering skill bundle installed. Restart your agent to load new skills.\n'
