classdef Field
    properties
        data % the data array for the field
        grid % field's grid
        pos  % the data's position in the grid
    end
    methods
        function obj = Field(data, g, pos)
            obj.data = data;
            obj.grid = g;
            obj.pos = pos;
        end
        
        function r = dx_f(obj)
            r = obj.grid.dx_f(obj.pos);
        end
        function r = dy_f(obj)
            r = obj.grid.dy_f(obj.pos);
        end
        function r = dz_f(obj)
            r = obj.grid.dz_f(obj.pos);
        end

        function r = dx_b(obj)
            r = obj.grid.dx_b(obj.pos);
        end
        function r = dy_b(obj)
            r = obj.grid.dy_b(obj.pos);
        end
        function r = dz_b(obj)
            r = obj.grid.dz_b(obj.pos);
        end
        
        %overload '+'
        function r = plus(obj1,obj2)
            check_grid_match(obj1, obj2);
            grid = get_valid_grid(obj1, obj2);
            pos = get_valid_pos(obj1, obj2);
            r = Field(double(obj1) + double(obj2), grid, pos);
        end
        
        %overload '-'
        function r = minus(obj1,obj2)
            check_grid_match(obj1, obj2);
            grid = get_valid_grid(obj1, obj2);
            pos = get_valid_pos(obj1, obj2);
            r = Field(double(obj1) - double(obj2), grid, pos);
        end
        
        %overload '.*'
        function r = times(obj1,obj2)
            check_grid_match(obj1, obj2);
            grid = get_valid_grid(obj1, obj2);
            pos = get_valid_pos(obj1, obj2);
            r = Field(double(obj1) .* double(obj2), grid, pos);
        end

        %overload '*'
        function r = mtimes(obj1,obj2)
            check_grid_match(obj1, obj2);
            grid = get_valid_grid(obj1, obj2);
            pos = get_valid_pos(obj1, obj2);
            r = Field(double(obj1) * double(obj2), grid, pos);
        end
        
        %overload './'
        function r = rdivide(obj1,obj2)
            check_grid_match(obj1, obj2);
            grid = get_valid_grid(obj1, obj2);
            pos = get_valid_pos(obj1, obj2);
            r = Field(double(obj1) ./ double(obj2), grid, pos);
        end
        
        function r = mrdivide(a, b)
            check_grid_match(a, b);
            grid = get_valid_grid(a, b);
            pos = get_valid_pos(a, b);
            r = Field(double(a) / double(b), grid, pos);
        end
        
        function r = mldivide(a,b)
            check_grid_match(a, b);
            grid = get_valid_grid(a, b);
            pos = get_valid_pos(a, b);
            r = Field(double(a) \ double(b), grid, pos);
        end       
        
        function r = power(a,b)            
            check_grid_match(a, b);
            grid = get_valid_grid(a, b);
            pos = get_valid_pos(a, b);
            r = Field(double(a) .^ double(b), grid, pos);
        end
        
        function r = mpower(a,b)            
            check_grid_match(a, b);
            grid = get_valid_grid(a, b);
            pos = get_valid_pos(a, b);
            r = Field(double(a) ^ double(b), grid, pos);
        end
        
        function r = lt(a,b)           
            check_grid_match(a, b);
            grid = get_valid_grid(a, b);
            pos = get_valid_pos(a, b);
            r = Field(double(a) < double(b), grid, pos);
        end
 
        function r = gt(a,b)             
            check_grid_match(a, b);
            grid = get_valid_grid(a, b);
            pos = get_valid_pos(a, b);
            r = Field(double(a) > double(b), grid, pos);
        end
        
        function r = le(a,b)            
            check_grid_match(a, b);
            grid = get_valid_grid(a, b);
            pos = get_valid_pos(a, b);
            r = Field(double(a) <= double(b), grid, pos);
        end
        
        function r = ge(a,b)           
            check_grid_match(a, b);
            grid = get_valid_grid(a, b);
            pos = get_valid_pos(a, b);
            r = Field(double(a) >= double(b), grid, pos);
        end
        
        function r = ne(a,b)            
            check_grid_match(a, b);
            grid = get_valid_grid(a, b);
            pos = get_valid_pos(a, b);
            r = Field(double(a) ~= double(b), grid, pos);
        end
        
        function r = eq(a,b)  
            check_grid_match(a, b);
            grid = get_valid_grid(a, b);
            pos = get_valid_pos(a, b);
            r = Field(double(a) == double(b), grid, pos);
        end                     
        
        function r = and(a,b)          
            check_grid_match(a, b);
            grid = get_valid_grid(a, b);
            pos = get_valid_pos(a, b);
            r = Field(double(a) & double(b), grid, pos);
        end       
        
        function r = or(a,b)           
            check_grid_match(a, b);
            grid = get_valid_grid(a, b);
            pos = get_valid_pos(a, b);
            r = Field(double(a) | double(b), grid, pos);
        end   
        
        function r = not(a)          
            r = Field(not(double(a)), a.grid, a.pos);
        end   
        
        function r = ctranspose(a)            
            r = Field(a.var', a.grid, a.pos);
        end 
 
        function r = transpose(a)            
            r = Field(a.var.', a.grid, a.pos);
        end 

        function r = uminus(a)
            r = Field(-a.data, a.grid, a.pos);
        end
        
        function r = uplus(a)
            r = a;
        end
        
        function r = abs(a)
            r = Field(abs(a.data), a.grid, a.pos);
        end
        
        function [r q] = max(a)
            [r q] = max(a.data);
        end
        
        function r = repmat(a, varargin)
            switch(length(varargin))
              case 1
                r = Field(repmat(a.data, varargin{1}), a.grid, a.pos);
              case 2
                r = Field(repmat(a.data, varargin{1}, varargin{2}), ...
                          a.grid, a.pos);
              case 3
                r = Field(repmat(a.data, varargin{1}, varargin{2}, ...
                           varargin{3}), a.grid, a.pos);
            end
        end
        
        function r = sum(a, varargin)
            switch(length(varargin))
              case 0
                r = sum(a.data);
              case 1
                r = sum(a.data, varargin{1});
            end
        end
        
        function r = reshape(a, varargin)
            switch(length(varargin))
              case 1
                r = reshape(a.data, varargin{1});
              case 2
                r = reshape(a.data, varargin{1}, varargin{2});
              case 3
                r = reshape(a.data, varargin{1}, varargin{2}, varargin{3});
            end
        end
        
        function r = horzcat(a,b,varargin)  
            check_grid_match(a, b);
            grid = get_valid_grid(a, b);
            pos = get_valid_pos(a, b);

            r=Field([double(a) double(b)], grid, pos);            
            
            nvar = length(varargin);
            for k=1:nvar
                r=Field([double(r) double(varargin{k})], grid, pos);
            end
        end 
 
        function r = vertcat(a,b,varargin)  
            check_grid_match(a, b);
            grid = get_valid_grid(a, b);
            pos = get_valid_pos(a, b);

            r=Field([a.data ; b.data], grid, pos);
            
            nvar = length(varargin);
            for k=1:nvar
                r=Field([r.data ; varargin{k}.data], grid, pos);
            end
        end
        
        function disp(a)
            a.data
        end
        
        %customized subsref        
        function v=subsref(obj,S)
            if(S(1).type == '.')
                v = builtin('subsref', obj, S);
            else
                if(isa(obj, 'Field')) 
                    v = Field(builtin('subsref', obj.data, S), ...
                              obj.grid, obj.pos);
                else
                    v = builtin('subsref',obj, S);
                end
            end
        end

        function obj = subsasgn(obj, S, varargin)
            if(S(1).type == '.')
                if(~isa(obj, 'Field'))
                    obj = builtin('subsasgn', obj, S, varargin{1});
                else
                    obj.data = builtin('subsasgn', obj.data, S, varargin{1});
                end
            else
                if(isa(obj, 'Field'))
                    obj.data = builtin('subsasgn', obj.data, S, varargin{1});
                else
                    obj = builtin('subsasgn', obj, S, varargin{1})                
                end
            end
        end
        
        function obj = sqrt(obj)
            obj = Field(sqrt(obj.data), obj.grid, obj.pos);
        end

        function obj = sin(obj)
            obj = Field(sin(obj.data), obj.grid, obj.pos);
        end

        function obj = cos(obj)
            obj = Field(sqrt(obj.data), obj.grid, obj.pos);
        end
        
        function d = double(obj)
            if(isnumeric(obj))
                d = obj;
            else
                d = obj.data;
            end
        end
        
        function check_grid_match(obj1, obj2)
            if(isnumeric(obj1) || isnumeric(obj2)) 
                return
            end
            
            if(~isequal(obj1.pos, obj2.pos))
                error('Error: position of obj1 and obj2 does not match!');
            end
        end
        
        function r = get_valid_grid(obj1, obj2)
            if(isnumeric(obj1))
                r = obj2.grid;
            else
                r = obj1.grid;
            end
        end
        
        function r = get_valid_pos(obj1, obj2)
            if(isnumeric(obj1))
                r = obj2.pos;
            else
                r = obj1.pos;
            end
        end
        
    end
end