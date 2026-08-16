# mattpocock-skills-dsh

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
npx @deepseek-ai/dsh plugin --profile web add github:<你的用户名>/mattpocock-skills-dsh
```

### 从本地文件夹安装(PoC 阶段推荐)

```sh
# 任意目录下执行;文件夹安装是链接方式,改完重启 profile 即生效
dsh plugin --profile web add D:\plugins\mattpocock-skills-dsh
```

### 让 DeepSeek Harness 帮你安装

打开 DeepSeek Harness(Web 界面),新建对话,把下面这句话发给它:

```
帮我安装这个链接里边的插件:https://github.com/<你的用户名>/mattpocock-skills-dsh
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

| 技能 | 用途 | 调用方式 |
| --- | --- | --- |
| `grill-me` | 入口:无情地拷问一个计划或设计 | 用户调用(指向 grilling) |
| `grilling` | 把想法压力测试成设计树,逐轮提问直到共识 | 模型/用户调用 |
| `handoff` | 把当前对话压成交接文档给下一个 agent | 用户调用 |
| `teach` | 在多个会话里教用户一个概念 | 用户调用 |
| `to-questionnaire` | 把答不了的决策转成给别人填的问卷 | 用户调用 |
| `wait-what` | 停下:上一条消息没接住——重新表述 | 用户调用 |
| `writing-for-agents` | 编写 agent 消费的文档(skill、AGENTS.md 等) | 模型/用户调用 |

### engineering(18)

| 技能 | 用途 | 调用方式 |
| --- | --- | --- |
| `ask-matt` | 路由器:问哪个技能/流程适合当前情况 | 用户调用 |
| `code-review` | 双轴评审(标准 + 规格),并行子代理 | 模型/用户调用 |
| `codebase-design` | 深模块设计词汇(module/interface/depth/seam...) | 模型/用户调用 |
| `diagnosing-bugs` | 硬 bug 与性能回归的诊断循环 | 模型/用户调用 |
| `domain-modeling` | 打磨项目领域语言,记录 ADR | 模型/用户调用 |
| `grill-with-docs` | 带文档沉淀的拷问(ADR + 词汇表) | 用户调用 |
| `implement` | 按 spec/票据实现一段工作 | 用户调用 |
| `improve-codebase-architecture` | 扫描深挖机会,HTML 报告 + 拷问 | 用户调用 |
| `prototype` | 用一次性原型回答设计问题 | 模型/用户调用 |
| `research` | 背景代理查一手资料,产出引用 Markdown | 模型/用户调用 |
| `resolving-merge-conflicts` | 按意图解决 merge/rebase 冲突 | 模型/用户调用 |
| `setup-matt-pocock-skills` | 一次性配置 issue tracker/标签/文档布局 | 用户调用 |
| `tdd` | 红-绿-重构实现循环 | 模型/用户调用 |
| `to-spec` | 把对话合成 spec 发布到 tracker | 用户调用 |
| `to-tickets` | 把 spec 拆成声明阻塞边的 tracer-bullet 票据 | 用户调用 |
| `triage` | 把 issue/PR 走完三态机并写 agent 简报 | 用户调用 |
| `wayfinder` | 超大会话工作:决策票据地图逐条解决 | 用户调用 |
| `wizard` | 生成交互式 bash 向导,让人走只有人能走的步骤 | 模型/用户调用 |

> 说明:`/clear`、`/compact` 是上游引用的 Claude Code 原生命令,非本包技能;
> DSH 中对应"开新会话"与"手动摘要续接",详见
> `skills/ask-matt/PHASE-BOUNDARIES.md` 的移植注记。

## 移植说明(对比上游 mattpocock/skills)

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
