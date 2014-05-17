#   Copyright (C) 2013 Samuele Carcagno <sam.carcagno@gmail.com>
#   This file is part of jsndlib

#    jsndlib is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.

#    jsndlib is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.

#    You should have received a copy of the GNU General Public License
#    along with jsndlib.  If not, see <http://www.gnu.org/licenses/>.
#

#jsndlibs is a module to generate sounds in julia

function broadbandNoise(spectrumLevel, duration, ramp, channel, fs, maxLevel)
    ## """
    ## Synthetise a broadband noise.

    ## Parameters
    ## ----------
    ## spectrumLevel : float
    ##     Intensity spectrum level of the noise in dB SPL. 
    ## duration : float
    ##     Noise duration (excluding ramps) in milliseconds.
    ## ramp : float
    ##     Duration of the onset and offset ramps in milliseconds.
    ##     The total duration of the sound will be duration+ramp*2.
    ## channel : string ('Right', 'Left' or 'Both')
    ##     Channel in which the noise will be generated.
    ## fs : int
    ##     Samplig frequency in Hz.
    ## maxLevel : float
    ##     Level in dB SPL output by the soundcard for a sinusoid of amplitude 1.

    ## Returns
    ## -------
    ## snd : 2-dimensional array of floats
    ##     The array has dimensions (nSamples, 2).
       
    ## Examples
    ## --------
    ## >>> noise = broadbandNoise(spectrumLevel=40, duration=180, ramp=10,
    ## ...     channel='Both', fs=48000, maxLevel=100)
    
    ## """
    ## """ Comments:.
    ## The intensity spectrum level in dB is SL
    ## The peak amplitude A to achieve a desired SL is
    ## SL = 10*log10(RMS^2/NHz) that is the total RMS^2 divided by the freq band
    ## SL/10 = log10(RMS^2/NHz)
    ## 10^(SL/10) = RMS^2/NHz
    ## RMS^2 = 10^(SL/10) * NHz
    ## RMS = 10^(SL/20) * sqrt(NHz)
    ## NHz = sampRate / 2 (Nyquist)
    

    ## """
    amp = sqrt(fs/2)*(10^((spectrumLevel - maxLevel) / 20))
    duration = duration / 1000 #convert from ms to sec
    ramp = ramp / 1000

    nSamples = int(round(duration * fs))
    nRamp = int(round(ramp * fs))
    nTot = nSamples + (nRamp * 2)

    timeAll = [0:nTot-1] / fs
    timeRamp = [0:nRamp-1]

    snd = zeros(nTot, 2)
    #random is a numpy module
    noise = (rand(nTot) + rand(nTot)) - (rand(nTot) + rand(nTot))
    RMS = sqrt(mean(noise.*noise))
    #scale the noise so that the maxAmplitude goes from -1 to 1
    #since A = RMS*sqrt(2)
    scaled_noise = noise / (RMS * sqrt(2))


    if channel == "Right"
        snd[1:nRamp, 2] = amp * ((1-cos(pi * timeRamp/nRamp))/2) .* scaled_noise[1:nRamp]
        snd[nRamp+1:nRamp+nSamples, 2] = amp * scaled_noise[nRamp+1:nRamp+nSamples]
        snd[nRamp+nSamples+1:length(timeAll), 2] = amp * ((1+cos(pi * timeRamp/nRamp))/2) .* scaled_noise[nRamp+nSamples+1:length(timeAll)]
    elseif channel == "Left"
        snd[1:nRamp, 1] = amp * ((1-cos(pi * timeRamp/nRamp))/2) .* scaled_noise[1:nRamp]
        snd[nRamp+1:nRamp+nSamples, 1] = amp * scaled_noise[nRamp+1:nRamp+nSamples]
        snd[nRamp+nSamples+1:length(timeAll), 1] = amp * ((1+cos(pi * timeRamp/nRamp))/2) .* scaled_noise[nRamp+nSamples+1:length(timeAll)]
    elseif channel == "Both"
        snd[1:nRamp, 2] = amp * ((1-cos(pi * timeRamp/nRamp))/2) .* scaled_noise[1:nRamp]
        snd[nRamp+1:nRamp+nSamples, 2] = amp * scaled_noise[nRamp+1:nRamp+nSamples]
        snd[nRamp+nSamples+1:length(timeAll), 2] = amp * ((1+cos(pi * timeRamp/nRamp))/2) .* scaled_noise[nRamp+nSamples+1:length(timeAll)]
        snd[1:nRamp, 1] = amp * ((1-cos(pi * timeRamp/nRamp))/2) .* scaled_noise[1:nRamp]
        snd[nRamp+1:nRamp+nSamples, 1] = amp * scaled_noise[nRamp+1:nRamp+nSamples]
        snd[nRamp+nSamples+1:length(timeAll), 1] = amp * ((1+cos(pi * timeRamp/nRamp))/2) .* scaled_noise[nRamp+nSamples+1:length(timeAll)]
    end

    return snd
end


function complexTone(F0, harmPhase, lowHarm, highHarm, stretch, level, duration, ramp, channel, fs, maxLevel)
    ## """
    ## Synthetise a complex tone.

    ## Parameters
    ## ----------
    ## F0 : float
    ##     Tone fundamental frequency in hertz.
    ## harmPhase : one of 'Sine', 'Cosine', 'Alternating', 'Random', 'Schroeder'
    ##     Phase relationship between the partials of the complex tone.
    ## lowHarm : int
    ##     Lowest harmonic component number.
    ## highHarm : int
    ##     Highest harmonic component number.
    ## stretch : float
    ##     Harmonic stretch in %F0. Increase each harmonic frequency by a fixed value
    ##     that is equal to (F0*stretch)/100. If 'stretch' is different than
    ##     zero, an inhanmonic complex tone will be generated.
    ## level : float
    ##     The level of each partial in dB SPL.
    ## duration : float
    ##     Tone duration (excluding ramps) in milliseconds.
    ## ramp : float
    ##     Duration of the onset and offset ramps in milliseconds.
    ##     The total duration of the sound will be duration+ramp*2.
    ## channel : 'Right', 'Left', 'Both', 'Odd Right' or 'Odd Left'
    ##     Channel in which the tone will be generated. If 'channel'
    ##     if 'Odd Right', odd numbered harmonics will be presented
    ##     to the right channel and even number harmonics to the left
    ##     channel. The opposite is true if 'channel' is 'Odd Left'.
    ## fs : int
    ##     Samplig frequency in Hz.
    ## maxLevel : float
    ##     Level in dB SPL output by the soundcard for a sinusoid of amplitude 1.

    ## Returns
    ## -------
    ## snd : 2-dimensional array of floats
    ##     The array has dimensions (nSamples, 2).

    ## Examples
    ## --------
    ## >>> ct = complexTone(F0=440, harmPhase='Sine', lowHarm=3, highHarm=10,
    ## ...     stretch=0, level=55, duration=180, ramp=10, channel='Both',
    ## ...     fs=48000, maxLevel=100)
    
    ## """
    
    amp = 10^((level - maxLevel) / 20)
    duration = duration / 1000 #convert from ms to sec
    ramp = ramp / 1000
    stretchHz = (F0*stretch)/100
    
    nSamples = int(round(duration * fs))
    nRamp = int(round(ramp * fs))
    nTot = nSamples + (nRamp * 2)

    timeAll = [0:nTot-1] / fs
    timeRamp = [0:nRamp-1]

    snd = zeros(nTot, 2)
    if channel == "Right" || channel == "Left" || channel == "Both"
        tone = zeros(nTot)
    elseif channel == "Odd Left" || channel == "Odd Right"
        toneOdd = zeros(nTot)
        toneEven = zeros(nTot)
    end

    if harmPhase == "Sine"
        for i=lowHarm:highHarm
            if channel == "Right" || channel == "Left" || channel == "Both"
                tone =  tone + sin(2 * pi * ((F0 * i) + stretchHz) * timeAll)
            elseif channel == "Odd Left" || channel == "Odd Right"
                if i%2 > 0 #odd harmonic
                    toneOdd = toneOdd + sin(2 * pi * ((F0 * i)+stretchHz) * timeAll)
                else
                    toneEven = toneEven + sin(2 * pi * ((F0 * i)+stretchHz) * timeAll)
                end
            end
        end
    elseif harmPhase == "Cosine"
        for i=lowHarm:highHarm
            if channel == "Right" || channel == "Left" || channel == "Both"
                tone = tone + cos(2 * pi * ((F0 * i)+stretchHz) * timeAll)
            elseif channel == "Odd Left" || channel == "Odd Right"
                if i%2 > 0 #odd harmonic
                    toneOdd = toneOdd + cos(2 * pi * ((F0 * i)+stretchHz) * timeAll)
                else
                    toneEven = toneEven + cos(2 * pi * ((F0 * i)+stretchHz) * timeAll)
                end
            end
        end
    elseif harmPhase == "Alternating"
        for i=lowHarm:highHarm
            if i%2 > 0 #odd harmonic
                if channel == "Right" || channel == "Left" || channel == "Both"
                    tone = tone + cos(2 * pi * ((F0 * i)+stretchHz) * timeAll)
                elseif channel == "Odd Left" || channel == "Odd Right"
                    toneOdd = toneOdd + cos(2 * pi * ((F0 * i)+stretchHz) * timeAll)
                end
            else #even harmonic
                if channel == "Right" || channel == "Left" || channel == "Both"
                    tone = tone + sin(2 * pi * ((F0 * i)+stretchHz) * timeAll)
                elseif channel == "Odd Left" || channel == "Odd Right"
                    toneEven = toneEven + sin(2 * pi * ((F0 * i)+stretchHz) * timeAll)
                end
            end
        end
    elseif harmPhase == "Schroeder"
        for i=lowHarm:highHarm
            phase = -pi * i * (i - 1) / highHarm
            if channel == "Right" || channel == "Left" || channel == "Both"
                tone = tone + sin(2 * pi * ((F0 * i)+stretchHz) * timeAll + phase)
            elseif channel == "Odd Left" || channel == "Odd Right"
                if i%2 > 0 #odd harmonic
                    toneOdd = toneOdd + sin(2 * pi * ((F0 * i)+stretchHz) * timeAll + phase)
                else
                    toneEven = toneEven + sin(2 * pi * ((F0 * i)+stretchHz) * timeAll + phase)
                end
            end
        end
    elseif harmPhase == "Random"
        for i=lowHarm:highHarm
            phase = rand() * 2 * pi
            if channel == "Right" || channel == "Left" || channel == "Both"
                tone = tone + sin(2 * pi * ((F0 * i)+stretchHz) * timeAll + phase)
            elseif channel == "Odd Left" || channel == "Odd Right"
                if i%2 > 0 #odd harmonic
                    toneOdd = toneOdd + sin(2 * pi * ((F0 * i)+stretchHz) * timeAll + phase)
                else
                    toneEven = toneEven + sin(2 * pi * ((F0 * i)+stretchHz) * timeAll + phase)
                end
            end
        end
    end
  

    if channel == "Right"
        snd[1:nRamp, 2]                     = amp * ((1-cos(pi * timeRamp/nRamp))/2) .* tone[1:nRamp]
        snd[nRamp+1:nRamp+nSamples, 2]        = amp * tone[nRamp+1:nRamp+nSamples]
        snd[nRamp+nSamples+1:length(timeAll), 2] = amp * ((1+cos(pi * timeRamp/nRamp))/2) .* tone[nRamp+nSamples+1:length(timeAll)]
    elseif channel == "Left"
        snd[1:nRamp, 1]                     = amp * ((1-cos(pi * timeRamp/nRamp))/2) .* tone[1:nRamp]
        snd[nRamp+1:nRamp+nSamples, 1]        = amp * tone[nRamp+1:nRamp+nSamples]
        snd[nRamp+nSamples+1:length(timeAll), 1] = amp * ((1+cos(pi * timeRamp/nRamp))/2) .* tone[nRamp+nSamples+1:length(timeAll)]
    elseif channel == "Both"
        snd[1:nRamp, 1]                     = amp * ((1-cos(pi * timeRamp/nRamp))/2) .* tone[1:nRamp]
        snd[nRamp+1:nRamp+nSamples, 1]        = amp * tone[nRamp+1:nRamp+nSamples]
        snd[nRamp+nSamples+1:length(timeAll), 1] = amp * ((1+cos(pi * timeRamp/nRamp))/2) .* tone[nRamp+nSamples+1:length(timeAll)]
        snd[:, 2] = snd[:, 1]
    elseif channel == "Odd Left"
        snd[1:nRamp, 1]                     = amp * ((1-cos(pi * timeRamp/nRamp))/2) .* toneOdd[1:nRamp]
        snd[nRamp+1:nRamp+nSamples, 1]        = amp * toneOdd[nRamp+1:nRamp+nSamples]
        snd[nRamp+nSamples+1:length(timeAll), 1] = amp * ((1+cos(pi * timeRamp/nRamp))/2) .* toneOdd[nRamp+nSamples+1:length(timeAll)]
        snd[1:nRamp, 2]                     = amp * ((1-cos(pi * timeRamp/nRamp))/2) .* toneEven[1:nRamp]
        snd[nRamp+1:nRamp+nSamples, 2]        = amp * toneEven[nRamp+1:nRamp+nSamples]
        snd[nRamp+nSamples+1:length(timeAll), 2] = amp * ((1+cos(pi * timeRamp/nRamp))/2) .* toneEven[nRamp+nSamples+1:length(timeAll)]
    elseif channel == "Odd Right"
        snd[1:nRamp, 2]                     = amp * ((1-cos(pi * timeRamp/nRamp))/2) .* toneOdd[1:nRamp]
        snd[nRamp+1:nRamp+nSamples, 2]        = amp * toneOdd[nRamp+1:nRamp+nSamples]
        snd[nRamp+nSamples+1:length(timeAll), 2] = amp * ((1+cos(pi * timeRamp/nRamp))/2) .* toneOdd[nRamp+nSamples+1:length(timeAll)]
        snd[1:nRamp, 1]                     = amp * ((1-cos(pi * timeRamp/nRamp))/2) .* toneEven[1:nRamp]
        snd[nRamp+1:nRamp+nSamples, 1]        = amp * toneEven[nRamp+1:nRamp+nSamples]
        snd[nRamp+nSamples+1:length(timeAll), 1] = amp * ((1+cos(pi * timeRamp/nRamp))/2) .* toneEven[nRamp+nSamples+1:length(timeAll)]
    end

    return snd
    end

function gate(ramps, sig, fs)
    ## """
    ## Impose onset and offset ramps to a sound.

    ## Parameters
    ## ----------
    ## ramps : float
    ##     The duration of the ramps.
    ## sig : array of floats    
    ##     The signal on which the ramps should be imposed.
    ## fs : int
    ##     The sampling frequency os 'sig'

    ## Returns
    ## -------
    ## sig : array of floats
    ##    The ramped signal.

    ## Examples
    ## --------
    ## >>> noise = broadbandNoise(spectrumLevel=40, duration=200, ramp=0,
    ## ...     channel='Both', fs=48000, maxLevel=100)
    ## >>> gate(ramps=10, sig=noise, fs=48000)

    ## """
    
    ramps = ramps / 1000
    nRamp = int(round(ramps * fs))
    timeRamp = [0:nRamp-1] 
    nTot = length(sig[:,1])
    nStartSecondRamp = nTot - nRamp
    
    sig[1:nRamp, 1] = sig[1:nRamp, 1] .*  ((1-cos(pi * timeRamp/nRamp))/2)
    sig[1:nRamp, 2] = sig[1:nRamp, 2] .*  ((1-cos(pi * timeRamp/nRamp))/2)
    sig[nStartSecondRamp+1:nTot, 1] = sig[nStartSecondRamp+1:nTot, 1] .* ((1+cos(pi * timeRamp/nRamp))/2)
    sig[nStartSecondRamp+1:nTot, 2] = sig[nStartSecondRamp+1:nTot, 2] .* ((1+cos(pi * timeRamp/nRamp))/2)

    return sig
end

function makeSilence(duration, fs)
    ## """
    ## Generate a silence.

    ## This function just fills an array with zeros for the
    ## desired duration.
    
    ## Parameters
    ## ----------
    ## duration : float
    ##     Duration of the silence in milliseconds.
    ## fs : int
    ##     Samplig frequency in Hz.

    ## Returns
    ## -------
    ## snd : 2-dimensional array of floats
    ##     The array has dimensions (nSamples, 2).
       

    ## Examples
    ## --------
    ## >>> sil = makeSilence(duration=200, fs=48000)

    ## """
    #duration in ms
    duration = duration / 1000 #convert from ms to sec
    nSamples = int(round(duration * fs))
    snd = zeros(nSamples, 2)
    
    return snd
end

function pureTone(frequency, phase, level, duration, ramp, channel, fs, maxLevel) 

    amp = 10^((level - maxLevel) / 20)
    duration = duration / 1000 #convert from ms to sec
    ramp = ramp / 1000
    
    nSamples = int(round(duration * fs))
    nRamp = int(round(ramp * fs))
    nTot = nSamples + (nRamp * 2)

    timeAll = [0:nTot-1] / fs
    timeRamp = [0:nRamp-1]
    
    snd = zeros((nTot, 2))
    if channel == "Right"
        snd[1:nRamp, 2] = amp .* ((1.-cos(pi .* timeRamp/nRamp))./2) .* sin(2*pi*frequency .* timeAll[1:nRamp] .+ phase)
        snd[nRamp+1:nRamp+nSamples, 2] = amp* sin(2*pi*frequency .* timeAll[nRamp+1:nRamp+nSamples] .+ phase)
        snd[nRamp+nSamples+1:length(timeAll), 2] = amp .* ((1.+cos(pi .* timeRamp/nRamp))./2) .* sin(2*pi*frequency .* timeAll[nRamp+nSamples+1:length(timeAll)] .+ phase)
    elseif channel == "Left"
        snd[1:nRamp, 1] = amp .* ((1.-cos(pi .* timeRamp/nRamp))./2) .* sin(2*pi*frequency .* timeAll[1:nRamp] .+ phase)
        snd[nRamp+1:nRamp+nSamples, 1] = amp* sin(2*pi*frequency .* timeAll[nRamp+1:nRamp+nSamples] .+ phase)
        snd[nRamp+nSamples+1:length(timeAll), 1] = amp .* ((1.+cos(pi .* timeRamp/nRamp))./2) .* sin(2*pi*frequency .* timeAll[nRamp+nSamples+1:length(timeAll)] .+ phase)
    elseif channel == "Both"
        snd[1:nRamp, 1] = amp .* ((1 .-cos(pi .* timeRamp/nRamp))./2) .* sin(2*pi*frequency .* timeAll[1:nRamp] .+ phase)
        snd[nRamp+1:nRamp+nSamples, 1] = amp* sin(2*pi*frequency .* timeAll[nRamp+1:nRamp+nSamples] .+ phase)
        snd[nRamp+nSamples+1:length(timeAll), 1] = amp .* ((1.+cos(pi .* timeRamp/nRamp))./2) .* sin(2*pi*frequency .* timeAll[nRamp+nSamples+1:length(timeAll)] .+ phase)
        snd[:, 2] = snd[:, 1]
    end
    
        
    return snd
end

function scale(level, sig)
    ## """
    ## Increase or decrease the amplitude of a sound signal.

    ## Parameters
    ## ----------
    ## level : float
    ##     Desired increment or decrement in dB SPL.
    ## signal : array of floats
    ##     Signal to scale.

    ## Returns
    ## -------
    ## sig : 2-dimensional array of floats
       
    ## Examples
    ## --------
    ## >>> noise = broadbandNoise(spectrumLevel=40, duration=180, ramp=10,
    ## ...     channel='Both', fs=48000, maxLevel=100)
    ## >>> noise = scale(level=-10, sig=noise) #reduce level by 10 dB

    ## """
    #10**(level/20) is the amplitude corresponding to level
    #by multiplying the amplitudes we're adding the decibels
    # 20*log10(a1*a2) = 20*log10(a1) + 20*log10(a2)
    sig = sig * 10^(level/20)
    return sig
end


function steepNoise(frequency1, frequency2, level, duration, ramp, channel, fs, maxLevel)
    ## """
    ## Synthetise band-limited noise from the addition of random-phase
    ## sinusoids.

    ## Parameters
    ## ----------
    ## frequency1 : float
    ##     Start frequency of the noise.
    ## frequency2 : float
    ##     End frequency of the noise.
    ## level : float
    ##     Noise spectrum level.
    ## duration : float
    ##     Tone duration (excluding ramps) in milliseconds.
    ## ramp : float
    ##     Duration of the onset and offset ramps in milliseconds.
    ##     The total duration of the sound will be duration+ramp*2.
    ## channel : string ('Right', 'Left' or 'Both')
    ##     Channel in which the tone will be generated.
    ## fs : int
    ##     Samplig frequency in Hz.
    ## maxLevel : float
    ##     Level in dB SPL output by the soundcard for a sinusoid of amplitude 1.

    ## Returns
    ## -------
    ## snd : 2-dimensional array of floats
    ##     The array has dimensions (nSamples, 2).
       
    ## Examples
    ## --------
    ## >>> nbNoise = steepNoise(frequency=440, frequency2=660, level=65,
    ## ...     duration=180, ramp=10, channel='Right', fs=48000, maxLevel=100)
    
    ## """

    duration = duration/1000 #convert from ms to sec
    ramp = ramp/1000

    totDur = duration + (2 * ramp)
    nSamples = int(round(duration * fs))
    nRamp = int(round(ramp * fs))
    nTot = nSamples + (nRamp * 2)

    spacing = 1 / totDur
    components = 1 + floor((frequency2 - frequency1) / spacing)
    # SL = 10*log10(A^2/NHz) 
    # SL/10 = log10(A^2/NHz)
    # 10^(SL/10) = A^2/NHz
    # A^2 = 10^(SL/10) * NHz
    # RMS = 10^(SL/20) * sqrt(NHz) where NHz is the spacing between harmonics
    amp =  10^((level - maxLevel) / 20) * sqrt((frequency2 - frequency1) / components)
    
    timeAll = [0:nTot-1] / fs
    timeRamp = [0:nRamp-1]
    snd = zeros(nTot, 2)

    noise= zeros(nTot)
    for f=frequency1:spacing:frequency2
        radFreq = 2 * pi * f 
        phase = rand() * 2 * pi
        noise = noise + sin(phase + (radFreq * timeAll))
    end
    
    if channel == "Right"
        snd[1:nRamp, 2] = amp * ((1-cos(pi * timeRamp/nRamp))/2) .* noise[1:nRamp]
        snd[nRamp+1:nRamp+nSamples, 2] = amp * noise[nRamp+1:nRamp+nSamples]
        snd[nRamp+nSamples+1:length(timeAll), 2] = amp * ((1+cos(pi * timeRamp/nRamp))/2) .* noise[nRamp+nSamples+1:length(timeAll)]
    elseif channel == "Left"
        snd[1:nRamp, 1] = amp * ((1-cos(pi * timeRamp/nRamp))/2) .* noise[1:nRamp]
        snd[nRamp+1:nRamp+nSamples, 1] = amp * noise[nRamp+1:nRamp+nSamples]
        snd[nRamp+nSamples+1:length(timeAll), 1] = amp * ((1+cos(pi * timeRamp/nRamp))/2) .* noise[nRamp+nSamples+1:length(timeAll)]
    elseif channel == "Both"
        snd[1:nRamp, 2] = amp * ((1-cos(pi * timeRamp/nRamp))/2) .* noise[1:nRamp]
        snd[nRamp+1:nRamp+nSamples, 2] = amp * noise[nRamp+1:nRamp+nSamples]
        snd[nRamp+nSamples+1:length(timeAll), 2] = amp * ((1+cos(pi * timeRamp/nRamp))/2) .* noise[nRamp+nSamples+1:length(timeAll)]
        snd[1:nRamp, 1] = amp * ((1-cos(pi * timeRamp/nRamp))/2) .* noise[1:nRamp]
        snd[nRamp+1:nRamp+nSamples, 1] = amp * noise[nRamp+1:nRamp+nSamples]
        snd[nRamp+nSamples+1:length(timeAll), 1] = amp * ((1+cos(pi * timeRamp/nRamp))/2) .* noise[nRamp+nSamples+1:length(timeAll)]
    end

    return snd
end
