#!/usr/bin/env bash
# One-command push (Linux/macOS/Git Bash). Usage: ./push.sh [commit message]
set -e
cd "$(dirname "$0")"
[ -d .git ] || { git init; git branch -M main; }
git remote get-url origin >/dev/null 2>&1 || { read -r -p "GitHub repo URL (https://github.com/USER/REPO.git): " URL; git remote add origin "$URL"; }
git add -A
git commit -m "${1:-Update BedFight}" || echo "Nothing new to commit."
BR=$(git rev-parse --abbrev-ref HEAD)
git push -u origin "$BR" || { echo; echo "Push rejected (remote has other history). Retrying with --force-with-lease..."; git push -u --force-with-lease origin "$BR"; }
echo "Pushed. Now open the Actions tab on GitHub and wait for the green check."
