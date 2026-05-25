#!/bin/bash
USECASE=$1
OUT_DIR="./docs/uml/$USECASE"
CONFIG_FILE="$(dirname "${BASH_SOURCE[0]}")/config.json"
if [ -z "$USECASE" ] || [ ! -d "$OUT_DIR" ]; then echo "Usage: /uml [usecase_name]"; exit 1; fi

# 분석내용 및 HTML 헤더 생성
ANALYSIS_HTML=$(marked < "$OUT_DIR/analysis.md")
TITLE_CASE=$(echo "$USECASE" | awk '{print toupper(substr($0,1,1))tolower(substr($0,2))}')

cat <<HTML > "$OUT_DIR/index.html"
<!DOCTYPE html>
<html lang="ko">
<head><meta charset="UTF-8"><link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/github-markdown-css/5.5.0/github-markdown.min.css">
<style>body{padding:40px; background:#f6f8fa;} .markdown-body{max-width:900px; margin:auto; background:white; padding:40px;} img{max-width:100%;}</style></head>
<body class="markdown-body">
    <h1>Architecture: $TITLE_CASE</h1>
    $ANALYSIS_HTML
    <hr>
HTML

for puml in "$OUT_DIR"/*.puml; do
    [ -e "$puml" ] || continue
    FILENAME=$(basename "$puml" .puml)
    SVG_FILE="$OUT_DIR/$FILENAME.svg"
    TITLE=$(grep "@startuml" "$puml" | head -n 1 | sed 's/@startuml//g' | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')
    [ -z "$TITLE" ] && TITLE=$(echo "${FILENAME}" | awk '{print toupper(substr($0,1,1))tolower(substr($0,2))}')
    
    java -jar "/opt/homebrew/Cellar/plantuml/1.2026.4/libexec/plantuml.jar" -tsvg "$puml"
    
    cat <<HTML >> "$OUT_DIR/index.html"
    <h3>$TITLE</h3>
    <img src="$FILENAME.svg" alt="$TITLE" />
HTML
done
echo "</body></html>" >> "$OUT_DIR/index.html"
open "$OUT_DIR/index.html"
