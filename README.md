# mattpocock-skills-dsh

[![npm version](https://img.shields.io/npm/v/mattpocock-skills-dsh)](https://www.npmjs.com/package/mattpocock-skills-dsh)
[![GitHub release](https://img.shields.io/github/v/release/gongyijie85/mattpocock-skills-dsh)](https://github.com/gongyijie85/mattpocock-skills-dsh/releases)
[![CI](https://github.com/gongyijie85/mattpocock-skills-dsh/actions/workflows/ci.yml/badge.svg)](https://github.com/gongyijie85/mattpocock-skills-dsh/actions/workflows/ci.yml)
[![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![DSH](https://img.shields.io/badge/DSH-0.1.1--rc.2%2B-4d6bfe)](https://github.com/gongyijie85/mattpocock-skills-dsh)
[![-技能](https://img.shields.io/badge/-技能-4d6bfe)]() [![-七课工作流](https://img.shields.io/badge/-七课工作流-4d6bfe)]() [![-grilling](https://img.shields.io/badge/-grilling-4d6bfe)]() [![-to-spec](https://img.shields.io/badge/-to--spec-4d6bfe)]() [![-to-tickets](https://img.shields.io/badge/-to--tickets-4d6bfe)]()

<div align="center">

[English](README.en.md) | **简体中文**

</div>

为 **DeepSeek Harness (DSH)** 打造的 Matt Pocock 技能插件包:把
[mattpocock/skills](https://github.com/mattpocock/skills)(来自
[aihero.dev/skills](https://www.aihero.dev/skills) 的"真实工程师"技能集)
移植到 DSH 的 Cordis 插件架构上。

插件会向 `ctx.skills` 注册表的 **host 层** 注册一个技能提供者,因此每个
agent preset 的作用域链都会合并这些技能。技能正文随包分发
(`skills/<name>/SKILL.md`),通过 `import.meta.url` 定位——这是包的
组装事实,不需要任何用户配置。

> **非官方移植**:技能内容改编自 [mattpocock/skills](https://github.com/mattpocock/skills)(MIT,
> © Matt Pocock)。上游以 Claude Code 插件格式发布;本包做的是 DSH 适配。

## 快速上手:七课工作流(中英对照)

> 出自 Matt Pocock 的 skills 邮件——整包技能的正确打开方式,就是按下面
> 这条工作流从头跑到尾。`Sandcastle` 为外部工具,不在本包内。

> Prompts are disposable. Workflows are reusable. That is the whole
> difference, and these seven lessons are one workflow in the order you
> would actually run it:
>
> 提示词用过即弃,工作流可以复用——全部区别就在于此。而这七课,合起来
> 就是一条按真实执行顺序运行的工作流:

| Step | 原文 | 对照中文 |
| --- | --- | --- |
| 0 | This email. Pick your path. | 这封邮件就是起点:选一条路。 |
| 1 | `/grill-with-docs` , so the agent is not building from fog | 先把想法拷问清楚,agent 才不会在迷雾中开工 |
| 2 | `/prototype` and `/handoff` , to test the uncertain part in a toy version | 用玩具原型验证不确定的部分,并留好交接 |
| 3 | `/to-spec` and `/to-tickets` , to break big work into reviewable slices | 把大工作拆成可评审的切片 |
| 4 | `Sandcastle` , to run AFK agents somewhere safe | 在安全的地方跑挂机(AFK)agent(外部工具,不在本包) |
| 5 | `/code-review` , so each run teaches the next one | 每一次评审,都让下一次运行变得更好 |
| 6 | The full loop, start to finish | 从起点到终点,跑完整条循环 |

## 在 DeepSeek Harness 中安装与使用

这是 DeepSeek Harness 的**插件包**。安装后会把技能注册进 host 技能注册表,
你 profile 里的每个 agent 会话都能在技能目录中看到它们,并可用 `skill`
工具加载。

### 前置条件

- 已安装 DeepSeek Harness,并且有 **pnpm** —— `dsh plugin` 命令内部调用
  pnpm(用 `pnpm --version` 检查;没有的话到 https://pnpm.io 安装)
- `dsh` 命令行。它随 Harness 一起提供,通常以 `npx @deepseek-ai/dsh web`
  方式启动。要么把它装成全局命令,要么在所有命令前加 `npx`:

  ```sh
  # 方式一:全局安装 dsh,永久可用(推荐)
  npm install -g @deepseek-ai/dsh
  dsh --version

  # 方式二:不安装,所有命令用 npx 形式
  npx @deepseek-ai/dsh --version
  ```

  下文所有 `dsh ...` 示例都可以等价写成 `npx @deepseek-ai/dsh ...`。

### 最简单:一条命令(从 GitHub 安装)

```sh
npx @deepseek-ai/dsh plugin --profile web add github:gongyijie85/mattpocock-skills-dsh
```

### 从本地文件夹安装(开发阶段)

```sh
# 任意目录下执行;文件夹安装是链接方式,改完重启 profile 即生效
dsh plugin --profile web add D:\plugins\mattpocock-skills-dsh
```

### 让 DeepSeek Harness 帮你安装

打开 DeepSeek Harness(Web 界面),新建对话,把下面这句话发给它:

```
帮我安装这个链接里边的插件:https://github.com/gongyijie85/mattpocock-skills-dsh
```

Agent 会自动完成安装(`dsh plugin add` → 重启 profile → 验证技能注册)。

### 重启并验证

bundle 层在 profile 启动时挂载,所以需要**重启 profile**(停掉后重新运行
`dsh web` / `npx @deepseek-ai/dsh web`,再刷新浏览器)。确认层已组合:

```sh
dsh --profile web --dump-config     # 必须出现 `mattpocock-skills-dsh` 行
```

之后技能会出现在 agent 技能目录中,可以用 `skill` 工具加载。

### 卸载

```sh
dsh plugin --profile web remove mattpocock-skills-dsh
# 卸载后同样需要重启 profile
```

## 技能列表(全量 25 个 = 上游 promoted 集)

### productivity(7)

| 技能 | 用途(官方描述对照翻译,见 [aihero.dev/skills](https://www.aihero.dev/skills)) | 调用方式 |
| --- | --- | --- |
| [grill-me](https://aihero.dev/skills-grill-me) | 把一个**模糊的想法**拷问成你能承诺的东西——以"轮"提问,每轮只问前置条件已定的完整**前沿**(frontier) | 用户调用(指向 grilling) |
| [grilling](https://aihero.dev/skills-grilling) | 在任何人行动之前压力测试计划/决策/想法的面试循环:把主题映射成**设计树**,逐支问到底,直到没有默认假设残留 | 模型/用户调用 |
| [handoff](https://aihero.dev/skills-handoff) | 把当前对话压缩成**交接文档**——写到系统临时目录(而非工作区)的单个 Markdown 文件,新 agent 读它即可接手 | 用户调用 |
| [teach](https://aihero.dev/skills-teach) | 把所在目录变成常驻教学空间,跨多个会话用短小的自包含 HTML 课程教一个主题 | 用户调用 |
| [to-questionnaire](https://aihero.dev/skills-to-questionnaire) | 把一个人定不了的决策变成**问卷**——交给掌握缺失信息的人异步填,或开会一起过 | 用户调用 |
| [wait-what](https://aihero.dev/skills-wait-what) | 消息没接住时输入它:agent 重讲一遍刚才的话,补上缺失的上下文、用平实的英语、采用项目 `CONTEXT.md` 的词汇 | 用户调用 |
| [writing-for-agents](https://aihero.dev/skills-writing-for-agents) | 写 agent 消费文档的参考(skill、`AGENTS.md`/`CLAUDE.md`、spec、运行时提示词、README):包装不同,写法相同 | 模型/用户调用 |

### engineering(18)

| 技能 | 用途(官方描述对照翻译,见 [aihero.dev/skills](https://www.aihero.dev/skills)) | 调用方式 |
| --- | --- | --- |
| [ask-matt](https://aihero.dev/skills-ask-matt) | 全仓库技能的路由器:描述你的处境,它给出匹配的技能或技能序列,以及其中人类决策的位置 | 用户调用 |
| [code-review](https://aihero.dev/skills-code-review) | 按两个轴评审 `HEAD` 与指定基点的 diff:**Standards**(是否符合本仓库写法)+ **Spec**(是否实现了源头 issue/spec),两轴各由独立子代理运行 | 模型/用户调用 |
| [codebase-design](https://aihero.dev/skills-codebase-design) | 固定模块设计词汇:**module、interface、depth、seam、adapter、leverage、locality**,逐一精确定义并禁用松散替身词 | 模型/用户调用 |
| [diagnosing-bugs](https://aihero.dev/skills-diagnosing-bugs) | 对硬 bug 或性能回归跑六阶段诊断:复现→最小化→假设排序→插桩→带回归测试修复→清理 | 模型/用户调用 |
| [domain-modeling](https://aihero.dev/skills-domain-modeling) | 设计过程中构建并打磨项目的**通用语言**:挑战与词汇表冲突的术语、逼出精确词、用具体场景压力测试关系 | 模型/用户调用 |
| [grill-with-docs](https://aihero.dev/skills-grill-with-docs) | 拷问计划/设计直到共享理解,同时把词汇与硬决策写进仓库(ADR + 词汇表);与 grill-me 同款面试,面向代码库 | 用户调用 |
| [implement](https://aihero.dev/skills-implement) | 构建已决策的工作:指向 ticket/spec/刚谈定的计划,写代码、在接缝处驱动 tdd、边写边类型检查、末尾跑 code-review 并提交 | 用户调用 |
| [improve-codebase-architecture](https://aihero.dev/skills-improve-codebase-architecture) | 扫描代码库找**加深机会**(浅模块→深模块),写成自包含 HTML 报告,然后拷问你选中的那个 | 用户调用 |
| [prototype](https://aihero.dev/skills-prototype) | 写**一次性代码回答问题**——状态模型对不对、界面该长什么样;问题先行,答错问题就是纯浪费 | 模型/用户调用 |
| [research](https://aihero.dev/skills-research) | 只从**一手资料**(官方文档/源码/spec/官方 API)读答案,在仓库留下带引用的 Markdown;每条结论追到拥有它的源头 | 模型/用户调用 |
| [resolving-merge-conflicts](https://aihero.dev/skills-resolving-merge-conflicts) | 逐块解决进行中的 git merge/rebase 冲突,跑项目自己的检查,提交收尾 | 模型/用户调用 |
| [setup-matt-pocock-skills](https://aihero.dev/skills-setup-matt-pocock-skills) | 回答一个仓库的三个问题(issue 放哪、triage 标签叫什么、领域文档在哪),以 `docs/agents/` 下的 markdown 记录 | 用户调用 |
| [tdd](https://aihero.dev/skills-tdd) | 测试先行构建功能/修 bug:一个失败测试→刚好能过的代码→下一个行为;并携带让测试套件值得保留的标准 | 模型/用户调用 |
| [to-spec](https://aihero.dev/skills-to-spec) | 把刚谈完的对话变成 **spec**,作为单个 issue 发布到 issue tracker | 用户调用 |
| [to-tickets](https://aihero.dev/skills-to-tickets) | 把计划/spec/对话拆成一组 **ticket**,每个声明**阻塞边**(必须先行完成的其它 ticket) | 用户调用 |
| [triage](https://aihero.dev/skills-triage) | 把 tracker 上的 issue 逐个走完 triage 角色状态机,留下 agent-ready 简报、给报告人的具体问题、或带原因关闭的 issue | 用户调用 |
| [wayfinder](https://aihero.dev/skills-wayfinder) | 把超过一个 agent 会话的大工程画成 issue tracker 上的**决策票据地图**,逐条解决直到路清晰 | 用户调用 |
| [wizard](https://aihero.dev/skills-wizard) | 生成交互式 bash 脚本,一步步带人走手动流程(接三方服务/一次性迁移):打开 URL、说清点哪复制什么、捕获结果写入 `.env` 与 GitHub secrets | 模型/用户调用 |

> 说明:`/clear`、`/compact` 是上游引用的 Claude Code 原生命令,非本包技能;
> DSH 中对应"开新会话"与"手动摘要续接",详见
> `skills/ask-matt/PHASE-BOUNDARIES.md` 的移植注记。

## 移植说明(对比上游 mattpocock/skills)

- **同步状态**:25 个技能正文持续跟进上游——最近一次 **2026-08-26** 全量同步至
  [mattpocock/skills](https://github.com/mattpocock/skills) `6654f6b`(含 grilling
  轮次 HR 分隔、wait-what `CONTEXT-MAP.md` 指引、to-tickets wide-refactor 段落)。
  更新历史见 [CHANGELOG.md](CHANGELOG.md)。
- **格式**:上游即标准 `SKILL.md`(YAML frontmatter:`name` +
  `description`,可选 `whenToUse`),DSH 可直接消费,正文基本零改动。
- **调用语义**:上游 `disable-model-invocation: true`(仅用户可调,如
  `grill-me`、`wait-what`)映射为 DSH 的 `invocation.modelInvocable: false`,
  保留原意图;其余技能模型/用户均可调用。
- **工具名适配**:`grill-me` 原文 "Call the Skill tool with 'grilling'" 的
  Claude Code 工具名改为 DSH 的 `skill` 工具;`grilling` 中的"dispatch a
  sub-agent"对应 DSH 的 `subagent` 工具,原文措辞通用,未改动。
- **未移植的辅助文件**:各技能目录下的 `agents/openai.yaml` 是 Codex 的
  调用策略,DSH 不需要,已剔除;`writing-for-agents` 的相对引用
  `SKILL-MECHANICS.md` 随包保留,由 `resourceBase` 解析。
- **相对引用**:技能目录内相对文件(如 `SKILL-MECHANICS.md`)通过
  `resourceBase` 指向技能所在目录,可正常加载。

## 工作原理

- **Bundle 层** —— `cordis.patch.yml` 在 dsh-base 层之上插入一行
  (`- id: mattpocock-skills-dsh, name: mattpocock-skills-dsh`)。后面的层
  (profile 的 `cordis.patch.yml`、`--patch` 叠加)仍可按 id 定位这一行。
- **提供者** —— `lib/index.js` 调用 `ctx.skills.registerProvider(...)`:
  - `list()` 扫描包内 `skills/` 目录,把每个 `<name>/SKILL.md` 作为候选,
    从 YAML frontmatter 解析出 `name`、`description`、`whenToUse` 与
    `disable-model-invocation`。
  - `get()` 按需读取候选技能正文,返回完整技能定义,`resourceBase` 指向
    技能所在目录,使相对引用可以正确解析。
- **零运行时依赖** —— 插件只使用 Node 内置模块,消费注入的 `ctx.skills`
  服务接口。

## 添加自己的技能

往包里放一个新的 `skills/<kebab-name>/SKILL.md` 即可——它必须以 YAML
frontmatter 开头(`name` + `description`,可选 `whenToUse` 与
`disable-model-invocation`)。无需改任何代码:`list()` 会自动发现它。

## 许可证

MIT。技能内容改编自
[mattpocock/skills](https://github.com/mattpocock/skills)(MIT),© Matt
Pocock;DSH 移植部分 © mattpocock-skills-dsh contributors。见 [LICENSE](LICENSE)。
