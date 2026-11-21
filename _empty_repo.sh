#!/bin/bash
# 把 GitHub 仓库清成只剩 CNAME（提交说明"发布"），本地文件原样保留、不会丢。
# 之后改好内容，用 ./_publish.sh "说明" 再推上去。
set -e
cd "$(dirname "$0")"

echo "远程仓库：$(git remote get-url origin)"
echo "将用只含 CNAME 的新提交强制覆盖远程 main，网站内容会从 GitHub 上消失。"
read -r -p "确认请输入 yes：" ok
[ "$ok" = "yes" ] || { echo "已取消。"; exit 1; }

git checkout --orphan empty_main
git rm -r -q --cached . 
git add CNAME
git commit -m "发布"
git branch -D main
git branch -m main
git reflog expire --expire=now --all
git gc --prune=now --quiet
git push -f -u origin main
echo
echo "完成：仓库里现在只有 CNAME。本地文件都还在。"
git log --oneline
