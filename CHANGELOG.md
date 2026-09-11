# Changelog

## [0.1.7] - 2026-09-11

### Fixed

- **`skills/diagnosing-bugs/scripts/hitl-loop.template.sh` 是残渣文件（82 B）**：内容为一段 `git ls-tree` 输出（`tree origin/HEAD:skills/engineeringdiagnosing-bugs/scripts` + 文件名），真实模板应有 1363 B（`#!/usr/bin/env bash` 开头的 HITL 复现回路模板）。该残渣自初版 `cb7aefd` / 同步 `d4699c0` 起就在仓库里，并随 **0.1.5 / 0.1.6 一起发布到了 npm**（安装体实测同为 82 B）。本次从上游 `mattpocock/skills` 逐字节还原（SHA256 与上游相同）。
  影响面：本机该技能被 `~/.agents/skills` 的同名技能跨层覆盖，残渣此前不会被读取；但对未安装该技能副本的宿主与本包的其它消费者，`diagnosing-bugs` 的 HITL 回路会指向一个空壳脚本。

## [0.1.6] - 2026-09-10

### Changed

- 新增 `peerDependencies.@deepseek-ai/cordis "^4.0.1"`：显式声明宿主 cordis 契约。
- `dsh.compatibility.dshReleases` 由 17 键补至 20 键：新增 `0.1.5-alpha.2` / `0.1.5-rc.1` / `0.1.5-rc.2`（均 `compatible`），适配 0.1.5 线宿主；`engines.dsh` 维持 `>=0.1.0-rc.6`。

> 0.1.4 / 0.1.5 未在本文件留条目，本次一并记录当前状态。

## [0.1.3] - 2026-08-26

### Changed

- 全量再同步上游 [mattpocock/skills](https://github.com/mattpocock/skills)
  (068b6e0 → 6654f6b):25 个正式技能内容全部刷新。
- 实质性改动:grilling 轮次模板加水平分隔线(HR);wait-what 补充
  `CONTEXT-MAP.md` 指引;to-tickets 新增 wide-refactor expand–contract 段落、
  blocking-edge 校验问题与按 ticket 模板字段。
- 全仓去除 em-dash、SKILL.md description 加引号(YAML 安全);继续保留去技能
  斜杠前缀的 DSH 适配(`/clear`、`/compact` 不动)。
- 上游新增 in-progress `retro` 技能尚未转正,本次不引入。

## [0.1.2] - 2026-08-16

### Added

- provider 原生解析折叠 YAML frontmatter(有未加引号冒号的 description)。

## [0.1.1] - 2026-08-16

### Changed

- 新增完整英文 README(`README.en.md`),随 npm 包分发;中文 README 顶部加语言切换链接。
- 技能表对齐 [aihero.dev/skills](https://www.aihero.dev/skills) 官方描述(中文对照翻译),
  每个技能名挂官方文档链接。
- README 增加安装徽章、七课工作流(中英对照)与 CHANGELOG。

## [0.1.0] - 2026-08-16

首个发布版:把 Matt Pocock 的完整发布技能集移植到 DeepSeek Harness。

### Added

- 25 个技能(上游 promoted 集:productivity 7 + engineering 18),标准 `SKILL.md`
  格式,由 host 层技能提供者(`ctx.skills.registerProvider`)注册:
  - productivity: `grill-me`、`grilling`、`handoff`、`teach`、`to-questionnaire`、
    `wait-what`、`writing-for-agents`
  - engineering: `ask-matt`(路由器)、`code-review`、`codebase-design`、
    `diagnosing-bugs`、`domain-modeling`、`grill-with-docs`、`implement`、
    `improve-codebase-architecture`、`prototype`、`research`、
    `resolving-merge-conflicts`、`setup-matt-pocock-skills`、`tdd`、`to-spec`、
    `to-tickets`、`triage`、`wayfinder`、`wizard`
- Cordis bundle 插件:`cordis.patch.yml`(dsh-base 层插入插件行)+ `lib/index.js`
  (技能提供者,零运行时依赖)
- 验证脚本 `scripts/verify-provider.mjs`(25/25 冒烟测试,`npm run verify`)

### Adapted (vs 上游 mattpocock/skills)

- `Skill tool` → DSH `skill` 工具命名
- 斜杠前缀技能名(`/tdd` → `tdd`)全量去除,匹配 DSH 裸名寻址
- `disable-model-invocation: true` → `invocation.modelInvocable: false`(仅用户可调)
- 剔除 Codex 专用 `agents/openai.yaml`;`/clear`、`/compact` 保留原样并加 DSH 对照注记

### License

MIT;技能内容 © Matt Pocock([mattpocock/skills](https://github.com/mattpocock/skills)),
DSH 移植 © mattpocock-skills-dsh contributors。
