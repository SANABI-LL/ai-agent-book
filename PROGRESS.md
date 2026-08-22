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

## 当前状态

- **所在阶段**：第 1 周 · 地基
- **下一步**：填好 `.keys.env` 里的 `GEMINI_API_KEY`，跑 `cd chapter1/context && .venv/bin/python main.py`，观察 `Iteration N/10` 的推进
- **待办**：跑完 5 种上下文模式的消融对比

## 日志

| 日期 | 内容 | 一句话收获 |
| --- | --- | --- |
| 2026-08-22 | 环境搭建；写 `lesson1_peek.py` 看上下文组装 | 上下文没有玄学，就是一个 messages 列表；`no_history` 会让 Agent 忘记自己已经调过哪些工具 |
| 2026-08-22 | 给 `chapter1/context` 加上 Gemini / Claude 支持 | OpenAI SDK 的 `base_url` 可换，所以 Agent 逻辑和模型厂商是解耦的 |
| | | |

<!-- 每天学完追加一行，最后一列是当天的「今天我明白了 ___」 -->
