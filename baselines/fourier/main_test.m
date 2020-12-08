%_d: Daily
%The timeseries that represent the occurrences of concepts within `daily` time interval
load('data/ConceptsDailyTimeseries.mat')
e_d = [];

%Class definition of Concept -> cmn/Concept.m
[stopIds_d, mainIds_d, e_d_] = Concept.ClusterConceptsByFtp(ConceptsDailyTimeseries, 0.5, e_d);
save('output/fourier/clusters_d.mat', 'noiseIds_d', 'stopIds_d', 'mainIds_d', 'e_d', 'e_d_');

%_h: Hourly
e_h = [];
load('data/ConceptsHourlyTimeseries.mat')
[noiseIds_h, stopIds_h, mainIds_h, e_h_] = Concept.ClusterConceptsByFtp(ConceptsHourlyTimeseries, e_h);
save('output/fourier/clusters_h.mat', 'noiseIds_h', 'stopIds_h', 'mainIds_h', 'e_h', 'e_h_');

%%%%%%%%%%%%%%%%%%
%%Scatter Figure%%
%%%%%%%%%%%%%%%%%%
mains_d = ConceptsDailyTimeseries(mainIds_d);
noises_d = ConceptsDailyTimeseries(noiseIds_d);
stops_d = ConceptsDailyTimeseries(stopIds_d);


titles_d = {};
for i = 1: length(mains_d)
    titles_d{i,1} = mains_d{i}.Title;
end
for i = 1: length(stops_d)
    titles_d{i,2} = stops_d{i}.Title;
end
for i = 1: length(noises_d)
    titles_d{i,3} = noises_d{i}.Title;
end
hold on
scatter(e_d_(noiseIds_d,1),e_d_(noiseIds_d,2),10,[1 0 0],'o');
scatter(e_d_(mainIds_d,1),e_d_(mainIds_d,2),10,[0 0 1],'o');
scatter(e_d_(stopIds_d,1),e_d_(stopIds_d,2),10,[0 1 0],'o');
xlabel('Smoothness Measure of Concept Signal')
ylabel('Energy Measure of Concept Signal')
legend('Noise Concepts','Main Concepts','Stop Concepts')


mains_h = ConceptsHourlyTimeseries(mainIds_h);
noises_h = ConceptsHourlyTimeseries(noiseIds_h);
stops_h = ConceptsHourlyTimeseries(stopIds_h);

titles_h = {};
for i = 1: length(mains_h)
    titles_h{i,1} = mains_h{i}.Title;
end
for i = 1: length(stops_h)
    titles_h{i,2} = stops_h{i}.Title;
end
for i = 1: length(noises_h)
    titles_h{i,3} = noises_h{i}.Title;
end
hold on
scatter(e_h_(noiseIds_h,1),e_d_(noiseIds_h,2),10,[1 0 0],'o');
scatter(e_h_(mainIds_h,1),e_d_(mainIds_h,2),10,[0 0 1],'o');
scatter(e_h_(stopIds_h,1),e_d_(stopIds_h,2),10,[0 1 0],'o');
xlabel('Smoothness Measure of Concept Signal')
ylabel('Energy Measure of Concept Signal')
legend('Noise Concepts','Main Concepts','Stop Concepts')