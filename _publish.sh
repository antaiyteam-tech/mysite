#!/bin/bash
# 一键发布 antaiy.com：./_publish.sh "说明文字"
set -e
cd "$(dirname "$0")"
git add -A
git commit -m "${1:-更新网站}" || echo "（没有新变化，无需提交）"
git push origin main
echo "已推送。等 1-2 分钟后打开 https://www.antaiy.com/ 查看。"
