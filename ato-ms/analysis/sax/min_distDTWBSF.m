%
% This function computes the minimum (lower-bounding) distance between two strings.  The strings
% should have equal length.
%   Input:
%       str1: first string
%       str2: second string
%       alphabet_size: alphabet size used to construct the strings
%       compression_ratio: original_data_len / symbolic_len
%   Output:
%       dist: lower-bounding distance
%
%   usage: dist = min_dist(str1, str2, alphabet_size, compression_ratio)
%
%
function [dist BSF] = min_distDTWBSF(str1, U, L, BSF, maxN)
    currentBSF = 1;
    %dist_matrix = build_dist_table(alphabet_size);
        tmpVal = 0;
        for i = 1:length(str1)
            if str1(i) > U(i)
                tmpVal = tmpVal + ((str1(i) - U(i)) ^ 2);
            elseif str1(i) < L(i)
                tmpVal = tmpVal + ((L(i) - str1(i)) ^ 2);
            end
            if tmpVal > (BSF(currentBSF) ^ 2)
                if (currentBSF == maxN)
                    tmpVal = tmpVal + sqrt(length(str1) - i);
                    break;
                else
                    currentBSF = currentBSF + 1;
                end
            end
        end
        if (i == length(str1))
            BSF = [BSF(1:(currentBSF - 1)) sqrt(tmpVal) BSF((currentBSF):end)];
            if length(BSF) > maxN
                BSF = BSF(1:maxN);
            end
        end
        dist = sqrt(tmpVal);
    %dist = sqrt(compression_ratio * sum(diag(dist_matrix(str1,str2))));




%------------------------------------------------------------------------------------------------------
% LOCAL FUNCTION: given the alphabet size, build the distance table for the (squared) minimum distances 
%                 between different symbols
%                 
%   usage: [dist_matrix] = build_dist_table(alphabet_size)
%------------------------------------------------------------------------------------------------------

function dist_matrix = build_dist_table(alphabet_size)

    switch alphabet_size
        case 2, cutlines  = [0];
        case 3, cutlines  = [-0.43 0.43];
        case 4, cutlines  = [-0.67 0 0.67];
        case 5, cutlines  = [-0.84 -0.25 0.25 0.84];
        case 6, cutlines  = [-0.97 -0.43 0 0.43 0.97];
        case 7, cutlines  = [-1.07 -0.57 -0.18 0.18 0.57 1.07];
        case 8, cutlines  = [-1.15 -0.67 -0.32 0 0.32 0.67 1.15];
        case 9, cutlines  = [-1.22 -0.76 -0.43 -0.14 0.14 0.43 0.76 1.22];
        case 10, cutlines = [-1.28 -0.84 -0.52 -0.25 0. 0.25 0.52 0.84 1.28];
        case 11, cutlines = [-1.34 -0.91 -0.6 -0.35 -0.11 0.11 0.35 0.6 0.91 1.34];
        case 12, cutlines = [-1.38 -0.97 -0.67 -0.43 -0.21 0 0.21 0.43 0.67 0.97 1.38];
        case 13, cutlines = [-1.43 -1.02 -0.74 -0.5 -0.29 -0.1 0.1 0.29 0.5 0.74 1.02 1.43];
        case 14, cutlines = [-1.47 -1.07 -0.79 -0.57 -0.37 -0.18 0 0.18 0.37 0.57 0.79 1.07 1.47];
        case 15, cutlines = [-1.5 -1.11 -0.84 -0.62 -0.43 -0.25 -0.08 0.08 0.25 0.43 0.62 0.84 1.11 1.5];
        case 16, cutlines = [-1.53 -1.15 -0.89 -0.67 -0.49 -0.32 -0.16 0 0.16 0.32 0.49 0.67 0.89 1.15 1.53];
        case 17, cutlines = [-1.56 -1.19 -0.93 -0.72 -0.54 -0.38 -0.22 -0.07 0.07 0.22 0.38 0.54 0.72 0.93 1.19 1.56];
        case 18, cutlines = [-1.59 -1.22 -0.97 -0.76 -0.59 -0.43 -0.28 -0.14 0 0.14 0.28 0.43 0.59 0.76 0.97 1.22 1.59];
        case 19, cutlines = [-1.62 -1.25 -1 -0.8 -0.63 -0.48 -0.34 -0.2 -0.07 0.07 0.2 0.34 0.48 0.63 0.8 1 1.25 1.62];
        case 20, cutlines = [-1.64 -1.28 -1.04 -0.84 -0.67 -0.52 -0.39 -0.25 -0.13 0 0.13 0.25 0.39 0.52 0.67 0.84 1.04 1.28 1.64];
        case 64, cutlines = [((-3.875:0.125:3.875) ./ 2)];
        otherwise, disp('WARNING:: Alphabet size too big');
    end;

    dist_matrix=zeros(alphabet_size,alphabet_size);

    
    for i = 1 : alphabet_size
        
        % the min_dist for adjacent symbols are 0, so we start with i+2
        for j = i+2 : alphabet_size
            
            % square the distance now for future use
            dist_matrix(i,j)=(cutlines(i)-cutlines(j-1))^2;
            
            % the distance matrix is symmetric
            dist_matrix(j,i) = dist_matrix(i,j);
        end;
    end;  