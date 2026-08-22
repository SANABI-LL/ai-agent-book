#!/usr/bin/env python3
"""把仓库根目录 .keys.env 里的 Key 合并进某个项目的 .env。

用法: python scripts/inject_keys.py <项目目录>
- 若项目目录下没有 .env，则先从 env.example / .env.example 复制一份
- .keys.env 中非空的键会覆盖 .env 中的同名键；不存在的键则追加
- 跨平台：Mac / Windows / Linux 通用
"""
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent


def parse_env(path: Path) -> dict:
    out = {}
    if not path.exists():
        return out
    for line in path.read_text(encoding="utf-8").splitlines():
        line = line.strip()
        if not line or line.startswith("#") or "=" not in line:
            continue
        k, v = line.split("=", 1)
        out[k.strip()] = v.strip()
    return out


def main() -> int:
    if len(sys.argv) < 2:
        print("用法: python scripts/inject_keys.py <项目目录>")
        return 2
    # 允许用户写 chapter1\context 或 chapter1/context
    arg = sys.argv[1].replace("\\", "/").strip().strip("/")
    project = (ROOT / arg).resolve()
    if not project.is_dir():
        print(f"❌ 目录不存在: {project}")
        return 1

    keys_file = ROOT / ".keys.env"
    if not keys_file.exists():
        print("❌ 找不到 .keys.env。请先执行: cp keys.env.example .keys.env 并填入你的 Key")
        return 1

    keys = {k: v for k, v in parse_env(keys_file).items() if v}
    if not keys:
        print("⚠️  .keys.env 里所有值都是空的，没什么可注入的")
        return 1

    env_path = project / ".env"
    if not env_path.exists():
        for candidate in ("env.example", ".env.example"):
            src = project / candidate
            if src.exists():
                env_path.write_text(src.read_text(encoding="utf-8"), encoding="utf-8")
                print(f"  从 {candidate} 创建了 .env")
                break
        else:
            env_path.write_text("", encoding="utf-8")
            print("  该项目没有 env 模板，创建了空 .env")

    lines = env_path.read_text(encoding="utf-8").splitlines()
    remaining = dict(keys)
    for i, line in enumerate(lines):
        stripped = line.strip()
        if not stripped or stripped.startswith("#") or "=" not in stripped:
            continue
        k = stripped.split("=", 1)[0].strip()
        if k in remaining:
            lines[i] = f"{k}={remaining.pop(k)}"
    for k, v in remaining.items():
        lines.append(f"{k}={v}")

    env_path.write_text("\n".join(lines) + "\n", encoding="utf-8")
    print(f"✅ 已注入 {len(keys)} 个 Key 到 {env_path.relative_to(ROOT)}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
