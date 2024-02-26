% Specify the path to your audio samples folder
folderPath = 'C:\\Users\\winni\\OneDrive\\Documents\\MATLAB\\AudioSamplers\\';

% Initialize cell array to store audio data
audioData = cell(1, 9);
Fs = zeros(1, 9);

% Load audio files % need to delete this, replace with load button fcn. 
for sampleIdx = 1:9
    filename = sprintf([folderPath 'sample%d.wav'], sampleIdx);
    % disp(filename);all .wav files shown.
    [audioData{sampleIdx}, Fs(sampleIdx)] = audioread(filename);
end


% Create a figure for the GUI
figure('Name', 'Audio Player', 'Position', [100, 100, 400, 400]);

% Create buttons in a 3x3 grid layout
for row = 1:3
    for col = 1:3
        idx = (row - 1) * 3 + col;
        uicontrol('Style', 'pushbutton', ...
            'String', ['Sample ' num2str(idx)], ...
            'Position', [50 + (col - 1) * 100, 300 - (row - 1) * 100, 80, 30], ...
            'Callback', @(~,~) playSample(idx, audioData, Fs)); 
        
        
        % Add "Load" button for each sample
        uicontrol('Style', 'pushbutton', ...
            'String', 'Load', ...
            'Position', [50 + (col - 1) * 100, 270 - (row - 1) * 100, 80, 20], ...
            'Callback', @(~,~) loadSample(idx)); 
            % Defining an anonyous fcn as a calback for UI control (the
            % button in the grid).
    end
end

% Function to load audio sample
function loadSample(sampleIdx)
    % Display a message or perform any necessary actions.
    %disp(['Loading sample ' num2str(sampleIdx)]);% replace loading sample with unigetfile 
    [file,path] = uigetfile('*.wav');
    if isequal(file,0)
        disp('User selected Cancel');
    else
        disp(['User selected ', fullfile(path,file)]);
    end
end

% Function to play an audio sample
function playSample(sampleIdx, audioData, Fs)
% Plot soundwave 
    %subplot(3, 3, idx);
    f = figure;
    t = (0:length(audioData{sampleIdx}) - 1) / Fs(sampleIdx);
    plot(t, audioData{sampleIdx});
    title(['Soundwave ' num2str(sampleIdx)]);
    xlabel('Time (s)');
    ylabel('Amplitude');
    movegui(f,'southwest');  
    try
        % Play audio using audioplayer
        player = audioplayer(audioData{sampleIdx}, Fs(sampleIdx));
        playblocking(player); 
    catch
        errordlg('Error playing audio file.', 'Error', 'modal');
    end        
end



