function [] = frequency_analyses(data_vector, discard_samples, sampling_period, frequency_resolution)
% data_vector contains the samples of the signal to be analyzed
% discard_samples is the number of samples which is discarded at the
% beginning of the signal
% sampling_period is the sampling period of the signal (data_vector)
% frequency_resolution is the desired frequency resolution

if discard_samples > 0
    data_vector(1:discard_samples) =[];
end

fft_length = (1/sampling_period)/frequency_resolution;

data_temp = zeros(fft_length,1);
data_temp(1:length(data_vector)) = data_vector;

%frequency_axis = (0:frequency_resolution:(1/sampling_period)-1);
frequency_axis = (0:frequency_resolution:fft_length-1);

fft_temp = fft(data_temp(1:fft_length),fft_length)/fft_length;
FFT_abs = abs(fft_temp(1:fft_length/2+1));


figure

plot(frequency_axis(1:fft_length/2+1),log(FFT_abs(:,1)));
xlim([0,0.05]);

XTick = frequency_axis(1:end/2+1);

xlabel('frequency [Hz]');
ylabel('FFT Values');
title('Fast fourier transform')

end