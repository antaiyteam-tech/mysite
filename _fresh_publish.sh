#!/bin/bash
# 清空本仓库的全部历史，把当前文件当作"第一次提交"发布（提交说明只有"发布"）。
# 会强制覆盖 GitHub 上的 main 分支。旧历史备份在 _backup_* 里（不会上传）。
set -e
cd "$(dirname "$0")"

echo "远程仓库：$(git remote get-url origin)"
echo "将清空历史并强制覆盖远程 main，旧历史在 GitHub 页面上将无法恢复。"
read -r -p "确认请输入 yes：" ok
[ "$ok" = "yes" ] || { echo "已取消。"; exit 1; }

# 1. 备份旧历史
BK="_backup_$(date +%Y%m%d)/webgan_历史备份_$(date +%Y%m%d-%H%M%S).bundle"
mkdir -p "$(dirname "$BK")"
git bundle create "$BK" --all
echo "已备份旧历史到：$BK"

# 2. 用当前文件建一个全新的、没有历史的分支，替换 main
git checkout --orphan fresh_main
git add -A
git commit -m "发布"
git branch -D main
git branch -m main
git reflog expire --expire=now --all
git gc --prune=now --quiet

# 3. 强制推送（需要触碰 YubiKey）
git push -f -u origin main
echo
echo "完成：仓库现在只有 1 个提交。"
git log --oneline
