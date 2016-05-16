classdef node
    
    properties
        state
        parent
        depth
        action
        tcost
        hscore
    end
    
    methods
        function obj = node(matrix)
            if(nargin > 0)
                obj.state = matrix;
                obj.depth = 0;
                obj.action = char('original');
                obj.tcost = 0;
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
        
        % get the Manhattan Distance between two node states
        function score = getMscore(obj1,obj2)
           if(nargin > 0)
               temp = 0;
               for i = 2:5
                  [stm,stn] = find(obj1.state == i);
                  [gom,gon] = find(obj2.state == i);
                  temp = temp + abs(stm-gom)+abs(stn-gon); 
               end
               score = temp;
           end
        end
        
        % get the Hamming Distance
        function score = getHscore(obj1,obj2)
            temp = obj1.state ~= obj2.state;
            score = length(find(temp == 1))/2;
        end
        
        function score = getSMscore(obj1,obj2)
           score =  getHscore(obj1,obj2) * getMscore(obj1,obj2);
        end
        
        function score = getWeightedMscore(obj1,obj2)
           if(nargin > 0)
              temp = 0;
              d = 0;
              j = 1;
              for i = 2:5
                  [stm,stn] = find(obj1.state == i);
                  [gom,gon] = find(obj2.state == i);
                  Mdis = abs(stm-gom)+abs(stn-gon);
                  if(Mdis > 0 && i == 5)
                      temp = temp + Mdis;
                  elseif(j > 1 && (temp + j * d)>10 && i == 5)
                      temp = temp - Mdis; 
                  elseif(Mdis > 0 && i ~= 5)
                      d = d + Mdis;
                      j = j + 1;
                  end   
              end
              j = j - 1;
              temp = temp + j * d;
              score = temp;
           end
        end
       
        % move the '5' tile left
        function  obj = moveLeft(obj) 
            matrix = obj.state;
            temp = matrix;
            % find the '5' tile
            [x,y] = find(matrix == 5);
            % if not reach the left boundray, move the '5' left
            if(y-1>0) 
                % switch the tile
                temp(x,y-1) = matrix(x,y);
                temp(x,y)   = matrix(x,y-1);
            end;
            obj.state = temp;
            obj.action = char('Left');
        end
        
        % move the '5' tile right
        function  obj = moveRight(obj)
            matrix = obj.state;
            temp = matrix;
            [x,y] = find(matrix == 5);
            if(y+1<5) 
                temp(x,y+1) = matrix(x,y);
                temp(x,y) = matrix(x,y+1);
            end;
            obj.state = temp;
            obj.action = char('Right');
        end
        
        % move the '5' tile down
        function  obj = moveDown(obj) 
            matrix = obj.state;
            temp = matrix;
            [x,y] = find(matrix == 5);
            if(x+1<5) 
                temp(x+1,y) = matrix(x,y);
                temp(x,y) = matrix(x+1,y);
            end;
            obj.state = temp;
            obj.action = char('Down');
        end  
        
        % move the '5' tile up
        function  obj = moveUp(obj) 
            matrix = obj.state;
            temp = matrix;
            [x,y] = find(matrix == 5);
            if(x-1>0) 
                temp(x-1,y) = matrix(x,y);
                temp(x,y) = matrix(x-1,y);
            end;
            obj.state = temp;
            obj.action = char('Up');
        end 
    end
    
end

