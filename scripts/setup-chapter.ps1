# 一条命令把某个实验项目准备好（Windows PowerShell）
# 用法: .\scripts\setup-chapter.ps1 chapter1/context
param([Parameter(Mandatory=$true)][string]$Project)
$ErrorActionPreference = "Stop"

$Root = Split-Path -Parent $PSScriptRoot
$Dir  = Join-Path $Root $Project
if (-not (Test-Path $Dir)) { Write-Error "目录不存在: $Project"; exit 1 }

Write-Host "[1/3] 创建虚拟环境 $Project/.venv"
$VenvPy = Join-Path $Dir ".venv\Scripts\python.exe"
if (-not (Test-Path $VenvPy)) { python -m venv (Join-Path $Dir ".venv") }

Write-Host "[2/3] 安装依赖"
& $VenvPy -m pip install -q --upgrade pip
$Req = Join-Path $Dir "requirements.txt"
if (Test-Path $Req) {
    & $VenvPy -m pip install -q -r $Req
    Write-Host "  requirements.txt 安装完成"
} else {
    Write-Host "  该项目没有 requirements.txt，跳过"
}

Write-Host "[3/3] 注入 API Key"
python (Join-Path $Root "scripts\inject_keys.py") $Project

Write-Host ""
Write-Host "就绪。运行方式:"
Write-Host "   cd $Project; .venv\Scripts\python.exe main.py"
