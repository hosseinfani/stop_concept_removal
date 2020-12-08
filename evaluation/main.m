mallet_base = 'mallet/bin/';
mallet_corpus = 'data/cu';
topicCount = 50;
wordCount = 150;
threadCount = 40;
intervals = {'Daily', 'Hourly'};

%evaluation = 'threshold';
evaluation = 'topk';
output_base = [evaluation '/'];

stoplist_base = ['../output/' evaluation '/fourier/']; 
RunLda(mallet_base, mallet_corpus, stoplist_base, topicCount, wordCount, threadCount, output_base, intervals)
SaveLdaMetrics(output_base, intervals, 'Ftp'); 

stoplist_base = ['../output/' evaluation '/wavelet/']; 
RunLda(mallet_base, mallet_corpus, stoplist_base, topicCount, wordCount, threadCount, output_base, intervals)
SaveLdaMetrics(output_base, intervals, 'Wvl'); 

stoplist_base = ['../output/' evaluation '/xcr/']; 
RunLda(mallet_base, mallet_corpus, stoplist_base, topicCount, wordCount, threadCount, output_base, intervals)
SaveLdaMetrics(output_base, intervals, 'Xcr'); 

stoplist_base = ['../output/' evaluation '/tfidf/']; 
intervals = {'CUD'};
RunLda(mallet_base, mallet_corpus, stoplist_base, topicCount, wordCount, threadCount, output_base, intervals)
SaveLdaMetrics(output_base, intervals, 'Tfidf'); 

stoplist_base = ['../output/' evaluation '/random/']; 
intervals = {'CUD'};
RunLda(mallet_base, mallet_corpus, stoplist_base, topicCount, wordCount, threadCount, output_base, intervals)
SaveLdaMetrics(output_base, intervals, 'NA'); 

%count = CountStopConcepts([mallet_output_base '../matlab/'], intervals, methods);
%[~, avg] = LoadMalletOutput(mallet_output_base, intervals, methods);
