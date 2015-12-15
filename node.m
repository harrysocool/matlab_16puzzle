classdef node
    
    properties
        state
        parent
        depth
        action
        tcost
        h_score
    end
    
    methods
        function obj = node(matrix)
            if(nargin > 0)
                obj.state = matrix;
                obj.depth = 0;
                obj.action = char('original');
                obj.tcost = 0;
                obj.h_score = 0;
            end
        end
        
        % get the array out of a matrix
        function array = getArray(obj)
            if(nargin > 0)
                matrix = obj.state;
                array = reshape(matrix',1,length(matrix)^2);
            end
        end
        
        % test if the state is different
        function boolean = testDiff(obj1,obj2)
                boolean = max(max(obj1.state ~= obj2.state));
        end
        
        function score = getScore(obj1,obj2)
           if(nargin > 0)
               temp = 0;
               for i = 52:55
                  [stm,stn] = find(obj1.state == i);
                  [gom,gon] = find(obj2.state == i);
                  temp = temp + abs(stm-gom)+abs(stn-gon); 
               end
               score = temp;
           end
        end
        
        % move the '55' tile left
        function  obj = moveLeft(obj) 
            matrix = obj.state;
            temp = matrix;
            % find the '55' tile
            [x,y] = find(matrix == 55);
            % if not reach the left boundray, move the '55' left
            if(y-1>0) 
                % switch the tile
                temp(x,y-1) = matrix(x,y);
                temp(x,y)   = matrix(x,y-1);
            end;
            obj.state = temp;
            obj.action = char('Left');
        end
        
        % move the '55' tile right
        function  obj = moveRight(obj)
            matrix = obj.state;
            temp = matrix;
            [x,y] = find(matrix == 55);
            if(y+1<5) 
                temp(x,y+1) = matrix(x,y);
                temp(x,y) = matrix(x,y+1);
            end;
            obj.state = temp;
            obj.action = char('Right');
        end
        
        % move the '55' tile down
        function  obj = moveDown(obj) 
            matrix = obj.state;
            temp = matrix;
            [x,y] = find(matrix == 55);
            if(x+1<5) 
                temp(x+1,y) = matrix(x,y);
                temp(x,y) = matrix(x+1,y);
            end;
            obj.state = temp;
            obj.action = char('Down');
        end  
        
        % move the '55' tile up
        function  obj = moveUp(obj) 
            matrix = obj.state;
            temp = matrix;
            [x,y] = find(matrix == 55);
            if(x-1>0) 
                temp(x-1,y) = matrix(x,y);
                temp(x,y) = matrix(x-1,y);
            end;
            obj.state = temp;
            obj.action = char('Up');
        end 
    end
    
end

