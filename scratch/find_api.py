import json
import sys

def find_request(item):
    if "item" in item:
        for i in item["item"]:
            find_request(i)
    elif "request" in item:
        url = ""
        if "url" in item["request"]:
            if isinstance(item["request"]["url"], dict):
                url = item["request"]["url"].get("raw", "")
            else:
                url = item["request"]["url"]
        
        body_str = json.dumps(item["request"].get("body", {}))
        if "utr" in body_str.lower() or "receipt" in body_str.lower():
            print("Name:", item.get("name"))
            print("URL:", url)
            print("Body:", json.dumps(item["request"]["body"], indent=2))
            print("-" * 40)

with open('Distributor_Mobile_APIs.postman_collection (2).json', 'r') as f:
    data = json.load(f)

find_request(data)
