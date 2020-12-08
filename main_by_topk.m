% %%%%%All values. Should be sorted later by an app like excel
% %%the higher the score, the more probable the concept is stop

file = fopen('output/topk/xcr_daily_values.txt','w');
for i = 1: length(ConceptsDailyTimeseries)
    [~, s] = ConceptsDailyTimeseries{i}.IsStopConcept(AllTweetDailyTimeseries, 1.0);
    fprintf(file, '%i, %.8f\n', ConceptsDailyTimeseries{i}.Id, s);
end
fclose(file);
file = fopen('output/topk/xcr_hourly_values.txt','w');
for i = 1: length(ConceptsHourlyTimeseries)
    [~, s] = ConceptsHourlyTimeseries{i}.IsStopConcept(AllTweetHourlyTimeseries, 1.0);
    fprintf(file, '%i, %.8f\n', ConceptsHourlyTimeseries{i}.Id, s);
end
fclose(file);

%%the lower the score, the more probable the concept is stop
load('output/threshold/fourier/f_Daily.mat', 'f');
f = FourScore(f');
file = fopen([base_path 'output/topk/ftp_daily_values.txt'],'w');
for i = 1: length(ConceptsDailyTimeseries)
    fprintf(file, '%i, %.8f\n', ConceptsDailyTimeseries{i}.Id, f(i, 2));
end
fclose(file);
load('output/threshold/fourier/f_Hourly.mat', 'f');
f = FourScore(f');
file = fopen('output/topk/ftp_hourly_values.txt','w');
for i = 1: length(ConceptsHourlyTimeseries)
    fprintf(file, '%i, %.8f\n', ConceptsHourlyTimeseries{i}.Id, f(i, 2));
end
fclose(file);

%%the higher the score, the more probable the concept is stop
load('output/threshold/wavelet/e_Daily.mat', 'e');
e = WavScore(e');
file = fopen('output/topk/wvl_daily_values.txt','w');
for i = 1: length(ConceptsDailyTimeseries)
    fprintf(file, '%i, %.8f\n', ConceptsDailyTimeseries{i}.Id, e(i, 2));
end
fclose(file);
load('output/threshold/wavelet/e_Hourly.mat', 'e_h');
e = WavScore(e');
file = fopen('output/topk/wvl_hourly_values.txt','w');
for i = 1: length(ConceptsHourlyTimeseries)
    fprintf(file, '%i, %.8f\n', ConceptsHourlyTimeseries{i}.Id, e(i, 2));
end
fclose(file);

methods = {'Ftp', 'Wvl', 'Xcr'};
for m = 1: length(methods)
    fd = fopen(['output/topk/' lower(methods{m}) '_daily_values.txt'],'r');
    fh = fopen(['output/topk/' lower(methods{m}) '_hourly_values.txt'],'r');
    for threshold = 0.0: 0.1: 1.0  
        f = fopen(['output/topk/' methods{m} '_Daily_' num2str(threshold, '%.1f') '.txt'], 'w');
        for i = 1: (threshold * 254001)
            line = fgetl(fd);
            sid_value = strsplit(line, ',');
            fprintf(f, '%i\n', str2num(sid_value{1}));
        end
        fclose(f);

        f = fopen(['output/topk/' methods{m} '_Hourly_' num2str(threshold, '%.1f') '.txt'], 'w');
        for i = 1: (threshold * 254001)
            line = fgetl(fh);
            sid_value = strsplit(line, ',');
            fprintf(f, '%i\n', str2num(sid_value{1}));
        end
        fclose(f);

        frewind(fd);
        frewind(fh);
    end
    fclose(fd);
    fclose(fh);
end

load('data/all_concepts.mat', 'Concepts');
rp = randperm(length(Concepts));
s = Concepts(rp);
for threshold = 0.0: 0.1: 1.0  
    f = fopen(['output/topk/Random_NA_' num2str(threshold, '%.1f') '.txt'], 'w');
    if threshold > 0
        random_stops = datasample(s, uint64(threshold * 254001), 'Replace', false);
        for i = 1: length(random_stops)
            fprintf(f, '%i\n', random_stops(i));
        end
    end
    fclose(f);
end


fcu = fopen('output/topk/tfidf_cu_values.txt','r');
fcud = fopen('output/topk/tfidf_cud_values.txt','r');
for threshold = 0.0: 0.1: 1.0  
    f = fopen(['output/topk/Tfidf_CU_' num2str(threshold, '%.1f') '.txt'], 'w');
    for i = 1: (threshold * 254001)
        line = fgetl(fcu);
        sid_value = strsplit(line, ',');
        fprintf(f, '%i\n', str2num(sid_value{1}));
    end
    fclose(f);

    f = fopen(['output/topk/Tfidf_CUD_' num2str(threshold, '%.1f') '.txt'], 'w');
    for i = 1: (threshold * 254001)
        line = fgetl(fcud);
        sid_value = strsplit(line, ',');
        fprintf(f, '%i\n', str2num(sid_value{1}));
    end
    fclose(f);

    frewind(fcu);
    frewind(fcud);
end
fclose(fcu);
fclose(fcud);
