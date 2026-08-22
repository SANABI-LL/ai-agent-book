# 一条命令把某个实验项目准备好（Windows PowerShell）
# 用法: .\scripts\setup-chapter.ps1 chapter1/context
param([Parameter(Mandatory=$true)][string]$Project)
$ErrorActionPreference = "Stop"

$Root = Split-Path -Parent $PSScriptRoot
$Dir  = Join-Path $Root $Project
if (-not (Test-Path $Dir)) {
    Write-Host "[X] 目录不存在: $Project" -ForegroundColor Red
    Write-Host "    请确认你在仓库根目录下运行，且路径写法形如 chapter1/context"
    exit 1
}

# --- 找到可用的 python：优先 py 启动器，其次 python ---
$PyCmd = $null
foreach ($c in @("py", "python")) {
    if (Get-Command $c -ErrorAction SilentlyContinue) {
        $ver = & $c -c "import sys;print(f'{sys.version_info.major}.{sys.version_info.minor}')" 2>$null
        if ($LASTEXITCODE -eq 0 -and [version]$ver -ge [version]"3.10") { $PyCmd = $c; break }
    }
}
if (-not $PyCmd) {
    Write-Host "[X] 没找到 Python 3.10+。" -ForegroundColor Red
    Write-Host "    去 https://www.python.org/downloads/ 安装，安装时务必勾选 'Add python.exe to PATH'，"
    Write-Host "    装完关掉这个窗口重开一个再试。"
    exit 1
}
Write-Host "[i] 使用 $PyCmd (Python $(& $PyCmd -c 'import sys;print(sys.version.split()[0])'))" -ForegroundColor DarkGray

$VenvDir = Join-Path $Dir ".venv"
$VenvPy  = Join-Path $VenvDir "Scripts\python.exe"

Write-Host "[1/3] 创建虚拟环境 $Project\.venv"
if (-not (Test-Path $VenvPy)) {
    & $PyCmd -m venv $VenvDir
    if (-not (Test-Path $VenvPy)) { Write-Host "[X] venv 创建失败" -ForegroundColor Red; exit 1 }
} else {
    Write-Host "      已存在，跳过" -ForegroundColor DarkGray
}

Write-Host "[2/3] 安装依赖（首次可能要几分钟）"
& $VenvPy -m pip install -q --upgrade pip
$Req = Join-Path $Dir "requirements.txt"
if (Test-Path $Req) {
    & $VenvPy -m pip install -q -r $Req
    if ($LASTEXITCODE -ne 0) {
        Write-Host "[!] 有依赖装失败了，但通常不影响主流程，先继续。" -ForegroundColor Yellow
    } else {
        Write-Host "      requirements.txt 安装完成" -ForegroundColor Green
    }
} else {
    Write-Host "      该项目没有 requirements.txt，跳过" -ForegroundColor DarkGray
}

Write-Host "[3/3] 注入 API Key"
if (-not (Test-Path (Join-Path $Root ".keys.env"))) {
    Write-Host "[!] 还没有 .keys.env。先执行：" -ForegroundColor Yellow
    Write-Host "      copy keys.env.example .keys.env" -ForegroundColor Yellow
    Write-Host "    然后用记事本填入你的 Key，再重跑本脚本。" -ForegroundColor Yellow
} else {
    & $PyCmd (Join-Path $Root "scripts\inject_keys.py") $Project
}

Write-Host ""
Write-Host "完成。运行方式：" -ForegroundColor Green
Write-Host "   cd $Project"
Write-Host "   .venv\Scripts\python.exe main.py"
