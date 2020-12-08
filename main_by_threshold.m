load('data/AllTweetDailyTimeseries.mat');
load('data/AllTweetHourlyTimeseries.mat');
load('data/ConceptsDailyTimeseries.mat');
load('data/ConceptsHourlyTimeseries.mat');

GenerateStopConcepts(AllTweetDailyTimeseries, ConceptsDailyTimeseries, 'Daily')
GenerateStopConcepts(AllTweetHourlyTimeseries, ConceptsHourlyTimeseries, 'Hourly')