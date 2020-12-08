classdef Concept < handle    
    
    properties(Access = public)
        Id;
        Title;
        Signal;
        SamplingRate;
        AutoCorrelation;
    end
    
    methods(Access = public)
        function [b, score] = IsStopConcept(obj, allTweetConcept, threshold)
            b = false;
            signal = full(obj.Signal);
            allTweetSignal = full(allTweetConcept.Signal);
            score = xcorr(signal, allTweetSignal, 0, 'coeff');
            if score >= threshold
                b = true;
            end
        end
        function [b, score] = IsWhiteNoise(obj,threshold)
            b = false;
            signal = full(obj.Signal);
            if obj.SamplingRate == 24
                whitenoise = wgn(1, 24 * 61,0);
            else
                whitenoise = wgn(1, 61,0);
            end          
            score = xcorr(signal, whitenoise, 0, 'coeff');
            if score >= threshold
                b=true;
            end
        end
        function b = IsFewNonZeroSample(obj, m, stdv)
           b = false;
           if nnz(obj.Signal) < m + stdv; %
               b = true;
           end
        end
        function [b, score] = IsSimilarXcr(obj, other, threshold, scale)
            b = false;

            [score, lag] = xcorr(full(obj.Signal), full(other.Signal), 0, scale);

            %[~, maxidx] = max(abs(c));   
            if abs(score) > threshold
                score = abs(score);
                b = true;
            end
        end
        function [b,score] = IsSimilarDtw(obj, other, threshold)
            b = false;

            [Distance, ~, k, w] = dtw(full(obj.Signal), full(other.Signal));
            length = size(obj.Signal, 2);
            diagnal = (1: 1: length);
            area = sum(abs(w(:, 2) - w(:, 1)));
            worseArea = sum((ones(1, length).* length) - diagnal) + (1 + length).* length ./ 2;
            path = 1 - (area ./ worseArea);
            score=k./Distance ;
           
            if (path >=0.9) && (score > threshold)
                b = true;

            end 
        end
        
        function [e] = GetSignalEnergy(obj, scale)
            %baselines/wavelet/WaveEnergy
            e = WaveEnergy( full(obj.Signal), scale );
        end        
        function f = GetFourierTransformParameters(obj)
            %baselines/fourier/FourierParameters
            [dp, dps] = FourierParameters(full(obj.Signal));
            f = [dp, dps];
        end
    end
    
    methods(Static)
        function [m, stdv] = GetStatistics(concepts)
            ms = zeros(1, length(concepts));
            for i = 1: length(concepts)
                ms(i) = nnz(concepts{i}.Signal);
            end
            stdv = std(ms);
            m = mean(ms);
        end
        function scores = CalculatePairwiseSimilarity(concepts, threshold, method, scale, core)
            
            scores = sparse(length(concepts), length(concepts));
            N = length(concepts);
            K = core;
            D = floor(N/K) + 1;
            subscores = sparse(D, D);
            for i = 1: K
                data1 = concepts((i - 1) * D + 1: min(i * D, N));
                    for j = i: K
                    data2 = concepts((j - 1) * D + 1: min(j * D, N));
                    parfor w = (i - 1) * D + 1: i * D
                        subsubscores = zeros(1, D);
                        for z = (j - 1) * D + 1 : j * D
                            if z > w && w <= N && z <= N
                                if strcmp(method, 'xcr')
                                    [b, score] = data1{w - ((i - 1) * D)}.IsSimilarXcr(data2{z - ((j - 1) * D)}, threshold, scale);
                                else% strcmp(method, 'dtw')
                                    [b, score] = data1{w - ((i - 1) * D)}.IsSimilarXcr(data2{z - ((j - 1) * D)}, threshold);
                                end
                                if b
                                    subsubscores(1, z - ((j - 1) * D)) = score;
                                end
                            end
                        end
                        subscores(w, :) = subsubscores;
                    end
                    scores((i - 1) * D + 1: i * D, (j - 1) * D + 1: j * D) = subscores((i - 1) * D + 1: i * D,:);
                end
            end
        end
        
        %x-correlation (xcr) baseline
        function [stopIds, mainIds] = ClusterConceptsByXcr(allTweetConcept, concepts, threshold)
            threshold = 1 - threshold;
            stopIds = [];
            mainIds = [];
            for i = 1: length(concepts)
                [b_s, ~] = concepts{i}.IsStopConcept(allTweetConcept, threshold);
                [b_w, ~] = concepts{i}.IsWhiteNoise(threshold);
                if b_s || b_w 
                    stopIds = [stopIds,  concepts{i}.Id];
                else
                    mainIds = [mainIds, concepts{i}.Id];
                end
            end
        end
        
        %wavelet (wvl) baseline
        function [stopIds, mainIds, e] = ClusterConceptsByWvl(concepts, threshold, e)
            stopIds = [];
            mainIds = [];
            if isempty(e)
                e = [];
                parfor i = 1:length(concepts)
                    e(i, :) = concepts{i}.GetSignalEnergy(100);
                end
            end
            e(:,2) = log(e(:,2));
            
            %baselines/wavelet/IDMakerII.m
            [sIdx, mIdx] = IDMakerII(e', threshold);
            for i = 1:length(sIdx)
                stopIds = [stopIds, concepts{sIdx(i)}.Id];                
            end
            for i = 1:length(mIdx)
                mainIds = [mainIds, concepts{mIdx(i)}.Id];                
            end
        end
        
        %fourier (ftp) baseline
        function [stopIds, mainIds, f] = ClusterConceptsByFtp(concepts, threshold, f)
            stopIds = [];
            mainIds = [];
            if isempty(f)
                f = [];
                parfor i = 1:length(concepts)
                    f(i, :) = concepts{i}.GetFourierTransformParameters();
                end
            end
            [sIdx, mIdx] = IDMakerIII(f', threshold);
            for i = 1:length(sIdx)
                stopIds = [stopIds, concepts{sIdx(i)}.Id];                
            end
            for i = 1:length(mIdx)
                mainIds = [mainIds, concepts{mIdx(i)}.Id];                
            end
        end
                
    end
end