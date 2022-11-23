%
% This functions plays a perfect round of tictactoe against a opponent who
% moves random. The computer always starts firt and always wins. 

function result = tictactoe
mat = repmat('#',3);
turn = 1; %% computer starts first
hack = -1;
if turn == 1
    mat(9) = 'x';
    disp(mat)
    % opponent turn 2
    p2t1 = randi(8);
    mat(p2t1) = 'o';
    fprintf('\n');
    disp(mat)
    %computer turn 3
    if strcmp(mat(1), '#') == 1 % check to see if desired place is free
        mat(1) = 'x';
        p1t1 = 1;
        fprintf('\n');
        disp(mat)
    else
        mat(3) = 'x';
        p1t1 = 3;
        fprintf('\n');
        disp(mat)
    end
    
    % opponent turn 4
    niza = [];
    for i = 1:9
        if strcmp(mat(i),'#') == 1
            niza = [niza i];
        end
    end
    p1t2 = niza(randi(6));
    mat(p1t2) = 'o';
    fprintf('\n');
    disp(mat)
    % computer turn 5
    if p1t1 == 3
        if strcmp(mat(6), '#') == 1 % check to see if desired place is free
            mat(6) = 'x';
            result = 1;
            fprintf('\n');
            disp(mat)
            fprintf('Computer wins!');
            return
        else
            mat(7) = 'x';
            hack = 7;
            fprintf('\n');
            disp(mat)
        end
    else  %p1t1 == 1
        if strcmp(mat(5), '#') == 1 % check to see if desired place is free
            mat(5) = 'x';
            result = 1;
            fprintf('\n');
            disp(mat)
            fprintf('Computer wins!');
            return
        else
            if strcmp(mat(3), '#') == 1 % check to see if desired place is free
                mat(3) = 'x';
                hack = 3;
                fprintf('\n');
                disp(mat)
            end
        end
    end
    
    % opponent turn 6
    niza = [];
    for i = 1:9
        if strcmp(mat(i),'#') == 1
            niza = [niza i];
        end
    end
    p1t4 = niza(randi(3));
    mat(p1t4) = 'o';
    fprintf('\n');
    disp(mat)
    % computer turn 7
    if hack == 7
        if strcmp(mat(5), '#') == 1 % check to see if desired place is free
            mat(5) = 'x';
            result = 1;
            fprintf('\n');
            disp(mat)
            fprintf('Computer wins!');
            return
        else
            strcmp(mat(8), '#') == 1; % check to see if desired place is free
            mat(8) = 'x';
            result = 1;
            fprintf('\n');
            disp(mat)
            fprintf('Computer wins!');
            return
        end
    else %hack ==3
        if strcmp(mat(2), '#') == 1
        mat(2) = 'x';
        result = 1;
        fprintf('\n');
        disp(mat)
        fprintf('Computer wins!');
        return
        else
        mat(6) = 'x';
        result = 1;
        fprintf('\n');
        disp(mat)
        fprintf('Computer wins!');
        return
        end
    end
end
end