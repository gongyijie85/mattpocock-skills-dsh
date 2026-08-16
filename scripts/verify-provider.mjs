// verify-provider.mjs — functional smoke test for the mattpocock-skills-dsh
// skill provider, without booting a DSH profile.
//
// Usage: node scripts/verify-provider.mjs
//
// It fakes the `ctx.skills.registerProvider` surface, captures the registered
// provider, then exercises list() and get() exactly like the host registry
// would.
import { apply } from '../lib/index.js'

let captured
const ctx = {
  skills: {
    registerProvider(providerFactory) {
      captured = providerFactory({})
    }
  }
}

apply(ctx)
if (!captured) {
  console.error('FAIL: provider was not registered')
  process.exit(1)
}

const candidates = await captured.list({ signal: undefined })
console.log(`discovered ${candidates.length} candidate(s):`)
const expected = new Set([
  'ask-matt', 'code-review', 'codebase-design', 'diagnosing-bugs', 'domain-modeling',
  'grill-me', 'grill-with-docs', 'grilling', 'handoff', 'implement',
  'improve-codebase-architecture', 'prototype', 'research', 'resolving-merge-conflicts',
  'setup-matt-pocock-skills', 'tdd', 'teach', 'to-questionnaire', 'to-spec', 'to-tickets',
  'triage', 'wait-what', 'wayfinder', 'wizard', 'writing-for-agents'
])
const found = new Set()
let failures = 0

for (const c of candidates) {
  found.add(c.name)
  const detail = await captured.get(c, { signal: undefined })
  const flag = detail?.invocation?.modelInvocable === false ? 'user-only' : 'model+user'
  console.log(
    `  - ${c.name}: "${c.description}" [${flag}] content=${detail?.content?.length ?? 0} chars resourceBase=${detail?.resourceBase?.path ?? 'MISSING'}`
  )
  if (!detail?.content || !detail?.resourceBase) failures++
}

for (const want of expected) {
  if (!found.has(want)) {
    console.error(`FAIL: expected skill "${want}" was not discovered`)
    failures++
  }
}
for (const name of found) {
  if (!expected.has(name)) {
    console.error(`FAIL: unexpected skill "${name}" discovered`)
    failures++
  }
}

if (failures) {
  console.error(`FAIL: ${failures} problem(s)`)
  process.exit(1)
}
console.log('OK: provider discovery, frontmatter parsing, invocation mapping and get() all pass')
