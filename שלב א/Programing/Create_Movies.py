import csv
import random
from datetime import datetime, timedelta

# רשימת סוגי סרטים
movie_types = ['indie', 'blockbuster', 'foreign', 'mid budget', 'Arthouse']

# פונקציה להפקת תאריך אקראי בפורמט dd/mm/yyyy
def generate_release_date(start_year=1990, end_year=2025):
    start_date = datetime(start_year, 1, 1)
    end_date = datetime(end_year, 12, 31)
    delta = end_date - start_date
    random_days = random.randint(0, delta.days)
    date = start_date + timedelta(days=random_days)
    return date.strftime('%d/%m/%Y')  # פורמט: 07/03/2010

# יצירת הקובץ
with open('movies.csv', mode='w', newline='') as file:
    writer = csv.writer(file)
    writer.writerow(['Release_Date', 'Duration', 'Movie_type', 'Title_ID'])

    for _ in range(1000):
        release_date = generate_release_date()
        duration = random.randint(70, 240)  # סרטים בין שעה ו־10 דקות ל־4 שעות
        movie_type = random.choice(movie_types)
        title_id = random.randint(0, 9999)  # עד 4 ספרות

        writer.writerow([release_date, duration, movie_type, title_id])
