"""
第 1 课：亲眼看看 Agent 的「眼睛」里有什么。
不需要 API Key —— 我们只调用仓库里真实的上下文组装逻辑。
运行: .venv/bin/python lesson1_peek.py
"""
import json
from agent import ContextAwareAgent, ContextMode

DUMMY = "sk-not-a-real-key"  # 只构造对象，不发请求

def build_agent(mode):
    a = ContextAwareAgent(api_key=DUMMY, context_mode=mode,
                          provider="siliconflow", verbose=False)
    # 手工伪造一段「已经跑了两轮」的轨迹，模拟真实 ReAct 过程
    a.conversation_history += [
        {"role": "user", "content": "把 PDF 里的金额换算成人民币并求和"},
        {"role": "assistant", "content": "我先解析 PDF。",
         "tool_calls": [{"id": "c1", "type": "function",
                         "function": {"name": "parse_pdf",
                                      "arguments": '{"url":"http://x/a.pdf"}'}}]},
        {"role": "tool", "tool_call_id": "c1",
         "content": json.dumps({"amounts": ["120 USD", "80 EUR"]})},
        {"role": "assistant", "content": "现在换算美元。",
         "tool_calls": [{"id": "c2", "type": "function",
                         "function": {"name": "convert_currency",
                                      "arguments": '{"amount":120,"from_currency":"USD","to_currency":"CNY"}'}}]},
        {"role": "tool", "tool_call_id": "c2",
         "content": json.dumps({"converted": 864.0})},
    ]
    return a

def show(mode):
    a = build_agent(mode)
    msgs = a._prepare_messages_for_api()   # ← 真实代码，不是我编的
    print(f"\n{'='*62}\n模式 = {mode.value}  →  模型这一轮实际看到 {len(msgs)} 条消息\n{'='*62}")
    for i, m in enumerate(msgs):
        role = m["role"]
        body = (m.get("content") or "")[:60].replace("\n", " ")
        tc = m.get("tool_calls")
        extra = f"  +调用[{tc[0]['function']['name']}]" if tc else ""
        print(f"  {i}. [{role:9}] {body}{extra}")

for mode in (ContextMode.FULL, ContextMode.NO_HISTORY):
    show(mode)

print("\n" + "="*62)
print("工具是本地真跑的，验证一下（不经过 LLM）：")
from agent import ToolRegistry
print("  calculate('864 + 80*7.8') =",
      ToolRegistry.calculate("864 + 80*7.8"))
