import os
import re

api_routes_file = "lib/core/constants/api_routes.dart"

with open(api_routes_file, 'r') as f:
    content = f.read()

# Find all static const variable names in ApiRoutes
api_vars = re.findall(r'static\s+const\s+(?:String\s+)?([A-Za-z0-9_]+)\s*=', content)

used_vars = set()

for root, _, files in os.walk("lib"):
    for file in files:
        if not file.endswith('.dart'): continue
        filepath = os.path.join(root, file)
        
        # skip the constants file itself
        if "api_routes.dart" in filepath: continue
            
        with open(filepath, 'r') as f:
            file_content = f.read()
            
        for var in api_vars:
            if f"ApiRoutes.{var}" in file_content:
                used_vars.add(var)

print("UNUSED API ROUTES:")
for var in api_vars:
    if var not in used_vars:
        print(f"- {var}")
