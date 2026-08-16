#!/usr/bin/env bash
# sync-upstream.sh — pull the promoted skill set from upstream mattpocock/skills
# and re-apply the DSH adaptations. Run from the repo root.
#
#   bash scripts/sync-upstream.sh
#
# Manual follow-ups after a sync:
#   - skills/ask-matt/PHASE-BOUNDARIES.md: re-apply the "DSH port note" block
#     at the top (upstream may have rewritten the file).
#   - npm run verify — the 25/25 provider smoke test must pass.
#   - Commit and bump the version if skill content changed.
set -euo pipefail

UPSTREAM_REPO=https://github.com/mattpocock/skills
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

git clone --depth 1 "$UPSTREAM_REPO" "$TMP/upstream" >/dev/null 2>&1
echo "Upstream cloned at $(git -C "$TMP/upstream" rev-parse --short HEAD)"

# Skill names from the upstream plugin manifest (the promoted set).
SKILL_NAMES='grill-with-docs|grill-me|grilling|domain-modeling|codebase-design|handoff|prototype|to-spec|to-tickets|implement|tdd|code-review|triage|wayfinder|research|wizard|wait-what|teach|writing-for-agents|setup-matt-pocock-skills|diagnosing-bugs|improve-codebase-architecture|resolving-merge-conflicts|to-questionnaire|ask-matt'

for bucket in engineering productivity; do
  for skill_dir in "$TMP/upstream/skills/$bucket"/*/; do
    [ -d "$skill_dir" ] || continue
    name="$(basename "$skill_dir")"
    mkdir -p "$ROOT/skills/$name"
    # Copy everything except Codex-specific aux files.
    find "$skill_dir" -type f ! -path '*/agents/*' ! -name 'openai.yaml' \
      -exec cp {} "$ROOT/skills/$name/" \;
    skill_file="$ROOT/skills/$name/SKILL.md"
    if [ -f "$skill_file" ]; then
      # DSH adaptation 1: Claude Code 'Skill tool' -> DSH 'skill tool'.
      sed -i 's/Skill tool/skill tool/g' "$skill_file"
      # DSH adaptation 2: slash-prefixed skill names -> bare names.
      sed -i -E "s|/($SKILL_NAMES)|\1|g" "$skill_file"
    fi
    echo "synced $name"
  done
done

echo ""
echo "Done. Follow-ups:"
echo "  - re-check skills/ask-matt/PHASE-BOUNDARIES.md DSH note"
echo "  - npm run verify"
