function varargout = final(varargin)
% FINAL MATLAB code for final.fig
%      FINAL, by itself, creates a new FINAL or raises the existing
%      singleton*.
%
%      H = FINAL returns the handle to a new FINAL or the handle to
%      the existing singleton*.
%
%      FINAL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FINAL.M with the given input arguments.
%
%      FINAL('Property','Value',...) creates a new FINAL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before final_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to final_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help final

% Last Modified by GUIDE v2.5 07-Jun-2017 19:47:17

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @final_OpeningFcn, ...
                   'gui_OutputFcn',  @final_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before final is made visible.
function final_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to final (see VARARGIN)

% Choose default command line output for final
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
addpath(genpath('./PSOLA/'));
addpath(genpath('./Recognition/'));

global config;
config.pitchScale           = 1;
config.timeScale            = 1;
config.resamplingScale      = 1;
config.reconstruct          = 0;
config.cutOffFreq           = 900;

global data;
data.recorder = [];
data.waveOut = [];
data.letter = 0;
data.count = 0;
data.dir = './waves/';
data.result = [];
data.again = 0;
data.in = 0;
data.emo = 0;
data.pitchMarks = [];
data.Candidates = [];
[data.train1,data.train2,data.train3] = train_load();

% UIWAIT makes final wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = final_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in run.
function run_Callback(hObject, eventdata, handles)
% hObject    handle to run (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global data;
global config;
data.in = 0;
data.count = 0;
config.pitchScale           = 1;
config.timeScale            = 1;
config.resamplingScale      = 1;
[hi,fs] = audioread([data.dir 'Hi.wav']);
hi = hi/max(abs(hi));
set(handles.text2, 'String', '')
set(handles.text3, 'String', '')
set(handles.text4, 'String', '')
str_hi = 'Hi! I am VANIS.';
set(handles.text1, 'String', str_hi)
player = audioplayer(hi,fs);
playblocking(player);
[three,fs] = audioread([data.dir 'threeway.wav']);
three = three/max(abs(three));
str_three = 'You can change your voice in three ways:';
set(handles.text2, 'String', str_three)
player = audioplayer(three,fs);
playblocking(player);
[first,fs] = audioread([data.dir 'firstchoose1.wav']);
first = first/max(abs(first));
str_first = '1. Voice transform 2. Emotion transform 3. Both of two';
set(handles.text3, 'String', str_first)
player = audioplayer(first,fs);
playblocking(player);
[re,fs] = audioread([data.dir 'recorder.wav']);
re = re/max(abs(re));
str_re = 'Press Recorder button and answer your option.(1 sec)';
set(handles.text4, 'String', str_re)
player = audioplayer(re,fs);
playblocking(player);

% --- Executes on button press in record.
function record_Callback(hObject, eventdata, handles)
% hObject    handle to record (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of record
global data;
global config;
state = get(hObject,'Value');
recorder = audiorecorder(44100,16,1);
if state == get(hObject,'Max') && data.count == 0
    recordblocking(recorder,1);
    record = getaudiodata(recorder);
    set(handles.record,'Value',0)
    letter = num_recog(record,44100,data.train1,data.train2,data.train3);
    data.count = letter+data.count;
    set(handles.text1, 'String', '')
    set(handles.text2, 'String', '')
    set(handles.text3, 'String', '')
    set(handles.text4, 'String', '')
    if letter == 1
        [A,fs] = audioread([data.dir 'One.wav']);
        A = A/max(abs(A));
        str_A = 'Option 1 is registered.';
        set(handles.text1, 'String', str_A)
        player = audioplayer(A,fs);
        playblocking(player);
    elseif letter == 2
        [B,fs] = audioread([data.dir 'Two.wav']);
        B = B/max(abs(B));
        str_B = 'Option 2 is registered.';
        set(handles.text1, 'String', str_B)
        player = audioplayer(B,fs);
        playblocking(player);
    elseif letter == 3
        [C,fs] = audioread([data.dir 'Three.wav']);
        C = C/max(abs(C));
        str_C = 'Option 3 is registered.';
        set(handles.text1, 'String', str_C)
        player = audioplayer(C,fs);
        playblocking(player);
    end
elseif state == get(hObject,'Max') && (data.count == 1 || data.count == 3) && ~data.in
    recordblocking(recorder,1);
    record = getaudiodata(recorder);
    set(handles.record,'Value',0)
    letter = num_recog(record,44100,data.train1,data.train2,data.train3);
    if ~data.again
        set(handles.text1, 'String', '')
    end
    set(handles.text2, 'String', '')
    set(handles.text3, 'String', '')
    set(handles.text4, 'String', '')
    if letter == 1
        [A,fs] = audioread([data.dir 'One.wav']);
        A = A/max(abs(A));
        str_A = 'Option 1 is registered.';
        set(handles.text1, 'String', str_A)
        player = audioplayer(A,fs);
        playblocking(player);
        data.again = 0;
        if data.count == 1
            data.in = 1;
            [in,fs] = audioread([data.dir 'in.wav']);
            in = in/max(abs(in));
            set(handles.text2, 'String', 'Press recorder button to record your input.(5 sec)')
            player = audioplayer(in,fs);
            playblocking(player);
        elseif data.count == 3
            data.count = 4;
        end        
        config.pitchScale           = 0.6;
        config.timeScale            = 1.2;
        config.resamplingScale      = 0.6;
    elseif letter == 2
        [B,fs] = audioread([data.dir 'Two.wav']);
        B = B/max(abs(B));
        str_B = 'Option 2 is registered.';
        set(handles.text1, 'String', str_B)
        player = audioplayer(B,fs);
        playblocking(player);
        data.again = 0;
        if data.count == 1
            data.in = 1;
            [in,fs] = audioread([data.dir 'in.wav']);
            in = in/max(abs(in));
            set(handles.text2, 'String', 'Press recorder button to record your input.(5 sec)')
            player = audioplayer(in,fs);
            playblocking(player);
        elseif data.count == 3
            data.count = 4;
        end
        config.pitchScale           = 1.5;
        config.timeScale            = 0.7;
        config.resamplingScale      = 1.2;
    elseif letter == 3
        data.again = 1;
        [t,fs] = audioread([data.dir 'try.wav']);
        t = t/max(abs(t));
        str_t = 'Try again!';
        set(handles.text1, 'String', str_t)
        player = audioplayer(t,fs);
        playblocking(player);
    end
elseif state == get(hObject,'Max') && (data.count == 2 || data.count == 4) && ~data.in
    recordblocking(recorder,1);
    record = getaudiodata(recorder);
    set(handles.record,'Value',0)
    letter = num_recog(record,44100,data.train1,data.train2,data.train3);
    data.letter = letter;
    if ~data.again
        set(handles.text1, 'String', '')
    end
    set(handles.text2, 'String', '')
    set(handles.text3, 'String', '')
    set(handles.text4, 'String', '')
    if letter == 1
        [A,fs] = audioread([data.dir 'One.wav']);
        A = A/max(abs(A));
        str_A = 'Option 1 is registered.';
        set(handles.text1, 'String', str_A)
        player = audioplayer(A,fs);
        playblocking(player);
        data.again = 0;
        data.emo = 1;
        if data.count == 2 || data.count == 4
            data.in = 1;
            [in,fs] = audioread([data.dir 'in.wav']);
            in = in/max(abs(in));
            set(handles.text2, 'String', 'Press recorder button to record your input.(5 sec)')
            player = audioplayer(in,fs);
            playblocking(player);
        end
    elseif letter == 2
        [B,fs] = audioread([data.dir 'Two.wav']);
        B = B/max(abs(B));
        str_B = 'Option 2 is registered.';
        set(handles.text1, 'String', str_B)
        player = audioplayer(B,fs);
        playblocking(player);
        data.again = 0;
        data.emo = 2;
        if data.count == 2 || data.count == 4
            data.in = 1;
            [in,fs] = audioread([data.dir 'in.wav']);
            in = in/max(abs(in));
            set(handles.text2, 'String', 'Press recorder button to record your input.(5 sec)')
            player = audioplayer(in,fs);
            playblocking(player);
        end
    elseif letter == 3
        data.again = 1;
        [t,fs] = audioread([data.dir 'try.wav']);
        t = t/max(abs(t));
        str_t = 'Try again!';
        set(handles.text1, 'String', str_t)
        player = audioplayer(t,fs);
        playblocking(player);
    end
elseif state == get(hObject,'Max') && data.in
    fs = 44100;
    recordblocking(recorder,5);
    data.record = getaudiodata(recorder);
    set(handles.record,'Value',0)
    if data.count == 1
        data.record = (data.record-mean(data.record))/std(data.record);
        LowPass = LowPassFilter(data.record, fs, config.cutOffFreq); 
        data.PitchContour = PitchEstimation(LowPass, fs);
        PitchMarking(data.record, data.PitchContour, fs,0,data.letter);
    elseif (data.count == 2 || data.count == 4)
        data.record = (data.record-mean(data.record))/std(data.record);
        LowPass = LowPassFilter(data.record, fs, config.cutOffFreq); 
        data.PitchContour = PitchEstimation(LowPass, fs);
        PitchMarking(data.record, data.PitchContour, fs,data.emo,data.letter);
    end
    data.waveOut = data.waveOut/max(abs(data.waveOut));
    %data.waveOut = LowPassFilter(data.waveOut, fs, config.cutOffFreq);
    player = audioplayer(data.waveOut,fs);
    playblocking(player);
end

if (data.count == 1 || data.count == 3) && ~data.again && ~data.in
    set(handles.text1, 'String', 'Change voice style')
    set(handles.text2, 'String', '')
    set(handles.text3, 'String', '')
    set(handles.text4, 'String', '')
    [voice,fs] = audioread([data.dir 'voice.wav']);
    voice = voice/max(abs(voice));
    player = audioplayer(voice,fs);
    playblocking(player);
    set(handles.text2, 'String', '1. Male 2. Female')
    [voice,fs] = audioread([data.dir 'voice_choose.wav']);
    voice = voice/max(abs(voice));
    player = audioplayer(voice,fs);
    playblocking(player);
end
if (data.count == 2 || data.count == 4)  && ~data.again && ~data.in
    set(handles.text1, 'String', 'Change voice emotion')
    set(handles.text2, 'String', '')
    set(handles.text3, 'String', '')
    set(handles.text4, 'String', '')
    [emotion,fs] = audioread([data.dir 'emotion.wav']);
    emotion = emotion/max(abs(emotion));
    player = audioplayer(emotion,fs);
    playblocking(player);
    set(handles.text2, 'String', '1. Happy 2. Angry')
    [emotion,fs] = audioread([data.dir 'emo_choose.wav']);
    emotion = emotion/max(abs(emotion));
    player = audioplayer(emotion,fs);
    playblocking(player);
end

% --- Executes on button press in Input.
function Input_Callback(hObject, eventdata, handles)
% hObject    handle to Input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global data;
p = data.record/max(abs(data.record));
player = audioplayer(p,44100);
playblocking(player);

% --- Executes on button press in play.
function play_Callback(hObject, eventdata, handles)
% hObject    handle to play (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global data;
player = audioplayer(data.waveOut,44100);
playblocking(player);
