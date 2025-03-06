clc; clear; close all;

time = linspace(-1, 1, 1000); 
alpha = 10; 
freq = 5; 

fsStart = 4 * freq; 
fsEnd = 0.5 * freq; 
numSamples = 2000; 

animTime = 5; 

x = exp(-alpha * time.^2) .* sin(2 * pi * freq * time);

figure;
hOrig = plot(time, x, 'k', 'LineWidth', 2);
hold on;
xlabel('Time (s)');
ylabel('Amplitude');
title('Signal Reconstruction: High to Low Sampling Frequency');
grid on;

pause(0);

hLine = plot(NaN, NaN, 'r', 'LineWidth', 1.5);
hScatter = scatter(NaN, NaN, 50, 'ro', 'filled');
hText = text(-0.9, 0.8, '', 'FontSize', 12, 'Color', 'b');
hFreq = text(-0.9, 0.6, ['Original Signal Frequency: ' num2str(freq) ' Hz'], 'FontSize', 12, 'Color', 'm');

fsValues = linspace(fsStart, fsEnd, numSamples); 

pauseTime = animTime / numSamples;

legend([hOrig, hLine], {'Original Signal', 'Reconstructed Signal'}, 'Location', 'Best');

for fs = fsValues  
    ts = 1 / fs; 
    tSampled = -1:ts:1; 
    xSampled = exp(-alpha * tSampled.^2) .* sin(2 * pi * freq * tSampled);
    
    set(hLine, 'XData', tSampled, 'YData', xSampled);
    set(hScatter, 'XData', tSampled, 'YData', xSampled);
    set(hText, 'String', ['Sampling Freq: ' num2str(fs, '%.2f') ' Hz']);
    
    pause(pauseTime); 
end

hold off;
