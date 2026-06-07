import re
import os

pr_path = 'KScout/Models/PlayerRanking.swift'
with open(pr_path, 'r', encoding='utf-8') as f:
    pr_content = f.read()

pr_content = pr_content.replace('let id: UUID', 'let id: Int')
pr_content = pr_content.replace('id: UUID = UUID()', 'id: Int = Int.random(in: 100000...999999)')

with open(pr_path, 'w', encoding='utf-8') as f:
    f.write(pr_content)

rvm_path = 'KScout/ViewModels/RankingViewModel.swift'
with open(rvm_path, 'r', encoding='utf-8') as f:
    rvm_content = f.read()

# Replace API mapping
rvm_content = re.sub(r'id: UUID\(\),\s*rank: index', r'id: item.player.id,\n                            rank: index', rvm_content)

# Remove id: UUID(), from mock data
rvm_content = rvm_content.replace('PlayerRanking(id: UUID(), ', 'PlayerRanking(')

with open(rvm_path, 'w', encoding='utf-8') as f:
    f.write(rvm_content)

print('Updated successfully.')
