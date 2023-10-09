classdef Element

    properties
        name
        Z
        atomic_weight
        density
    end

    methods
        % Constructor 
        function obj = Element(name, Z, atomic_weight, density)

            if (nargin == 1)
                
                % Search in the library
                tmp = load("elements_data.mat");
                elements_data = tmp.elements_data;
                index = elements_data.Symbol == name;
                disp(index)

            end

            if (nargin > 3)                
                % This is to define a custom element
                obj.name = name;
                obj.Z = Z;
                obj.atomic_weight = atomic_weight;
                obj.density = density;
                
            end
        end
    end

end