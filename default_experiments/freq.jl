

## """
## This experiment can be used to measure pure-tone frequency-discrimination
## thresholds.

## The available fields are:

## - Frequency (Hz) :
##     Signal frequency in Hz
## - Difference (%) :
##     Frequency difference (for constant procedures),
##     or starting frequency difference (for adaptive procedures),
##     between the standard and comparison stimuli. The difference
##     is measured as a percentage of the standard frequency in Hz.
## - Level (dB SPL) :
##     Signal level in dB SPL
## - Duration (ms) :
##     Signal duration (excluding ramps), in ms
## - Ramps (ms) :
##     Duration of each ramp, in ms

## The available choosers are:

## - Ear: [``Right``, ``Left``, ``Both``]
##     The ear to which the signal will be presented

## """

                                                                              
function initialize_freq(prm)
    exp_name = "Demo Frequency Discrimination"
    push!(prm["experimentsChoices"], exp_name)
    prm[exp_name] = (String => Any)[]
    prm[exp_name]["paradigmChoices"] = ["Transformed Up-Down",
                                         "Weighted Up-Down",
                                         "Constant m-Intervals n-Alternatives",
                                         "PEST"]

    prm[exp_name]["opts"] = ["hasISIBox", "hasAlternativesChooser", "hasFeedback",
                             "hasIntervalLights"]
    prm[exp_name]["defaultAdaptiveType"] = "Geometric"
    prm[exp_name]["defaultNIntervals"] = 2
    prm[exp_name]["defaultNAlternatives"] = 2
    prm[exp_name]["execString"] = "freq"
    #prm[exp_name]["version"] = __name__ + " " + pychoacoustics_version + " " + pychoacoustics_builddate
    
    return prm
end

function select_default_parameters_freq(prm, par)
   
    field = (FloatingPoint)[]
    fieldLabel = (String)[]
    chooser = (String)[]
    chooserLabel = (String)[]
    chooserOptions = (Any)[]
    
    push!(fieldLabel, "Frequency (Hz)")
    push!(field, 1000)
    
    push!(fieldLabel, "Difference (%)")
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

    prm["field"] = field
    prm["fieldLabel"] = fieldLabel
    prm["chooser"] = chooser
    prm["chooserLabel"] = chooserLabel
    prm["chooserOptions"] =  chooserOptions

    return prm
end
    
function doTrial_freq(prm)
    currBlock = "b"+ string(prm["currentBlock"])
    if prm["startOfBlock"] == true
        prm["additional_parameters_to_write"] = (Any)[]
        prm["adaptiveDifference"] = prm[currBlock]["field"][find(prm["fieldLabel"] .== "Difference (%)")]
        writeResultsHeader("log")
    end

    frequency = prm[currBlock]["field"][find(prm["fieldLabel"] .== "Frequency (Hz)")] 
    level = prm[currBlock]["field"][find(prm["fieldLabel"] .== "Level (dB SPL)")] 
    duration = prm[currBlock]["field"][find(prm["fieldLabel"] .== "Duration (ms)")] 
    ramps = prm[currBlock]["field"][find(prm["fieldLabel"] .== "Ramps (ms)")] 
    channel = prm[currBlock]["chooser"][find(prm["chooserLabel"] .== "Ear:")]
    phase = 0
    
    correctFrequency = frequency + (frequency*prm["adaptiveDifference"])/100
    stimulusCorrect = pureTone(correctFrequency, phase, level, duration, ramps,
                               channel, prm["sampRate"], parent.prm["maxLevel"])

      
    stimulusIncorrect = (Any)[]
    for i=1:(prm["nIntervals"]-1)
        thisSnd = pureTone(frequency, phase, level, duration, ramps, channel,
        prm["sampRate"], prm["maxLevel"])
        push!(stimulusIncorrect, thisSnd)
    end
    
    playRandomisedIntervals(stimulusCorrect, stimulusIncorrect)

end
