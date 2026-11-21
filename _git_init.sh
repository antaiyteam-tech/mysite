#!/bin/bash
# 只需运行一次：把本文件夹接到 GitHub 仓库 antaiyteam-tech/mysite（不会覆盖线上内容）
set -e
cd "$(dirname "$0")"
[ -d .git ] || git init -b main
git remote remove origin 2>/dev/null || true
git remote add origin git@github-antaiy:antaiyteam-tech/mysite.git
git fetch origin
git reset origin/main
echo
echo "=== 本地与线上的差异（M=修改 ??=新增 D=线上有本地没有）==="
git status --short
echo
echo "确认无误后运行：./_publish.sh \"首次同步\""
