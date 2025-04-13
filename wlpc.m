[audioData, fs] = audioread('compress audio file.wav');  
audioData = mean(audioData, 2);            
N = length(audioData);                      

Y = fft(audioData);                         
Y_shifted = fftshift(Y);                   
f = linspace(-fs/2, fs/2, N);            
magnitude = abs(Y_shifted)/N;              


t = (0:N-1)/fs; 
figure;
plot(t, audioData);
xlabel('Time (s)');
ylabel('Amplitude');
title('Signal waveform over time');
grid on;


energy_total = sum(magnitude.^2);
low_freq_energy = sum(magnitude(f < 500).^2);
mid_freq_energy = sum(magnitude((f >= 500 & f < 2000)).^2);
high_freq_energy = sum(magnitude(f >= 2000).^2);

fprintf('energy_total: %.2f\n', energy_total);
fprintf('low_freq_energy (<500Hz): %.2f%%\n', 100*low_freq_energy/energy_total);
fprintf('mid_freq_energy (500-2000Hz): %.2f%%\n', 100*mid_freq_energy/energy_total);
fprintf('high_freq_energy (>2000Hz): %.2f%%\n', 100*high_freq_energy/energy_total);