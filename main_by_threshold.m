load('data/AllTweetDailyTimeseries.mat');
load('data/AllTweetHourlyTimeseries.mat');
load('data/ConceptsDailyTimeseries.mat');
load('data/ConceptsHourlyTimeseries.mat');

FindStopConcepts(AllTweetDailyTimeseries, ConceptsDailyTimeseries, 'Daily')
FindStopConcepts(AllTweetHourlyTimeseries, ConceptsHourlyTimeseries, 'Hourly')