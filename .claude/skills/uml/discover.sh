#!/bin/bash
# 엔드포인트 스캔 (간단한 정규식 기반)
echo "Analyzing Controllers for endpoints..."
grep -rE "@RequestMapping|@GetMapping|@PostMapping" mvc-generator-gradle-plugin/src/main/java | \
sed -E 's/.*\/([^/]+)Controller\.java:.*RequestMapping\("([^"]+)"\).*/\1 \2/' | \
sort | uniq > ~/.claude/skills/gstack/uml/endpoints.txt

echo "Endpoints discovered:"
cat ~/.claude/skills/gstack/uml/endpoints.txt
