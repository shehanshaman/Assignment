import csv
import pandas as pd
import numpy as np

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
#print(X)

from nltk.stem.porter import PorterStemmer # for stemming
from sklearn.feature_extraction.text import CountVectorizer # for extract words frequncies 

porter_stemmer = PorterStemmer()
def stemming_tokenizer(str_input):
    words = re.sub(r"[^a-z]", " ", str_input).lower().split()
    words = [porter_stemmer.stem(word) for word in words]
    return words


import re

vec = CountVectorizer(stop_words='english', tokenizer=stemming_tokenizer)

matrix = vec.fit_transform(X)

results = pd.DataFrame(matrix.toarray(), columns=vec.get_feature_names())
#print(matrix)

from sklearn.naive_bayes import MultinomialNB

clf = MultinomialNB().fit(matrix, Y)

predicted = clf.predict(matrix)
np.mean(predicted == Y)

from sklearn.model_selection import train_test_split, cross_val_score

nclf=MultinomialNB() # clf is a classifier.
#nclf.fit(X,Y)
X_train , X_test , Y_train , Y_test = train_test_split(matrix, Y, test_size =0.333,random_state =0)
#nclf.fit(X_train ,Y_train) # clf is a classifier.
Y_pred = nclf.fit(X_train , Y_train ).predict(X_test)
#print(Y_pred)
np.mean(Y_pred == Y_test)


#predict classes of sentences in testsetwithoutlabels.txt file
with open('testsetwithoutlabels.txt', 'r') as in_file:
    stripped = []
    for line in in_file:
        sen = line.strip()
        stripped.append(sen)

    lines = (line.split("\t") for line in stripped if line)
    with open('testsetwithoutlabels.csv', 'w') as out_file:
        writer = csv.writer(out_file)
        writer.writerow(('title','date','body'))
        writer.writerows(lines)

fileName = 'testsetwithoutlabels.csv'
test_data = pd.read_csv(fileName)

#combine title date body cols
test_data['data'] = test_data[['title','date','body']].astype(str).sum(axis=1)

#predict testsetwithoutlabels.txt values
k=0
for i in clf.predict(vec.transform(test_data['data'])):
    print ("{0} {1}".format(i, test_data['data'][k]) )

