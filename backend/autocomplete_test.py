import requests
import getch

query = ""

while True:
    char = getch.getche()
    print()
    if char == "X":
        query = ""
        continue
    query += char
    print(query)
    print(requests.get(f'http://localhost:8000/exercises/{query}').json())
