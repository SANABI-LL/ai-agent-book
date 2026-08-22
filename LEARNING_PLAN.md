# 项目详解与学习计划

> 本文档是对本仓库（《深入理解 AI Agent：设计原理与工程实践》开源主仓库）的整体讲解，并给出一份可执行的分阶段学习计划。配合 [`README.md`](README.md) 与 [`book/`](book/) 中的书稿正文使用。

## 一、项目是什么

本仓库是李博杰所著《深入理解 AI Agent：设计原理与工程实践》一书的开源主仓库，包含两大部分：

1. **全书正文**（`book/` 中文原版，`book-en/`、`book-ta/`、`book-vi/` 为社区翻译版），含 Markdown 源码与编译好的 PDF；
2. **配套实验代码**（`chapter1/` ~ `chapter10/`），与全书十章一一对应，约百个实验项目，绝大多数为可独立运行的 Python 项目。

全书围绕一个核心公式展开：

> **Agent = LLM（大脑）+ 上下文（眼睛）+ 工具（手脚）**

对应强化学习的形式化语言：LLM = Policy（策略），上下文 = Observation Space（观察空间），工具 = Action Space（动作空间）。

## 二、全书结构与仓库目录

| 章节 | 主题 | 定位 | 配套代码目录 |
| --- | --- | --- | --- |
| 第 1 章 | Agent 基础知识 | 基础篇：核心公式、ReAct 循环、三种学习范式 | `chapter1/` |
| 第 2 章 | 上下文工程 | 上下文篇（全书最关键一章）：KV Cache、提示工程、Skills、上下文压缩 | `chapter2/` |
| 第 3 章 | 用户记忆和知识库 | 上下文篇：用户记忆、RAG 全栈、Agentic RAG | `chapter3/` |
| 第 4 章 | 工具 | 工具篇：MCP 协议、感知/执行/协作工具、异步 Agent | `chapter4/` |
| 第 5 章 | Coding Agent 与代码生成 | 工具篇：生产级 Coding Agent、代码作为元工具 | `chapter5/` |
| 第 6 章 | Agent 的评估 | 模型篇：基准测试、LLM-as-a-Judge、成本分析 | `chapter6/` |
| 第 7 章 | 模型后训练 | 模型篇：SFT、RL、RLHF、训练框架 | `chapter7/` |
| 第 8 章 | Agent 的自我进化 | 进阶篇：经验学习、工具发现与创造 | `chapter8/` |
| 第 9 章 | 多模态与实时交互 | 应用篇：语音、Computer Use、机器人 | `chapter9/` |
| 第 10 章 | 多 Agent 协作 | 应用篇：协作分类框架、管理者模式、Agent 社会 | `chapter10/` |

其他目录：

- `book/`：中文书稿源码（`introduction.md`、`chapter1.md`~`chapter10.md`、`afterword.md`）与 PDF，`build_pdf.sh` 可自行编译；
- `cursor-chats/`：作者与 AI 协作写书的过程记录；
- `scripts/`：辅助脚本；
- `EXPERIMENT_TRIAGE.md`：实验状态梳理。

### 项目的三种类型

- ✅ **可独立运行**：仓库自带完整代码，配好 API Key 即可跑（大多数项目属于此类）；
- 📖 **复现指南**：项目是详细的复现文档，依赖需自行 clone 的外部仓库（第 6 章基准、第 7 章训练框架、第 9 章 browser-use 等，克隆命令见 README 附录）；
- 🚧 **设计文档**：仅有架构设计文档，代码在完善中。

## 三、环境准备（第 0 步）

1. **基础环境**：Python 3.10+、pip/venv（或 conda）、git；建议安装一款 AI 辅助编程工具（Claude Code、Cursor 等），它们本身就是成熟的 Coding Agent，用它们做实验能第一手体验 ReAct 循环。
2. **API Key**（建议申请 2~3 个，按项目 README 配置到 `.env`，各项目通常附 `env.example`）：
   - Kimi（月之暗面）：https://platform.moonshot.cn/
   - 智谱 GLM：https://open.bigmodel.cn/
   - SiliconFlow（DeepSeek/Qwen 等开源模型）：https://siliconflow.cn/
   - 火山引擎（豆包）：https://www.volcengine.com/product/ark
   - OpenRouter（海外闭源模型的国内可达入口）：https://openrouter.ai/
3. **运行模式**：每个实验项目自带 `README.md` + `requirements.txt`，标准流程是
   `cd chapterN/项目名 && pip install -r requirements.txt && cp env.example .env`（填 Key）`&& python main.py`（以各项目 README 为准）。
4. 第 6、7、9、10 章的部分实验依赖外部仓库，需要时再按主 README《附录 · 外部仓库获取》克隆，不必一开始就全部拉取。

## 四、分阶段学习计划（约 10~12 周）

> 节奏假设：每周 6~10 小时。时间更充裕可以压缩到 6~8 周；只想建立认知可以只做每阶段的「必做实验」。方法论：**每章先读书稿（`book/chapterN.md`），再跑实验，最后做一个小改动验证理解**。
>
> **如果你的节奏是每天 1 小时**，请直接使用第七节《每天 1 小时版日程（14 周）》，它把下面各阶段拆成了逐日任务。

### 阶段一（第 1 周）· 基础认知：Agent 是什么

- **阅读**：`book/introduction.md` + `book/chapter1.md`
- **必做实验**：
  - `chapter1/context/` — 上下文消融研究：亲眼看到去掉上下文各组件后 Agent 行为如何退化，建立「上下文决定能力上限」的直觉；
  - `chapter1/learning-from-experience/` — Q-learning vs LLM 上下文学习的样本效率对比（250~400 倍差距）。
- **选做**：`chapter1/web-search-agent/`、`chapter1/search-codegen/`
- **里程碑**：能用自己的话解释 Agent = LLM + 上下文 + 工具，以及 ReAct「思考→行动→观察」循环。

### 阶段二（第 2~3 周）· 上下文工程（全书最关键）

- **阅读**：`book/chapter2.md`
- **必做实验**：
  - `chapter2/kv-cache/` — 理解 KV Cache 友好设计如何显著降低延迟与成本；
  - `chapter2/prompt-engineering/` — 基于 Tau-Bench 的提示工程消融，量化语气、指令组织、工具描述的影响；
  - `chapter2/context-compression/` — 对比多种上下文压缩策略；
  - `chapter2/prompt-injection/` — 提示注入攻防对照实验（3 种攻击 × 4 种防御）。
- **选做**：`chapter2/agent-skills-ppt/`（Skills 渐进式披露）、`chapter2/attention_visualization/`、`chapter2/local_llm_serving/`、`chapter2/system-hint/`
- **里程碑**：能说清「为什么系统提示要放前面、工具结果要追加不要改写」这类 KV Cache 友好设计原则；能演示一次成功的注入攻击及其防御。

### 阶段三（第 3~4 周）· 记忆与检索

- **阅读**：`book/chapter3.md`
- **必做实验**：
  - `chapter3/sparse-embedding/`（BM25 从零实现）→ `chapter3/dense-embedding/`（ANNOY vs HNSW）→ `chapter3/retrieval-pipeline/`（混合检索 + 重排序），按此顺序构建完整检索栈认知；
  - `chapter3/agentic-rag/` — 传统 RAG vs Agentic RAG 的性能对比（司法问答场景）；
  - `chapter3/user-memory/` — 用户记忆系统。
- **选做**：`chapter3/contextual-retrieval/`（Anthropic 上下文感知检索）、`chapter3/structured-index/`（RAPTOR/GraphRAG）、`chapter3/mem0/`、`chapter3/memobase/`
- **里程碑**：能独立选型「什么场景用稀疏/稠密/混合检索」，理解 Agentic RAG 为什么在复杂问题上更强。

### 阶段四（第 5 周）· 工具与 MCP

- **阅读**：`book/chapter4.md`
- **必做实验**：
  - `chapter4/perception-tools/` + `chapter4/execution-tools/` — 感知/执行两类 MCP 服务器（执行工具含 LLM 二次审批安全机制）；
  - `chapter4/agent-with-event-trigger/` — 集成 MCP 工具的事件驱动 Agent。
- **选做**：`chapter4/collaboration-tools/`、`chapter4/active-tool-selection/`、`chapter4/async-agent/`（打断与并行执行）；`chapter4/DOCKER_DEPLOYMENT.md` 提供 MCP 服务器容器化部署参考。
- **里程碑**：能自己写一个 MCP 工具并接入 Agent；理解「代码解释器优于计算器」的通用化工具设计原则。

### 阶段五（第 6~7 周）· Coding Agent（全书技术高峰）

- **阅读**：`book/chapter5.md`
- **必做实验**：
  - `chapter5/coding-agent/` — 生产级 Coding Agent（17 个工具、系统提示技术、Lint 检测），建议精读 `system-prompt.md` 与 `agent.py`；
  - `chapter5/code-for-math/` 或 `chapter5/code-for-logic/` — 体验「代码辅助推理」对准确率的提升；
  - `chapter5/erp-agent/` — NL2SQL 的 artifact 模式。
- **选做**：`chapter5/paper-to-ppt/`（提议者-审核者模式）、`chapter5/adaptive-log-parser/`（自愈闭环）、`chapter5/dynamic-form/`、`chapter5/conversational-ui/`
- **里程碑**：给 coding-agent 增加一个自定义工具并跑通；能解释提议者-审核者（proposer-reviewer）模式解决了什么问题。

### 阶段六（第 8 周）· 评估方法论

- **阅读**：`book/chapter6.md`
- **必做实验**：
  - `chapter6/model-benchmark/` — TTFT/延迟分位数/吞吐的多维模型选型；
  - `chapter6/agent-cost-analysis/` — 全链路成本拆解与 KV Cache/压缩的 A/B 验证；
  - `chapter6/tts-quality-eval/` 或 `chapter6/elo-leaderboard/` — LLM-as-a-Judge 与相对评估。
- **选做**（📖 需外部仓库）：SWE-bench、Terminal-Bench、GAIA、tau2-bench，挑一个跑通即可。
- **里程碑**：为自己在阶段五写的 Agent 设计一个小评估集（10~20 个用例）并跑出成功率——「没有评估，就没有进步」。

### 阶段七（第 9 周，可选深入）· 模型后训练

- **阅读**：`book/chapter7.md`（即使不训练也建议通读，理解「SFT 记忆、RL 泛化」「数据与环境比算法更重要」）
- **实验**（📖 多为复现指南，需 GPU；无 GPU 可只读文档）：
  - 入门：`chapter7/MiniMind-pretrain/` — 从零预训练小模型；
  - 进阶：`chapter7/SFTvsRL/`、`chapter7/AdaptThink/`、`chapter7/retool/`（verl + DAPO）。
- **里程碑**：能回答「我的场景该用提示工程、SFT 还是 RL」。

### 阶段八（第 10 周）· 自我进化

- **阅读**：`book/chapter8.md`
- **必做实验**：
  - `chapter8/active-tool-discovery/` — 全量注入 vs 按需发现工具的对照；
  - `chapter8/prompt-auto-optimization/` — 「反馈 → 改写提示词 → 重新评测」闭环；
  - `chapter8/self-evolving-tools/` — Agent 自己上网找库、封装新工具。
- **选做**：`chapter8/gaia-experience/`、`chapter8/browser-use-rpa/`、`chapter8/self-evolution-eval/`
- **里程碑**：理解不改权重的三条进化路径：经验沉淀、工作流外化为工具、提示蒸馏。

### 阶段九（第 11 周）· 多模态与实时交互

- **阅读**：`book/chapter9.md`
- **必做实验**：
  - `chapter9/streaming-speech/` — 流式识别的「首包延迟 vs 准确率」权衡；
  - `chapter9/live-audio/` — 实时语音对话全链路（ASR + LLM + TTS + WebSocket）；
  - `chapter9/browser-use/`（📖 外部仓库）— Computer Use 典型实现。
- **选做**：`chapter9/phone-agent/`、`chapter9/end-to-end-speech/`、`chapter9/controllable-tts/`
- **里程碑**：理解级联 vs 端到端语音范式的延迟与副语言信息取舍。

### 阶段十（第 12 周）· 多 Agent 协作与综合项目

- **阅读**：`book/chapter10.md` + `book/afterword.md`
- **必做实验**：
  - `chapter10/book-translation/` — 管理者模式如何控制上下文膨胀（附真实 token 对比）；
  - `chapter10/multi-role-transfer/` 或 `chapter10/staged-system-prompt/` — 共享上下文下的角色切换；
  - `chapter10/voice-werewolf/` — 上下文不共享的信息权限控制。
- **选做**：`chapter10/parallel-web-research/`（并行 + 级联终止）、TalkAct（双 Agent 语音+浏览器）
- **结业项目（建议）**：综合前面所学，独立完成一个小型 Agent，要求至少包含：自定义工具（第 4 章）+ 上下文管理策略（第 2 章）+ 一个小评估集（第 6 章），可选记忆（第 3 章）或多 Agent（第 10 章）。

## 五、按人群裁剪

- **时间有限 / 只想建立认知**：阶段一、二必做 + 阶段五的 coding-agent，约 3 周；
- **应用开发者**：阶段一~六 + 八、十，跳过阶段七的训练实验；
- **算法/训练方向**：阶段一、二、六必做，然后直奔阶段七，第 6 章评估是训练的前提；
- **语音/多模态方向**：阶段一、二、四打底，然后阶段九 + 第 10 章 TalkAct。

## 六、学习方法建议

1. **先读书稿再跑代码**：每个实验都对应书中的「实验 X-Y」编号，理论与实践互相印证；
2. **改代码比跑代码重要**：每个实验跑通后，至少做一处修改（换模型、改提示词、加工具）观察行为变化，消融实验类项目尤其适合这样玩；
3. **控制成本**：优先用国产平台的便宜模型（GLM、DeepSeek、Kimi）跑通流程，再按需换强模型对比；关注第 6 章的成本分析方法；
4. **建立自己的评估习惯**：从阶段六开始，对自己写的任何 Agent 都保留一个小评估集，改动前后跑分对比；
5. **善用 Coding Agent 学习本仓库**：用 Claude Code / Cursor 打开本仓库提问、让它解释代码，本身就是在体验书中讲的一切。

## 七、每天 1 小时版日程（14 周）

> **总量**：14 周 × 6 天 × 1 小时 ≈ 84 小时。每周第 7 天留作**机动日**（补上落下的进度、复盘笔记，或休息）。
>
> **一小时的用法约定**：一个小时不足以「既读完一章又跑完一个实验」，所以每一天只安排**一件事**——要么读，要么跑，要么改。这是这版日程与上面周计划的最大区别。
>
> **每日固定节奏**（建议）：
> - 前 5 分钟：回看昨天笔记的一句话结论；
> - 中间 50 分钟：完成当天任务；
> - 最后 5 分钟：在自己的笔记里写**一句话**——「今天我明白了 ___」。这一句话是整个计划里最重要的产出。
>
> **两条保命规则**：
> 1. **卡住 25 分钟就停**。装依赖、配 Key、跑不通是常态。记下报错，第二天或机动日再战，绝不要让一个环境问题吃掉一周的热情。
> 2. **读不完不要紧，别停**。书稿章节都很长，日程里给的是「读到哪一节」而非「读完」，按小节推进即可。

### 第 1 周 · 环境与全局认知

| 天 | 任务 | 产出 |
| --- | --- | --- |
| 1 | 读 `book/introduction.md`（引言）；浏览 `README.md` 的《内容速览》 | 能说出全书十章各讲什么 |
| 2 | 装环境：Python 3.10+、venv、git；注册 1~2 个 API 平台（推荐 GLM + SiliconFlow，便宜够用） | 拿到 API Key 并存好 |
| 3 | 读 `book/chapter1.md` 前半（Agent 核心公式、大脑/眼睛/手脚、Policy/观察/动作空间） | 一句话复述核心公式 |
| 4 | 读 `book/chapter1.md` 后半（ReAct 循环、三种学习范式、工作流 vs 自主 Agent） | 画一张 ReAct 循环草图 |
| 5 | 跑 `chapter1/context/`：装依赖、配 `.env`、跑通默认模式 | 看到 Agent 完整跑完一个任务 |
| 6 | 继续 `chapter1/context/`：切换不同上下文模式（去掉工具结果 / 去掉历史等）跑消融 | 对比表：少了哪块上下文，Agent 怎么退化 |
| 7 | 机动日 | — |

### 第 2 周 · 上下文工程（上）

| 天 | 任务 |
| --- | --- |
| 1 | 跑 `chapter1/learning-from-experience/`，看 Q-learning 与 LLM 的样本效率差距 |
| 2 | 读 `book/chapter2.md`：消息结构与 Agent 核心循环（"上下文就是消息列表"） |
| 3 | 读 `book/chapter2.md`：KV Cache 原理小节（读不动可只记开头三条核心结论，不影响后续） |
| 4 | 跑 `chapter2/kv-cache/`，观察不同上下文写法对缓存命中的影响 |
| 5 | 继续 `chapter2/kv-cache/`：故意制造一次缓存失效（如在系统提示里插入当前时间戳），量化延迟/成本变化 |
| 6 | 读 `book/chapter2.md`：提示工程小节（流程化设计、工具描述、业务规则细化） |
| 7 | 机动日 |

### 第 3 周 · 上下文工程（下）

| 天 | 任务 |
| --- | --- |
| 1 | 跑 `chapter2/prompt-engineering/`：先跑通 baseline（Tau-Bench 环境，注意控制样本量省钱） |
| 2 | 继续该实验：跑 1~2 组消融配置，对比任务完成率 |
| 3 | 读 `book/chapter2.md`：提示注入攻防小节 |
| 4 | 跑 `chapter2/prompt-injection/`：复现一次成功的注入攻击（无防御配置） |
| 5 | 继续：逐层打开防御（提示词加固 → 来源标记 → 组合防御），看成功率下降曲线 |
| 6 | 读 `book/chapter2.md`：Agent Skills 按需加载 + 状态栏 + 上下文压缩小节 |
| 7 | 机动日 |

### 第 4 周 · 上下文收尾 + 检索入门

| 天 | 任务 |
| --- | --- |
| 1 | 跑 `chapter2/context-compression/`，对比几种压缩策略的 token 节省与信息损失 |
| 2 | 跑 `chapter2/agent-skills-ppt/`，体验渐进式披露（薄目录 → 按需加载完整 Skill） |
| 3 | 读 `book/chapter3.md`：用户记忆的四种渐进式策略 |
| 4 | 跑 `chapter3/user-memory/`，跨会话记住用户偏好 |
| 5 | 读 `book/chapter3.md`：RAG 技术栈（分块、稀疏/稠密检索） |
| 6 | 跑 `chapter3/sparse-embedding/`，从零看懂 BM25 与倒排索引 |
| 7 | 机动日 |

### 第 5 周 · 检索全栈

| 天 | 任务 |
| --- | --- |
| 1 | 跑 `chapter3/dense-embedding/`，对比 ANNOY（树）与 HNSW（图）的性能/内存/更新能力 |
| 2 | 读 `book/chapter3.md`：重排序与混合检索小节 |
| 3 | 跑 `chapter3/retrieval-pipeline/`，把稀疏 + 稠密 + 重排序串成完整流水线 |
| 4 | 读 `book/chapter3.md`：Agentic RAG 小节 |
| 5 | 跑 `chapter3/agentic-rag/`：先跑 Non-Agentic 基线（司法问答） |
| 6 | 继续：跑 Agentic 模式，对比答案质量与检索轮次 |
| 7 | 机动日 |

### 第 6 周 · 工具与 MCP

| 天 | 任务 |
| --- | --- |
| 1 | 读 `book/chapter4.md`：MCP 标准 + 五类工具设计原则 |
| 2 | 跑 `chapter4/perception-tools/`：启动感知类 MCP 服务器（多数功能免 Key） |
| 3 | 读 `book/chapter4.md`：执行工具的安全机制小节 |
| 4 | 跑 `chapter4/execution-tools/`，观察 LLM 二次审批如何拦住危险操作 |
| 5 | **自己动手**：给 perception-tools 加一个自定义 MCP 工具（哪怕只是"查询本机时间/天气"） |
| 6 | 跑 `chapter4/agent-with-event-trigger/`，让 Agent 通过 HTTP 事件触发并调用上面的 MCP 工具 |
| 7 | 机动日 |

### 第 7 周 · Coding Agent（上）

| 天 | 任务 |
| --- | --- |
| 1 | 读 `book/chapter5.md`：Coding Agent + 文件系统为何是通用 Agent 的技术基础 |
| 2 | 精读 `chapter5/coding-agent/system-prompt.md`，对照第 2 章的提示工程原则找印证 |
| 3 | 跑 `chapter5/coding-agent/quickstart.py`，让它完成一个简单编码任务 |
| 4 | 读 `chapter5/coding-agent/agent.py` 的主循环，把 ReAct 在真实代码里认出来 |
| 5 | 浏览它的 17 个工具定义，重点看纯 Python 实现的 Grep 工具 |
| 6 | **自己动手**：给 coding-agent 加一个自定义工具并跑通 |
| 7 | 机动日 |

### 第 8 周 · Coding Agent（下）

| 天 | 任务 |
| --- | --- |
| 1 | 读 `book/chapter5.md`：代码在编程之外的价值（辅助思考、造工具、自举） |
| 2 | 跑 `chapter5/code-for-math/`：纯思维链模式 |
| 3 | 继续：代码辅助模式，对比准确率 |
| 4 | 读 `book/chapter5.md`：提议者-审核者（proposer-reviewer）小节 |
| 5 | 跑 `chapter5/paper-to-ppt/`，看 Reviewer 如何用 Vision 检查排版并驱动迭代 |
| 6 | 跑 `chapter5/erp-agent/`，理解 artifact 模式（LLM 只生成 SQL，不亲自搬数据） |
| 7 | 机动日 |

### 第 9 周 · 评估方法论

| 天 | 任务 |
| --- | --- |
| 1 | 读 `book/chapter6.md`：评估环境与数据集设计原则 |
| 2 | 跑 `chapter6/model-benchmark/`，测几个平台的 TTFT / p50 / p95 / 吞吐 |
| 3 | 读 `book/chapter6.md`：LLM-as-a-Judge 与统计显著性 |
| 4 | 跑 `chapter6/tts-quality-eval/` 或 `chapter6/elo-leaderboard/`，体验自动评判 |
| 5 | 跑 `chapter6/agent-cost-analysis/`，拆出「哪一步最贵」 |
| 6 | **自己动手**：给第 7 周那个加了工具的 coding-agent 写 10 个测试用例，跑出成功率基线 |
| 7 | 机动日 |

### 第 10 周 · 后训练（以读为主，无需 GPU）

| 天 | 任务 |
| --- | --- |
| 1 | 读 `book/chapter7.md`：预训练/SFT/RL 三阶段全景 |
| 2 | 读：「SFT 记忆、RL 泛化」与经典 RL 理论小节 |
| 3 | 读：奖励信号设计（二元 → 过程奖励 → 奖励结果约束过程） |
| 4 | 读：单轮 vs 多轮 RL 算法（PPO / GRPO / DAPO）比较 |
| 5 | 读 `chapter7/SFTvsRL/` 与 `chapter7/AdaptThink/` 的 README，理解实验怎么设计 |
| 6 | 写一段自己的决策笔记：「我的场景该用提示工程、SFT 还是 RL」（有 GPU 可改为跑 `chapter7/MiniMind-pretrain/`） |
| 7 | 机动日 |

### 第 11 周 · 自我进化

| 天 | 任务 |
| --- | --- |
| 1 | 读 `book/chapter8.md`：从经验中学习（策略摘要、工作流录制、Skills 外部化） |
| 2 | 跑 `chapter8/active-tool-discovery/`：先跑「全量注入 120+ 工具」基线 |
| 3 | 继续：跑「按需发现」模式，对比 token 消耗与选错工具的比例 |
| 4 | 读 `book/chapter8.md`：主动发现与创造工具（MCP-Zero、Alita 式进化） |
| 5 | 跑 `chapter8/prompt-auto-optimization/`，走一遍「反馈 → 改写提示词 → 重新评测」闭环 |
| 6 | 跑 `chapter8/self-evolving-tools/`，看 Agent 自己上网找库、沙箱验证、封装成新工具 |
| 7 | 机动日 |

### 第 12 周 · 多模态与实时交互

| 天 | 任务 |
| --- | --- |
| 1 | 读 `book/chapter9.md`：语音三范式（级联 / 端到端全模态 / 全双工） |
| 2 | 跑 `chapter9/streaming-speech/`，体会「首包延迟 vs 过早决策代价」的权衡 |
| 3 | 跑 `chapter9/live-audio/`：配置 ASR + LLM + TTS 链路（这天可能只够配环境） |
| 4 | 继续 `chapter9/live-audio/`：跑通对话，看各段延迟数据 |
| 5 | 读 `book/chapter9.md`：Computer Use 与机器人操作（VLA、Sim2Real） |
| 6 | 跑 `chapter9/controllable-tts/` 或 `chapter9/phone-agent/`（任选其一） |
| 7 | 机动日 |

### 第 13 周 · 多 Agent 协作

| 天 | 任务 |
| --- | --- |
| 1 | 读 `book/chapter10.md`：多 Agent 分类框架（上下文共享/独立 × 对等/管理者/去中心化） |
| 2 | 跑 `chapter10/book-translation/`：先看单 Agent 方案的上下文膨胀 |
| 3 | 继续：跑管理者模式，对比真实 token 数 |
| 4 | 跑 `chapter10/multi-role-transfer/`，理解共享上下文下的自主 handoff |
| 5 | 跑 `chapter10/voice-werewolf/`，理解不共享上下文时的信息权限控制与审计校验 |
| 6 | 读 `book/chapter10.md` 收尾（失败模式、Agent 社会）+ `book/afterword.md` |
| 7 | 机动日 |

### 第 14 周 · 结业项目

| 天 | 任务 |
| --- | --- |
| 1 | 定题 + 设计：选一个你自己的真实需求，写下 Agent 的三要素设计（模型选型 / 上下文策略 / 工具清单） |
| 2 | 搭骨架：主循环 + LLM 调用跑通 |
| 3 | 加工具：至少 2 个自定义工具（第 4 章） |
| 4 | 加上下文管理：KV Cache 友好的消息组织 + 必要时压缩（第 2 章） |
| 5 | 写评估集：10~20 个用例，跑出成功率（第 6 章） |
| 6 | 迭代一轮：针对失败用例改提示词或工具，再跑评估，对比前后分数 |
| 7 | 复盘：把 14 周的每日一句话笔记整理成一份自己的《Agent 设计原则清单》 |

### 进度自查（每 4 周问自己一次）

- 第 4 周末：能否解释「为什么系统提示要稳定在前面、工具结果要追加而不是改写」？
- 第 8 周末：能否给一个 Agent 加上自定义工具，并说清工具描述怎么写才不会被误用？
- 第 12 周末：能否为自己的 Agent 设计一个评估集，并用数据判断一次改动是变好还是变坏？
- 第 14 周末：能否只用「模型 + 上下文 + 工具」三个词，把你见到的任意一个 Agent 产品拆解清楚？

### 如果每天只有 1 小时且想更快见效

可以砍到 **7 周速成路线**（仍是每天 1 小时）：第 1 周（基础）→ 第 2~3 周（上下文工程，全书最关键）→ 第 6 周（工具与 MCP）→ 第 7 周（Coding Agent 上）→ 第 9 周（评估）→ 第 14 周（结业项目）。检索、后训练、多模态、多 Agent 留到有需要时再按主计划补。
