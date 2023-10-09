function element = get_element_properties(element_name)

load('elements_data.mat', 'elements_data');

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

end