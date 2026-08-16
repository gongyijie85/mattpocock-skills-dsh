# Changelog

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
