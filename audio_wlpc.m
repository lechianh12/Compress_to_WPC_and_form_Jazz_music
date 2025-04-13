% Đọc file âm thanh FLAC
[audioData, fs] = audioread('audio-out.wlp.flac');  
audioData = mean(audioData, 2);  % Nếu stereo, chuyển về mono

% Thông tin cơ bản
N = length(audioData);
t = (0:N-1)/fs;

% ===== Waveform theo thời gian =====
figure;
plot(t, audioData);
xlabel('Time (s)');
ylabel('Amplitude');
title('Signal Waveform over Time');
grid on;

% ===== Phổ tần số (Frequency Spectrum) =====
Y = fft(audioData);
f = (0:N-1)*(fs/N);  % Trục tần dương
magnitude = abs(Y)/N;

figure;
plot(f(1:N/2), magnitude(1:N/2));  % Chỉ vẽ phần phổ dương
xlabel('Frequency (Hz)');
ylabel('Magnitude');
title('Frequency Spectrum (0 to Nyquist)');
grid on;

% ===== Spectrogram (Tần số theo thời gian) =====
figure;
spectrogram(audioData, 1024, 512, 1024, fs, 'yaxis');
title('Spectrogram of audio-out.wlp.flac');
xlabel('Time (s)');
ylabel('Frequency (Hz)');
colorbar;
