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

include("global_parameters.jl")
include("default_experiments/default_experiments.jl")
using PySide

szp = Qt.QSizePolicy()

prm = (String => Any)[]
wd = (String => Any)[] #widgets
wdc = (String => Any)[] #widget containers (like lists of widgets)
prm = get_prefs(prm)
prm = set_global_parameters(prm)

## prm["fieldsToHide"] = (Any)[]; prm["fieldsToShow"] = (Any)[]
## prm["choosersToHide"] = (Any)[]; prm["choosersToShow"] = (Any)[];
## prm["fileChoosersToHide"] = (Any)[]; prm["fileChoosersToShow"] = (Any)[];

function onChooserChange()
    prm["fieldsToHide"] = (Any)[]; prm["fieldsToShow"] = (Any)[]
    prm["choosersToHide"] = (Any)[]; prm["choosersToShow"] = (Any)[];
    prm["fileChoosersToHide"] = (Any)[]; prm["fileChoosersToShow"] = (Any)[];

    #would be good to check if get_fields_to_hide_ function exists so that it
    #can be made optional
    
    execString = prm[prm["currExp"]]["execString"]
    eval(parse(string("default_experiments.get_fields_to_hide_", execString, "(prm, wd)")))
    fieldsToHide = prm["fieldsToHide"]
    fieldsToShow = prm["fieldsToShow"]
    choosersToHide = prm["choosersToHide"]
    choosersToShow = prm["choosersToShow"]
    fileChoosersToHide = prm["fileChoosersToHide"]
    fileChoosersToShow = prm["fileChoosersToShow"] 
    
 
    for i in 1:length(fieldsToHide)
        wd["field"][fieldsToHide[i]][:hide]()
        wd["fieldLabel"][fieldsToHide[i]][:hide]()
        wd["fieldCheckBox"][fieldsToHide[i]][:hide]()
    end
    for i in 1:length(fieldsToShow)
        wd["field"][fieldsToShow[i]][:show]()
        wd["fieldLabel"][fieldsToShow[i]][:show]()
        wd["fieldCheckBox"][fieldsToShow[i]][:show]()
    end
    for i in 1:length(choosersToHide)
        wd["chooser"][choosersToHide[i]][:hide]()
        wd["chooserLabel"][choosersToHide[i]][:hide]()
        wd["chooserCheckBox"][choosersToHide[i]][:hide]()
    end
    for i in 1:length(choosersToShow)
        wd["chooser"][choosersToShow[i]][:show]()
        wd["chooserLabel"][choosersToShow[i]][:show]()
        wd["chooserCheckBox"][choosersToShow[i]][:show]()
    end
    for i in 1:length(fileChoosersToHide)
        wd["fileChooser"][fileChoosersToHide[i]][:hide]()
        wd["fileChooserButton"][fileChoosersToHide[i]][:hide]()
        wd["fileChooserCheckBox"][fileChoosersToHide[i]][:hide]()
    end
    for i in 1:length(fileChoosersToShow)
        wd["fileChooser"][fileChoosersToHide[i]][:show]()
        wd["fileChooserButton"][fileChoosersToHide[i]][:show]()
        wd["fileChooserCheckBox"][fileChoosersToHide[i]][:show]()
    end
end


function onClickDeleteParametersButton()
        ## if prm["storedBlocks"] > 1:
        ##     if prm["currentBlock"] <= prm["storedBlocks"] and prm["storedBlocks"] > 0:
        ##         currBlock = "b" + str(prm["currentBlock"])
                
        ##         if prm["currentBlock"] < (prm["storedBlocks"] -1):
        ##             blockPosition = prm[currBlock]["blockPosition"]
        ##             del prm[currBlock]
        ##             prm["storedBlocks"] = prm["storedBlocks"] -1
        ##             for i in range(prm["storedBlocks"]-prm["currentBlock"]+1):
        ##                 prm["b"+str(prm["currentBlock"]+i)] = prm["b"+str(prm["currentBlock"]+i+1)]
        ##             del prm["b"+str(prm["currentBlock"]+i+1)]
        ##             updateParametersWin()
        ##         elif prm["currentBlock"] == (prm["storedBlocks"] -1):
        ##             blockPosition = prm[currBlock]["blockPosition"]
        ##             del prm[currBlock]
        ##             prm["storedBlocks"] = prm["storedBlocks"] -1
        ##             prm["b"+str(prm["currentBlock"])] =  prm["b"+str(prm["storedBlocks"]+1)]
        ##             del prm["b"+str(prm["storedBlocks"]+1)]
        ##             updateParametersWin()
        ##         elif prm["currentBlock"] > (prm["storedBlocks"] -1):
        ##             moveNextBlock()
        ##             blockPosition = prm[currBlock]["blockPosition"]
        ##             del prm[currBlock]
        ##             prm["storedBlocks"] = prm["storedBlocks"] -1
        ##             storedBlocksCountLabel[:setText](str(prm["storedBlocks"]))

        ##         for i in range(prm["storedBlocks"]):
        ##             if int(prm["b"+str(i+1)]["blockPosition"]) > int(blockPosition):
        ##                 prm["b"+str(i+1)]["blockPosition"] = str(int(prm["b"+str(i+1)]["blockPosition"]) -1)
        ##         shufflingSchemeTF[:setText]("")
        ##         updateParametersWin()
        ##     else:
        ##         moveNextBlock()
        ## elif prm["storedBlocks"] == 1 and prm["currentBlock"] > prm["storedBlocks"]: #created a new 2nd block, not saved, and now wants to delete, since for a single stored block you should do nothing it does nothing, so move to next block
        ##     moveNextBlock()
end

function onClickResetParametersButton()
    ##    if prm["storedBlocks"] == 0:
    ##         pass
    ##     else:
    ##         prm["currentBlock"] = 1
    ##         for i in range(prm["storedBlocks"]):
    ##             prm["b"+str(i+1)]["blockPosition"] = str(i+1)
    ##         updateParametersWin()
    ##         prm["shuffled"] = False
    ##         saveParametersToFile(prm["tmpParametersFile"])
    ##         prm["currentRepetition"] = 1
    ##         autoSetGaugeValue()
    ##         responseBox.statusButton[:setText](prm["rbTrans"].translate("rb", "Start"))
    ## def onClickUndoUnsavedButton(self):
    ##     if prm["currentBlock"] > prm["storedBlocks"]:
    ##         onExperimentChange(experimentChooser.currentText())
    ##     else:
    ##         updateParametersWin()
end

function onClickLoadParametersButton()
    fd = Qt.QFileDialog()
    fName = fd[:getOpenFileName](w, "Choose parameters file to load", "", "prm files (*.prm *PRM *Prm);;All Files (*)")[1]
    if length(fName) > 0 #if the user didn't press cancel
        #@     loadParameters(fName)
    end
end

function onClickSaveParametersButton()
    ##@ if prm["storedBlocks"] < 1
    ##     ret = QMessageBox.warning(self, tr("Warning"),
    ##                               tr("There are no stored parameters to save."),
    ##                               QMessageBox.Ok)
    ## else
    ##     if parametersFile == None:
    ##         ftow = QFileDialog.getSaveFileName(self, tr("Choose file to write prm"), ".prm", tr("All Files (*)"))[0]
    ##     else
    ##         ftow = QFileDialog.getSaveFileName(self, tr("Choose file to write prm"), parametersFile, tr("All Files (*)"))[0]
    ##     end
    ##     if length(ftow) > 0 and prm["storedBlocks"] > 0:
    ##         saveParametersToFile(ftow)
    ##         saveParametersToFile(prm["tmpParametersFile"])
    ##         #if parametersFile == prm["tmpParametersFile"]:
    ##         #    if os.path.exists(parametersFile) == True:
    ##         #        os.remove(parametersFile)
    ##         parametersFile = ftow
    ##     end
    ## end
end

function onClickSaveResultsButton()
    fd = Qt.QFileDialog()
    ftow = fd[:getSaveFileName](w, "Choose file to write results", "", "All Files (*)", "", fd[:DontConfirmOverwrite])[1]

    if length(ftow) > 0
        x = [".txt", ".TXT", ".Txt"]
        if in(ftow[end-3:end], x) == false
            ftow = string(ftow, ".txt")
        end
        prm["resultsFile"] = ftow
        if ispath(ftow) == false
            fName = open(ftow, "w")
            write(fName, "")
            close(fName)
        end
    end
        statusBar[:showMessage](string("Saving results to file: ", prm["resultsFile"]))
end

function onClickShiftBlockDownButton()
    #@shiftBlock(prm["currentBlock"], "down")
end    

function onClickShiftBlockUpButton()
    #@shiftBlock(prm["currentBlock"], "up")
end

function onExperimentChange(experimentSelected)

    for i=1:paradigmChooser[:count]()
        paradigmChooser[:removeItem](0)
    end

    paradigmChooser[:addItems](prm[experimentSelected]["paradigmChoices"])
    setDefaultParameters(experimentSelected, prm[experimentSelected]["paradigmChoices"][1], par)
    #@responseBox.setupLights()
end

function onIntervalLightsChange()
    prm["intervalLights"] = intervalLightsChooser[:currentText]()
    #@responseBox.setupLights()
end

function onListenerChange()
    prm["listener"] = text(listenerTF)
end

function onResponseModeChange(selectedMode)
    if selectedMode != "Automatic"
        autoPCorrLabel[:hide]()
        autoPCorrTF[:hide]()
    else
        autoPCorrLabel[:show]()
        autoPCorrTF[:show]()
    end
end

function onSessionLabelChange()
    prm["sessionLabel"] = text(sessionLabelTF)
end

function onWarningIntervalChange()
    if warningIntervalChooser[:currentText]() == "Yes"
        prm["warningInterval"] = true
        warningIntervalDurLabel[:show]()
        warningIntervalDurTF[:show]()
        warningIntervalISILabel[:show]()
        warningIntervalISITF[:show]()
    else
        prm["warningInterval"] = false
        warningIntervalDurLabel[:hide]()
        warningIntervalDurTF[:hide]()
        warningIntervalISILabel[:hide]()
        warningIntervalISITF[:hide]()
    end
    #@responseBox.setupLights()
end

function removePrmWidgets()
    if prm["prevExp"] != None
        for f in 1:length(wd["field"])
            pw_prm_sizer_0[:removeWidget](wd["fieldLabel"][f])
            wd["fieldLabel"][f][:setParent](nothing)
            pw_prm_sizer_0[:removeWidget](wd["field"][f])
            wd["field"][f][:setParent](nothing)
            pw_prm_sizer_0[:removeWidget](wd["fieldCheckBox"][f])
            wd["fieldCheckBox"][f][:setParent](nothing)
        end
        for c in 1:length(wd["chooser"])
            pw_prm_sizer_1[:removeWidget](wd["chooserLabel"][c])
            wd["chooserLabel"][c][:setParent](nothing)
            pw_prm_sizer_1[:removeWidget](wd["chooser"][c])
            wd["chooser"][c][:setParent](nothing)
            pw_prm_sizer_1[:removeWidget](wd["chooserCheckBox"][c])
            wd["chooserCheckBox"][c][:setParent](nothing)
            end
        for f in 1:length(wd["fileChooser"])
            pw_prm_sizer_0[:removeWidget](wd["fileChooser"][f])
            wd["fileChooser"][f][:setParent](nothing)
            pw_prm_sizer_0[:removeWidget](wd["fileChooserButton"][f])
            wd["fileChooserButton"][f][:setParent](nothing)
            pw_prm_sizer_0[:removeWidget](wd["fileChooserCheckBox"][f])
            wd["fileChooserCheckBox"][f][:setParent](nothing)
        end
    end
end

function setAdditionalWidgets()
    if prm["prevExp"] != None
        for i=1:length(wdc["additionalWidgetsIntFieldList"])
            add_widg_sizer[:removeWidget](wdc["additionalWidgetsIntFieldLabelList"][i])
            wdc["additionalWidgetsIntFieldLabelList"][i][:setParent](nothing)
            add_widg_sizer[:removeWidget](wdc["additionalWidgetsIntFieldList"][i])
            wdc["additionalWidgetsIntFieldList"][i][:setParent](nothing)
            add_widg_sizer[:removeWidget](wdc["additionalWidgetsIntFieldCheckBoxList"][i])
            wdc["additionalWidgetsIntFieldCheckBoxList"][i][:setParent](nothing)
        end
        
        for i=1:length(wdc["additionalWidgetsChooserList"])
            add_widg_sizer[:removeWidget](wdc["additionalWidgetsChooserLabelList"][i])
            wdc["additionalWidgetsChooserLabelList"][i][:setParent](nothing)
            add_widg_sizer[:removeWidget](wdc["additionalWidgetsChooserList"][i])
            wdc["additionalWidgetsChooserList"][i][:setParent](nothing)
            add_widg_sizer[:removeWidget](wdc["additionalWidgetsChooserCheckBoxList"][i])
            wdc["additionalWidgetsChooserCheckBoxList"][i][:setParent](nothing)
        end
    end

        ## #ADD ADDITIONAL WIDGETS
        n = 0
        wdc["additionalWidgetsIntFieldList"] = (Any)[]
        wdc["additionalWidgetsIntFieldLabelList"] = (Any)[]
        wdc["additionalWidgetsIntFieldCheckBoxList"] = (Any)[]
        wdc["additionalWidgetsChooserList"] = (Any)[]
        wdc["additionalWidgetsChooserLabelList"] =(Any) []
        wdc["additionalWidgetsChooserCheckBoxList"] = (Any)[]

        if prm[prm["currExp"]]["hasISIBox"] == true
            ISILabel = Qt.QLabel("ISI (ms):")
            add_widg_sizer[:addWidget](ISILabel, n, 1)
            ISIBox = Qt.QLineEdit()
            ISIBox[:setText]("500")
            ISIBox[:setValidator](Qt.QIntValidator())
            add_widg_sizer[:addWidget](ISIBox, n, 2)
            ISIBoxCheckBox = Qt.QCheckBox()
            add_widg_sizer[:addWidget](ISIBoxCheckBox, n, 0)
            push!(wdc["additionalWidgetsIntFieldList"], ISIBox)
            push!(wdc["additionalWidgetsIntFieldLabelList"], ISILabel)
            push!(wdc["additionalWidgetsIntFieldCheckBoxList"], ISIBoxCheckBox)
            n = n+1
        end
        if prm[prm["currExp"]]["hasAlternativesChooser"] == true
            nIntervalsLabel = Qt.QLabel("Intervals:")
            add_widg_sizer[:addWidget](nIntervalsLabel, n, 1)
            nIntervalsChooser = Qt.QComboBox()
            nIntervalsChooser[:addItems](prm["nIntervalsChoices"])
            if haskey(prm, "nIntervals")
                nIntervalsChooser[:setCurrentIndex](find(prm["nIntervalsChoices"] .== string(prm["nIntervals"]))-1)
            else
                nIntervalsChooser[:setCurrentIndex](0)
            end
            add_widg_sizer[:addWidget](nIntervalsChooser, n, 2)
            qconnect(nIntervalsChooser, :activated, (str) -> onNIntervalsChange())
            nIntervalsCheckBox = Qt.QCheckBox()
            add_widg_sizer[:addWidget](nIntervalsCheckBox, n, 0)
            push!(wdc["additionalWidgetsChooserList"], nIntervalsChooser)
            push!(wdc["additionalWidgetsChooserLabelList"], nIntervalsLabel)
            push!(wdc["additionalWidgetsChooserCheckBoxList"], nIntervalsCheckBox)
            n = n+1
            nAlternativesLabel = Qt.QLabel("Alternatives:")
            add_widg_sizer[:addWidget](nAlternativesLabel, n, 1)
            nAlternativesChooser = Qt.QComboBox()
            nAlternativesChooser[:addItems]([string(prm["currentLocale"][:toInt](nIntervalsChooser[:currentText]())[1]-1), nIntervalsChooser[:currentText]()])
            nAlternativesChooser[:setCurrentIndex](nAlternativesChooser[:findText](string(prm["nAlternatives"])))
            add_widg_sizer[:addWidget](nAlternativesChooser, n, 2)
            qconnect(nAlternativesChooser, :activated, (str) -> onNAlternativesChange())
            nAlternativesCheckBox = Qt.QCheckBox()
            add_widg_sizer[:addWidget](nAlternativesCheckBox, n, 0)
            push!(wdc["additionalWidgetsChooserList"], nAlternativesChooser)
            push!(wdc["additionalWidgetsChooserLabelList"], nAlternativesLabel)
            push!(wdc["additionalWidgetsChooserCheckBoxList"], nAlternativesCheckBox)
            n = n+1
        end

        #Pre-Trial Interval
        if prm[prm["currExp"]]["hasPreTrialInterval"] == true
            preTrialIntervalChooserLabel = Qt.QLabel("Pre-Trial Interval:")
            add_widg_sizer[:addWidget](preTrialIntervalChooserLabel, n, 1)
            preTrialIntervalChooser = Qt.QComboBox()
            preTrialIntervalChooser[:addItems]([tr("Yes"), tr("No")])
            preTrialIntervalChooser[:setCurrentIndex](1)
            qconnect(preTrialIntervalChooser, :activated, (str) -> onPreTrialIntervalChange())
            add_widg_sizer[:addWidget](preTrialIntervalChooser, n, 2)
            preTrialIntervalCheckBox = Qt.QCheckBox()
            add_widg_sizer[:addWidget](preTrialIntervalCheckBox, n, 0)
            push!(wdc["additionalWidgetsChooserList"], preTrialIntervalChooser)
            push!(wdc["additionalWidgetsChooserLabelList"], preTrialIntervalChooserLabel)
            push!(wdc["additionalWidgetsChooserCheckBoxList"], preTrialIntervalCheckBox)
            n = n+1
            preTrialIntervalISILabel = Qt.QLabel("Pre-Trial Interval ISI (ms):")
            add_widg_sizer[:addWidget](preTrialIntervalISILabel, n, 1)
           
            preTrialIntervalISITF = Qt.QLineEdit()
            preTrialIntervalISITF[:setText]("500")
            preTrialIntervalISITF[:setValidator](QIntValidator())
            preTrialIntervalISITF[:setWhatsThis]("Sets the duration of the silent interval between the pre-trial interval and the first observation interval")
         
            add_widg_sizer[:addWidget](preTrialIntervalISITF, n, 2)
            preTrialIntervalISICheckBox = Qt.QCheckBox()
            add_widg_sizer[:addWidget](preTrialIntervalISICheckBox, n, 0)

            preTrialIntervalISILabel[:hide]()
            preTrialIntervalISITF[:hide]()
            preTrialIntervalISICheckBox[:hide]()
            
            push!(wdc["additionalWidgetsIntFieldList"], preTrialIntervalISITF)
            push!(wdc["additionalWidgetsIntFieldLabelList"], preTrialIntervalISILabel)
            push!(wdc["additionalWidgetsIntFieldCheckBoxList"], preTrialIntervalISICheckBox)
            n = n+1
        end

        #Precursor Interval
        if prm[prm["currExp"]]["hasPrecursorInterval"] == true
            precursorIntervalChooserLabel = Qt.QLabel("Precursor Interval:")
            add_widg_sizer[:addWidget](precursorIntervalChooserLabel, n, 1)
            precursorIntervalChooser = Qt.QComboBox()
            precursorIntervalChooser[:addItems](["Yes", "No"])
            precursorIntervalChooser[:setCurrentIndex](1)
            qconnect(precursorIntervalChooser, :activated, (str) -> onPrecursorIntervalChange())
            add_widg_sizer[:addWidget](precursorIntervalChooser, n, 2)
            precursorIntervalCheckBox = Qt.QCheckBox()
            add_widg_sizer[:addWidget](precursorIntervalCheckBox, n, 0)
            push!(wdc["additionalWidgetsChooserList"], precursorIntervalChooser)
            push!(wdc["additionalWidgetsChooserLabelList"], precursorIntervalChooserLabel)
            push!(wdc["additionalWidgetsChooserCheckBoxList"], precursorIntervalCheckBox)
            n = n+1
            precursorIntervalISILabel = Qt.QLabel("Precursor Interval ISI (ms):")
            add_widg_sizer[:addWidget](precursorIntervalISILabel, n, 1)
           
            precursorIntervalISITF = Qt.QLineEdit()
            precursorIntervalISITF[:setText]("500")
            precursorIntervalISITF[:setValidator](Qt.QIntValidator())
            precursorIntervalISITF[:setWhatsThis]("Sets the duration of the silent interval between the precursor interval and the observation interval")
         
            add_widg_sizer[:addWidget](precursorIntervalISITF, n, 2)
            precursorIntervalISICheckBox = Qt.QCheckBox()
            add_widg_sizer[:addWidget](precursorIntervalISICheckBox, n, 0)

            precursorIntervalISILabel[:hide]()
            precursorIntervalISITF[:hide]()
            precursorIntervalISICheckBox[:hide]()
            
            push!(wdc["additionalWidgetsIntFieldList"], precursorIntervalISITF)
            push!(wdc["additionalWidgetsIntFieldLabelList"], precursorIntervalISILabel)
            push!(wdc["additionalWidgetsIntFieldCheckBoxList"], precursorIntervalISICheckBox)
            n = n+1
        end
    
        #Postcursor Interval
        if prm[prm["currExp"]]["hasPostcursorInterval"] == true
            postcursorIntervalChooserLabel = Qt.QLabel("Postcursor Interval:")
            add_widg_sizer[:addWidget](postcursorIntervalChooserLabel, n, 1)
            postcursorIntervalChooser = Qt.QComboBox()
            postcursorIntervalChooser[:addItems](["Yes", "No"])
            postcursorIntervalChooser[:setCurrentIndex](1)
            qconnect(postcursorIntervalChooser, :activated, (str) -> onPostcursorIntervalChange())
            add_widg_sizer[:addWidget](postcursorIntervalChooser, n, 2)
            postcursorIntervalCheckBox = Qt.QCheckBox()
            add_widg_sizer[:addWidget](postcursorIntervalCheckBox, n, 0)
            push!(wdc["additionalWidgetsChooserList"], postcursorIntervalChooser)
            push!(wdc["additionalWidgetsChooserLabelList"], postcursorIntervalChooserLabel)
            push!(wdc["additionalWidgetsChooserCheckBoxList"], postcursorIntervalCheckBox)
            n = n+1
            postcursorIntervalISILabel = Qt.QLabel("Postcursor Interval ISI (ms):")
            add_widg_sizer[:addWidget](postcursorIntervalISILabel, n, 1)
           
            postcursorIntervalISITF = QLineEdit()
            postcursorIntervalISITF[:setText]("500")
            postcursorIntervalISITF[:setValidator](Qt.QIntValidator())
            postcursorIntervalISITF[:setWhatsThis]("Sets the duration of the silent interval between the observation interval and the postcursor interval")
         
            add_widg_sizer[:addWidget](postcursorIntervalISITF, n, 2)
            postcursorIntervalISICheckBox = Qt.QCheckBox()
            add_widg_sizer[:addWidget](postcursorIntervalISICheckBox, n, 0)

            postcursorIntervalISILabel[:hide]()
            postcursorIntervalISITF[:hide]()
            postcursorIntervalISICheckBox[:hide]()
            
            push!(wdc["additionalWidgetsIntFieldList"], postcursorIntervalISITF)
            push!(wdc["additionalWidgetsIntFieldLabelList"], postcursorIntervalISILabel)
            push!(wdc["additionalWidgetsIntFieldCheckBoxList"], postcursorIntervalISICheckBox)
            n = n+1
        end
            
        if prm[prm["currExp"]]["hasFeedback"] == true
            responseLightLabel =  Qt.QLabel("Response Light:")
            responseLightChooser = Qt.QComboBox()
            responseLightChooser[:addItems](["Feedback", "Neutral", "None"])
            add_widg_sizer[:addWidget](responseLightLabel, n, 1)
            add_widg_sizer[:addWidget](responseLightChooser, n, 2)
            responseLightCheckBox = Qt.QCheckBox()
            add_widg_sizer[:addWidget](responseLightCheckBox, n, 0)
            push!(wdc["additionalWidgetsChooserList"], responseLightChooser)
            push!(wdc["additionalWidgetsChooserLabelList"], responseLightLabel)
            push!(wdc["additionalWidgetsChooserCheckBoxList"], responseLightCheckBox)
            n = n+1
            responseLightDurationLabel = Qt.QLabel("Response Light Duration (ms):")
            add_widg_sizer[:addWidget](responseLightDurationLabel, n, 1)
            responseLightDurationTF = Qt.QLineEdit()
            responseLightDurationTF[:setText](prm["pref"]["general"]["responseLightDuration"])
            responseLightDurationTF[:setValidator](Qt.QIntValidator())

            add_widg_sizer[:addWidget](responseLightDurationTF, n, 2)
            responseLightDurationCheckBox = Qt.QCheckBox()
            add_widg_sizer[:addWidget](responseLightDurationCheckBox, n, 0)
            push!(wdc["additionalWidgetsIntFieldList"], responseLightDurationTF)
            push!(wdc["additionalWidgetsIntFieldLabelList"], responseLightDurationLabel)
            push!(wdc["additionalWidgetsIntFieldCheckBoxList"], responseLightDurationCheckBox)
            n = n+1
        else
            responseLightLabel =  QLabel("Response Light:")
            responseLightChooser = Qt.QComboBox()
            responseLightChooser[:addItems]([tr("Neutral"), tr("None")])
            add_widg_sizer[:addWidget](responseLightLabel, n, 1)
            add_widg_sizer[:addWidget](responseLightChooser, n, 2)
            responseLightCheckBox = Qt.QCheckBox()
            add_widg_sizer[:addWidget](responseLightCheckBox, n, 0)
            push!(wdc["additionalWidgetsChooserList"], responseLightChooser)
            push!(wdc["additionalWidgetsChooserLabelList"], responseLightLabel)
            push!(wdc["additionalWidgetsChooserCheckBoxList"], responseLightCheckBox)
            n = n+1
            responseLightDurationLabel = QLabel(tr("Response Light Duration (ms):"), self)
            add_widg_sizer[:addWidget](responseLightDurationLabel, n, 1)
            responseLightDurationTF = QLineEdit()
            responseLightDurationTF[:setText](prm["pref"]["general"]["responseLightDuration"])
            responseLightDurationTF[:setValidator](Qt.QIntValidator())
            push!(wdc["additionalWidgetsIntFieldList"], responseLightDurationTF)
            push!(wdc["additionalWidgetsIntFieldLabelList"], responseLightDurationLabel)

            add_widg_sizer[:addWidget](responseLightDurationTF, n, 2)
            responseLightDurationCheckBox = Qt.QCheckBox()
            add_widg_sizer[:addWidget](responseLightDurationCheckBox, n, 0)
            push!(wdc["additionalWidgetsIntFieldCheckBoxList"], responseLightDurationCheckBox)
            n = n+1
        end
end

function setDefaultParameters(experiment, paradigm, par)
    prm["prevExp"] = copy(prm["currExp"])
    prm["currExp"] = experiment
    #prevExp = prm["prevExp"]; currExp = prm["currExp"]
    removePrmWidgets()

    if paradigm in ["Transformed Up-Down Interleaved", "Weighted Up-Down Interleaved"]
        if prm[prm["currExp"]]["hasNTracksChooser"] == false
            par["nDifferences"] = prm[prm["currExp"]]["defaultNTracks"]
        else
            if "nDifferences" in par == false
                if "defaultNTracks" in prm[prm["currExp"]]
                    par["nDifferences"] = prm[prm["currExp"]]["defaultNTracks"]
                else
                    par["nDifferences"] = 2
                end
            end
        end
    end
    
    if paradigm in ["Multiple Constants 1-Interval 2-Alternatives", "Multiple Constants m-Intervals n-Alternatives", "Odd One Out"]
        if prm[prm["currExp"]]["hasNDifferencesChooser"] == false
            par["nDifferences"] = prm[prm["currExp"]]["defaultNDifferences"]
        else
            if "nDifferences" in par == false
                if "defaultNDifferences" in prm[prm["currExp"]]
                    par["nDifferences"] = prm[prm["currExp"]]["defaultNDifferences"]
                else
                    par["nDifferences"] = 2
                end
            end
        end
    end
    
    execString = prm[prm["currExp"]]["execString"]
    tmp = eval(parse(string("default_experiments.select_default_parameters_", execString, "(prm, par)")))

    prm["field"] = tmp["field"]
    prm["fieldLabel"] = tmp["fieldLabel"]
    prm["nFields"] = length(prm["fieldLabel"])
    prm["chooser"] = tmp["chooser"]
    prm["chooserLabel"] = tmp["chooserLabel"]
    prm["nChoosers"] = length(prm["chooserLabel"])
    prm["chooserOptions"] = tmp["chooserOptions"]

    if "fileChooser" in tmp
        prm["fileChooser"] = tmp["fileChooser"]
        prm["fileChooserButton"] = tmp["fileChooserButton"]
    else
        prm["fileChooser"] = []
        prm["fileChooserButton"] = []
    end
    prm["nFileChoosers"] = length(prm["fileChooser"])
    # SET UP TEXT FIELDS
    wd["field"] = (Any)[] 
    wd["fieldLabel"] = (Any)[] 
    wd["fieldCheckBox"] = (Any)[] 
    for f in 1:prm["nFields"]
        push!(wd["fieldLabel"], Qt.QLabel(prm["fieldLabel"][f]))
        pw_prm_sizer_0[:addWidget](wd["fieldLabel"][f], f, 1)
        push!(wd["field"], Qt.QLineEdit())
        wd["field"][f][:setText](string(prm["field"][f]))
        wd["field"][f][:setValidator](Qt.QDoubleValidator())
        pw_prm_sizer_0[:addWidget](wd["field"][f], f, 2)
        push!(wd["fieldCheckBox"], Qt.QCheckBox())
        pw_prm_sizer_0[:addWidget](wd["fieldCheckBox"][f], f, 0)
    end
    # SET UP CHOOSERS
    wd["chooser"] = (Any)[] 
    wd["chooserLabel"] = (Any)[] 
    wd["chooserOptions"] = (Any)[] 
    wd["chooserCheckBox"] = (Any)[] 
    for c in 1:prm["nChoosers"]
        push!(wd["chooserLabel"], Qt.QLabel(prm["chooserLabel"][c]))
        pw_prm_sizer_1[:addWidget](wd["chooserLabel"][c], c, 4)
        push!(wd["chooserOptions"], prm["chooserOptions"][c])
        push!(wd["chooser"], Qt.QComboBox())
        wd["chooser"][c][:addItems](wd["chooserOptions"][c])
        wd["chooser"][c][:setCurrentIndex](find(wd["chooserOptions"][c] .== prm["chooser"][c])-1)
        pw_prm_sizer_1[:addWidget](wd["chooser"][c], c, 5)
        push!(wd["chooserCheckBox"], Qt.QCheckBox())
        pw_prm_sizer_1[:addWidget](wd["chooserCheckBox"][c], c, 3)
    end
    for c in 1:length(wd["chooser"])
        qconnect(wd["chooser"][c], :activated, (str) -> onChooserChange())
    end
 
    #SET UP FILE CHOOSERS
    wd["fileChooser"] = (Any)[] #list(range(prm["nFileChoosers"]))
    wd["fileChooserButton"] = (Any)[] #list(range(prm["nFileChoosers"]))
    wd["fileChooserCheckBox"] = (Any)[] #list(range(prm["nFileChoosers"]))
    for f in 1:prm["nFileChoosers"]
        push!(wd["fileChooser"], QLineEdit())
        wd["fileChooser"][f][:setText(str(prm["fileChooser"][f]))]
        pw_prm_sizer_0[:addWidget(wd["fileChooser"][f], prm["nFields"]+f, 2)]
        push!(wd["fileChooserButton"], QPushButton(prm["fileChooserButton"][f]), self)
        wd["fileChooserButton"][f][:clicked][:connect(fileChooserButtonClicked)]
        pw_prm_sizer_0[:addWidget(wd["fileChooserButton"][f], prm["nFields"]+f, 1)]
        push!(wd["fileChooserCheckBox"][f], Qt.QCheckBox())
        pw_prm_sizer_0[:addWidget(wd["fileChooserCheckBox"][f], prm["nFields"]+f, 0)]
    end
        
    prm["prevParadigm"] = copy(prm["currParadigm"])
    prm["currParadigm"] = paradigm 
    paradigmChooser[:setCurrentIndex](find(prm[prm["currExp"]]["paradigmChoices"] .== prm["currParadigm"])-1)
    preTrialSilenceTF[:setText](prm["pref"]["general"]["preTrialSilence"])

    setParadigmWidgets()
    if prm["currParadigm"] == "Transformed Up-Down"
        wd["adaptiveTypeChooser"][:setCurrentIndex](find(prm["adaptiveTypeChoices"] .== prm[prm["currExp"]]["defaultAdaptiveType"])-1)
    end
    
    prm["nIntervals"] = prm[prm["currExp"]]["defaultNIntervals"]  #tmp["nIntervals"]
    prm["nAlternatives"] = prm[prm["currExp"]]["defaultNAlternatives"]#tmp["nAlternatives"]
    setAdditionalWidgets()
    onChooserChange()
end


function setParadigmWidgets()
    if prm["prevParadigm"] != None
        for i=1:length(wdc["paradigmChooserList"])
            paradigm_widg_sizer[:removeWidget](wdc["paradigmChooserList"][i])
            wdc["paradigmChooserList"][i][:setParent](nothing)
            paradigm_widg_sizer[:removeWidget](wdc["paradigmChooserLabelList"][i])
            wdc["paradigmChooserLabelList"][i][:setParent](nothing)
            paradigm_widg_sizer[:removeWidget](wdc["paradigmChooserCheckBoxList"][i])
            wdc["paradigmChooserCheckBoxList"][i][:setParent](nothing)
        end
        for i=1:length(wdc["paradigmFieldList"])
            paradigm_widg_sizer[:removeWidget](wdc["paradigmFieldList"][i])
            wdc["paradigmFieldList"][i][:setParent](nothing)
            paradigm_widg_sizer[:removeWidget](wdc["paradigmFieldLabelList"][i])
            wdc["paradigmFieldLabelList"][i][:setParent](nothing)
            paradigm_widg_sizer[:removeWidget](wdc["paradigmFieldCheckBoxList"][i])
            wdc["paradigmFieldCheckBoxList"][i][:setParent](nothing)
        end
    end

         
        ## #------------------------------------
        ## #ADAPTIVE PARADIGM WIDGETS
    if prm["currParadigm"] == "Transformed Up-Down"
        n = 0
        wd["adaptiveTypeChooserLabel"] = Qt.QLabel("Procedure:")
        paradigm_widg_sizer[:addWidget](wd["adaptiveTypeChooserLabel"], n, 1)
        wd["adaptiveTypeChooser"] = Qt.QComboBox()
        wd["adaptiveTypeChooser"][:addItems](prm["adaptiveTypeChoices"])
        wd["adaptiveTypeChooser"][:setCurrentIndex](0)
        paradigm_widg_sizer[:addWidget](wd["adaptiveTypeChooser"], n, 2)
        wd["adaptiveTypeCheckBox"] = Qt.QCheckBox()
        paradigm_widg_sizer[:addWidget](wd["adaptiveTypeCheckBox"], n, 0)

        n = n+1
        wd["initialTrackDirChooserLabel"] = Qt.QLabel("Initial Track Direction:")
        paradigm_widg_sizer[:addWidget](wd["initialTrackDirChooserLabel"], n, 1)
        wd["initialTrackDirChooser"] = Qt.QComboBox()
        wd["initialTrackDirChooser"][:addItems](["Up", "Down"])
        wd["initialTrackDirChooser"][:setCurrentIndex](0)
        paradigm_widg_sizer[:addWidget](wd["initialTrackDirChooser"], n, 2)
        wd["initialTrackDirCheckBox"] = Qt.QCheckBox()
        paradigm_widg_sizer[:addWidget](wd["initialTrackDirCheckBox"], n, 0)
        
        n = n+1
        wd["ruleDownLabel"] = Qt.QLabel("Rule Down")
        paradigm_widg_sizer[:addWidget](wd["ruleDownLabel"], n, 1)
        wd["ruleDownTF"] = Qt.QLineEdit()
        wd["ruleDownTF"][:setText]("2")
        wd["ruleDownTF"][:setValidator](Qt.QIntValidator())
        paradigm_widg_sizer[:addWidget](wd["ruleDownTF"], n, 2)
        wd["ruleDownCheckBox"] = Qt.QCheckBox()
        paradigm_widg_sizer[:addWidget](wd["ruleDownCheckBox"], n, 0)
        
        wd["ruleUpLabel"] = Qt.QLabel("Rule Up")
        paradigm_widg_sizer[:addWidget](wd["ruleUpLabel"], n, 5)
        wd["ruleUpTF"] = Qt.QLineEdit()
        wd["ruleUpTF"][:setText]("1")
        wd["ruleUpTF"][:setValidator](Qt.QIntValidator())
        paradigm_widg_sizer[:addWidget](wd["ruleUpTF"], n, 4)
        wd["ruleUpCheckBox"] = Qt.QCheckBox()
        paradigm_widg_sizer[:addWidget](wd["ruleUpCheckBox"], n, 3)
        n = n+1
        wd["initialTurnpointsLabel"] = Qt.QLabel("Initial Turnpoints")
        paradigm_widg_sizer[:addWidget](wd["initialTurnpointsLabel"], n, 1)
        wd["initialTurnpointsTF"] = Qt.QLineEdit()
        wd["initialTurnpointsTF"][:setText]("4")
        wd["initialTurnpointsTF"][:setValidator](Qt.QIntValidator())
        paradigm_widg_sizer[:addWidget](wd["initialTurnpointsTF"], n, 2)
        wd["initialTurnpointsCheckBox"] = Qt.QCheckBox()
        paradigm_widg_sizer[:addWidget](wd["initialTurnpointsCheckBox"], n, 0)
        
        wd["totalTurnpointsLabel"] = Qt.QLabel("Total Turnpoints")
        paradigm_widg_sizer[:addWidget](wd["totalTurnpointsLabel"], n, 5)
        wd["totalTurnpointsTF"] = Qt.QLineEdit()
        wd["totalTurnpointsTF"][:setText]("16")
        wd["totalTurnpointsTF"][:setValidator](Qt.QIntValidator())
        paradigm_widg_sizer[:addWidget](wd["totalTurnpointsTF"], n, 4)
        wd["totalTurnpointsCheckBox"] = Qt.QCheckBox()
        paradigm_widg_sizer[:addWidget](wd["totalTurnpointsCheckBox"], n, 3)
        n = n+1
        wd["stepSize1Label"] = Qt.QLabel("Step Size 1")
        paradigm_widg_sizer[:addWidget](wd["stepSize1Label"], n, 1)
        wd["stepSize1TF"] = Qt.QLineEdit()
        wd["stepSize1TF"][:setText]("4")
        wd["stepSize1TF"][:setValidator](Qt.QDoubleValidator())
        paradigm_widg_sizer[:addWidget](wd["stepSize1TF"], n, 2)
        wd["stepSize1CheckBox"] = Qt.QCheckBox()
        paradigm_widg_sizer[:addWidget](wd["stepSize1CheckBox"], n, 0)

        wd["stepSize2Label"] = Qt.QLabel("Step Size 2")
        paradigm_widg_sizer[:addWidget](wd["stepSize2Label"], n, 5)
        wd["stepSize2TF"] = Qt.QLineEdit()
        wd["stepSize2TF"][:setText]("2")
        wd["stepSize2TF"][:setValidator](Qt.QDoubleValidator())
        paradigm_widg_sizer[:addWidget](wd["stepSize2TF"], n, 4)
        wd["stepSize2CheckBox"] = Qt.QCheckBox()
        paradigm_widg_sizer[:addWidget](wd["stepSize2CheckBox"], n, 3)
        
        wdc["paradigmChooserList"] = [wd["adaptiveTypeChooser"], wd["initialTrackDirChooser"]]
        wdc["paradigmChooserLabelList"] = [wd["adaptiveTypeChooserLabel"], wd["initialTrackDirChooserLabel"]]
        wdc["paradigmChooserOptionsList"] = [prm["adaptiveTypeChoices"], ["Up", "Down"]]
        wdc["paradigmChooserCheckBoxList"] = [wd["adaptiveTypeCheckBox"], wd["initialTrackDirCheckBox"]]
        
        wdc["paradigmFieldList"] = [wd["ruleDownTF"], wd["ruleUpTF"], wd["initialTurnpointsTF"], wd["totalTurnpointsTF"], wd["stepSize1TF"], wd["stepSize2TF"]]
        wdc["paradigmFieldLabelList"] = [wd["ruleDownLabel"], wd["ruleUpLabel"], wd["initialTurnpointsLabel"], wd["totalTurnpointsLabel"], wd["stepSize1Label"], wd["stepSize2Label"]]
        wdc["paradigmFieldCheckBoxList"] = [wd["ruleDownCheckBox"], wd["ruleUpCheckBox"], wd["initialTurnpointsCheckBox"], wd["totalTurnpointsCheckBox"], wd["stepSize1CheckBox"], wd["stepSize2CheckBox"]]
    end
    
    ## #------------------------------------
    ## #WEIGHTED UP/DOWN PARADIGM WIDGETS
        ## if currParadigm == tr("Weighted Up-Down"):
        ##     n = 0
        ##     adaptiveTypeChooserLabel = Qt.QLabel(tr("Procedure:"))
        ##     paradigm_widg_sizer[:addWidget](adaptiveTypeChooserLabel, n, 1)
        ##     adaptiveTypeChooser = Qt.QComboBox()
        ##     adaptiveTypeChooser[:addItems](prm["adaptiveTypeChoices"])
        ##     adaptiveTypeChooser.setCurrentIndex(0)
        ##     paradigm_widg_sizer[:addWidget](adaptiveTypeChooser, n, 2)
        ##     adaptiveTypeCheckBox = Qt.QCheckBox()
        ##     paradigm_widg_sizer[:addWidget](adaptiveTypeCheckBox, n, 0)

        ##     n = n+1
        ##     initialTrackDirChooserLabel = Qt.QLabel(tr("Initial Track Direction:"), self)
        ##     paradigm_widg_sizer[:addWidget](initialTrackDirChooserLabel, n, 1)
        ##     initialTrackDirChooser = Qt.QComboBox()
        ##     initialTrackDirChooser[:addItems]([tr("Up"), tr("Down")])
        ##     initialTrackDirChooser.setCurrentIndex(1)
        ##     paradigm_widg_sizer[:addWidget](initialTrackDirChooser, n, 2)
        ##     initialTrackDirCheckBox = Qt.QCheckBox()
        ##     paradigm_widg_sizer[:addWidget](initialTrackDirCheckBox, n, 0)
        ##     n = n+1
        ##     pcTrackedLabel = Qt.QLabel(tr("Percent Correct Tracked"), self)
        ##     paradigm_widg_sizer[:addWidget](pcTrackedLabel, n, 1)
        ##     pcTrackedTF = Qt.QLineEdit()
        ##     pcTrackedTF[:setText]("75")
        ##     paradigm_widg_sizer[:addWidget](pcTrackedTF, n, 2)
        ##     pcTrackedCheckBox = Qt.QCheckBox()
        ##     paradigm_widg_sizer[:addWidget](pcTrackedCheckBox, n, 0)
            
        ##     n = n+1
        ##     initialTurnpointsLabel = Qt.QLabel(tr("Initial Turnpoints"), self)
        ##     paradigm_widg_sizer[:addWidget](initialTurnpointsLabel, n, 1)
        ##     initialTurnpointsTF = Qt.QLineEdit()
        ##     initialTurnpointsTF[:setText]("4")
        ##     paradigm_widg_sizer[:addWidget](initialTurnpointsTF, n, 2)
        ##     initialTurnpointsCheckBox = Qt.QCheckBox()
        ##     paradigm_widg_sizer[:addWidget](initialTurnpointsCheckBox, n, 0)

        ##     totalTurnpointsLabel = Qt.QLabel(tr("Total Turnpoints"), self)
        ##     paradigm_widg_sizer[:addWidget](totalTurnpointsLabel, n, 4)
        ##     totalTurnpointsTF = Qt.QLineEdit()
        ##     totalTurnpointsTF[:setText]("16")
        ##     paradigm_widg_sizer[:addWidget](totalTurnpointsTF, n, 5)
        ##     totalTurnpointsCheckBox = Qt.QCheckBox()
        ##     paradigm_widg_sizer[:addWidget](totalTurnpointsCheckBox, n, 3)
        ##     n = n+1
        ##     stepSize1Label = Qt.QLabel(tr("Step Size 1"), self)
        ##     paradigm_widg_sizer[:addWidget](stepSize1Label, n, 1)
        ##     stepSize1TF = Qt.QLineEdit()
        ##     stepSize1TF[:setText]("4")
        ##     paradigm_widg_sizer[:addWidget](stepSize1TF, n, 2)
        ##     stepSize1CheckBox = Qt.QCheckBox()
        ##     paradigm_widg_sizer[:addWidget](stepSize1CheckBox, n, 0)

        ##     stepSize2Label = Qt.QLabel(tr("Step Size 2"), self)
        ##     paradigm_widg_sizer[:addWidget](stepSize2Label, n, 4)
        ##     stepSize2TF = Qt.QLineEdit()
        ##     stepSize2TF[:setText]("2")
        ##     paradigm_widg_sizer[:addWidget](stepSize2TF, n, 5)
        ##     stepSize2CheckBox = Qt.QCheckBox()
        ##     paradigm_widg_sizer[:addWidget](stepSize2CheckBox, n, 3)
        ##     n = n+1
            
        ##     paradigmChooserList = [adaptiveTypeChooser, initialTrackDirChooser]
        ##     paradigmChooserLabelList = [adaptiveTypeChooserLabel, initialTrackDirChooserLabel]
        ##     paradigmChooserOptionsList = [prm["adaptiveTypeChoices"], [tr("Up"), tr("Down")]]
        ##     paradigmChooserCheckBoxList = [adaptiveTypeCheckBox, initialTrackDirCheckBox]

        ##     paradigmFieldList = [pcTrackedTF, initialTurnpointsTF, totalTurnpointsTF, stepSize1TF, stepSize2TF]
        ##     paradigmFieldLabelList = [pcTrackedLabel, initialTurnpointsLabel, totalTurnpointsLabel, stepSize1Label, stepSize2Label]
        ##     paradigmFieldCheckBoxList = [pcTrackedCheckBox, initialTurnpointsCheckBox, totalTurnpointsCheckBox, stepSize1CheckBox, stepSize2CheckBox]

        ## #------------------------------------
        ## #ADAPTIVE INTERLEAVED PARADIGM WIDGETS
        ## if currParadigm == tr("Transformed Up-Down Interleaved"):
        ##     n = 0
        ##     adaptiveTypeChooserLabel = Qt.QLabel(tr("Procedure:"), self)
        ##     paradigm_widg_sizer[:addWidget](adaptiveTypeChooserLabel, n, 1)
        ##     adaptiveTypeChooser = Qt.QComboBox()
        ##     adaptiveTypeChooser[:addItems](prm["adaptiveTypeChoices"])
        ##     adaptiveTypeChooser.setCurrentIndex(0)
        ##     paradigm_widg_sizer[:addWidget](adaptiveTypeChooser, n, 2)
        ##     adaptiveTypeCheckBox = Qt.QCheckBox()
        ##     paradigm_widg_sizer[:addWidget](adaptiveTypeCheckBox, n, 0)

        ##     n = n+1

        ##     nTracksLabel = Qt.QLabel(tr("No. Tracks:"), self)
        ##     paradigm_widg_sizer[:addWidget](nTracksLabel, n, 1)
        ##     nTracksChooser = Qt.QComboBox()
        ##     nTracksOptionsList = list(range(1,101))
        ##     nTracksOptionsList = [str(el) for el in nTracksOptionsList]
        ##     nTracksChooser[:addItems](nTracksOptionsList)
        ##     nTracks = par["nDifferences"]
        ##     nTracksChooser.setCurrentIndex(nTracksOptionsList.index(str(nTracks)))
        ##     paradigm_widg_sizer[:addWidget](nTracksChooser, n, 2)
        ##     nTracksChooser.activated[str].connect(onChangeNTracks)
        ##     nTracksCheckBox = Qt.QCheckBox()
        ##     paradigm_widg_sizer[:addWidget](nTracksCheckBox, n, 0)
        ##     if prm[currExp]["hasNTracksChooser"] == True:
        ##         nTracksLabel[:show]()
        ##         nTracksChooser[:show]()
        ##         nTracksCheckBox[:show]()
        ##     else:
        ##         nTracksLabel[:hide]()
        ##         nTracksChooser[:hide]()
        ##         nTracksCheckBox[:hide]()
        ##     n = n+1
        ##     maxConsecutiveTrialsLabel = Qt.QLabel(tr("Max. Consecutive Trials x Track:"), self)
        ##     paradigm_widg_sizer[:addWidget](maxConsecutiveTrialsLabel, n, 1)
        ##     maxConsecutiveTrials = Qt.QComboBox()
        ##     maxConsecutiveTrialsOptionsList = list(range(1,101))
        ##     maxConsecutiveTrialsOptionsList = [str(el) for el in maxConsecutiveTrialsOptionsList]
        ##     maxConsecutiveTrialsOptionsList.insert(0, tr("unlimited"))
          
        ##     maxConsecutiveTrials[:addItems](maxConsecutiveTrialsOptionsList)
        ##     paradigm_widg_sizer[:addWidget](maxConsecutiveTrials, n, 2)
        ##     maxConsecutiveTrialsCheckBox = Qt.QCheckBox()
        ##     paradigm_widg_sizer[:addWidget](maxConsecutiveTrialsCheckBox, n, 0)
        ##     if nTracks > 1:
        ##         maxConsecutiveTrialsLabel[:show]()
        ##         maxConsecutiveTrials[:show]()
        ##         maxConsecutiveTrialsCheckBox[:show]()
        ##     else:
        ##         maxConsecutiveTrials.setCurrentIndex(0)#"unlimited"
        ##         maxConsecutiveTrialsLabel[:hide]()
        ##         maxConsecutiveTrials[:hide]()
        ##         maxConsecutiveTrialsCheckBox[:hide]()
           

        ##     n = n+1

        ##     tnpToAverageLabel = Qt.QLabel(tr("Turnpoints to average:"), self)
        ##     paradigm_widg_sizer[:addWidget](tnpToAverageLabel, n, 1)
        ##     tnpToAverageChooser = Qt.QComboBox()
        ##     tnpToAverageChooser[:addItems](prm["tnpToAverageChoices"])
        ##     tnpToAverageChooser.setCurrentIndex(0)
        ##     paradigm_widg_sizer[:addWidget](tnpToAverageChooser, n, 2)
        ##     tnpToAverageCheckBox = Qt.QCheckBox()
        ##     paradigm_widg_sizer[:addWidget](tnpToAverageCheckBox, n, 0)

        ##     n = n+1
        ##     initialTrackDirChooserLabel = []
        ##     initialTrackDirChooser = []
        ##     trackDirOptionsList = []
        ##     initialTrackDirCheckBox = []
            
        ##     ruleDownTF = []
        ##     ruleUpTF = []
        ##     initialTurnpointsTF = []
        ##     totalTurnpointsTF = []
        ##     stepSize1TF = []
        ##     stepSize2TF = []
            
        ##     ruleDownLabel = []
        ##     ruleUpLabel = []
        ##     initialTurnpointsLabel = []
        ##     totalTurnpointsLabel = []
        ##     stepSize1Label = []
        ##     stepSize2Label = []

        ##     ruleDownCheckBox = []
        ##     ruleUpCheckBox = []
        ##     initialTurnpointsCheckBox = []
        ##     totalTurnpointsCheckBox = []
        ##     stepSize1CheckBox = []
        ##     stepSize2CheckBox = []
            
        ##     for i in range(par["nDifferences"]):
        ##         initialTrackDirChooserLabel.append(Qt.QLabel(tr("Initial Track {0} Direction:".format(str(i+1))), self))
        ##         paradigm_widg_sizer[:addWidget](initialTrackDirChooserLabel[i], n, 1)
        ##         initialTrackDirChooser.append(Qt.QComboBox())
        ##         initialTrackDirChooser[i][:addItems]([tr("Up"), tr("Down")])
        ##         initialTrackDirChooser[i].setCurrentIndex(1)
        ##         paradigm_widg_sizer[:addWidget](initialTrackDirChooser[i], n, 2)
        ##         trackDirOptionsList.append([tr("Up"), tr("Down")])
        ##         initialTrackDirCheckBox.append(QCheckBox())
        ##         paradigm_widg_sizer[:addWidget](initialTrackDirCheckBox[i], n, 0)
        ##         n = n+1
        ##         ruleDownLabel.append(Qt.QLabel(tr("Rule Down Track " + str(i+1)), self))
        ##         paradigm_widg_sizer[:addWidget](ruleDownLabel[i], n, 1)
        ##         ruleDownTF.append(Qt.QLineEdit())
        ##         ruleDownTF[i][:setText]("2")
        ##         ruleDownTF[i][:setValidator](Qt.QIntValidator())
        ##         paradigm_widg_sizer[:addWidget](ruleDownTF[i], n, 2)
        ##         ruleDownCheckBox.append(QCheckBox())
        ##         paradigm_widg_sizer[:addWidget](ruleDownCheckBox[i], n, 0)

        ##         ruleUpLabel.append(Qt.QLabel(tr("Rule Up Track " + str(i+1)), self))
        ##         paradigm_widg_sizer[:addWidget](ruleUpLabel[i], n, 4)
        ##         ruleUpTF.append(Qt.QLineEdit())
        ##         ruleUpTF[i][:setText]("1")
        ##         ruleUpTF[i][:setValidator](Qt.QIntValidator())
        ##         paradigm_widg_sizer[:addWidget](ruleUpTF[i], n, 5)
        ##         ruleUpCheckBox.append(QCheckBox())
        ##         paradigm_widg_sizer[:addWidget](ruleUpCheckBox[i], n, 3)

        ##         n = n+1
              
        ##         initialTurnpointsLabel.append(Qt.QLabel(tr("Initial Turnpoints Track " + str(i+1)), self))
        ##         paradigm_widg_sizer[:addWidget](initialTurnpointsLabel[i], n, 1)
        ##         initialTurnpointsTF.append(Qt.QLineEdit())
        ##         initialTurnpointsTF[i][:setText]("4")
        ##         initialTurnpointsTF[i][:setValidator](Qt.QIntValidator())
        ##         paradigm_widg_sizer[:addWidget](initialTurnpointsTF[i], n, 2)
        ##         initialTurnpointsCheckBox.append(QCheckBox())
        ##         paradigm_widg_sizer[:addWidget](initialTurnpointsCheckBox[i], n, 0)

        ##         totalTurnpointsLabel.append(Qt.QLabel(tr("Total Turnpoints Track " + str(i+1)), self))
        ##         paradigm_widg_sizer[:addWidget](totalTurnpointsLabel[i], n, 4)
        ##         totalTurnpointsTF.append(Qt.QLineEdit())
        ##         totalTurnpointsTF[i][:setText]("16")
        ##         totalTurnpointsTF[i][:setValidator](Qt.QIntValidator())
        ##         paradigm_widg_sizer[:addWidget](totalTurnpointsTF[i], n, 5)
        ##         totalTurnpointsCheckBox.append(QCheckBox())
        ##         paradigm_widg_sizer[:addWidget](totalTurnpointsCheckBox[i], n, 3)
                
        ##         n = n+1
        ##         stepSize1Label.append(Qt.QLabel(tr("Step Size 1 Track " + str(i+1)), self))
        ##         paradigm_widg_sizer[:addWidget](stepSize1Label[i], n, 1)
        ##         stepSize1TF.append(Qt.QLineEdit())
        ##         stepSize1TF[i][:setText]("4")
        ##         stepSize1TF[i][:setValidator](Qt.QDoubleValidator(self))
        ##         paradigm_widg_sizer[:addWidget](stepSize1TF[i], n, 2)
        ##         stepSize1CheckBox.append(QCheckBox())
        ##         paradigm_widg_sizer[:addWidget](stepSize1CheckBox[i], n, 0)
                
        ##         stepSize2Label.append(Qt.QLabel(tr("Step Size 2 Track " + str(i+1)), self))
        ##         paradigm_widg_sizer[:addWidget](stepSize2Label[i], n, 4)
        ##         stepSize2TF.append(Qt.QLineEdit())
        ##         stepSize2TF[i][:setText]("2")
        ##         stepSize2TF[i][:setValidator](Qt.QDoubleValidator(self))
        ##         paradigm_widg_sizer[:addWidget](stepSize2TF[i], n, 5)
        ##         stepSize2CheckBox.append(QCheckBox())
        ##         paradigm_widg_sizer[:addWidget](stepSize2CheckBox[i], n, 3)
        ##         n = n+1
           
                
        ##     paradigmChooserList = [adaptiveTypeChooser, nTracksChooser, maxConsecutiveTrials, tnpToAverageChooser]
        ##     paradigmChooserLabelList = [adaptiveTypeChooserLabel, nTracksLabel, maxConsecutiveTrialsLabel, tnpToAverageLabel]
        ##     paradigmChooserOptionsList = [prm["adaptiveTypeChoices"], nTracksOptionsList, maxConsecutiveTrialsOptionsList, prm["tnpToAverageChoices"]]
        ##     paradigmChooserCheckBoxList = [adaptiveTypeCheckBox, nTracksCheckBox, maxConsecutiveTrialsCheckBox, tnpToAverageCheckBox]
        ##     paradigmChooserList.extend(initialTrackDirChooser)
        ##     paradigmChooserLabelList.extend(initialTrackDirChooserLabel)
        ##     paradigmChooserOptionsList.extend(trackDirOptionsList)
        ##     paradigmChooserCheckBoxList.extend(initialTrackDirCheckBox)

        ##     paradigmFieldList = ruleDownTF
        ##     paradigmFieldList.extend(ruleUpTF)
        ##     paradigmFieldList.extend(initialTurnpointsTF)
        ##     paradigmFieldList.extend(totalTurnpointsTF)
        ##     paradigmFieldList.extend(stepSize1TF)
        ##     paradigmFieldList.extend(stepSize2TF)
        ##     paradigmFieldLabelList = ruleDownLabel
        ##     paradigmFieldLabelList.extend(ruleUpLabel)
        ##     paradigmFieldLabelList.extend(initialTurnpointsLabel)
        ##     paradigmFieldLabelList.extend(totalTurnpointsLabel)
        ##     paradigmFieldLabelList.extend(stepSize1Label)
        ##     paradigmFieldLabelList.extend(stepSize2Label)
        ##     paradigmFieldCheckBoxList = ruleDownCheckBox
        ##     paradigmFieldCheckBoxList.extend(ruleUpCheckBox)
        ##     paradigmFieldCheckBoxList.extend(initialTurnpointsCheckBox)
        ##     paradigmFieldCheckBoxList.extend(totalTurnpointsCheckBox)
        ##     paradigmFieldCheckBoxList.extend(stepSize1CheckBox)
        ##     paradigmFieldCheckBoxList.extend(stepSize2CheckBox)

        ## #--------------------------
        ## #WEIGHTED UP/DOWN INTERLEAVED PARADIGM WIDGETS
        ## if currParadigm == tr("Weighted Up-Down Interleaved"):
        ##     n = 0
        ##     adaptiveTypeChooserLabel = Qt.QLabel(tr("Procedure:"), self)
        ##     paradigm_widg_sizer[:addWidget](adaptiveTypeChooserLabel, n, 1)
        ##     adaptiveTypeChooser = Qt.QComboBox()
        ##     adaptiveTypeChooser[:addItems](prm["adaptiveTypeChoices"])
        ##     adaptiveTypeChooser.setCurrentIndex(0)
        ##     paradigm_widg_sizer[:addWidget](adaptiveTypeChooser, n, 2)
        ##     adaptiveTypeCheckBox = Qt.QCheckBox()
        ##     paradigm_widg_sizer[:addWidget](adaptiveTypeCheckBox, n, 0)
        ##     n = n+1

        ##     nTracksLabel = Qt.QLabel(tr("No. Tracks:"), self)
        ##     paradigm_widg_sizer[:addWidget](nTracksLabel, n, 1)
        ##     nTracksChooser = Qt.QComboBox()
        ##     nTracksOptionsList = list(range(1,101))
        ##     nTracksOptionsList = [str(el) for el in nTracksOptionsList]
        ##     nTracksChooser[:addItems](nTracksOptionsList)
        ##     nTracks = par["nDifferences"]
        ##     nTracksChooser.setCurrentIndex(nTracksOptionsList.index(str(nTracks)))
        ##     paradigm_widg_sizer[:addWidget](nTracksChooser, n, 2)
        ##     nTracksChooser.activated[str].connect(onChangeNTracks)
        ##     nTracksCheckBox = Qt.QCheckBox()
        ##     paradigm_widg_sizer[:addWidget](nTracksCheckBox, n, 0)
        ##     if prm[currExp]["hasNTracksChooser"] == True:
        ##         nTracksLabel[:show]()
        ##         nTracksChooser[:show]()
        ##         nTracksCheckBox[:show]()
        ##     else:
        ##         nTracksLabel[:hide]()
        ##         nTracksChooser[:hide]()
        ##         nTracksCheckBox[:hide]()
        ##     n = n+1
        ##     maxConsecutiveTrialsLabel = Qt.QLabel(tr("Max. Consecutive Trials x Track:"), self)
        ##     paradigm_widg_sizer[:addWidget](maxConsecutiveTrialsLabel, n, 1)
        ##     maxConsecutiveTrials = Qt.QComboBox()
        ##     maxConsecutiveTrialsOptionsList = list(range(1,101))
        ##     maxConsecutiveTrialsOptionsList = [str(el) for el in maxConsecutiveTrialsOptionsList]
        ##     maxConsecutiveTrialsOptionsList.insert(0, tr("unlimited"))
          
        ##     maxConsecutiveTrials[:addItems](maxConsecutiveTrialsOptionsList)
        ##     paradigm_widg_sizer[:addWidget](maxConsecutiveTrials, n, 2)
        ##     maxConsecutiveTrialsCheckBox = Qt.QCheckBox()
        ##     paradigm_widg_sizer[:addWidget](maxConsecutiveTrialsCheckBox, n, 0)
        ##     if nTracks > 1:
        ##         maxConsecutiveTrialsLabel[:show]()
        ##         maxConsecutiveTrials[:show]()
        ##         maxConsecutiveTrialsCheckBox[:show]()
        ##     else:
        ##         maxConsecutiveTrials.setCurrentIndex(0)#"unlimited"
        ##         maxConsecutiveTrialsLabel[:hide]()
        ##         maxConsecutiveTrials[:hide]()
        ##         maxConsecutiveTrialsCheckBox[:hide]()
           

        ##     n = n+1
        ##     tnpToAverageLabel = Qt.QLabel(tr("Turnpoints to average:"), self)
        ##     paradigm_widg_sizer[:addWidget](tnpToAverageLabel, n, 1)
        ##     tnpToAverageChooser = Qt.QComboBox()
        ##     tnpToAverageChooser[:addItems](prm["tnpToAverageChoices"])
        ##     tnpToAverageChooser.setCurrentIndex(0)
        ##     paradigm_widg_sizer[:addWidget](tnpToAverageChooser, n, 2)
        ##     tnpToAverageCheckBox = Qt.QCheckBox()
        ##     paradigm_widg_sizer[:addWidget](tnpToAverageCheckBox, n, 0)

        ##     n = n+1
        ##     initialTrackDirChooserLabel = []
        ##     initialTrackDirChooser = []
        ##     trackDirOptionsList = []
        ##     initialTrackDirCheckBox = []
             
        ##     pcTrackedTF = []
        ##     initialTurnpointsTF = []
        ##     totalTurnpointsTF = []
        ##     stepSize1TF = []
        ##     stepSize2TF = []
            
        ##     pcTrackedLabel = []
        ##     initialTurnpointsLabel = []
        ##     totalTurnpointsLabel = []
        ##     stepSize1Label = []
        ##     stepSize2Label = []

        ##     pcTrackedCheckBox = []
        ##     initialTurnpointsCheckBox = []
        ##     totalTurnpointsCheckBox = []
        ##     stepSize1CheckBox = []
        ##     stepSize2CheckBox = []
            
        ##     for i in range(par["nDifferences"]):
        ##         initialTrackDirChooserLabel.append(QLabel(tr("Initial Track {0} Direction:".format(str(i+1))), self))
        ##         paradigm_widg_sizer[:addWidget](initialTrackDirChooserLabel[i], n, 1)
        ##         initialTrackDirChooser.append(Qt.QComboBox())
        ##         initialTrackDirChooser[i][:addItems]([tr("Up"), tr("Down")])
        ##         initialTrackDirChooser[i].setCurrentIndex(1)
        ##         paradigm_widg_sizer[:addWidget](initialTrackDirChooser[i], n, 2)
        ##         trackDirOptionsList.append([tr("Up"), tr("Down")])
        ##         initialTrackDirCheckBox.append(QCheckBox())
        ##         paradigm_widg_sizer[:addWidget](initialTrackDirCheckBox[i], n, 0)
        ##         n = n+1
        ##         pcTrackedLabel.append(QLabel(tr("Percent Correct Tracked Track " + str(i+1)), self))
        ##         paradigm_widg_sizer[:addWidget](pcTrackedLabel[i], n, 1)
        ##         pcTrackedTF.append(Qt.QLineEdit())
        ##         pcTrackedTF[i][:setText]("75")
        ##         pcTrackedTF[i][:setValidator](Qt.QDoubleValidator(self))
        ##         paradigm_widg_sizer[:addWidget](pcTrackedTF[i], n, 2)
        ##         pcTrackedCheckBox.append(QCheckBox())
        ##         paradigm_widg_sizer[:addWidget](pcTrackedCheckBox[i], n, 0)

        ##         n = n+1
        ##         initialTurnpointsLabel.append(QLabel(tr("Initial Turnpoints Track " + str(i+1)), self))
        ##         paradigm_widg_sizer[:addWidget](initialTurnpointsLabel[i], n, 1)
        ##         initialTurnpointsTF.append(Qt.QLineEdit())
        ##         initialTurnpointsTF[i][:setText]("4")
        ##         initialTurnpointsTF[i][:setValidator](Qt.QIntValidator())
        ##         paradigm_widg_sizer[:addWidget](initialTurnpointsTF[i], n, 2)
        ##         initialTurnpointsCheckBox.append(QCheckBox())
        ##         paradigm_widg_sizer[:addWidget](initialTurnpointsCheckBox[i], n, 0)

        ##         totalTurnpointsLabel.append(QLabel(tr("Total Turnpoints Track " + str(i+1)), self))
        ##         paradigm_widg_sizer[:addWidget](totalTurnpointsLabel[i], n, 4)
        ##         totalTurnpointsTF.append(Qt.QLineEdit())
        ##         totalTurnpointsTF[i][:setText]("16")
        ##         totalTurnpointsTF[i][:setValidator](Qt.QIntValidator())
        ##         paradigm_widg_sizer[:addWidget](totalTurnpointsTF[i], n, 5)
        ##         totalTurnpointsCheckBox.append(QCheckBox())
        ##         paradigm_widg_sizer[:addWidget](totalTurnpointsCheckBox[i], n, 3)
                
        ##         n = n+1
        ##         stepSize1Label.append(QLabel(tr("Step Size 1 Track " + str(i+1)), self))
        ##         paradigm_widg_sizer[:addWidget](stepSize1Label[i], n, 1)
        ##         stepSize1TF.append(Qt.QLineEdit())
        ##         stepSize1TF[i][:setText]("4")
        ##         stepSize1TF[i][:setValidator](Qt.QDoubleValidator(self))
        ##         paradigm_widg_sizer[:addWidget](stepSize1TF[i], n, 2)
        ##         stepSize1CheckBox.append(QCheckBox())
        ##         paradigm_widg_sizer[:addWidget](stepSize1CheckBox[i], n, 0)
                
        ##         stepSize2Label.append(QLabel(tr("Step Size 2 Track " + str(i+1)), self))
        ##         paradigm_widg_sizer[:addWidget](stepSize2Label[i], n, 4)
        ##         stepSize2TF.append(Qt.QLineEdit())
        ##         stepSize2TF[i][:setText]("2")
        ##         stepSize2TF[i][:setValidator](Qt.QDoubleValidator(self))
        ##         paradigm_widg_sizer[:addWidget](stepSize2TF[i], n, 5)
        ##         stepSize2CheckBox.append(QCheckBox())
        ##         paradigm_widg_sizer[:addWidget](stepSize2CheckBox[i], n, 3)
        ##         n = n+1
           
                
        ##     paradigmChooserList = [adaptiveTypeChooser, nTracksChooser, maxConsecutiveTrials, tnpToAverageChooser]
        ##     paradigmChooserLabelList = [adaptiveTypeChooserLabel, nTracksLabel, maxConsecutiveTrialsLabel, tnpToAverageLabel]
        ##     paradigmChooserOptionsList = [prm["adaptiveTypeChoices"], nTracksOptionsList, maxConsecutiveTrialsOptionsList, prm["tnpToAverageChoices"]]
        ##     paradigmChooserCheckBoxList = [adaptiveTypeCheckBox, nTracksCheckBox, maxConsecutiveTrialsCheckBox, tnpToAverageCheckBox]
        ##     paradigmChooserList.extend(initialTrackDirChooser)
        ##     paradigmChooserLabelList.extend(initialTrackDirChooserLabel)
        ##     paradigmChooserOptionsList.extend(trackDirOptionsList)
        ##     paradigmChooserCheckBoxList.extend(initialTrackDirCheckBox)

        ##     paradigmFieldList = pcTrackedTF
        ##     paradigmFieldList.extend(initialTurnpointsTF)
        ##     paradigmFieldList.extend(totalTurnpointsTF)
        ##     paradigmFieldList.extend(stepSize1TF)
        ##     paradigmFieldList.extend(stepSize2TF)
        ##     paradigmFieldLabelList = pcTrackedLabel
        ##     paradigmFieldLabelList.extend(initialTurnpointsLabel)
        ##     paradigmFieldLabelList.extend(totalTurnpointsLabel)
        ##     paradigmFieldLabelList.extend(stepSize1Label)
        ##     paradigmFieldLabelList.extend(stepSize2Label)
        ##     paradigmFieldCheckBoxList = pcTrackedCheckBox
        ##     paradigmFieldCheckBoxList.extend(initialTurnpointsCheckBox)
        ##     paradigmFieldCheckBoxList.extend(totalTurnpointsCheckBox)
        ##     paradigmFieldCheckBoxList.extend(stepSize1CheckBox)
        ##     paradigmFieldCheckBoxList.extend(stepSize2CheckBox)

        ## #------------------------
        ## #ONE CONSTANT PARADIGM WIDGETS
        ## if currParadigm in [tr("Constant 1-Interval 2-Alternatives"), tr("Constant 1-Pair Same/Different"), tr("Constant m-Intervals n-Alternatives")]:
        ##     n = 0
        ##     nTrialsLabel = QLabel(tr("No. Trials"), self)
        ##     paradigm_widg_sizer[:addWidget](nTrialsLabel, n, 1)
        ##     nTrialsTF = Qt.QLineEdit()
        ##     nTrialsTF[:setText]("25")
        ##     nTrialsTF[:setValidator](Qt.QIntValidator())
        ##     paradigm_widg_sizer[:addWidget](nTrialsTF, n, 2)
        ##     nTrialsCheckBox = Qt.QCheckBox()
        ##     paradigm_widg_sizer[:addWidget](nTrialsCheckBox, n, 0)

        ##     n = n+1
        ##     nPracticeTrialsLabel = QLabel(tr("No. Practice Trials"), self)
        ##     paradigm_widg_sizer[:addWidget](nPracticeTrialsLabel, n, 1)
        ##     nPracticeTrialsTF = Qt.QLineEdit()
        ##     nPracticeTrialsTF[:setText]("0")
        ##     nPracticeTrialsTF[:setValidator](Qt.QIntValidator())
        ##     paradigm_widg_sizer[:addWidget](nPracticeTrialsTF, n, 2)
        ##     nPracticeTrialsCheckBox = Qt.QCheckBox()
        ##     paradigm_widg_sizer[:addWidget](nPracticeTrialsCheckBox, n, 0)

        ##     paradigmChooserList = []
        ##     paradigmChooserLabelList = []
        ##     paradigmChooserOptionsList = []
        ##     paradigmChooserCheckBoxList = []

        ##     paradigmFieldList = [nTrialsTF, nPracticeTrialsTF]
        ##     paradigmFieldLabelList = [nTrialsLabel, nPracticeTrialsLabel]
        ##     paradigmFieldCheckBoxList = [nTrialsCheckBox, nPracticeTrialsCheckBox]

      
        ## #------------------------
        ## #MULTIPLE CONSTANTS PARADIGM WIDGETS
        ## if currParadigm in [tr("Multiple Constants 1-Interval 2-Alternatives"), tr("Multiple Constants m-Intervals n-Alternatives"), tr("Odd One Out")]:
        ##     n = 0
        ##     nTrialsLabel = QLabel(tr("No. Trials"), self)
        ##     paradigm_widg_sizer[:addWidget](nTrialsLabel, n, 1)
        ##     nTrialsTF = Qt.QLineEdit()
        ##     nTrialsTF[:setText]("25")
        ##     nTrialsTF[:setValidator](Qt.QIntValidator())
        ##     paradigm_widg_sizer[:addWidget](nTrialsTF, n, 2)
        ##     nTrialsCheckBox = Qt.QCheckBox()
        ##     paradigm_widg_sizer[:addWidget](nTrialsCheckBox, n, 0)

        ##     n = n+1
        ##     nPracticeTrialsLabel = QLabel(tr("No. Practice Trials"), self)
        ##     paradigm_widg_sizer[:addWidget](nPracticeTrialsLabel, n, 1)
        ##     nPracticeTrialsTF = Qt.QLineEdit()
        ##     nPracticeTrialsTF[:setText]("0")
        ##     nPracticeTrialsTF[:setValidator](Qt.QIntValidator())
        ##     paradigm_widg_sizer[:addWidget](nPracticeTrialsTF, n, 2)
        ##     nPracticeTrialsCheckBox = Qt.QCheckBox()
        ##     paradigm_widg_sizer[:addWidget](nPracticeTrialsCheckBox, n, 0)

        ##     n = n+1
        ##     nDifferencesLabel = QLabel(tr("No. Differences:"), self)
        ##     paradigm_widg_sizer[:addWidget](nDifferencesLabel, n, 1)
        ##     nDifferencesChooser = Qt.QComboBox()
        ##     nDifferencesOptionsList = list(range(1,101))
        ##     nDifferencesOptionsList = [str(el) for el in nDifferencesOptionsList]
        ##     nDifferencesChooser[:addItems](nDifferencesOptionsList)
          
        ##     nDifferencesChooser.setCurrentIndex(nDifferencesOptionsList.index(str(par["nDifferences"])))
        ##     paradigm_widg_sizer[:addWidget](nDifferencesChooser, n, 2)
        ##     nDifferencesChooser.activated[str].connect(onChangeNDifferences)

        ##     nDifferencesCheckBox = Qt.QCheckBox()
        ##     paradigm_widg_sizer[:addWidget](nDifferencesCheckBox, n, 0)
        ##     if prm[currExp]["hasNDifferencesChooser"] == True:
        ##         nDifferencesLabel[:show]()
        ##         nDifferencesChooser[:show]()
        ##         nDifferencesCheckBox[:show]()
        ##     else:
        ##         nDifferencesLabel[:hide]()
        ##         nDifferencesChooser[:hide]()
        ##         nDifferencesCheckBox[:hide]()

        ##     paradigmChooserList = [nDifferencesChooser]
        ##     paradigmChooserLabelList = [nDifferencesLabel]
        ##     paradigmChooserOptionsList = [nDifferencesOptionsList]
        ##     paradigmChooserCheckBoxList = [nDifferencesCheckBox]

        ##     paradigmFieldList = [nTrialsTF, nPracticeTrialsTF]
        ##     paradigmFieldLabelList = [nTrialsLabel, nPracticeTrialsLabel]
        ##     paradigmFieldCheckBoxList = [nTrialsCheckBox, nPracticeTrialsCheckBox]

        ## #------------------------------------
        ## #PEST PARADIGM WIDGETS
        ## if currParadigm == tr("PEST"):
        ##     n = 0
        ##     adaptiveTypeChooserLabel = QLabel(tr("Procedure:"), self)
        ##     paradigm_widg_sizer[:addWidget](adaptiveTypeChooserLabel, n, 1)
        ##     adaptiveTypeChooser = Qt.QComboBox()
        ##     adaptiveTypeChooser[:addItems](prm["adaptiveTypeChoices"])
        ##     adaptiveTypeChooser.setCurrentIndex(0)
        ##     paradigm_widg_sizer[:addWidget](adaptiveTypeChooser, n, 2)
        ##     adaptiveTypeCheckBox = Qt.QCheckBox()
        ##     paradigm_widg_sizer[:addWidget](adaptiveTypeCheckBox, n, 0)

        ##     n = n+1
        ##     initialTrackDirChooserLabel = QLabel(tr("Initial Track Direction:"), self)
        ##     paradigm_widg_sizer[:addWidget](initialTrackDirChooserLabel, n, 1)
        ##     initialTrackDirChooser = Qt.QComboBox()
        ##     initialTrackDirChooser[:addItems](["Up", "Down"])
        ##     initialTrackDirChooser.setCurrentIndex(1)
        ##     paradigm_widg_sizer[:addWidget](initialTrackDirChooser, n, 2)
        ##     initialTrackDirCheckBox = Qt.QCheckBox()
        ##     paradigm_widg_sizer[:addWidget](initialTrackDirCheckBox, n, 0)

        ##     n = n+1
        ##     pcTrackedLabel = QLabel(tr("Percent Correct Tracked"), self)
        ##     paradigm_widg_sizer[:addWidget](pcTrackedLabel, n, 1)
        ##     pcTrackedTF = Qt.QLineEdit()
        ##     pcTrackedTF[:setText]("75")
        ##     pcTrackedTF[:setValidator](Qt.QDoubleValidator(self))
        ##     paradigm_widg_sizer[:addWidget](pcTrackedTF, n, 2)
        ##     pcTrackedCheckBox = Qt.QCheckBox()
        ##     paradigm_widg_sizer[:addWidget](pcTrackedCheckBox, n, 0)

        ##     #n = n+1
        ##     initialStepSizeLabel = QLabel(tr("Initial Step Size"), self)
        ##     paradigm_widg_sizer[:addWidget](initialStepSizeLabel, n, 4)
        ##     initialStepSizeTF = Qt.QLineEdit()
        ##     initialStepSizeTF[:setText]("5")
        ##     initialStepSizeTF[:setValidator](Qt.QIntValidator())
        ##     paradigm_widg_sizer[:addWidget](initialStepSizeTF, n, 5)
        ##     initialStepSizeCheckBox = Qt.QCheckBox()
        ##     paradigm_widg_sizer[:addWidget](initialStepSizeCheckBox, n, 3)

        ##     n = n+1
        ##     minStepSizeLabel = QLabel(tr("Minimum Step Size"), self)
        ##     paradigm_widg_sizer[:addWidget](minStepSizeLabel, n, 1)
        ##     minStepSizeTF = Qt.QLineEdit()
        ##     minStepSizeTF[:setText]("1")
        ##     minStepSizeTF[:setValidator](Qt.QDoubleValidator(self))
        ##     paradigm_widg_sizer[:addWidget](minStepSizeTF, n, 2)
        ##     minStepSizeCheckBox = Qt.QCheckBox()
        ##     paradigm_widg_sizer[:addWidget](minStepSizeCheckBox, n, 0)

        ##     #n = n+1
        ##     maxStepSizeLabel = QLabel(tr("Maximum Step Size"), self)
        ##     paradigm_widg_sizer[:addWidget](maxStepSizeLabel, n, 4)
        ##     maxStepSizeTF = Qt.QLineEdit()
        ##     maxStepSizeTF[:setText]("10")
        ##     maxStepSizeTF[:setValidator](Qt.QDoubleValidator(self))
        ##     paradigm_widg_sizer[:addWidget](maxStepSizeTF, n, 5)
        ##     maxStepSizeCheckBox = Qt.QCheckBox()
        ##     paradigm_widg_sizer[:addWidget](maxStepSizeCheckBox, n, 3)

        ##     n = n+1
        ##     WLabel = QLabel(tr("W"), self)
        ##     paradigm_widg_sizer[:addWidget](WLabel, n, 1)
        ##     WTF = Qt.QLineEdit()
        ##     WTF[:setText]("1.5")
        ##     WTF[:setValidator](Qt.QDoubleValidator(self))
        ##     paradigm_widg_sizer[:addWidget](WTF, n, 2)
        ##     WCheckBox = Qt.QCheckBox()
        ##     paradigm_widg_sizer[:addWidget](WCheckBox, n, 0)

        ##     paradigmChooserList = [adaptiveTypeChooser, initialTrackDirChooser]
        ##     paradigmChooserLabelList = [adaptiveTypeChooserLabel, initialTrackDirChooserLabel]
        ##     paradigmChooserOptionsList = [prm["adaptiveTypeChoices"], [tr("Up"), tr("Down")]]
        ##     paradigmChooserCheckBoxList = [adaptiveTypeCheckBox, initialTrackDirCheckBox]

        ##     paradigmFieldList = [initialStepSizeTF, minStepSizeTF, maxStepSizeTF,
        ##                               WTF, pcTrackedTF]
        ##     paradigmFieldLabelList = [initialStepSizeLabel, minStepSizeLabel,
        ##                                    maxStepSizeLabel, WLabel, pcTrackedLabel]
        ##     paradigmFieldCheckBoxList = [initialStepSizeCheckBox, minStepSizeCheckBox,
        ##                                       maxStepSizeCheckBox, WCheckBox, pcTrackedCheckBox]

end
function toggleResTableCheckBox()
    if procResTableCheckBox[:isChecked]() == false
        winPlotCheckBox[:setChecked](false)
        pdfPlotCheckBox[:setChecked](false)
    end
end

function toggleWinPlotCheckBox()
    if winPlotCheckBox[:isChecked]() == true
        procResTableCheckBox[:setChecked](true)
    end
end

function togglePdfPlotCheckBox()
    if pdfPlotCheckBox[:isChecked]() == true
        procResTableCheckBox[:setChecked](true)
    end
end


prm["currExp"] = None
prm["prevExp"] = None
prm["currParadigm"] = None
prm["prevParadigm"] = None
prm["currentBlock"] = 1
prm["storedBlocks"] = 0
par = (Any)[]

w = Qt.QMainWindow()
cw = Qt.QFrame()
pw = Qt.QFrame()#dropFrame(None)
cw[:Sunken]#.setFrameStyle(QFrame.StyledPanel|QFrame.Sunken)
pw[:Sunken]#.setFrameStyle(QFrame.StyledPanel|QFrame.Sunken)
splitter = Qt.QSplitter()
cw_sizer = Qt.QVBoxLayout()
def_widg_sizer = Qt.QGridLayout()
statusBar = w[:statusBar]()
menubar = w[:menuBar]()

fileMenu = menubar[:addMenu]("&File")
#exitButton = Qt.QAction(Qt.QIcon[:fromTheme]("application-exit", Qt.QIcon(":/application-exit")), "Exit", w)
exitButton = Qt.QAction("Exit", w)
exitButton[:setShortcut]("Ctrl+Q")
exitButton[:setStatusTip]("Exit application")
#@exitButton[:triggered][:connect](close)

processResultsMenu = fileMenu[:addMenu]("&Process Results")

processResultsLinearButton = Qt.QAction("&Process Results (Plain Text)", w)
processResultsLinearButton[:setStatusTip]("Process Results (Plain Text)")
#@processResultsLinearButton[:triggered][:connect](processResultsLinearDialog)

processResultsTableButton = Qt.QAction("&Process Results Table", w)
processResultsTableButton[:setStatusTip]("Process Results Table")
#@processResultsTableButton[:triggered][:connect](processResultsTableDialog)


## openResultsButton = QAction(QIcon.fromTheme("document-open", QIcon(":/document-open")), tr("Open Results File"), self)
openResultsButton = Qt.QAction("Open Results File", w)
openResultsButton[:setStatusTip]("Open Results File")
#@openResultsButton[:triggered][:connect](onClickOpenResultsButton)

processResultsMenu[:addAction](processResultsLinearButton)
processResultsMenu[:addAction](processResultsTableButton)
        
## fileMenu.addAction(openResultsButton)
fileMenu[:addAction](exitButton)
        
#EDIT MENU
editMenu = menubar[:addMenu]("&Edit")
#editPrefAction = Qt.QAction(QIcon.fromTheme("preferences-other", QIcon(":/preferences-other")), tr("Preferences"), self)
editPrefAction = Qt.QAction("Preferences", w)
editMenu[:addAction](editPrefAction)
#@editPrefAction[:triggered][:connect](onEditPref)

## editPhonesAction = Qt.QAction(QIcon.fromTheme("audio-headphones", QIcon(":/audio-headphones")), tr("Phones"), self)
editPhonesAction = Qt.QAction("Phones", w)
editMenu[:addAction](editPhonesAction)
#@editPhonesAction[:triggered][:connect](onEditPhones)

#editExperimentersAction = Qt.QAction(QIcon.fromTheme("system-users", QIcon(":/system-users")), tr("Experimenters"), self)
editExperimentersAction = Qt.QAction("Experimenters", w)
editMenu[:addAction](editExperimentersAction)
#@editExperimentersAction[:triggered][:connect](onEditExperimenters)

#TOOLS MENU
toolsMenu = menubar[:addMenu]("&Tools")
swapBlocksAction = Qt.QAction("Swap Blocks", w)
toolsMenu[:addAction](swapBlocksAction)
#@ swapBlocksAction[:triggered][:connect](onSwapBlocksAction)

#HELP MENU
helpMenu = menubar[:addMenu]("&Help")

##onShowManualPdfAction = Qt.QAction("Manual (pdf)", w)
## helpMenu[:addAction](onShowManualPdfAction)
## onShowManualPdfAction[:triggered][:connect](onShowManualPdf)

## onShowModulesDocAction = Qt.QAction(tr("Manual (html)"), self)
## helpMenu[:addAction](onShowModulesDocAction)
## onShowModulesDocAction[:triggered][:connect](onShowModulesDoc)

onShowFortuneAction = Qt.QAction("Fortunes", w)
helpMenu[:addAction](onShowFortuneAction)
#@ onShowFortuneAction[:triggered][:connect](onShowFortune)
        
#onAboutAction = Qt.QAction(QIcon.fromTheme("help-about", QIcon(":/help-about")), tr("About pychoacoustics"), self)
onAboutAction = Qt.QAction("About pychoacoustics", w)
helpMenu[:addAction](onAboutAction)
#@ onAboutAction[:triggered][:connect](onAbout)

n = 0
listenerLabel = Qt.QLabel("Listener")
listenerTF = Qt.QLineEdit("")
if haskey(prm, "listener")
    listenerTF[:setText](prm["listener"])
end
listenerTF[:editingFinished][:connect](onListenerChange)
listenerTF[:setWhatsThis]("Set a label (e.g. initials, or full name) for the listener being tested.")
def_widg_sizer[:addWidget](listenerLabel, n, 0)
def_widg_sizer[:addWidget](listenerTF, n, 1)
n = n+1
experimentLabelLabel = Qt.QLabel("Experiment Label")
experimentLabelTF = Qt.QLineEdit("")
def_widg_sizer[:addWidget](experimentLabelLabel, n, 0)
def_widg_sizer[:addWidget](experimentLabelTF, n, 1)
#n = n+1
sessionLabelLabel = Qt.QLabel("Session")
sessionLabelTF = Qt.QLineEdit("")
if haskey(prm, "sessionLabel")
    sessionLabelTF[:setText](prm["sessionLabel"])
end
sessionLabelTF[:setWhatsThis]("Set a label for the current experimental session. It can be a number or a descriptive word.")
sessionLabelTF[:editingFinished][:connect](onSessionLabelChange)
def_widg_sizer[:addWidget](sessionLabelLabel, n, 2)
def_widg_sizer[:addWidget](sessionLabelTF, n, 3)
n = n+1
conditionLabelLabel = Qt.QLabel("Condition Label")
conditionLabelTF = Qt.QLineEdit("")
def_widg_sizer[:addWidget](conditionLabelLabel, n, 0)
def_widg_sizer[:addWidget](conditionLabelTF, n, 1)

n = n+1
endExpCommandLabel = Qt.QLabel("End Command:")
def_widg_sizer[:addWidget](endExpCommandLabel, n, 0)
endExpCommandTF = Qt.QLineEdit("")
endExpCommandTF[:setWhatsThis]("Allows you to specify an operating system command at the end of the experiment (e.g. to process the results files, make a backup copy, etc...). Consult the pychoacoustics manual for further info.")
def_widg_sizer[:addWidget](endExpCommandTF, n, 1, 1, 3)

#SHUFFLE ORDER
n = n+1
shufflingSchemeLabel = Qt.QLabel("Shuffling Scheme:")
def_widg_sizer[:addWidget](shufflingSchemeLabel, n, 0)
shufflingSchemeTF = Qt.QLineEdit("")
shufflingSchemeTF[:setWhatsThis]("Give a blocks shuffling scheme. Example ([1,2,3],(4,5,6)) runs the first group of blocks '1,2,3' in random order, before running the second group of blocks '4,5,6', in linearorder. Consult the pychoacoustics manual for further info.")
def_widg_sizer[:addWidget](shufflingSchemeTF, n, 1, 1, 3)
n = n+1

#PROC RES
procResCheckBox = Qt.QCheckBox("Proc. Res.")
def_widg_sizer[:addWidget](procResCheckBox, n, 0)

#PROC RES TABLE
procResTableCheckBox = Qt.QCheckBox("Proc. Res. Table")
qconnect(procResTableCheckBox, :stateChanged, (int) -> toggleResTableCheckBox())
def_widg_sizer[:addWidget](procResTableCheckBox, n, 1)
n = n+1

#PLOT
winPlotCheckBox = Qt.QCheckBox("Plot")
qconnect(winPlotCheckBox, :stateChanged, (int) -> toggleWinPlotCheckBox())
def_widg_sizer[:addWidget](winPlotCheckBox, n, 0)
if prm["appData"]["plotting_available"] == false
    winPlotCheckBox[:hide]()
end

## #PDF PLOT
pdfPlotCheckBox = Qt.QCheckBox("PDF Plot")
qconnect(pdfPlotCheckBox, :stateChanged, (int) -> togglePdfPlotCheckBox())
def_widg_sizer[:addWidget](pdfPlotCheckBox, n, 1)
if prm["appData"]["plotting_available"] == false
    pdfPlotCheckBox[:hide]()
end
## #EXPERIMENTER
n = n+1
experimenterLabel =  Qt.QLabel("Experimenter:")
def_widg_sizer[:addWidget](experimenterLabel, n, 0)
experimenterChooser = Qt.QComboBox()
experimenterChooser[:addItems](prm["experimenter"]["experimenter_id"])
experimenterChooser[:setCurrentIndex](find(prm["experimenter"]["defaultExperimenter"] .== "\u2713")-1)
experimenterChooser[:setWhatsThis]("Allows choosing the experimenter identifier. This must have been previously stored in the experimenters database. On the toolbar click on the Edit > Experimenters to modify the experimenters database")
def_widg_sizer[:addWidget](experimenterChooser, n, 1)

#EXPERIMENT
n = n+1
experimentLabel =  Qt.QLabel("Experiment:")
def_widg_sizer[:addWidget](experimentLabel, n, 0)
experimentChooser = Qt.QComboBox()
experimentChooser[:addItems](prm["experimentsChoices"])
def_widg_sizer[:addWidget](experimentChooser, n, 1)
qconnect(experimentChooser, :activated, (str) -> onExperimentChange(prm["experimentsChoices"][str+1]))

#PARADIGM
n = n+1
paradigmLabel = Qt.QLabel("Paradigm:")
def_widg_sizer[:addWidget](paradigmLabel, n, 0)
paradigmChooser = Qt.QComboBox()
paradigmChooser[:addItems](prm["Audiogram"]["paradigmChoices"])
paradigmChooser[:setCurrentIndex](0)#qt index
def_widg_sizer[:addWidget](paradigmChooser, n, 1)
##@ paradigmChooser.activated[str].connect(onParadigmChange)

## #PHONES
n = n+1
phonesLabel = Qt.QLabel("Phones:")
def_widg_sizer[:addWidget](phonesLabel, n, 0)
phonesChooser = Qt.QComboBox()
phonesChooser[:addItems](prm["phones"]["phonesChoices"])
phonesChooser[:setCurrentIndex](find(prm["phones"]["defaultPhones"] .== "\u2713")-1)
def_widg_sizer[:addWidget](phonesChooser, n, 1)

#SAMPLING RATE
n = n+1
sampRateLabel = Qt.QLabel("Sample Rate (Hz):")
def_widg_sizer[:addWidget](sampRateLabel, n, 0)
sampRateTF = Qt.QLineEdit()
sampRateTF[:setText](prm["pref"]["sound"]["defaultSampleRate"])
sampRateTF[:setValidator](Qt.QIntValidator())
def_widg_sizer[:addWidget](sampRateTF, n, 1)
prm["sampRate"] =  prm["currentLocale"][:toInt](sampRateTF[:text]())[1]

#BITS
n = n+1
nBitsLabel = Qt.QLabel("Bits:")
def_widg_sizer[:addWidget](nBitsLabel, n, 0)
nBitsChooser = Qt.QComboBox()
nBitsChooser[:addItems](prm["nBitsChoices"])
nBitsChooser[:setCurrentIndex](find(prm["nBitsChoices"] .== prm["pref"]["sound"]["defaultNBits"])-1)
def_widg_sizer[:addWidget](nBitsChooser, n, 1)

#REPETITIONS
n = n+1
repetitionsLabel = Qt.QLabel("No. Repetitions:")
def_widg_sizer[:addWidget](repetitionsLabel, n, 0)
repetitionsTF = Qt.QLineEdit()
repetitionsTF[:setText]("1")
repetitionsTF[:setValidator](Qt.QIntValidator())
repetitionsTF[:setWhatsThis]("Sets the number of times the series of blocks is repeated")
def_widg_sizer[:addWidget](repetitionsTF, n, 1)

#PRE-TRIAL Silence
n = n+1
preTrialSilenceLabel = Qt.QLabel("Pre-Trial Silence (ms):")
def_widg_sizer[:addWidget](preTrialSilenceLabel, n, 0)
preTrialSilenceTF = Qt.QLineEdit()
preTrialSilenceTF[:setText](prm["pref"]["general"]["preTrialSilence"])
preTrialSilenceTF[:setValidator](Qt.QIntValidator())
preTrialSilenceTF[:setWhatsThis]("Sets the duration of a silent pause between the moment the listener has given the response and the start of the next trial")
def_widg_sizer[:addWidget](preTrialSilenceTF, n, 1)

#Warning Interval
n = n+1
warningIntervalLabel =  Qt.QLabel("Warning Interval:")
warningIntervalChooser = Qt.QComboBox()
warningIntervalChooser[:addItems](["Yes", "No"])
warningIntervalChooser[:setCurrentIndex](warningIntervalChooser[:findText]("No"))
qconnect(warningIntervalChooser, :activated, (str) -> onWarningIntervalChange())
def_widg_sizer[:addWidget](warningIntervalLabel, n, 0)
def_widg_sizer[:addWidget](warningIntervalChooser, n, 1)
n = n+1
warningIntervalDurLabel = Qt.QLabel("Warning Interval Duration (ms):")
def_widg_sizer[:addWidget](warningIntervalDurLabel, n, 0)
warningIntervalDurLabel[:hide]()
warningIntervalDurTF = Qt.QLineEdit()
warningIntervalDurTF[:setText]("500")
warningIntervalDurTF[:setValidator](Qt.QIntValidator())
warningIntervalDurTF[:setWhatsThis]("Sets the duration of the warning interval light")
warningIntervalDurTF[:hide]()
def_widg_sizer[:addWidget](warningIntervalDurTF, n, 1)
n = n+1
warningIntervalISILabel = Qt.QLabel("Warning Interval ISI (ms):")
def_widg_sizer[:addWidget](warningIntervalISILabel, n, 0)
warningIntervalISILabel[:hide]()
warningIntervalISITF = Qt.QLineEdit()
warningIntervalISITF[:setText]("500")
warningIntervalISITF[:setValidator](Qt.QIntValidator())
warningIntervalISITF[:setWhatsThis]("Sets the duration of the silent interval between the warning interval and the first observation interval")
warningIntervalISITF[:hide]()
def_widg_sizer[:addWidget](warningIntervalISITF, n, 1)

#INTERVAL LIGHTS
n = n+1
intervalLightsLabel = Qt.QLabel("Interval Lights:")
def_widg_sizer[:addWidget](intervalLightsLabel, n, 0)
intervalLightsChooser = Qt.QComboBox()
intervalLightsChooser[:addItems](["Yes", "No"])
intervalLightsChooser[:setCurrentIndex](intervalLightsChooser[:findText](prm["intervalLights"]))
def_widg_sizer[:addWidget](intervalLightsChooser, n, 1)
qconnect(intervalLightsChooser, :activated, (str) -> onIntervalLightsChange())

#RESULTS FILE
n = n+1
saveResultsLabel =  Qt.QLabel("Results File:")
def_widg_sizer[:addWidget](saveResultsLabel, n, 0)
min_pw_butt_size = 22
min_pw_icon_size = 20

def_widg_sizer[:setRowMinimumHeight](0, min_pw_butt_size)
saveResultsButton = Qt.QPushButton("Choose Results File")
saveResultsButton[:clicked][:connect](onClickSaveResultsButton)
#saveResultsButton[:setIcon](Qt.QIcon.fromTheme("document-save", QIcon(":/document-save")))
## saveResultsButton.setIconSize(QtCore.QSize(min_pw_icon_size, min_pw_icon_size))
saveResultsButton[:setToolTip]("Choose file to save results")
def_widg_sizer[:addWidget](saveResultsButton, n, 1, 1, 1)

## #Additional Widgets
add_widg_sizer = Qt.QGridLayout()
add_widg_sizer[:addItem](Qt.QSpacerItem(10,10, szp[:Expanding]), 0, 2)
add_widg_sizer[:addItem](Qt.QSpacerItem(10,10, szp[:Expanding]), 0, 3)
#setAdditionalWidgets() 

## #def widgets 2
def_widg_sizer2 = Qt.QGridLayout()
      
# SHUFFLE MODE
shuffleLabel = Qt.QLabel("Shuffle Mode:")
def_widg_sizer2[:addWidget](shuffleLabel, 1, 0)
shuffleChooser = Qt.QComboBox()
shuffleChooser[:addItems](prm["shuffleChoices"])
shuffleChooser[:setCurrentIndex](find(prm["shuffleChoices"] .== prm["pref"]["general"]["defaultShuffle"])-1)
                                 
def_widg_sizer2[:addWidget](shuffleChooser, 1, 1)
def_widg_sizer2[:addItem](Qt.QSpacerItem(10,10, szp[:Expanding]), 0, 4)

#ONOFF Trigger
triggerCheckBox = Qt.QCheckBox("EEG ON/OFF Trigger")
def_widg_sizer2[:addWidget](triggerCheckBox, 1, 2)

#RESPONSE MODE
responseModeLabel = Qt.QLabel("Response Mode:")
def_widg_sizer2[:addWidget](responseModeLabel, 2, 0)
responseModeChooser = Qt.QComboBox()
responseModeChooser[:addItems](prm["responseModeChoices"])
responseModeChooser[:setCurrentIndex](find(prm["responseModeChoices"] .== prm["pref"]["general"]["defaultResponseMode"])-1)
qconnect(responseModeChooser, :activated, (str) -> onResponseModeChange(prm["responseModeChoices"][str+1]))
def_widg_sizer2[:addWidget](responseModeChooser, 2, 1)

#AUTO Percent Correct
autoPCorrLabel = Qt.QLabel("Percent Correct (%):")
def_widg_sizer2[:addWidget](autoPCorrLabel, 2, 2)
autoPCorrTF = Qt.QLineEdit()
autoPCorrTF[:setText]("75")
#autoPCorrTF[:setValidator](Qt.QDoubleValidator(0, 100, 6, self))
autoPCorrTF[:setValidator](Qt.QDoubleValidator(0, 100, 6))
def_widg_sizer2[:addWidget](autoPCorrTF, 2, 3)
autoPCorrLabel[:hide]()
autoPCorrTF[:hide]()


paradigm_widg_sizer = Qt.QGridLayout()
pw_sizer = Qt.QVBoxLayout()
pw_buttons_sizer = Qt.QGridLayout()
min_pw_butt_size = 22
min_pw_icon_size = 20
## pw_buttons_sizer[:setRowMinimumHeight](0, min_pw_butt_size)
## pw_buttons_sizer[:setRowMinimumHeight](1, min_pw_butt_size)
## pw_buttons_sizer[:setRowMinimumHeigh](2, min_pw_butt_size)


## #---- FIRST ROW
n = 0
#LOAD PARAMETERS BUTTON
loadParametersButton = Qt.QPushButton("Load Prm")
## loadParametersButton.setIcon(QIcon.fromTheme("document-open", QIcon(":/document-open")))
## loadParametersButton.setIconSize(QtCore.QSize(min_pw_icon_size, min_pw_icon_size))
loadParametersButton[:clicked][:connect](onClickLoadParametersButton)
loadParametersButton[:setToolTip]("Load a parameters file")
loadParametersButton[:setWhatsThis]("Load a file containing the parameters for an experimental session")
loadParametersButton[:setSizePolicy](szp[:Expanding], szp[:Expanding])
pw_buttons_sizer[:addWidget](loadParametersButton, n, 0)

#SAVE PARAMETERS BUTTON
saveParametersButton = Qt.QPushButton("Save Prm")
## saveParametersButton.setIcon(QIcon.fromTheme("document-save", QIcon(":/document-save")))
## saveParametersButton.setIconSize(QtCore.QSize(min_pw_icon_size, min_pw_icon_size))
saveParametersButton[:clicked][:connect](onClickSaveParametersButton)
saveParametersButton[:setToolTip]("Save a parameters file")
saveParametersButton[:setWhatsThis]("Save the current experimental parameters to a file")
saveParametersButton[:setSizePolicy](szp[:Expanding], szp[:Expanding])
pw_buttons_sizer[:addWidget](saveParametersButton, n, 1)

#DELETE PARAMETERS BUTTON
deleteParametersButton = Qt.QPushButton("Delete")
deleteParametersButton[:clicked][:connect](onClickDeleteParametersButton)
## deleteParametersButton.setIcon(QIcon.fromTheme("edit-delete", QIcon(":/edit-delete")))
## deleteParametersButton.setIconSize(QtCore.QSize(min_pw_icon_size, min_pw_icon_size))
deleteParametersButton[:setToolTip]("Delete current Block")
deleteParametersButton[:setSizePolicy](szp[:Expanding], szp[:Expanding])
pw_buttons_sizer[:addWidget](deleteParametersButton, n, 2)


undoUnsavedButton = Qt.QPushButton("Undo Unsaved")
## undoUnsavedButton[:clicked][:connect](onClickUndoUnsavedButton)
## undoUnsavedButton.setIcon(QIcon.fromTheme("edit-undo", QIcon(":/edit-undo")))
## undoUnsavedButton.setIconSize(QtCore.QSize(min_pw_icon_size, min_pw_icon_size))
undoUnsavedButton[:setToolTip]("Undo unsaved changes")
undoUnsavedButton[:setSizePolicy](szp[:Expanding], szp[:Expanding])
pw_buttons_sizer[:addWidget](undoUnsavedButton, n, 3)

## #---- SECOND ROW
n = n+1
storeParametersButton = Qt.QPushButton("Store")
## storeParametersButton[:clicked][:connect](onClickStoreParametersButton)
## storeParametersButton.setIcon(QIcon.fromTheme("media-flash-memory-stick", QIcon(":/media-flash-memory-stick")))
## storeParametersButton.setIconSize(QtCore.QSize(min_pw_icon_size, min_pw_icon_size))
storeParametersButton[:setToolTip]("Store current Block")
storeParametersButton[:setSizePolicy](szp[:Expanding], szp[:Expanding])
pw_buttons_sizer[:addWidget](storeParametersButton, n, 0)

storeandaddParametersButton = Qt.QPushButton("Store 'n' add!")
## storeandaddParametersButton[:clicked][:connect](onClickStoreandaddParametersButton)
storeandaddParametersButton[:setToolTip]("Store current Block and add a new one")
storeandaddParametersButton[:setSizePolicy](szp[:Expanding], szp[:Expanding])
pw_buttons_sizer[:addWidget](storeandaddParametersButton, n, 1)

storeandgoParametersButton = Qt.QPushButton("Store 'n' go!")
## storeandgoParametersButton[:clicked][:connect](onClickStoreandgoParametersButton)
storeandgoParametersButton[:setToolTip]("Store current Block and move to the next")
storeandgoParametersButton[:setSizePolicy](szp[:Expanding], szp[:Expanding])
pw_buttons_sizer[:addWidget](storeandgoParametersButton, n, 2)

newBlockButton = Qt.QPushButton("New Block")
##newBlockButton[:clicked][:connect](onClickNewBlockButton)
## newBlockButton.setIcon(QIcon.fromTheme("document-new", QIcon(":/document-new")))
## newBlockButton.setIconSize(QtCore.QSize(min_pw_icon_size, min_pw_icon_size))
newBlockButton[:setToolTip]("Append a new block")
newBlockButton[:setSizePolicy](szp[:Expanding], szp[:Expanding])
pw_buttons_sizer[:addWidget](newBlockButton, n, 3)

      
      

#---- THIRD ROW
n = n+1
prevBlockButton = Qt.QPushButton("Previous")
## prevBlockButton[:clicked][:connect](onClickPrevBlockButton)
## prevBlockButton.setIcon(QIcon.fromTheme("go-previous", QIcon(":/go-previous")))
## prevBlockButton.setIconSize(QtCore.QSize(min_pw_icon_size, min_pw_icon_size))
prevBlockButton[:setToolTip]("Move to previous block")
prevBlockButton[:setSizePolicy](szp[:Expanding], szp[:Expanding])
pw_buttons_sizer[:addWidget](prevBlockButton, n, 0)

nextBlockButton = Qt.QPushButton("Next")
##nextBlockButton[:clicked][:connect](onClickNextBlockButton)
## nextBlockButton.setIcon(QIcon.fromTheme("go-next", QIcon(":/go-next")))
## nextBlockButton.setIconSize(QtCore.QSize(min_pw_icon_size, min_pw_icon_size))
nextBlockButton[:setToolTip]("Move to next block")
nextBlockButton[:setSizePolicy](szp[:Expanding], szp[:Expanding])
pw_buttons_sizer[:addWidget](nextBlockButton, n, 1)

shuffleBlocksButton = Qt.QPushButton("Shuffle")
## shuffleBlocksButton[:clicked][:connect](onClickShuffleBlocksButton)
## shuffleBlocksButton.setIcon(QIcon.fromTheme("media-playlist-shuffle", QIcon(":/media-playlist-shuffle")))
## shuffleBlocksButton.setIconSize(QtCore.QSize(min_pw_icon_size, min_pw_icon_size))
shuffleBlocksButton[:setToolTip]("Shuffle blocks")
shuffleBlocksButton[:setSizePolicy](szp[:Expanding], szp[:Expanding])
pw_buttons_sizer[:addWidget](shuffleBlocksButton, n, 2)

resetParametersButton = Qt.QPushButton("Reset")
## resetParametersButton[:clicked][:connect](onClickResetParametersButton)
## resetParametersButton.setIcon(QIcon.fromTheme("go-home", QIcon(":/go-home")))
## resetParametersButton.setIconSize(QtCore.QSize(min_pw_icon_size, min_pw_icon_size))
resetParametersButton[:setToolTip]("Reset parameters")
resetParametersButton[:setSizePolicy](szp[:Expanding], szp[:Expanding])
pw_buttons_sizer[:addWidget](resetParametersButton, n, 3)
n = n+1
pw_buttons_sizer[:addItem](Qt.QSpacerItem(10,10,szp[:Expanding]), n, 0, 1, 4)


## #----FOURTH ROW
n = n+1
currentBlockLabel = Qt.QLabel("Current Block:")
pw_buttons_sizer[:addWidget](currentBlockLabel, n, 0)

#currentBlockCountLabel = QLabel(str(prm["currentBlock"]))
#pw_buttons_sizer[:addWidget](currentBlockCountLabel, n, 1)

storedBlocksLabel = Qt.QLabel("Stored Blocks:")
pw_buttons_sizer[:addWidget](storedBlocksLabel, n, 2)

## storedBlocksCountLabel = QLabel(str(prm["storedBlocks"]))
## pw_buttons_sizer[:addWidget](storedBlocksCountLabel, n, 3)

#FIFTH ROW
n = n+1
currentBlockPositionLabelLabel = Qt.QLabel("Block Position:")
pw_buttons_sizer[:addWidget](currentBlockPositionLabelLabel, n, 0)
#@currentBlockPositionLabel = Qt.QLabel(string(prm["currentBlock"]))
#@pw_buttons_sizer[:addWidget](currentBlockPositionLabel, n, 1)

jumpToBlockLabel = Qt.QLabel("Jump to Block:")
jumpToBlockChooser = Qt.QComboBox()
## jumpToBlockChooser.activated[str].connect(onJumpToBlockChange)
pw_buttons_sizer[:addWidget](jumpToBlockLabel, n, 2)
pw_buttons_sizer[:addWidget](jumpToBlockChooser, n, 3)
#SIXTH ROW
n = n+1
prevBlockPositionButton = Qt.QPushButton("Previous Position")
## prevBlockPositionButton[:clicked][:connect](onClickPrevBlockPositionButton)
## prevBlockPositionButton.setIcon(QIcon.fromTheme("go-previous", QIcon(":/go-previous")))
prevBlockPositionButton[:setToolTip]("Move to previous block position")
pw_buttons_sizer[:addWidget](prevBlockPositionButton, n, 0)

nextBlockPositionButton = Qt.QPushButton("Next Position")
## nextBlockPositionButton[:clicked][:connect](onClickNextBlockPositionButton)
## nextBlockPositionButton.setIcon(QIcon.fromTheme("go-next", QIcon(":/go-next")))
nextBlockPositionButton[:setToolTip]("Move to next block position")
pw_buttons_sizer[:addWidget](nextBlockPositionButton, n, 1)

## jumpToPositionLabel = Qt.QLabel(tr("Jump to Position:"))
## jumpToPositionChooser = Qt.QComboBox()
## jumpToPositionChooser.activated[str].connect(onJumpToPositionChange)
## pw_buttons_sizer[:addWidget](jumpToPositionLabel, n, 2)
## pw_buttons_sizer[:addWidget](jumpToPositionChooser, n, 3)

# SEVENTH ROW
n = n+1
shiftBlockDownButton = Qt.QPushButton("< Shift Blk. Down")
shiftBlockDownButton[:clicked][:connect](onClickShiftBlockDownButton)
shiftBlockDownButton[:setToolTip]("Shift Block. Down")
pw_buttons_sizer[:addWidget](shiftBlockDownButton, n, 2)

shiftBlockUpButton = Qt.QPushButton("Shift Blk. Up >")
shiftBlockUpButton[:clicked][:connect](onClickShiftBlockUpButton)
shiftBlockUpButton[:setToolTip]("Shift Block Up")
pw_buttons_sizer[:addWidget](shiftBlockUpButton, n, 3)


n = n+1
## #spacer
pw_buttons_sizer[:addItem](Qt.QSpacerItem(10,10,szp[:Expanding]), n, 5)


pw_prm_sizer = Qt.QHBoxLayout()
pw_prm_sizer_0 = Qt.QGridLayout()
pw_prm_sizer_1 = Qt.QGridLayout()

pw_prm_sizer_0[:setAlignment](qt_enum("AlignTop"))
pw_prm_sizer_1[:setAlignment](qt_enum("AlignTop"))
cw_sizer[:addLayout](def_widg_sizer)
cw_sizer[:addLayout](add_widg_sizer)
cw_sizer[:addLayout](def_widg_sizer2)
cw_sizer[:addLayout](paradigm_widg_sizer)
cw[:setLayout](cw_sizer)
#wd = #adaptiveTypeChooser = 0
setDefaultParameters("Audiogram", "Transformed Up-Down", par)
cw_scrollarea = Qt.QScrollArea()
        
cw_scrollarea[:setWidget](cw)
splitter[:addWidget](cw_scrollarea)
pw_sizer[:addLayout](pw_buttons_sizer)
pw_sizer[:addSpacing](20)
pw_prm_sizer[:addLayout](pw_prm_sizer_0)
pw_prm_sizer[:addLayout](pw_prm_sizer_1)
pw_sizer[:addLayout](pw_prm_sizer)
pw[:setLayout](pw_sizer)
pw[:layout]()[:SetFixedSize]
cw[:layout]()[:SetFixedSize] 

pw_scrollarea = Qt.QScrollArea()
pw_scrollarea[:setWidget](pw)
splitter[:addWidget](pw_scrollarea)

screen = Qt.QDesktopWidget()[:screenGeometry]()
w[:setGeometry](80, 100, int((2/3)*screen[:width]()), int((7/10)*screen[:height]()))
splitter[:setSizes]([(2/6)*screen[:width](), (2/6)*screen[:width]()])



w[:setCentralWidget](splitter)
raise(w)

