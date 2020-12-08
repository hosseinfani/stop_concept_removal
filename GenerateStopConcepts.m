function GenerateStopConcepts(all_tweet_timeseries, concept_timeseries, time_interval)
%This part is for cache energy and ftp for all threshold.
e = [];
f = [];
parfor i = 1:length(concept_timeseries)
    e(i, :) = concept_timeseries{i}.GetSignalEnergy(100);
    f(i, :) = concept_timeseries{i}.GetFourierTransformParameters();
end
% save(['output/threshold/wavelet/e_' time_interval '.mat'], 'e');
% save(['output/threshold/fourier/f_' time_interval '.mat'], 'f');
% load(['output/threshold/wavelet/e_' time_interval '.mat'], 'e');
% load(['output/threshold/fourier/f_' time_interval '.mat'], 'f');

for threshold = 0.0: 0.1: 1.0
    [stopIds, mainIds] = Concept.ClusterConceptsByXcr(all_tweet_timeseries, concept_timeseries, threshold);
    save(['output/threshold/xcr/Xcr_' time_interval '_' num2str(threshold, '%.1f') '.mat'], 'stopIds', 'mainIds');
    
    [stopIds, mainIds, ~] = Concept.ClusterConceptsByWvl(concept_timeseries, threshold, e);
    save(['output/threshold/wavelet/Wvl_' time_interval '_' num2str(threshold, '%.1f') '.mat'], 'stopIds', 'mainIds');
    
    [stopIds, mainIds, ~] = Concept.ClusterConceptsByFtp(concept_timeseries, threshold, f);
    save(['output/threshold/fourier/Ftp_' time_interval '_' num2str(threshold, '%.1f') '.mat'], 'stopIds', 'mainIds');
end

%convert mat files to txt files to feed mallet.lda as stoplist
for threshold = 0.0: 0.1: 1.0
    path = ['output/threshold/xcr/Xcr_' time_interval '_' num2str(threshold, '%.1f')];
    load([path '.mat']);
    file = fopen([path '.txt'],'w');
    for i = 1: length(stopIds)
        fwrite(file, num2str(stopIds(i)));
        fprintf(file, '\n');
    end
    fclose(file);
    
    path = ['output/threshold/wavelet/Wvl_' time_interval '_' num2str(threshold, '%.1f')];
    load([path '.mat']);
    file = fopen([path '.txt'],'w');
    for i = 1: length(stopIds)
        fwrite(file, num2str(stopIds(i)));
        fprintf(file, '\n');
    end
    fclose(file);
    
    path = ['output/threshold/fourier/Ftp_' time_interval '_' num2str(threshold, '%.1f')];
    load([path '.mat']);
    file = fopen([path '.txt'],'w');
    for i = 1: length(stopIds)
        fwrite(file, num2str(stopIds(i)));
        fprintf(file, '\n');
    end
    fclose(file);
    
end




end

