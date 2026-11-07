#!/usr/bin/env bash
# sections/*.html 조각을 shell.html의 <!--SECTIONS--> 자리에 끼워 kearney-encyclopedia.html 생성
set -e
cd "$(dirname "$0")"
tmp=$(mktemp)
for f in sections/*.html; do cat "$f"; echo; done > "$tmp"
awk -v f="$tmp" '/<!--SECTIONS-->/{while((getline l < f)>0) print l; next} {print}' shell.html > kearney-encyclopedia.html
rm -f "$tmp"
echo "built kearney-encyclopedia.html ($(wc -c < kearney-encyclopedia.html) bytes, $(ls sections/*.html | wc -l) sections)"
