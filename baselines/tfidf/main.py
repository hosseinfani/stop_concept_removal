import os
import numpy as np
import pandas as pd
from sklearn.feature_extraction.text import TfidfVectorizer


folder_name = 'data/cud' #path to the document directory. cud: concept,user,daily, that is all the concepts of tweets of a user in a day is considered a single doc.
doc_list = []
label_list = [name for name in os.listdir(folder_name)]
file_list = [folder_name+'/'+name for name in label_list]
for file in file_list:#[:10]
    st = open(file,'r').read()
    doc_list.append(st)
    #print (file)
print ('Found %s documents under the dir %s .....'%(len(doc_list),folder_name))

tfidfvec = TfidfVectorizer(analyzer='word',token_pattern=r"\b[0-9]+\b")
tfidf = tfidfvec.fit_transform(doc_list)
weights = np.asarray(tfidf.mean(axis=0)).ravel().tolist()
weights_df = pd.DataFrame({'term': tfidfvec.get_feature_names(), 'weight': weights})
weights_df.sort_values(by='weight', ascending=False).to_csv('output/tfidf/tfidf_cud_values.txt', index=False)
