import sys
import re

commit_msg_file = sys.argv[1]

with open(commit_msg_file, 'r', encoding='utf-8') as f:
    content = f.read()

if "rebase-todo" in commit_msg_file:
    content = re.sub(r'^pick (.{7} fix: CalendarSheetView custom init parameter missing matches argument)', r'reword \1', content, flags=re.MULTILINE)
    content = re.sub(r'^pick (.{7} fix: revert ScheduleView corruption and apply text/calendar limits)', r'reword \1', content, flags=re.MULTILINE)
else:
    if "fix: CalendarSheetView custom init parameter missing matches argument" in content:
        content = content.replace("fix: CalendarSheetView custom init parameter missing matches argument", "fix: CalendarSheetView 초기화 파라미터 누락 수정")
    if "fix: revert ScheduleView corruption and apply text/calendar limits" in content:
        content = content.replace("fix: revert ScheduleView corruption and apply text/calendar limits", "fix: ScheduleView 코드 깨짐 복구 및 달력 연도 제한 적용")

with open(commit_msg_file, 'w', encoding='utf-8') as f:
    f.write(content)
