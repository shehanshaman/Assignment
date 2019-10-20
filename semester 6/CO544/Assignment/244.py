# f= open("trainset.txt","r")
# #print(f.read())
# x = []
# for line in f:
#         fields = line.split("\t")
#         #print(fields[0])
#         x.append(fields[0]) 
        
# print(x);

# import re #regex
# from nltk.corpus import stopwords
# from nltk.stem import PorterStemmer

# def preprocess(eliment):
      
#     eliment = re.sub(r'([^\s\w]|_)+', '', eliment) # Remove all the special characters except space
#     eliment = eliment.lower()
#     eliment = re.sub(r'\s+', ' ', eliment, flags=re.I)# Substituting multiple spaces with single space

#     all_words = eliment.split()
#     en_stops = set(stopwords.words('english')) #stopword handle
#     eliment = ""
#     ps = PorterStemmer() #stemming handle  

#     for word in all_words: 
#         if word not in en_stops:   
#             eliment +=  ps.stem(word) +" "

#     return eliment 



import csv
import pandas as pd

with open('trainset.txt', 'r') as in_file:
    stripped = []
    for line in in_file:
        sen = line.strip()
        stripped.append(sen)
#         wordstring = stripped[0]
#         wordlist = wordstring.split()

#         wordfreq = []
#         for w in wordlist:
#             wordfreq.append(wordlist.count(w))

#         print("String\n" + wordstring +"\n")
#         print("List\n" + str(wordlist) + "\n")
#         print("Frequencies\n" + str(wordfreq) + "\n")
#         print("Pairs\n" + str(zip(wordlist, wordfreq)))
#         for element1, element2 in zip(wordlist, wordfreq):
#             print(element1, element2)
#         #stripped[0] = #print (stripped[0])
        
    lines = (line.split("\t") for line in stripped if line)
    with open('log.csv', 'w') as out_file:
        writer = csv.writer(out_file)
        writer.writerow(('class', 'title','date','body'))
        writer.writerows(lines)

fileName = 'log.csv'
data = pd.read_csv(fileName)
Y = data['class']
data.drop(['class'], axis=1, inplace=True)
X = data
#print(X)


#x = preprocess(x)

from sklearn.feature_extraction.text import CountVectorizer
count_vect = CountVectorizer()

X_train_counts = count_vect.fit_transform(X)
X_train_counts.shape
print(X_train_counts)

from collections import Counter

#Counter(X['title']).most_common()



# Read data from trainset.txt
train_df = pd.read_csv('Data/trainset.txt',sep="\t" )
# set colums name
train_df.columns = ["class", "title", "date", "body"]
# Combine  body and title columns and create data column
# because of titles also gives some clues about documents 
train_df['data'] = df[['title', 'body']].apply(lambda x: ''.join(x), axis=1)

train_df = df[df.body != '(NO TEXT)']
train_df.shape


from nltk.stem.porter import PorterStemmer # for stemming
from sklearn.feature_extraction.text import CountVectorizer # for extract words frequncies 


porter_stemmer = PorterStemmer()
def stemming_tokenizer(str_input):
    words = re.sub(r"[^a-z]", " ", str_input).lower().split()
    words = [porter_stemmer.stem(word) for word in words]
    return words


vec = CountVectorizer(stop_words='english', tokenizer=stemming_tokenizer)


matrix = vec.fit_transform(x['body'])


results = pd.DataFrame(matrix.toarray(), columns=vec.get_feature_names())
results