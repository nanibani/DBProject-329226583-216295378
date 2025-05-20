import csv
import random
from datetime import datetime, timedelta

def generate_random_date(start_year=2000, end_year=2025):
    start_date = datetime(start_year, 1, 1)
    end_date = datetime(end_year, 12, 31)
    delta = end_date - start_date
    random_days = random.randint(0, delta.days)
    date = start_date + timedelta(days=random_days)
    return date.strftime('%-d-%b-%Y')  # דוגמה: 9-Jun-2016

with open('episodes.csv', mode='w', newline='') as file:
    writer = csv.writer(file)
    writer.writerow(['Season_number', 'Episode_Number', 'Duration', 'Date_Aired', 'Title_ID'])

    total_rows = 1000
    season = 1
    episode = 1
    episodes_in_season = random.randint(10, 30)

    for _ in range(total_rows):
        duration = random.randint(20, 60)
        date_aired = generate_random_date()
        title_id = random.randint(0, 9999)  # מספר עד 4 ספרות, ללא אפסים מובילים

        writer.writerow([season, episode, duration, date_aired, title_id])

        episode += 1
        if episode > episodes_in_season:
            season += 1
            episode = 1
            episodes_in_season = random.randint(10, 30)
