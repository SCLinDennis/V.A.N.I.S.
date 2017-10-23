%--------------------------------------------------------------------------
% Do pitch marking based-on pitch contour using dynamic programming
%--------------------------------------------------------------------------
function pm = PitchMarking(x, p, fs , response,res1)
%voice(res1 == 1),emotion(res1 == 2),both(res1 == 3)
%happy(response == 1), anger(response == 2)
global config;
global data;

% split voiced / unvoiced segments
[u, v] = UVSplit(p);

%  pitch marking for voiced segments
pm = [];
ca = [];
first = 1;
waveOut = [];
if res1 == 2
    scale = 1.2;
else
    scale = 1;
end
for i = 1 : length(v(:,1))
    range = (v(i, 1) : v(i, 2));
%% happy(hat shape)
%     interval = floor((v(i,2)-v(i,1))/5);
%     for j = 1:5
%         range = (v(i,1)+interval*(j-1):v(i,1)+interval*j);
%         if j <= 3
%             in = x(range);
%             [marks, cans] = VoicedSegmentMarking(in, p(range), fs);
%             pm = [pm  (marks + range(1))];
%             ca = [ca;  (cans + range(1))];
%             ra = first:marks(1)+range(1)-1;
%             first = marks(length(marks))+range(1)+1;
%             waveOut = [waveOut UnvoicedMod(x(ra), fs, config.timeScale)'];
%             waveOut = [waveOut PSOLA(in, fs, marks, config.timeScale, config.pitchScale+0.1*j)];
%         else
%             in = x(range);
%             [marks, cans] = VoicedSegmentMarking(in, p(range), fs);
%             pm = [pm  (marks + range(1))];
%             ca = [ca;  (cans + range(1))];
%             ra = first:marks(1)+range(1)-1;
%             first = marks(length(marks))+range(1)+1;
%             waveOut = [waveOut UnvoicedMod(x(ra), fs, config.timeScale)'];
%             waveOut = [waveOut PSOLA(in, fs, marks, config.timeScale, config.pitchScale+0.1*(5-j+1))];
%         end
%     end
%% anger
    if response == 2
        interval = floor((v(i,2)-v(i,1))/3);
        for j = 1:3
            range = (v(i,1)+interval*(j-1):v(i,1)+interval*j);
            if j == 1
                in = x(range)*5;
            else
                in = x(range);
            end
            [marks, cans] = VoicedSegmentMarking(in, p(range), fs);
            pm = [pm  (marks + range(1))];
            ca = [ca;  (cans + range(1))];
            ra = first:marks(1)+range(1)-1;
            first = marks(length(marks))+range(1)+1;
            waveOut = [waveOut UnvoicedMod(x(ra), fs, config.timeScale)'];
            waveOut = [waveOut PSOLA(in, fs, marks, scale , config.pitchScale-0.2*j)];
        end
    end
%% happy (increasing shape)
    if response == 1
        in = x(range);
        [marks, cans] = VoicedSegmentMarking(in, p(range), fs);

        pm = [pm  (marks + range(1))];
        ca = [ca;  (cans + range(1))];

        ra = first:marks(1)+range(1)-1;
        first = marks(length(marks))+range(1)+1;
        waveOut = [waveOut UnvoicedMod(x(ra), fs, config.timeScale)'];
        waveOut = [waveOut PSOLA(in, fs, marks, config.timeScale, config.pitchScale+i*0.1)];
    end
    
    if response == 0
        in = x(range);
        [marks, cans] = VoicedSegmentMarking(in, p(range), fs);

        pm = [pm  (marks + range(1))];
        ca = [ca;  (cans + range(1))];

        ra = first:marks(1)+range(1)-1;
        first = marks(length(marks))+range(1)+1;
        waveOut = [waveOut UnvoicedMod(x(ra), fs, config.timeScale)'];
        waveOut = [waveOut PSOLA(in, fs, marks, config.timeScale, config.pitchScale)];
    end
end

data.waveOut = waveOut;
data.pitchMarks = pm;
data.candidates = ca;

