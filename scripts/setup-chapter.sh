#!/usr/bin/env bash
# 一条命令把某个实验项目准备好（Mac / Linux / Windows Git Bash）
# 用法: bash scripts/setup-chapter.sh chapter1/context
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PROJECT="${1:-}"

if [ -z "$PROJECT" ]; then
  echo "用法: bash scripts/setup-chapter.sh <项目目录>   例如 chapter1/context"; exit 2
fi
DIR="$ROOT/$PROJECT"
[ -d "$DIR" ] || { echo "❌ 目录不存在: $PROJECT"; exit 1; }

PY=python3; command -v python3 >/dev/null 2>&1 || PY=python

echo "📦 [1/3] 创建虚拟环境 $PROJECT/.venv"
[ -d "$DIR/.venv" ] || "$PY" -m venv "$DIR/.venv"
VENV_PY="$DIR/.venv/bin/python"
[ -x "$VENV_PY" ] || VENV_PY="$DIR/.venv/Scripts/python.exe"   # Git Bash on Windows

echo "📦 [2/3] 安装依赖"
"$VENV_PY" -m pip install -q --upgrade pip
if [ -f "$DIR/requirements.txt" ]; then
  "$VENV_PY" -m pip install -q -r "$DIR/requirements.txt"
  echo "  ✅ requirements.txt 安装完成"
else
  echo "  ⚠️  该项目没有 requirements.txt，跳过"
fi

echo "🔑 [3/3] 注入 API Key"
"$PY" "$ROOT/scripts/inject_keys.py" "$PROJECT" || true

echo
echo "🎉 就绪。运行方式："
echo "   cd $PROJECT && .venv/bin/python main.py"
