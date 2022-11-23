%% Defeating a monster!

% Write a some code to determine the outcome of a heroic fight between a 
% hero and a monster. Both the monster and the hero have attack values and 
% defense values that are random integers between 1 and 20. The hero gets 
% additionally 4 bonus attack points and 2 bonus defense points added to 
% their random score. Both have 50 life points. The hero attacks first. 
% The fight lasts until someone dies or the hero flees the dungeon. If the
% hero kills the monster (it has 0 or less life points), the hero wins and
% gets the treasure. If the hero dies, the monster eats them. If the hero
% has less than 15 life points, instead of attacking, they try to flee the
% dungeon. To determine if they succeed in fleeing, randomly choose an
% integer between 1 and 6. If it is 5 or 6, the hero flees successfully and
% survives. If not, bad things happen - you can be creative with what that
% means. 
% Print the life points before each turn and its outcome to the command window!

lp_h = 50;
lp_m = 50;
at_h = 4;
de_h = 2;

while lp_h > 0 && lp_m > 0
    fprintf('The hero has %i life points left and the monster %i!\n',lp_h,lp_m);
    % hero's turn
    if lp_h > 15 % ...if well enough, they fight!
        attack = randi(20) + at_h;
        defense = randi(20);
        if attack > defense
            lp_m = lp_m - attack + defense; 
            fprintf('The hero attacks the monster with %i! The monster defends itself with %i, so the hero does %i damage.\n',attack,defense,attack-defense);
        else
           fprintf('The hero attacks the monster unsuccessfully and does no damage.\n');
        end
    else % ...otherwise, they try to run!
        dice = randi(6);
        if dice > 4
            fprintf('The hero successfully flees the dungeon!\n');
        else
            de_dam = randi(3);
            fprintf('The tries to flee but fails! The monster takes part of the hero''s armour and their defense is decreased by %i!\n',de_dam);
            de_h = de_h - de_dam;
        end
    end
    % monster's turn
    attack = randi(20);
    defense = randi(20) + de_h;
    if attack > defense
        lp_h = lp_h - attack + defense; 
        fprintf('The monster attacks the hero with %i! The hero defends themself with %i, so the monster does %i damage.\n',attack,defense,attack-defense);
    else
       fprintf('The monster attacks the hero unsuccessfully and does no damage.\n');
    end
end
if lp_h <= 0
    fprintf('The monster slays the hero and starts gorging on their body until nothing is left!\n')
else
    fprintf('The hero slays the monster and wins the magic flask! They will sing songs about this heroic defeat for all eternity!\n')
end