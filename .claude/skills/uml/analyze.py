import re
import sys

def analyze_controller(controller_name):
    path = f"mvc-generator-gradle-plugin/src/main/java/com/cnbsoft/generator/task/{controller_name}.java"
    # 간단한 정적 분석: Controller 내부에서 호출되는 Service 메서드 추출
    # 실제로는 전체 프로젝트의 AST를 파싱하는 것이 좋으나, 여기선 패턴 매칭 사용
    with open(path, 'r') as f:
        content = f.read()
    
    # 단순 시퀀스 예시 추출 (정교화 단계)
    methods = re.findall(r"(\w+Service)\.(\w+)\(", content)
    return methods

# 추후 유스케이스 분석 로직 고도화 예정
print(analyze_controller("GenerateMvcInteractiveTask"))
