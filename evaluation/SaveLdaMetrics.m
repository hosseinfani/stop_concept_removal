function [topic_metrics, word_metrics] = SaveLdaMetrics(output_base, intervals, method)
        for i = 1: length(intervals)
            for threshold = 0.0: 0.1: 1.0
                malletOutput = [output_base method '_' intervals{i} '_' num2str(threshold, '%.1f')];
                diag_file = [malletOutput '_diagnostic.xml'];
                [topic_metrics, word_metrics] = Xml2Metrics(diag_file);
                save(strrep(diag_file, '.xml', '.mat'),'topic_metrics','word_metrics');
            end
        end             
end
