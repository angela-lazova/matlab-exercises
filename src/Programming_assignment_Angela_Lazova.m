%%
% Programming Assignment
%
%% PARTICIPANT INFO:

filename = input('Please insert the full file name of the .log file (with .log): ', 's');

participant = log2table(filename);
%% GATHERING INPUT FROM USER:

run_length = input('How many scans is the length of one run? Please only write the number!\n');
dur_parameter = input('What is the duration of each stimuli (in sec)? Please only write the number!\n');
stim_in_con = input('How many stimuli are in each condition? Please only write the number!\n');

%% Identifying RUNS and calculating ONSETS
divider = run_length + 1; % variable used to separate the runs based on the length of each run
pulses = cellstr(participant.EventType)'; %saving the eventtype column in a separate vector so I can use it for the loop

% adding two new columns: counting the pulses and identfying the runs.
participant.counted_pulses = (1:height(participant))';
%GY3Ppaintask.runs = (1:height(GY3Ppaintask))';

% Preparing variables that we need for the loop: 
start = 0; % will store the onset of the first pulse of each run
prevous_run = 1; % we always start with run 1
new_run = 0; % stores the number of the run while going through loop
count = 0; % for counting the pulses

% Loop for adding new columns in the table based on which I'll create the
% cell arrays later
for i = 1:length(pulses)
    current_run = floor(count/run_length) + 1; 
    if contains(pulses(i), 'Pulse') % if it's a pulse, count it
        count = count + 1;
        participant.counted_pulses(i) = count; %add a new column and write the pulse's number
        if count == 1 || current_run ~= prevous_run % check if it's the start of a new run
            start = participant.Time(i); % if yes, store the timestamp (to substract it later)
            prevous_run = current_run;
        end
    else
        participant.counted_pulses(i) = 0; % not a pulse
    end
    
    participant.runs(i) = floor(count/divider) + 1; % identifying the run based on user's input and adding it to the column: runs.
    participant.onsets(i) = (participant.Time(i) - start) / 10000; %calculate the correct onset for each row and add it to the column: onsets
end

%% Go through namestr and identify the conditions, then add them to a column: conditions.

con_names = cellstr(participant.namestr)'; %saving the namestr column in a separate array so I can use it for the loop
for i = 1:length(con_names)
    if (contains(con_names(i), "ki")|| contains(con_names(i), "ch")) && contains(con_names(i), "pain")
        participant.conditions(i) = "child pain";
    elseif (contains(con_names(i), "ki")|| contains(con_names(i), "ch")) && contains(con_names(i), "nopa")
        participant.conditions(i) = "child neutral";
    elseif (contains(con_names(i), "er") || contains(con_names(i), "ad")) && contains(con_names(i), "pain")
        participant.conditions(i) = "adult pain";
    elseif (contains(con_names(i), "er") || contains(con_names(i), "ad")) && contains(con_names(i), "nopa")
        participant.conditions(i) = "adult neutral";
    end

end
%% Separating the data and creating tables for each run.

run1 = participant(participant.runs == 1, :);
run2 = participant(participant.runs == 2, :);

%% CREATING THE CELL ARRAYS for RUN 1

run1_names = {"adult pain","adult neutral","child pain","child neutral"};
run1_durations = cell(1,size(run1_names,2)); % create cell array based on the number of conditions

for  i = 1:size(run1_durations,2)
run1_durations{i} = repelem(dur_parameter,stim_in_con); % fill in the cell array based on input values
end

% Prep for creating the onset cell array 
run1_cond_stim = cellstr(run1.conditions)';

%variables counting the stumuli for each condition

run1_cond_one = zeros(1,stim_in_con);
run1_cond_two = zeros(1,stim_in_con);
run1_cond_three = zeros(1,stim_in_con);
run1_cond_four = zeros(1,stim_in_con);

run1_one = 0; % need them so I can preallocate the changing variables in the loop and make the code more efficient
run1_two = 0;
run1_three = 0;
run1_four = 0;

% calculating the onsets for each stimuli and adding them to a cell array
for i = 1:length(run1_cond_stim)
    if contains(run1.conditions(i), "adult pain")
        run1_one = run1_one + 1;
        run1_cond_one(run1_one) = run1.onsets(i);
    elseif contains(run1.conditions(i), "adult neutral")
        run1_two = run1_two + 1;
        run1_cond_two(run1_two) = run1.onsets(i);
    elseif contains(run1.conditions(i), "child pain")
        run1_three = run1_three + 1;
        run1_cond_three(run1_three) = run1.onsets(i);
    elseif contains(run1.conditions(i), "child neutral")
        run1_four = run1_four + 1;
        run1_cond_four(run1_four) = run1.onsets(i);
    end
end

run1_onsets = {run1_cond_one, run1_cond_two, run1_cond_three, run1_cond_four};

% SAVING THE THREE CELL ARRYS FOR RUN 1 PARTICIPANT GY3P IN A SEPARATE FILE
run1_file_name = input('Please specify a file name for the first run for this participant(use .mat): ', 's');

save(run1_file_name, 'run1_onsets', 'run1_names', 'run1_durations')

%% CREATING THE CELL ARRAYS FOR RUN 2

run2_names = {"adult pain","adult neutral","child pain","child neutral"};
run2_durations = cell(1,size(run2_names,2)); % create cell array based on the number of conditions

for  i = 1:size(run2_durations,2)
run2_durations{i} = repelem(dur_parameter,stim_in_con); % fill in the cell array based on input values
end

% Prep for creating the onset cell array

run2_cond_stim = cellstr(run2.conditions)';

% PREP variables counting the stumuli for each condition

run2_cond_one = zeros(1,stim_in_con);
run2_cond_two = zeros(1,stim_in_con);
run2_cond_three = zeros(1,stim_in_con);
run2_cond_four = zeros(1,stim_in_con);

run2_one = 0;  % need them so I can preallocate the changing variables in the loop and make the code more efficient
run2_two = 0;
run2_three = 0;
run2_four = 0;

% calculating the onsets for each stimuli and adding them to a cell array

for i = 1:length(run2_cond_stim)
    if contains(run2.conditions(i), "adult pain")
        run2_one = run2_one + 1;
        run2_cond_one(run2_one) = run2.onsets(i);
    elseif contains(run2.conditions(i), "adult neutral")
        run2_two = run2_two + 1;
        run2_cond_two(run2_two) = run2.onsets(i);
    elseif contains(run2.conditions(i), "child pain")
        run2_three = run2_three + 1;
        run2_cond_three(run2_three) = run2.onsets(i);
    elseif contains(run2.conditions(i), "child neutral")
        run2_four = run2_four + 1;
        run2_cond_four(run2_four) = run2.onsets(i);
    end
end

run2_onsets = {run2_cond_one, run2_cond_two, run2_cond_three, run2_cond_four};

% SAVING THE THREE CELL ARRYS FOR RUN 1 PARTICIPANT GY3P IN A SEPARATE FILE

run2_file_name = input('Please specify a file name for the second run for this participant(use .mat): ', 's');

save(run2_file_name, 'run2_onsets', 'run2_names', 'run2_durations')
