import os
import re

service_locator_path = 'lib/core/di/service_locator.dart'
repo_dir = 'lib/data/repository'

with open(service_locator_path, 'r') as f:
    locator_code = f.read()

unregistered = []

for filename in os.listdir(repo_dir):
    if not filename.endswith('.dart'): continue
    filepath = os.path.join(repo_dir, filename)
    with open(filepath, 'r') as f:
        code = f.read()
    
    # Find the class name implementing the repository
    match = re.search(r'class\s+([A-Za-z0-9_]+)\s+implements\s+[A-Za-z0-9_]+', code)
    if match:
        class_name = match.group(1)
        if class_name not in locator_code:
            unregistered.append((filename, class_name))

print("Unregistered repositories:")
for f, c in unregistered:
    print(f"- {f}: {c}")

# Check UseCases
unregistered_usecases = []
usecase_dir = 'lib/domain/usecase'
for root, _, files in os.walk(usecase_dir):
    for filename in files:
        if not filename.endswith('.dart'): continue
        filepath = os.path.join(root, filename)
        with open(filepath, 'r') as f:
            code = f.read()
        
        # Find the use case class name
        match = re.search(r'class\s+([A-Za-z0-9_]+UseCase)\b', code)
        if match:
            class_name = match.group(1)
            if class_name not in locator_code:
                unregistered_usecases.append((filename, class_name))

print("\nUnregistered usecases:")
for f, c in unregistered_usecases:
    print(f"- {f}: {c}")
