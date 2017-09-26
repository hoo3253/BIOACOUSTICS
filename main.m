%devices = daq.getDevices;%%Shows the available devices

s = daq.createSession('ni');
s.Rate = 44100;
s.DurationInSeconds=600;

ch=addAnalogInputChannel(s,'Dev1', 'ai6', 'Voltage');
ch.InputType='SingleEnded';

hf = figure;
hp = plot(zeros(1000,1));
T = title('Discrete FFT Plot');
xlabel('Frequency (Hz)')
ylabel('|Y(f)|')
grid on;

%%%lh = addlistener(s,'DataAvailable', @plotData);
plotFFT = @(src, event) helper_continuous_fft(event.Data, src.Rate, hp);
lh = addlistener(s,'DataAvailable', plotFFT); 



startBackground(s);

%%
delete(lh)

