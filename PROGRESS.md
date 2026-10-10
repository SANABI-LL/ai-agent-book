# 学习进度（跨设备同步）

> 这是我自己的学习日志。**它跟着 git 走**，所以在 Mac 上写完 push，在 PC 上 pull 下来就能接着看。
> 计划见 [`LEARNING_PLAN.md`](LEARNING_PLAN.md) 第八节《7 周速成路线》。

## 换设备时的三步

```bash
git pull                                  # 1. 拉最新进度
bash scripts/setup-chapter.sh chapter1/context   # 2. 准备当前项目（PC 用 .\scripts\setup-chapter.ps1）
# 3. 看下面的日志，从「下一步」那行接着做
```

首次在一台新设备上，还要先建一次 Key 文件（**不走 git，见下方说明**）：

```bash
cp keys.env.example .keys.env    # 然后手工填入你的 Key
```

## 设备与路径

| 设备 | 仓库位置 |
| --- | --- |
| PC | `H:\Dropbox\Academy\Claude Code\AI-AGENT-BOOK`（**Dropbox 需排除 `.git` 和 `.venv`**，见下） |
| Mac | 待定 |

**同步走 git，不要走 Dropbox。** 两台设备靠 `git pull` / `git push` 同步，GitHub 是唯一真相。
让 Dropbox 也同步这个文件夹会出两类问题：

1. **`.git` 被 Dropbox 同步会损坏仓库**——git 写 `index.lock`、打包对象时若 Dropbox 正在半同步，
   会出现 "another git process seems to be running" 或对象损坏，且会生成 `xxx (conflicted copy).py`
   这类文件悄悄污染代码。
2. **`.venv` 体积巨大且不跨平台**——单个项目的 venv 就有 269 MB / 约 11000 个文件，全书 69 个项目。
   而且 Mac 装的是 macOS 二进制，同步到 PC 根本不能用，纯属拖垮 Dropbox。

**在 PC 上让 Dropbox 忽略这两个目录**（PowerShell，在仓库根目录执行）：

```powershell
Set-Content -Path ".git"   -Stream com.dropbox.ignored -Value 1
Get-ChildItem -Path . -Recurse -Directory -Filter ".venv" | ForEach-Object {
    Set-Content -Path $_.FullName -Stream com.dropbox.ignored -Value 1
}
```

每次在新项目里建了 `.venv`，重跑一次上面第二条即可。

## 当前状态

- **所在阶段**：第 1 周 · 地基（计划见 `LEARNING_PLAN.md` 第八节 · 7 周速成路线）
- **工作方式**：本地 clone（Mac + PC），用 VS Code 里的 Claude Code 操作；同步走 git，不走 Dropbox
- **已完成**：第 1 周 Day 1~4 的概念部分（核心公式、ReAct 循环、消息列表结构）；
  `chapter1/context` 已支持 Gemini / Claude；写了离线预习脚本 `chapter1/context/lesson1_peek.py`
- **下一步（Day 5）**：在本机准备环境并首次跑通
  1. `copy keys.env.example .keys.env`，填 `LLM_PROVIDER=gemini` 和 `GEMINI_API_KEY`
  2. `powershell -ExecutionPolicy Bypass -File .\scripts\setup-chapter.ps1 chapter1/context`（Mac: `bash scripts/setup-chapter.sh chapter1/context`）
  3. 跑 `main.py`，输入 `samples` 再 `sample 1`，观察日志里 `Iteration N/10` 怎么推进
- **待办（Day 6）**：跑完 5 种上下文模式（`full` / `no_history` / `no_reasoning` / `no_tool_calls` / `no_tool_results`）的消融对比，
  记录每种模式「转了几轮、调了哪些工具、答案对不对」，填成对照表

## 日志

| 日期 | 内容 | 一句话收获 |
| --- | --- | --- |
| 2026-08-22 | 环境搭建；写 `lesson1_peek.py` 看上下文组装 | 上下文没有玄学，就是一个 messages 列表；`no_history` 会让 Agent 忘记自己已经调过哪些工具 |
| 2026-08-22 | 给 `chapter1/context` 加上 Gemini / Claude 支持 | OpenAI SDK 的 `base_url` 可换，所以 Agent 逻辑和模型厂商是解耦的 |
| | | |

<!-- 每天学完追加一行，最后一列是当天的「今天我明白了 ___」 -->
