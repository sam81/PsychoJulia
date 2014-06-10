#   Copyright (C) 2013-2014 Samuele Carcagno <sam.carcagno@gmail.com>
#   This file is part of PsychoJulia

#    PsychoJulia is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.

#    PsychoJulia is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.

#    You should have received a copy of the GNU General Public License
#    along with PsychoJulia.  If not, see <http://www.gnu.org/licenses/>.

function initialize_audiogram(prm)
    exp_name = "Audiogram"
    push!(prm["experimentsChoices"], exp_name)
    prm[exp_name] = (String => Any)[]
    prm[exp_name]["paradigmChoices"] = ["Transformed Up-Down",
                                        "Weighted Up-Down",
                                        "Constant m-Intervals n-Alternatives",
                                        "PEST"]
    
    prm[exp_name]["opts"] = ["hasISIBox", "hasAlternativesChooser", "hasFeedback",
                             "hasIntervalLights"]
    prm[exp_name]["defaultAdaptiveType"] = "Arithmetic"
    prm[exp_name]["defaultNIntervals"] = 2
    prm[exp_name]["defaultNAlternatives"] = 2
    prm[exp_name]["execString"] = "audiogram"
    #prm[exp_name]["version"] = __name__ + " " + pychoacoustics_version + " " + pychoacoustics_builddate

    return prm
    
end

function select_default_parameters_audiogram(prm, par)
   
    field = (FloatingPoint)[]
    fieldLabel = (String)[]
    chooser = (String)[]
    chooserLabel = (String)[]
    chooserOptions = (Any)[]
    
    push!(fieldLabel, "Frequency (Hz)")
    push!(field, 1000)
    
    push!(fieldLabel, "Bandwidth (Hz)")
    push!(field, 10)
    
    push!(fieldLabel, "Level (dB SPL)")
    push!(field, 50)
    
    push!(fieldLabel, "Duration (ms)")
    push!(field, 180)
    
    push!(fieldLabel, "Ramps (ms)")
    push!(field, 10)

    
    push!(chooserOptions, ["Right",
                           "Left",
                           "Both"])
    push!(chooserLabel, "Ear:")
    push!(chooser, "Right")
    push!(chooserOptions, ["Sinusoid",
                           "Narrowband Noise"])
    push!(chooserLabel, "Signal Type:")
    push!(chooser, "Sinusoid")
    
    #prm = (String => Any)[]
    prm["field"] = field
    prm["fieldLabel"] = fieldLabel
    prm["chooser"] = chooser
    prm["chooserLabel"] = chooserLabel
    prm["chooserOptions"] =  chooserOptions

    return prm
end

function get_fields_to_hide_audiogram(prm, wd)
    if wd["chooser"][find(prm["chooserLabel"] .== "Signal Type:")[1]][:currentText]() == "Sinusoid"
        prm["fieldsToHide"] = [find(prm["fieldLabel"] .== "Bandwidth (Hz)")]
    else
        prm["fieldsToShow"] = [find(prm["fieldLabel"] .== "Bandwidth (Hz)")]
    end
end

function doTrial_audiogram(prm, wd, wdc)
 
    currBlock = string("b", prm["currentBlock"])
    if prm["startOfBlock"] == true
        prm["additional_parameters_to_write"] = (Any)[]
        prm["adaptiveDifference"] = prm[currBlock]["field"][find(prm["fieldLabel"] .== "Level (dB SPL)")][1]
        prm["conditions"] = [string(prm["adaptiveDifference"])]

        writeResultsHeader("log", prm, wd)
    end

    currentCondition = prm["conditions"][1]
    frequency = prm[currBlock]["field"][find(prm["fieldLabel"] .== "Frequency (Hz)")][1] 
    bandwidth = prm[currBlock]["field"][find(prm["fieldLabel"] .== "Bandwidth (Hz)")][1]
    phase = 0
    correctLevel = prm["adaptiveDifference"]
    incorrectLevel = -200
    duration = prm[currBlock]["field"][find(prm["fieldLabel"] .== "Duration (ms)")][1]
    ramps = prm[currBlock]["field"][find(prm["fieldLabel"] .== "Ramps (ms)")][1] 
    channel = prm[currBlock]["chooser"][find(prm["chooserLabel"] .== "Ear:")][1]
    sndType = prm[currBlock]["chooser"][find(prm["chooserLabel"] .== "Signal Type:")][1]

    if sndType == "Narrowband Noise"
        if bandwidth > 0
            stimulusCorrect = steepNoise(frequency-(bandwidth/2), frequency+(bandwidth/2), correctLevel - (10*log10(bandwidth)),
                                                duration, ramps, channel, prm["sampRate"], prm["maxLevel"])
        else
            stimulusCorrect = pureTone(frequency, phase, correctLevel, duration, ramps, channel, prm["sampRate"], prm["maxLevel"])
        end
    elseif sndType == "Sinusoid"
        stimulusCorrect = pureTone(frequency, phase, correctLevel, duration, ramps, channel, prm["sampRate"], prm["maxLevel"])
    end
    
    
    stimulusIncorrect = (Any)[]
    for i=1:(prm["nIntervals"]-1)
        thisSnd = pureTone(frequency, phase, incorrectLevel, duration, ramps, channel, prm["sampRate"], prm["maxLevel"])
        push!(stimulusIncorrect, thisSnd)
    end
 
    playRandomisedIntervals(prm, wdc, stimulusCorrect, stimulusIncorrect)

end
