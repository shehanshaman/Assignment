import csv
import pandas as pd

with open('trainset.txt', 'r') as in_file:
    stripped = []
    for line in in_file:
        sen = line.strip()
        stripped.append(sen)
        
    lines = (line.split("\t") for line in stripped if line)
    with open('log.csv', 'w') as out_file:
        writer = csv.writer(out_file)
        writer.writerow(('class', 'title','date','body'))
        writer.writerows(lines)

fileName = 'log.csv'
data = pd.read_csv(fileName)
Y = data['class']
data.drop(['class'], axis=1, inplace=True)
X = data['title'] + " " + data['date'] + " " + data['body'] 
print(X)

