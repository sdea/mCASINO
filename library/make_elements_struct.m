%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% Make the materials struct 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc;
close all;
clear; 


%% Find the right element
%  Say we want to find the element 'Si'
element_name = 'Al';

% We get the list of elements
element_list = elements_data.Symbol;
index = 0;
for i=1:length(element_list)
    symbol = cell2mat(element_list(i));
    if (symbol == element_name)
        index = i;
    end
end

% Check if the element is found 
if (index ~= 0)
    element.Z = elements_data{index, 2};
    element.A = elements_data{index, 3};
    element.rho = elements_data{index, 4};
else
    error('Element not found in library!')
end

%% 
element = get_element_properties('Si');









