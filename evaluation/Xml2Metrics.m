
function [topic_metrics, word_metrics] = Xml2Metrics(diag_file)
% topic metrics in order:
% allocation_count
% allocation_ratio
% coherence
% corpus_dist
% document_entropy
% eff_num_words
% exclusivity
% id
% rank_1_docs
% token-doc-diff
% tokens
% uniform_dist
% word-length

% word metrics in order
% coherence
% corpus_dist
% count
% cumulative
% docs
% exclusivity
% prob
% rank
% token-doc-diff
% uniform_dist
% word
% word-length
    xml = xmlread(diag_file);
   topics = xml.getElementsByTagName('topic');
   topic_metrics = [];
   word_metrics = [];
   for z = 1: topics.getLength
       topic = topics.item(z - 1);
       theMetrics = topic.getAttributes;
       numMetrics = theMetrics.getLength;
       for m = 1: numMetrics
          metric = theMetrics.item(m - 1);
          %Name = char(metric.getName);
          topic_metrics(z, m) = str2double(metric.getValue);
       end                      

       words = topic.getElementsByTagName('word');
       for w = 1: words.getLength
           word = words.item(w - 1);
           theMetrics = word.getAttributes;
           numMetrics = theMetrics.getLength;
           for m = 1: numMetrics
              metric = theMetrics.item(m - 1);%word.getAttributeNode('word-length')
              %Name = char(metric.getName);
              word_metrics((z - 1) * words.getLength + w, m) = str2double(metric.getValue);
           end
           word_metrics((z - 1) * words.getLength + w, m + 1) = str2double(word.getTextContent);
       end
   end
end