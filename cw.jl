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

function onChooserChange(selectedOption)
        ## self.fieldsToHide = []; self.fieldsToShow = []
        ## self.choosersToHide = []; self.choosersToShow = [];
        ## self.fileChoosersToHide = []; self.fileChoosersToShow = [];

        ## execString = self.prm[self.currExp]['execString']

        ## try:
        ##     methodToCall1 = getattr(default_experiments, execString)
        ## except:
        ##     pass
        ## try:
        ##     methodToCall1 = getattr(labexp, execString)
        ## except:
        ##     pass

        ## if hasattr(methodToCall1, 'get_fields_to_hide_'+ execString):
        ##     methodToCall2 = getattr(methodToCall1, 'get_fields_to_hide_'+ execString)
        ##     tmp = methodToCall2(self)

        ##     for i in range(len(self.fieldsToHide)):
        ##         self.field[self.fieldsToHide[i]].hide()
        ##         self.fieldLabel[self.fieldsToHide[i]].hide()
        ##         self.fieldCheckBox[self.fieldsToHide[i]].hide()
        ##     for i in range(len(self.fieldsToShow)):
        ##         self.field[self.fieldsToShow[i]].show()
        ##         self.fieldLabel[self.fieldsToShow[i]].show()
        ##         self.fieldCheckBox[self.fieldsToShow[i]].show()
        ##     for i in range(len(self.choosersToHide)):
        ##         self.chooser[self.choosersToHide[i]].hide()
        ##         self.chooserLabel[self.choosersToHide[i]].hide()
        ##         self.chooserCheckBox[self.choosersToHide[i]].hide()
        ##     for i in range(len(self.choosersToShow)):
        ##         self.chooser[self.choosersToShow[i]].show()
        ##         self.chooserLabel[self.choosersToShow[i]].show()
        ##         self.chooserCheckBox[self.choosersToShow[i]].show()
        ##     for i in range(len(self.fileChoosersToHide)):
        ##         self.fileChooser[self.fileChoosersToHide[i]].hide()
        ##         self.fileChooserButton[self.fileChoosersToHide[i]].hide()
        ##         self.fileChooserCheckBox[self.fileChoosersToHide[i]].hide()
        ##     for i in range(len(self.fileChoosersToShow)):
        ##         self.fileChooser[self.fileChoosersToHide[i]].show()
        ##         self.fileChooserButton[self.fileChoosersToHide[i]].show()
        ##         self.fileChooserCheckBox[self.fileChoosersToHide[i]].show()
end


function onClickDeleteParametersButton()
        ## if self.prm["storedBlocks"] > 1:
        ##     if self.prm["currentBlock"] <= self.prm["storedBlocks"] and self.prm["storedBlocks"] > 0:
        ##         currBlock = "b" + str(self.prm["currentBlock"])
                
        ##         if self.prm["currentBlock"] < (self.prm["storedBlocks"] -1):
        ##             blockPosition = self.prm[currBlock]["blockPosition"]
        ##             del self.prm[currBlock]
        ##             self.prm["storedBlocks"] = self.prm["storedBlocks"] -1
        ##             for i in range(self.prm["storedBlocks"]-self.prm["currentBlock"]+1):
        ##                 self.prm["b"+str(self.prm["currentBlock"]+i)] = self.prm["b"+str(self.prm["currentBlock"]+i+1)]
        ##             del self.prm["b"+str(self.prm["currentBlock"]+i+1)]
        ##             self.updateParametersWin()
        ##         elif self.prm["currentBlock"] == (self.prm["storedBlocks"] -1):
        ##             blockPosition = self.prm[currBlock]["blockPosition"]
        ##             del self.prm[currBlock]
        ##             self.prm["storedBlocks"] = self.prm["storedBlocks"] -1
        ##             self.prm["b"+str(self.prm["currentBlock"])] =  self.prm["b"+str(self.prm["storedBlocks"]+1)]
        ##             del self.prm["b"+str(self.prm["storedBlocks"]+1)]
        ##             self.updateParametersWin()
        ##         elif self.prm["currentBlock"] > (self.prm["storedBlocks"] -1):
        ##             self.moveNextBlock()
        ##             blockPosition = self.prm[currBlock]["blockPosition"]
        ##             del self.prm[currBlock]
        ##             self.prm["storedBlocks"] = self.prm["storedBlocks"] -1
        ##             self.storedBlocksCountLabel.setText(str(self.prm["storedBlocks"]))

        ##         for i in range(self.prm["storedBlocks"]):
        ##             if int(self.prm["b"+str(i+1)]["blockPosition"]) > int(blockPosition):
        ##                 self.prm["b"+str(i+1)]["blockPosition"] = str(int(self.prm["b"+str(i+1)]["blockPosition"]) -1)
        ##         self.shufflingSchemeTF.setText("")
        ##         self.updateParametersWin()
        ##     else:
        ##         self.moveNextBlock()
        ## elif self.prm["storedBlocks"] == 1 and self.prm["currentBlock"] > self.prm["storedBlocks"]: #created a new 2nd block, not saved, and now wants to delete, since for a single stored block you should do nothing it does nothing, so move to next block
        ##     self.moveNextBlock()
end

function onClickResetParametersButton()
    ##    if self.prm["storedBlocks"] == 0:
    ##         pass
    ##     else:
    ##         self.prm["currentBlock"] = 1
    ##         for i in range(self.prm["storedBlocks"]):
    ##             self.prm["b"+str(i+1)]["blockPosition"] = str(i+1)
    ##         self.updateParametersWin()
    ##         self.prm["shuffled"] = False
    ##         self.saveParametersToFile(self.prm["tmpParametersFile"])
    ##         self.prm["currentRepetition"] = 1
    ##         self.autoSetGaugeValue()
    ##         self.responseBox.statusButton.setText(self.prm["rbTrans"].translate("rb", "Start"))
    ## def onClickUndoUnsavedButton(self):
    ##     if self.prm["currentBlock"] > self.prm["storedBlocks"]:
    ##         self.onExperimentChange(self.experimentChooser.currentText())
    ##     else:
    ##         self.updateParametersWin()
end

function onClickLoadParametersButton()
    fd = Qt.QFileDialog()
    fName = fd[:getOpenFileName](w, "Choose parameters file to load", "", "prm files (*.prm *PRM *Prm);;All Files (*)")[1]
    if length(fName) > 0 #if the user didn't press cancel
        #@     loadParameters(fName)
    end
end

function onClickSaveParametersButton()
    ##@ if self.prm["storedBlocks"] < 1
    ##     ret = QMessageBox.warning(self, self.tr("Warning"),
    ##                               self.tr("There are no stored parameters to save."),
    ##                               QMessageBox.Ok)
    ## else
    ##     if self.parametersFile == None:
    ##         ftow = QFileDialog.getSaveFileName(self, self.tr("Choose file to write prm"), ".prm", self.tr("All Files (*)"))[0]
    ##     else
    ##         ftow = QFileDialog.getSaveFileName(self, self.tr("Choose file to write prm"), self.parametersFile, self.tr("All Files (*)"))[0]
    ##     end
    ##     if len(ftow) > 0 and self.prm["storedBlocks"] > 0:
    ##         self.saveParametersToFile(ftow)
    ##         self.saveParametersToFile(self.prm["tmpParametersFile"])
    ##         #if self.parametersFile == self.prm["tmpParametersFile"]:
    ##         #    if os.path.exists(self.parametersFile) == True:
    ##         #        os.remove(self.parametersFile)
    ##         self.parametersFile = ftow
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
            wd["fieldLabel"][f][:setParent](None)
            pw_prm_sizer_0[:removeWidget](wd["field"][f])
            wd["field"][f][:setParent](None)
            pw_prm_sizer_0[:removeWidget](wd["fieldCheckBox"][f])
            wd["fieldCheckBox"][f][:setParent](None)
        end
        for c in 1:length(chooser)
            pw_prm_sizer_1[:removeWidget](wd["chooserLabel"][c])
            wd["chooserLabel"][c][:setParent](None)
            pw_prm_sizer_1[:removeWidget](wd["chooser"][c])
            wd["chooser"][c][:setParent](None)
            pw_prm_sizer_1[:removeWidget](wd["chooserCheckBox"][c])
            wd["chooserCheckBox"][c][:setParent](None)
            end
        for f in 1:length(fileChooser)
            pw_prm_sizer_0[:removeWidget](wd["fileChooser"][f])
            wd["fileChooser"][f][:setParent](None)
            pw_prm_sizer_0[:removeWidget](wd["fileChooserButton"][f])
            wd["fileChooserButton"][f][:setParent](None)
            pw_prm_sizer_0[:removeWidget](wd["fileChooserCheckBox"][f])
            wd["fileChooserCheckBox"][f][:setParent](None)
        end
    end
end

function setAdditionalWidgets()
    if prm["prevExp"] != None
        for i=1:length(additionalWidgetsIntFieldList)
        ##         self.add_widg_sizer.removeWidget(self.additionalWidgetsIntFieldLabelList[i])
        ##         self.additionalWidgetsIntFieldLabelList[i].setParent(None)
        ##         self.add_widg_sizer.removeWidget(self.additionalWidgetsIntFieldList[i])
        ##         self.additionalWidgetsIntFieldList[i].setParent(None)
        ##         self.add_widg_sizer.removeWidget(self.additionalWidgetsIntFieldCheckBoxList[i])
        ##         self.additionalWidgetsIntFieldCheckBoxList[i].setParent(None)
        end
        for i=1:length(additionalWidgetsChooserList)
            ##self.add_widg_sizer.removeWidget(self.additionalWidgetsChooserLabelList[i])
        ##         self.additionalWidgetsChooserLabelList[i].setParent(None)
        ##         self.add_widg_sizer.removeWidget(self.additionalWidgetsChooserList[i])
        ##         self.additionalWidgetsChooserList[i].setParent(None)
        ##         self.add_widg_sizer.removeWidget(self.additionalWidgetsChooserCheckBoxList[i])
        ##         self.additionalWidgetsChooserCheckBoxList[i].setParent(None)
        end
    end

        ## #ADD ADDITIONAL WIDGETS
        ## n = 0
        ## self.additionalWidgetsIntFieldList = []
        ## self.additionalWidgetsIntFieldLabelList = []
        ## self.additionalWidgetsIntFieldCheckBoxList = []
        ## self.additionalWidgetsChooserList = []
        ## self.additionalWidgetsChooserLabelList = []
        ## self.additionalWidgetsChooserCheckBoxList = []

        ## if self.prm[self.currExp]["hasISIBox"] == True:
        ##     self.ISILabel = Qt.QLabel(self.tr("ISI (ms):"), self)
        ##     self.add_widg_sizer.addWidget(self.ISILabel, n, 1)
        ##     self.ISIBox = QLineEdit()
        ##     self.ISIBox.setText('500')
        ##     self.ISIBox.setValidator(QIntValidator(self))
        ##     self.add_widg_sizer.addWidget(self.ISIBox, n, 2)
        ##     self.ISIBoxCheckBox = QCheckBox()
        ##     self.add_widg_sizer.addWidget(self.ISIBoxCheckBox, n, 0)
        ##     self.additionalWidgetsIntFieldList.append(self.ISIBox)
        ##     self.additionalWidgetsIntFieldLabelList.append(self.ISILabel)
        ##     self.additionalWidgetsIntFieldCheckBoxList.append(self.ISIBoxCheckBox)
        ##     n = n+1
        ## if self.prm[self.currExp]["hasAlternativesChooser"] == True:
        ##     self.nIntervalsLabel = Qt.QLabel(self.tr("Intervals:"), self)
        ##     self.add_widg_sizer.addWidget(self.nIntervalsLabel, n, 1)
        ##     self.nIntervalsChooser = QComboBox()
        ##     self.nIntervalsChooser.addItems(self.prm['nIntervalsChoices'])
        ##     if 'nIntervals' in self.prm:
        ##         self.nIntervalsChooser.setCurrentIndex(self.prm['nIntervalsChoices'].index(str(self.prm['nIntervals'])))
        ##     else:
        ##         self.nIntervalsChooser.setCurrentIndex(0)
        ##     self.add_widg_sizer.addWidget(self.nIntervalsChooser, n, 2)
        ##     self.nIntervalsChooser.activated[str].connect(self.onNIntervalsChange)
        ##     self.nIntervalsCheckBox = QCheckBox()
        ##     self.add_widg_sizer.addWidget(self.nIntervalsCheckBox, n, 0)
        ##     self.additionalWidgetsChooserList.append(self.nIntervalsChooser)
        ##     self.additionalWidgetsChooserLabelList.append(self.nIntervalsLabel)
        ##     self.additionalWidgetsChooserCheckBoxList.append(self.nIntervalsCheckBox)
        ##     n = n+1
        ##     self.nAlternativesLabel = Qt.QLabel(self.tr("Alternatives:"), self)
        ##     self.add_widg_sizer.addWidget(self.nAlternativesLabel, n, 1)
        ##     self.nAlternativesChooser = QComboBox()
        ##     self.nAlternativesChooser.addItems([str(self.currLocale.toInt(self.nIntervalsChooser.currentText())[0]-1), self.nIntervalsChooser.currentText()])
        ##     self.nAlternativesChooser.setCurrentIndex(self.nAlternativesChooser.findText(str(self.prm['nAlternatives'])))
        ##     self.add_widg_sizer.addWidget(self.nAlternativesChooser, n, 2)
        ##     self.nAlternativesChooser.activated[str].connect(self.onNAlternativesChange)
        ##     self.nAlternativesCheckBox = QCheckBox()
        ##     self.add_widg_sizer.addWidget(self.nAlternativesCheckBox, n, 0)
        ##     self.additionalWidgetsChooserList.append(self.nAlternativesChooser)
        ##     self.additionalWidgetsChooserLabelList.append(self.nAlternativesLabel)
        ##     self.additionalWidgetsChooserCheckBoxList.append(self.nAlternativesCheckBox)
        ##     n = n+1

        ## #Pre-Trial Interval
        ## if self.prm[self.currExp]["hasPreTrialInterval"] == True:
        ##     self.preTrialIntervalChooserLabel = Qt.QLabel(self.tr("Pre-Trial Interval:"), self)
        ##     self.add_widg_sizer.addWidget(self.preTrialIntervalChooserLabel, n, 1)
        ##     self.preTrialIntervalChooser = QComboBox()
        ##     self.preTrialIntervalChooser.addItems([self.tr("Yes"), self.tr("No")])
        ##     self.preTrialIntervalChooser.setCurrentIndex(1)
        ##     self.preTrialIntervalChooser.activated[str].connect(self.onPreTrialIntervalChange)
        ##     self.add_widg_sizer.addWidget(self.preTrialIntervalChooser, n, 2)
        ##     self.preTrialIntervalCheckBox = QCheckBox()
        ##     self.add_widg_sizer.addWidget(self.preTrialIntervalCheckBox, n, 0)
        ##     self.additionalWidgetsChooserList.append(self.preTrialIntervalChooser)
        ##     self.additionalWidgetsChooserLabelList.append(self.preTrialIntervalChooserLabel)
        ##     self.additionalWidgetsChooserCheckBoxList.append(self.preTrialIntervalCheckBox)
        ##     n = n+1
        ##     self.preTrialIntervalISILabel = Qt.QLabel(self.tr("Pre-Trial Interval ISI (ms):"), self)
        ##     self.add_widg_sizer.addWidget(self.preTrialIntervalISILabel, n, 1)
           
        ##     self.preTrialIntervalISITF = QLineEdit()
        ##     self.preTrialIntervalISITF.setText("500")
        ##     self.preTrialIntervalISITF.setValidator(QIntValidator(self))
        ##     self.preTrialIntervalISITF.setWhatsThis(self.tr("Sets the duration of the silent interval between the pre-trial interval and the first observation interval"))
         
        ##     self.add_widg_sizer.addWidget(self.preTrialIntervalISITF, n, 2)
        ##     self.preTrialIntervalISICheckBox = QCheckBox()
        ##     self.add_widg_sizer.addWidget(self.preTrialIntervalISICheckBox, n, 0)

        ##     self.preTrialIntervalISILabel.hide()
        ##     self.preTrialIntervalISITF.hide()
        ##     self.preTrialIntervalISICheckBox.hide()
            
        ##     self.additionalWidgetsIntFieldList.append(self.preTrialIntervalISITF)
        ##     self.additionalWidgetsIntFieldLabelList.append(self.preTrialIntervalISILabel)
        ##     self.additionalWidgetsIntFieldCheckBoxList.append(self.preTrialIntervalISICheckBox)
        ##     n = n+1

        ## #Precursor Interval
        ## if self.prm[self.currExp]["hasPrecursorInterval"] == True:
        ##     self.precursorIntervalChooserLabel = Qt.QLabel(self.tr("Precursor Interval:"), self)
        ##     self.add_widg_sizer.addWidget(self.precursorIntervalChooserLabel, n, 1)
        ##     self.precursorIntervalChooser = QComboBox()
        ##     self.precursorIntervalChooser.addItems([self.tr("Yes"), self.tr("No")])
        ##     self.precursorIntervalChooser.setCurrentIndex(1)
        ##     self.precursorIntervalChooser.activated[str].connect(self.onPrecursorIntervalChange)
        ##     self.add_widg_sizer.addWidget(self.precursorIntervalChooser, n, 2)
        ##     self.precursorIntervalCheckBox = QCheckBox()
        ##     self.add_widg_sizer.addWidget(self.precursorIntervalCheckBox, n, 0)
        ##     self.additionalWidgetsChooserList.append(self.precursorIntervalChooser)
        ##     self.additionalWidgetsChooserLabelList.append(self.precursorIntervalChooserLabel)
        ##     self.additionalWidgetsChooserCheckBoxList.append(self.precursorIntervalCheckBox)
        ##     n = n+1
        ##     self.precursorIntervalISILabel = Qt.QLabel(self.tr("Precursor Interval ISI (ms):"), self)
        ##     self.add_widg_sizer.addWidget(self.precursorIntervalISILabel, n, 1)
           
        ##     self.precursorIntervalISITF = QLineEdit()
        ##     self.precursorIntervalISITF.setText("500")
        ##     self.precursorIntervalISITF.setValidator(QIntValidator(self))
        ##     self.precursorIntervalISITF.setWhatsThis(self.tr("Sets the duration of the silent interval between the precursor interval and the observation interval"))
         
        ##     self.add_widg_sizer.addWidget(self.precursorIntervalISITF, n, 2)
        ##     self.precursorIntervalISICheckBox = QCheckBox()
        ##     self.add_widg_sizer.addWidget(self.precursorIntervalISICheckBox, n, 0)

        ##     self.precursorIntervalISILabel.hide()
        ##     self.precursorIntervalISITF.hide()
        ##     self.precursorIntervalISICheckBox.hide()
            
        ##     self.additionalWidgetsIntFieldList.append(self.precursorIntervalISITF)
        ##     self.additionalWidgetsIntFieldLabelList.append(self.precursorIntervalISILabel)
        ##     self.additionalWidgetsIntFieldCheckBoxList.append(self.precursorIntervalISICheckBox)
        ##     n = n+1

        ## #Postcursor Interval
        ## if self.prm[self.currExp]["hasPostcursorInterval"] == True:
        ##     self.postcursorIntervalChooserLabel = Qt.QLabel(self.tr("Postcursor Interval:"), self)
        ##     self.add_widg_sizer.addWidget(self.postcursorIntervalChooserLabel, n, 1)
        ##     self.postcursorIntervalChooser = QComboBox()
        ##     self.postcursorIntervalChooser.addItems([self.tr("Yes"), self.tr("No")])
        ##     self.postcursorIntervalChooser.setCurrentIndex(1)
        ##     self.postcursorIntervalChooser.activated[str].connect(self.onPostcursorIntervalChange)
        ##     self.add_widg_sizer.addWidget(self.postcursorIntervalChooser, n, 2)
        ##     self.postcursorIntervalCheckBox = QCheckBox()
        ##     self.add_widg_sizer.addWidget(self.postcursorIntervalCheckBox, n, 0)
        ##     self.additionalWidgetsChooserList.append(self.postcursorIntervalChooser)
        ##     self.additionalWidgetsChooserLabelList.append(self.postcursorIntervalChooserLabel)
        ##     self.additionalWidgetsChooserCheckBoxList.append(self.postcursorIntervalCheckBox)
        ##     n = n+1
        ##     self.postcursorIntervalISILabel = Qt.QLabel(self.tr("Postcursor Interval ISI (ms):"), self)
        ##     self.add_widg_sizer.addWidget(self.postcursorIntervalISILabel, n, 1)
           
        ##     self.postcursorIntervalISITF = QLineEdit()
        ##     self.postcursorIntervalISITF.setText("500")
        ##     self.postcursorIntervalISITF.setValidator(QIntValidator(self))
        ##     self.postcursorIntervalISITF.setWhatsThis(self.tr("Sets the duration of the silent interval between the observation interval and the postcursor interval"))
         
        ##     self.add_widg_sizer.addWidget(self.postcursorIntervalISITF, n, 2)
        ##     self.postcursorIntervalISICheckBox = QCheckBox()
        ##     self.add_widg_sizer.addWidget(self.postcursorIntervalISICheckBox, n, 0)

        ##     self.postcursorIntervalISILabel.hide()
        ##     self.postcursorIntervalISITF.hide()
        ##     self.postcursorIntervalISICheckBox.hide()
            
        ##     self.additionalWidgetsIntFieldList.append(self.postcursorIntervalISITF)
        ##     self.additionalWidgetsIntFieldLabelList.append(self.postcursorIntervalISILabel)
        ##     self.additionalWidgetsIntFieldCheckBoxList.append(self.postcursorIntervalISICheckBox)
        ##     n = n+1
      
            
        ## if self.prm[self.currExp]["hasFeedback"] == True:
        ##     self.responseLightLabel =  Qt.QLabel(self.tr("Response Light:"), self)
        ##     self.responseLightChooser = QComboBox()
        ##     self.responseLightChooser.addItems([self.tr("Feedback"), self.tr("Neutral"), self.tr("None")])
        ##     self.add_widg_sizer.addWidget(self.responseLightLabel, n, 1)
        ##     self.add_widg_sizer.addWidget(self.responseLightChooser, n, 2)
        ##     self.responseLightCheckBox = QCheckBox()
        ##     self.add_widg_sizer.addWidget(self.responseLightCheckBox, n, 0)
        ##     self.additionalWidgetsChooserList.append(self.responseLightChooser)
        ##     self.additionalWidgetsChooserLabelList.append(self.responseLightLabel)
        ##     self.additionalWidgetsChooserCheckBoxList.append(self.responseLightCheckBox)
        ##     n = n+1
        ##     self.responseLightDurationLabel = Qt.QLabel(self.tr("Response Light Duration (ms):"), self)
        ##     self.add_widg_sizer.addWidget(self.responseLightDurationLabel, n, 1)
        ##     self.responseLightDurationTF = QLineEdit()
        ##     self.responseLightDurationTF.setText(self.prm["pref"]["general"]["responseLightDuration"])
        ##     self.responseLightDurationTF.setValidator(QIntValidator(self))

        ##     self.add_widg_sizer.addWidget(self.responseLightDurationTF, n, 2)
        ##     self.responseLightDurationCheckBox = QCheckBox()
        ##     self.add_widg_sizer.addWidget(self.responseLightDurationCheckBox, n, 0)
        ##     self.additionalWidgetsIntFieldList.append(self.responseLightDurationTF)
        ##     self.additionalWidgetsIntFieldLabelList.append(self.responseLightDurationLabel)
        ##     self.additionalWidgetsIntFieldCheckBoxList.append(self.responseLightDurationCheckBox)
        ##     n = n+1
        ## else:
        ##     self.responseLightLabel =  QLabel(self.tr("Response Light:"), self)
        ##     self.responseLightChooser = QComboBox()
        ##     self.responseLightChooser.addItems([self.tr("Neutral"), self.tr("None")])
        ##     self.add_widg_sizer.addWidget(self.responseLightLabel, n, 1)
        ##     self.add_widg_sizer.addWidget(self.responseLightChooser, n, 2)
        ##     self.responseLightCheckBox = QCheckBox()
        ##     self.add_widg_sizer.addWidget(self.responseLightCheckBox, n, 0)
        ##     self.additionalWidgetsChooserList.append(self.responseLightChooser)
        ##     self.additionalWidgetsChooserLabelList.append(self.responseLightLabel)
        ##     self.additionalWidgetsChooserCheckBoxList.append(self.responseLightCheckBox)
        ##     n = n+1
        ##     self.responseLightDurationLabel = QLabel(self.tr("Response Light Duration (ms):"), self)
        ##     self.add_widg_sizer.addWidget(self.responseLightDurationLabel, n, 1)
        ##     self.responseLightDurationTF = QLineEdit()
        ##     self.responseLightDurationTF.setText(self.prm["pref"]["general"]["responseLightDuration"])
        ##     self.responseLightDurationTF.setValidator(QIntValidator(self))
        ##     self.additionalWidgetsIntFieldList.append(self.responseLightDurationTF)
        ##     self.additionalWidgetsIntFieldLabelList.append(self.responseLightDurationLabel)

        ##     self.add_widg_sizer.addWidget(self.responseLightDurationTF, n, 2)
        ##     self.responseLightDurationCheckBox = QCheckBox()
        ##     self.add_widg_sizer.addWidget(self.responseLightDurationCheckBox, n, 0)
        ##     self.additionalWidgetsIntFieldCheckBoxList.append(self.responseLightDurationCheckBox)
        ##     n = n+1
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
    wd["field"] = (Any)[] #list(range(prm["nFields"]))
    wd["fieldLabel"] = (Any)[] #list(range(prm["nFields"]))
    wd["fieldCheckBox"] = (Any)[] #list(range(prm["nFields"]))
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
    wd["chooser"] = (Any)[] #list(range(prm["nChoosers"]))
    wd["chooserLabel"] = (Any)[] #list(range(prm["nChoosers"]))
    wd["chooserOptions"] = (Any)[] #list(range(prm["nChoosers"]))
    wd["chooserCheckBox"] = (Any)[] #list(range(prm["nChoosers"]))
    for c in 1:prm["nChoosers"]
        push!(wd["chooserLabel"], Qt.QLabel(prm["chooserLabel"][c]))
        pw_prm_sizer_1[:addWidget](wd["chooserLabel"][c], c, 4)
        push!(wd["chooserOptions"], prm["chooserOptions"][c])
        push!(wd["chooser"], Qt.QComboBox())
        wd["chooser"][c][:addItems](wd["chooserOptions"][c])
        wd["chooser"][c][:setCurrentIndex](find(wd["chooserOptions"][c] .== prm["chooser"][c]))
        pw_prm_sizer_1[:addWidget](wd["chooser"][c], c, 5)
        push!(wd["chooserCheckBox"], Qt.QCheckBox())
        pw_prm_sizer_1[:addWidget](wd["chooserCheckBox"][c], c, 3)
    end
    for c in 1:length(wd["chooser"])
        qconnect(wd["chooser"][c], :activated, (str) -> oChooserChange())
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
        push!(wd["fileChooserCheckBox"][f], QCheckBox())
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
    onChooserChange(None)
end


function setParadigmWidgets()
    if prm["prevParadigm"] != None
        for i=1:length(wdc["paradigmChooserList"])
            paradigm_widg_sizer[:removeWidget](wdc["paradigmChooserList"][i])
            wdc["paradigmChooserList"][i][:setParent](None)
            paradigm_widg_sizer[:removeWidget](wdc["paradigmChooserLabelList"][i])
            wdc["paradigmChooserLabelList"][i][:setParent](None)
            paradigm_widg_sizer[:removeWidget](wdc["paradigmChooserCheckBoxList"][i])
            wdc["paradigmChooserCheckBoxList"][i][:setParent](None)
        end
        for i=1:length(wdc["paradigmFieldList"])
            paradigm_widg_sizer[:removeWidget](wdc["paradigmFieldList"][i])
            wdc["paradigmFieldList"][i][:setParent](None)
            paradigm_widg_sizer[:removeWidget](wdc["paradigmFieldLabelList"][i])
            wdc["paradigmFieldLabelList"][i][:setParent](None)
            paradigm_widg_sizer[:removeWidget](wdc["paradigmFieldCheckBoxList"][i])
            wdc["paradigmFieldCheckBoxList"][i][:setParent](None)
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
        ##     paradigm_widg_sizer.addWidget(adaptiveTypeChooserLabel, n, 1)
        ##     adaptiveTypeChooser = Qt.QComboBox()
        ##     adaptiveTypeChooser.addItems(prm["adaptiveTypeChoices"])
        ##     adaptiveTypeChooser.setCurrentIndex(0)
        ##     paradigm_widg_sizer.addWidget(adaptiveTypeChooser, n, 2)
        ##     adaptiveTypeCheckBox = QCheckBox()
        ##     paradigm_widg_sizer.addWidget(adaptiveTypeCheckBox, n, 0)

        ##     n = n+1
        ##     initialTrackDirChooserLabel = Qt.QLabel(tr("Initial Track Direction:"), self)
        ##     paradigm_widg_sizer.addWidget(initialTrackDirChooserLabel, n, 1)
        ##     initialTrackDirChooser = Qt.QComboBox()
        ##     initialTrackDirChooser.addItems([tr("Up"), tr("Down")])
        ##     initialTrackDirChooser.setCurrentIndex(1)
        ##     paradigm_widg_sizer.addWidget(initialTrackDirChooser, n, 2)
        ##     initialTrackDirCheckBox = QCheckBox()
        ##     paradigm_widg_sizer.addWidget(initialTrackDirCheckBox, n, 0)
        ##     n = n+1
        ##     pcTrackedLabel = Qt.QLabel(tr("Percent Correct Tracked"), self)
        ##     paradigm_widg_sizer.addWidget(pcTrackedLabel, n, 1)
        ##     pcTrackedTF = Qt.QLineEdit()
        ##     pcTrackedTF[:setText]("75")
        ##     paradigm_widg_sizer.addWidget(pcTrackedTF, n, 2)
        ##     pcTrackedCheckBox = QCheckBox()
        ##     paradigm_widg_sizer.addWidget(pcTrackedCheckBox, n, 0)
            
        ##     n = n+1
        ##     initialTurnpointsLabel = Qt.QLabel(tr("Initial Turnpoints"), self)
        ##     paradigm_widg_sizer.addWidget(initialTurnpointsLabel, n, 1)
        ##     initialTurnpointsTF = Qt.QLineEdit()
        ##     initialTurnpointsTF[:setText]("4")
        ##     paradigm_widg_sizer.addWidget(initialTurnpointsTF, n, 2)
        ##     initialTurnpointsCheckBox = QCheckBox()
        ##     paradigm_widg_sizer.addWidget(initialTurnpointsCheckBox, n, 0)

        ##     totalTurnpointsLabel = Qt.QLabel(tr("Total Turnpoints"), self)
        ##     paradigm_widg_sizer.addWidget(totalTurnpointsLabel, n, 4)
        ##     totalTurnpointsTF = Qt.QLineEdit()
        ##     totalTurnpointsTF[:setText]("16")
        ##     paradigm_widg_sizer.addWidget(totalTurnpointsTF, n, 5)
        ##     totalTurnpointsCheckBox = QCheckBox()
        ##     paradigm_widg_sizer.addWidget(totalTurnpointsCheckBox, n, 3)
        ##     n = n+1
        ##     stepSize1Label = Qt.QLabel(tr("Step Size 1"), self)
        ##     paradigm_widg_sizer.addWidget(stepSize1Label, n, 1)
        ##     stepSize1TF = Qt.QLineEdit()
        ##     stepSize1TF[:setText]("4")
        ##     paradigm_widg_sizer.addWidget(stepSize1TF, n, 2)
        ##     stepSize1CheckBox = QCheckBox()
        ##     paradigm_widg_sizer.addWidget(stepSize1CheckBox, n, 0)

        ##     stepSize2Label = Qt.QLabel(tr("Step Size 2"), self)
        ##     paradigm_widg_sizer.addWidget(stepSize2Label, n, 4)
        ##     stepSize2TF = Qt.QLineEdit()
        ##     stepSize2TF[:setText]("2")
        ##     paradigm_widg_sizer.addWidget(stepSize2TF, n, 5)
        ##     stepSize2CheckBox = QCheckBox()
        ##     paradigm_widg_sizer.addWidget(stepSize2CheckBox, n, 3)
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
        ##     paradigm_widg_sizer.addWidget(adaptiveTypeChooserLabel, n, 1)
        ##     adaptiveTypeChooser = Qt.QComboBox()
        ##     adaptiveTypeChooser.addItems(prm["adaptiveTypeChoices"])
        ##     adaptiveTypeChooser.setCurrentIndex(0)
        ##     paradigm_widg_sizer.addWidget(adaptiveTypeChooser, n, 2)
        ##     adaptiveTypeCheckBox = QCheckBox()
        ##     paradigm_widg_sizer.addWidget(adaptiveTypeCheckBox, n, 0)

        ##     n = n+1

        ##     nTracksLabel = Qt.QLabel(tr("No. Tracks:"), self)
        ##     paradigm_widg_sizer.addWidget(nTracksLabel, n, 1)
        ##     nTracksChooser = Qt.QComboBox()
        ##     nTracksOptionsList = list(range(1,101))
        ##     nTracksOptionsList = [str(el) for el in nTracksOptionsList]
        ##     nTracksChooser.addItems(nTracksOptionsList)
        ##     nTracks = par["nDifferences"]
        ##     nTracksChooser.setCurrentIndex(nTracksOptionsList.index(str(nTracks)))
        ##     paradigm_widg_sizer.addWidget(nTracksChooser, n, 2)
        ##     nTracksChooser.activated[str].connect(onChangeNTracks)
        ##     nTracksCheckBox = QCheckBox()
        ##     paradigm_widg_sizer.addWidget(nTracksCheckBox, n, 0)
        ##     if prm[currExp]["hasNTracksChooser"] == True:
        ##         nTracksLabel.show()
        ##         nTracksChooser.show()
        ##         nTracksCheckBox.show()
        ##     else:
        ##         nTracksLabel.hide()
        ##         nTracksChooser.hide()
        ##         nTracksCheckBox.hide()
        ##     n = n+1
        ##     maxConsecutiveTrialsLabel = Qt.QLabel(tr("Max. Consecutive Trials x Track:"), self)
        ##     paradigm_widg_sizer.addWidget(maxConsecutiveTrialsLabel, n, 1)
        ##     maxConsecutiveTrials = Qt.QComboBox()
        ##     maxConsecutiveTrialsOptionsList = list(range(1,101))
        ##     maxConsecutiveTrialsOptionsList = [str(el) for el in maxConsecutiveTrialsOptionsList]
        ##     maxConsecutiveTrialsOptionsList.insert(0, tr("unlimited"))
          
        ##     maxConsecutiveTrials.addItems(maxConsecutiveTrialsOptionsList)
        ##     paradigm_widg_sizer.addWidget(maxConsecutiveTrials, n, 2)
        ##     maxConsecutiveTrialsCheckBox = QCheckBox()
        ##     paradigm_widg_sizer.addWidget(maxConsecutiveTrialsCheckBox, n, 0)
        ##     if nTracks > 1:
        ##         maxConsecutiveTrialsLabel.show()
        ##         maxConsecutiveTrials.show()
        ##         maxConsecutiveTrialsCheckBox.show()
        ##     else:
        ##         maxConsecutiveTrials.setCurrentIndex(0)#"unlimited"
        ##         maxConsecutiveTrialsLabel.hide()
        ##         maxConsecutiveTrials.hide()
        ##         maxConsecutiveTrialsCheckBox.hide()
           

        ##     n = n+1

        ##     tnpToAverageLabel = Qt.QLabel(tr("Turnpoints to average:"), self)
        ##     paradigm_widg_sizer.addWidget(tnpToAverageLabel, n, 1)
        ##     tnpToAverageChooser = Qt.QComboBox()
        ##     tnpToAverageChooser.addItems(prm["tnpToAverageChoices"])
        ##     tnpToAverageChooser.setCurrentIndex(0)
        ##     paradigm_widg_sizer.addWidget(tnpToAverageChooser, n, 2)
        ##     tnpToAverageCheckBox = QCheckBox()
        ##     paradigm_widg_sizer.addWidget(tnpToAverageCheckBox, n, 0)

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
        ##         paradigm_widg_sizer.addWidget(initialTrackDirChooserLabel[i], n, 1)
        ##         initialTrackDirChooser.append(Qt.QComboBox())
        ##         initialTrackDirChooser[i].addItems([tr("Up"), tr("Down")])
        ##         initialTrackDirChooser[i].setCurrentIndex(1)
        ##         paradigm_widg_sizer.addWidget(initialTrackDirChooser[i], n, 2)
        ##         trackDirOptionsList.append([tr("Up"), tr("Down")])
        ##         initialTrackDirCheckBox.append(QCheckBox())
        ##         paradigm_widg_sizer.addWidget(initialTrackDirCheckBox[i], n, 0)
        ##         n = n+1
        ##         ruleDownLabel.append(Qt.QLabel(tr("Rule Down Track " + str(i+1)), self))
        ##         paradigm_widg_sizer.addWidget(ruleDownLabel[i], n, 1)
        ##         ruleDownTF.append(Qt.QLineEdit())
        ##         ruleDownTF[i][:setText]("2")
        ##         ruleDownTF[i][:setValidator](Qt.QIntValidator(self))
        ##         paradigm_widg_sizer.addWidget(ruleDownTF[i], n, 2)
        ##         ruleDownCheckBox.append(QCheckBox())
        ##         paradigm_widg_sizer.addWidget(ruleDownCheckBox[i], n, 0)

        ##         ruleUpLabel.append(Qt.QLabel(tr("Rule Up Track " + str(i+1)), self))
        ##         paradigm_widg_sizer.addWidget(ruleUpLabel[i], n, 4)
        ##         ruleUpTF.append(Qt.QLineEdit())
        ##         ruleUpTF[i][:setText]("1")
        ##         ruleUpTF[i][:setValidator](Qt.QIntValidator(self))
        ##         paradigm_widg_sizer.addWidget(ruleUpTF[i], n, 5)
        ##         ruleUpCheckBox.append(QCheckBox())
        ##         paradigm_widg_sizer.addWidget(ruleUpCheckBox[i], n, 3)

        ##         n = n+1
              
        ##         initialTurnpointsLabel.append(Qt.QLabel(tr("Initial Turnpoints Track " + str(i+1)), self))
        ##         paradigm_widg_sizer.addWidget(initialTurnpointsLabel[i], n, 1)
        ##         initialTurnpointsTF.append(Qt.QLineEdit())
        ##         initialTurnpointsTF[i][:setText]("4")
        ##         initialTurnpointsTF[i][:setValidator](Qt.QIntValidator(self))
        ##         paradigm_widg_sizer.addWidget(initialTurnpointsTF[i], n, 2)
        ##         initialTurnpointsCheckBox.append(QCheckBox())
        ##         paradigm_widg_sizer.addWidget(initialTurnpointsCheckBox[i], n, 0)

        ##         totalTurnpointsLabel.append(Qt.QLabel(tr("Total Turnpoints Track " + str(i+1)), self))
        ##         paradigm_widg_sizer.addWidget(totalTurnpointsLabel[i], n, 4)
        ##         totalTurnpointsTF.append(Qt.QLineEdit())
        ##         totalTurnpointsTF[i][:setText]("16")
        ##         totalTurnpointsTF[i][:setValidator](Qt.QIntValidator(self))
        ##         paradigm_widg_sizer.addWidget(totalTurnpointsTF[i], n, 5)
        ##         totalTurnpointsCheckBox.append(QCheckBox())
        ##         paradigm_widg_sizer.addWidget(totalTurnpointsCheckBox[i], n, 3)
                
        ##         n = n+1
        ##         stepSize1Label.append(Qt.QLabel(tr("Step Size 1 Track " + str(i+1)), self))
        ##         paradigm_widg_sizer.addWidget(stepSize1Label[i], n, 1)
        ##         stepSize1TF.append(Qt.QLineEdit())
        ##         stepSize1TF[i][:setText]("4")
        ##         stepSize1TF[i][:setValidator](Qt.QDoubleValidator(self))
        ##         paradigm_widg_sizer.addWidget(stepSize1TF[i], n, 2)
        ##         stepSize1CheckBox.append(QCheckBox())
        ##         paradigm_widg_sizer.addWidget(stepSize1CheckBox[i], n, 0)
                
        ##         stepSize2Label.append(Qt.QLabel(tr("Step Size 2 Track " + str(i+1)), self))
        ##         paradigm_widg_sizer.addWidget(stepSize2Label[i], n, 4)
        ##         stepSize2TF.append(Qt.QLineEdit())
        ##         stepSize2TF[i][:setText]("2")
        ##         stepSize2TF[i][:setValidator](Qt.QDoubleValidator(self))
        ##         paradigm_widg_sizer.addWidget(stepSize2TF[i], n, 5)
        ##         stepSize2CheckBox.append(QCheckBox())
        ##         paradigm_widg_sizer.addWidget(stepSize2CheckBox[i], n, 3)
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
        ##     paradigm_widg_sizer.addWidget(adaptiveTypeChooserLabel, n, 1)
        ##     adaptiveTypeChooser = Qt.QComboBox()
        ##     adaptiveTypeChooser.addItems(prm["adaptiveTypeChoices"])
        ##     adaptiveTypeChooser.setCurrentIndex(0)
        ##     paradigm_widg_sizer.addWidget(adaptiveTypeChooser, n, 2)
        ##     adaptiveTypeCheckBox = QCheckBox()
        ##     paradigm_widg_sizer.addWidget(adaptiveTypeCheckBox, n, 0)
        ##     n = n+1

        ##     self.nTracksLabel = Qt.QLabel(self.tr("No. Tracks:"), self)
        ##     self.paradigm_widg_sizer.addWidget(self.nTracksLabel, n, 1)
        ##     self.nTracksChooser = Qt.QComboBox()
        ##     self.nTracksOptionsList = list(range(1,101))
        ##     self.nTracksOptionsList = [str(el) for el in self.nTracksOptionsList]
        ##     self.nTracksChooser.addItems(self.nTracksOptionsList)
        ##     nTracks = self.par["nDifferences"]
        ##     self.nTracksChooser.setCurrentIndex(self.nTracksOptionsList.index(str(nTracks)))
        ##     self.paradigm_widg_sizer.addWidget(self.nTracksChooser, n, 2)
        ##     self.nTracksChooser.activated[str].connect(self.onChangeNTracks)
        ##     self.nTracksCheckBox = QCheckBox()
        ##     self.paradigm_widg_sizer.addWidget(self.nTracksCheckBox, n, 0)
        ##     if self.prm[self.currExp]["hasNTracksChooser"] == True:
        ##         self.nTracksLabel.show()
        ##         self.nTracksChooser.show()
        ##         self.nTracksCheckBox.show()
        ##     else:
        ##         self.nTracksLabel.hide()
        ##         self.nTracksChooser.hide()
        ##         self.nTracksCheckBox.hide()
        ##     n = n+1
        ##     self.maxConsecutiveTrialsLabel = Qt.QLabel(self.tr("Max. Consecutive Trials x Track:"), self)
        ##     self.paradigm_widg_sizer.addWidget(self.maxConsecutiveTrialsLabel, n, 1)
        ##     self.maxConsecutiveTrials = Qt.QComboBox()
        ##     self.maxConsecutiveTrialsOptionsList = list(range(1,101))
        ##     self.maxConsecutiveTrialsOptionsList = [str(el) for el in self.maxConsecutiveTrialsOptionsList]
        ##     self.maxConsecutiveTrialsOptionsList.insert(0, self.tr("unlimited"))
          
        ##     self.maxConsecutiveTrials.addItems(self.maxConsecutiveTrialsOptionsList)
        ##     self.paradigm_widg_sizer.addWidget(self.maxConsecutiveTrials, n, 2)
        ##     self.maxConsecutiveTrialsCheckBox = QCheckBox()
        ##     self.paradigm_widg_sizer.addWidget(self.maxConsecutiveTrialsCheckBox, n, 0)
        ##     if nTracks > 1:
        ##         self.maxConsecutiveTrialsLabel.show()
        ##         self.maxConsecutiveTrials.show()
        ##         self.maxConsecutiveTrialsCheckBox.show()
        ##     else:
        ##         self.maxConsecutiveTrials.setCurrentIndex(0)#"unlimited"
        ##         self.maxConsecutiveTrialsLabel.hide()
        ##         self.maxConsecutiveTrials.hide()
        ##         self.maxConsecutiveTrialsCheckBox.hide()
           

        ##     n = n+1
        ##     self.tnpToAverageLabel = Qt.QLabel(self.tr("Turnpoints to average:"), self)
        ##     self.paradigm_widg_sizer.addWidget(self.tnpToAverageLabel, n, 1)
        ##     self.tnpToAverageChooser = Qt.QComboBox()
        ##     self.tnpToAverageChooser.addItems(self.prm["tnpToAverageChoices"])
        ##     self.tnpToAverageChooser.setCurrentIndex(0)
        ##     self.paradigm_widg_sizer.addWidget(self.tnpToAverageChooser, n, 2)
        ##     self.tnpToAverageCheckBox = QCheckBox()
        ##     self.paradigm_widg_sizer.addWidget(self.tnpToAverageCheckBox, n, 0)

        ##     n = n+1
        ##     self.initialTrackDirChooserLabel = []
        ##     self.initialTrackDirChooser = []
        ##     self.trackDirOptionsList = []
        ##     self.initialTrackDirCheckBox = []
             
        ##     self.pcTrackedTF = []
        ##     self.initialTurnpointsTF = []
        ##     self.totalTurnpointsTF = []
        ##     self.stepSize1TF = []
        ##     self.stepSize2TF = []
            
        ##     self.pcTrackedLabel = []
        ##     self.initialTurnpointsLabel = []
        ##     self.totalTurnpointsLabel = []
        ##     self.stepSize1Label = []
        ##     self.stepSize2Label = []

        ##     self.pcTrackedCheckBox = []
        ##     self.initialTurnpointsCheckBox = []
        ##     self.totalTurnpointsCheckBox = []
        ##     self.stepSize1CheckBox = []
        ##     self.stepSize2CheckBox = []
            
        ##     for i in range(self.par["nDifferences"]):
        ##         self.initialTrackDirChooserLabel.append(QLabel(self.tr("Initial Track {0} Direction:".format(str(i+1))), self))
        ##         self.paradigm_widg_sizer.addWidget(self.initialTrackDirChooserLabel[i], n, 1)
        ##         self.initialTrackDirChooser.append(QComboBox())
        ##         self.initialTrackDirChooser[i].addItems([self.tr("Up"), self.tr("Down")])
        ##         self.initialTrackDirChooser[i].setCurrentIndex(1)
        ##         self.paradigm_widg_sizer.addWidget(self.initialTrackDirChooser[i], n, 2)
        ##         self.trackDirOptionsList.append([self.tr("Up"), self.tr("Down")])
        ##         self.initialTrackDirCheckBox.append(QCheckBox())
        ##         self.paradigm_widg_sizer.addWidget(self.initialTrackDirCheckBox[i], n, 0)
        ##         n = n+1
        ##         self.pcTrackedLabel.append(QLabel(self.tr("Percent Correct Tracked Track " + str(i+1)), self))
        ##         self.paradigm_widg_sizer.addWidget(self.pcTrackedLabel[i], n, 1)
        ##         self.pcTrackedTF.append(Qt.QLineEdit())
        ##         self.pcTrackedTF[i][:setText]("75")
        ##         self.pcTrackedTF[i][:setValidator](Qt.QDoubleValidator(self))
        ##         self.paradigm_widg_sizer.addWidget(self.pcTrackedTF[i], n, 2)
        ##         self.pcTrackedCheckBox.append(QCheckBox())
        ##         self.paradigm_widg_sizer.addWidget(self.pcTrackedCheckBox[i], n, 0)

        ##         n = n+1
        ##         self.initialTurnpointsLabel.append(QLabel(self.tr("Initial Turnpoints Track " + str(i+1)), self))
        ##         self.paradigm_widg_sizer.addWidget(self.initialTurnpointsLabel[i], n, 1)
        ##         self.initialTurnpointsTF.append(Qt.QLineEdit())
        ##         self.initialTurnpointsTF[i][:setText]("4")
        ##         self.initialTurnpointsTF[i][:setValidator](Qt.QIntValidator(self))
        ##         self.paradigm_widg_sizer.addWidget(self.initialTurnpointsTF[i], n, 2)
        ##         self.initialTurnpointsCheckBox.append(QCheckBox())
        ##         self.paradigm_widg_sizer.addWidget(self.initialTurnpointsCheckBox[i], n, 0)

        ##         self.totalTurnpointsLabel.append(QLabel(self.tr("Total Turnpoints Track " + str(i+1)), self))
        ##         self.paradigm_widg_sizer.addWidget(self.totalTurnpointsLabel[i], n, 4)
        ##         self.totalTurnpointsTF.append(Qt.QLineEdit())
        ##         self.totalTurnpointsTF[i][:setText]("16")
        ##         self.totalTurnpointsTF[i][:setValidator](Qt.QIntValidator(self))
        ##         self.paradigm_widg_sizer.addWidget(self.totalTurnpointsTF[i], n, 5)
        ##         self.totalTurnpointsCheckBox.append(QCheckBox())
        ##         self.paradigm_widg_sizer.addWidget(self.totalTurnpointsCheckBox[i], n, 3)
                
        ##         n = n+1
        ##         self.stepSize1Label.append(QLabel(self.tr("Step Size 1 Track " + str(i+1)), self))
        ##         self.paradigm_widg_sizer.addWidget(self.stepSize1Label[i], n, 1)
        ##         self.stepSize1TF.append(Qt.QLineEdit())
        ##         self.stepSize1TF[i][:setText]("4")
        ##         self.stepSize1TF[i][:setValidator](Qt.QDoubleValidator(self))
        ##         self.paradigm_widg_sizer.addWidget(self.stepSize1TF[i], n, 2)
        ##         self.stepSize1CheckBox.append(QCheckBox())
        ##         self.paradigm_widg_sizer.addWidget(self.stepSize1CheckBox[i], n, 0)
                
        ##         self.stepSize2Label.append(QLabel(self.tr("Step Size 2 Track " + str(i+1)), self))
        ##         self.paradigm_widg_sizer.addWidget(self.stepSize2Label[i], n, 4)
        ##         self.stepSize2TF.append(Qt.QLineEdit())
        ##         self.stepSize2TF[i][:setText]("2")
        ##         self.stepSize2TF[i][:setValidator](Qt.QDoubleValidator(self))
        ##         self.paradigm_widg_sizer.addWidget(self.stepSize2TF[i], n, 5)
        ##         self.stepSize2CheckBox.append(QCheckBox())
        ##         self.paradigm_widg_sizer.addWidget(self.stepSize2CheckBox[i], n, 3)
        ##         n = n+1
           
                
        ##     self.paradigmChooserList = [self.adaptiveTypeChooser, self.nTracksChooser, self.maxConsecutiveTrials, self.tnpToAverageChooser]
        ##     self.paradigmChooserLabelList = [self.adaptiveTypeChooserLabel, self.nTracksLabel, self.maxConsecutiveTrialsLabel, self.tnpToAverageLabel]
        ##     self.paradigmChooserOptionsList = [self.prm["adaptiveTypeChoices"], self.nTracksOptionsList, self.maxConsecutiveTrialsOptionsList, self.prm["tnpToAverageChoices"]]
        ##     self.paradigmChooserCheckBoxList = [self.adaptiveTypeCheckBox, self.nTracksCheckBox, self.maxConsecutiveTrialsCheckBox, self.tnpToAverageCheckBox]
        ##     self.paradigmChooserList.extend(self.initialTrackDirChooser)
        ##     self.paradigmChooserLabelList.extend(self.initialTrackDirChooserLabel)
        ##     self.paradigmChooserOptionsList.extend(self.trackDirOptionsList)
        ##     self.paradigmChooserCheckBoxList.extend(self.initialTrackDirCheckBox)

        ##     self.paradigmFieldList = self.pcTrackedTF
        ##     self.paradigmFieldList.extend(self.initialTurnpointsTF)
        ##     self.paradigmFieldList.extend(self.totalTurnpointsTF)
        ##     self.paradigmFieldList.extend(self.stepSize1TF)
        ##     self.paradigmFieldList.extend(self.stepSize2TF)
        ##     self.paradigmFieldLabelList = self.pcTrackedLabel
        ##     self.paradigmFieldLabelList.extend(self.initialTurnpointsLabel)
        ##     self.paradigmFieldLabelList.extend(self.totalTurnpointsLabel)
        ##     self.paradigmFieldLabelList.extend(self.stepSize1Label)
        ##     self.paradigmFieldLabelList.extend(self.stepSize2Label)
        ##     self.paradigmFieldCheckBoxList = self.pcTrackedCheckBox
        ##     self.paradigmFieldCheckBoxList.extend(self.initialTurnpointsCheckBox)
        ##     self.paradigmFieldCheckBoxList.extend(self.totalTurnpointsCheckBox)
        ##     self.paradigmFieldCheckBoxList.extend(self.stepSize1CheckBox)
        ##     self.paradigmFieldCheckBoxList.extend(self.stepSize2CheckBox)

        ## #------------------------
        ## #ONE CONSTANT PARADIGM WIDGETS
        ## if self.currParadigm in [self.tr("Constant 1-Interval 2-Alternatives"), self.tr("Constant 1-Pair Same/Different"), self.tr("Constant m-Intervals n-Alternatives")]:
        ##     n = 0
        ##     self.nTrialsLabel = QLabel(self.tr("No. Trials"), self)
        ##     self.paradigm_widg_sizer.addWidget(self.nTrialsLabel, n, 1)
        ##     self.nTrialsTF = Qt.QLineEdit()
        ##     self.nTrialsTF[:setText]("25")
        ##     self.nTrialsTF[:setValidator](Qt.QIntValidator(self))
        ##     self.paradigm_widg_sizer.addWidget(self.nTrialsTF, n, 2)
        ##     self.nTrialsCheckBox = QCheckBox()
        ##     self.paradigm_widg_sizer.addWidget(self.nTrialsCheckBox, n, 0)

        ##     n = n+1
        ##     self.nPracticeTrialsLabel = QLabel(self.tr("No. Practice Trials"), self)
        ##     self.paradigm_widg_sizer.addWidget(self.nPracticeTrialsLabel, n, 1)
        ##     self.nPracticeTrialsTF = Qt.QLineEdit()
        ##     self.nPracticeTrialsTF[:setText]("0")
        ##     self.nPracticeTrialsTF[:setValidator](Qt.QIntValidator(self))
        ##     self.paradigm_widg_sizer.addWidget(self.nPracticeTrialsTF, n, 2)
        ##     self.nPracticeTrialsCheckBox = QCheckBox()
        ##     self.paradigm_widg_sizer.addWidget(self.nPracticeTrialsCheckBox, n, 0)

        ##     self.paradigmChooserList = []
        ##     self.paradigmChooserLabelList = []
        ##     self.paradigmChooserOptionsList = []
        ##     self.paradigmChooserCheckBoxList = []

        ##     self.paradigmFieldList = [self.nTrialsTF, self.nPracticeTrialsTF]
        ##     self.paradigmFieldLabelList = [self.nTrialsLabel, self.nPracticeTrialsLabel]
        ##     self.paradigmFieldCheckBoxList = [self.nTrialsCheckBox, self.nPracticeTrialsCheckBox]

      
        ## #------------------------
        ## #MULTIPLE CONSTANTS PARADIGM WIDGETS
        ## if self.currParadigm in [self.tr("Multiple Constants 1-Interval 2-Alternatives"), self.tr("Multiple Constants m-Intervals n-Alternatives"), self.tr("Odd One Out")]:
        ##     n = 0
        ##     self.nTrialsLabel = QLabel(self.tr("No. Trials"), self)
        ##     self.paradigm_widg_sizer.addWidget(self.nTrialsLabel, n, 1)
        ##     self.nTrialsTF = Qt.QLineEdit()
        ##     self.nTrialsTF[:setText]("25")
        ##     self.nTrialsTF[:setValidator](Qt.QIntValidator(self))
        ##     self.paradigm_widg_sizer.addWidget(self.nTrialsTF, n, 2)
        ##     self.nTrialsCheckBox = QCheckBox()
        ##     self.paradigm_widg_sizer.addWidget(self.nTrialsCheckBox, n, 0)

        ##     n = n+1
        ##     self.nPracticeTrialsLabel = QLabel(self.tr("No. Practice Trials"), self)
        ##     self.paradigm_widg_sizer.addWidget(self.nPracticeTrialsLabel, n, 1)
        ##     self.nPracticeTrialsTF = Qt.QLineEdit()
        ##     self.nPracticeTrialsTF[:setText]("0")
        ##     self.nPracticeTrialsTF[:setValidator](Qt.QIntValidator(self))
        ##     self.paradigm_widg_sizer.addWidget(self.nPracticeTrialsTF, n, 2)
        ##     self.nPracticeTrialsCheckBox = QCheckBox()
        ##     self.paradigm_widg_sizer.addWidget(self.nPracticeTrialsCheckBox, n, 0)

        ##     n = n+1
        ##     self.nDifferencesLabel = QLabel(self.tr("No. Differences:"), self)
        ##     self.paradigm_widg_sizer.addWidget(self.nDifferencesLabel, n, 1)
        ##     self.nDifferencesChooser = QComboBox()
        ##     self.nDifferencesOptionsList = list(range(1,101))
        ##     self.nDifferencesOptionsList = [str(el) for el in self.nDifferencesOptionsList]
        ##     self.nDifferencesChooser.addItems(self.nDifferencesOptionsList)
          
        ##     self.nDifferencesChooser.setCurrentIndex(self.nDifferencesOptionsList.index(str(self.par["nDifferences"])))
        ##     self.paradigm_widg_sizer.addWidget(self.nDifferencesChooser, n, 2)
        ##     self.nDifferencesChooser.activated[str].connect(self.onChangeNDifferences)

        ##     self.nDifferencesCheckBox = QCheckBox()
        ##     self.paradigm_widg_sizer.addWidget(self.nDifferencesCheckBox, n, 0)
        ##     if self.prm[self.currExp]["hasNDifferencesChooser"] == True:
        ##         self.nDifferencesLabel.show()
        ##         self.nDifferencesChooser.show()
        ##         self.nDifferencesCheckBox.show()
        ##     else:
        ##         self.nDifferencesLabel.hide()
        ##         self.nDifferencesChooser.hide()
        ##         self.nDifferencesCheckBox.hide()

        ##     self.paradigmChooserList = [self.nDifferencesChooser]
        ##     self.paradigmChooserLabelList = [self.nDifferencesLabel]
        ##     self.paradigmChooserOptionsList = [self.nDifferencesOptionsList]
        ##     self.paradigmChooserCheckBoxList = [self.nDifferencesCheckBox]

        ##     self.paradigmFieldList = [self.nTrialsTF, self.nPracticeTrialsTF]
        ##     self.paradigmFieldLabelList = [self.nTrialsLabel, self.nPracticeTrialsLabel]
        ##     self.paradigmFieldCheckBoxList = [self.nTrialsCheckBox, self.nPracticeTrialsCheckBox]

        ## #------------------------------------
        ## #PEST PARADIGM WIDGETS
        ## if self.currParadigm == self.tr("PEST"):
        ##     n = 0
        ##     self.adaptiveTypeChooserLabel = QLabel(self.tr("Procedure:"), self)
        ##     self.paradigm_widg_sizer.addWidget(self.adaptiveTypeChooserLabel, n, 1)
        ##     self.adaptiveTypeChooser = QComboBox()
        ##     self.adaptiveTypeChooser.addItems(self.prm["adaptiveTypeChoices"])
        ##     self.adaptiveTypeChooser.setCurrentIndex(0)
        ##     self.paradigm_widg_sizer.addWidget(self.adaptiveTypeChooser, n, 2)
        ##     self.adaptiveTypeCheckBox = QCheckBox()
        ##     self.paradigm_widg_sizer.addWidget(self.adaptiveTypeCheckBox, n, 0)

        ##     n = n+1
        ##     self.initialTrackDirChooserLabel = QLabel(self.tr("Initial Track Direction:"), self)
        ##     self.paradigm_widg_sizer.addWidget(self.initialTrackDirChooserLabel, n, 1)
        ##     self.initialTrackDirChooser = QComboBox()
        ##     self.initialTrackDirChooser.addItems([self.tr("Up"), self.tr("Down")])
        ##     self.initialTrackDirChooser.setCurrentIndex(1)
        ##     self.paradigm_widg_sizer.addWidget(self.initialTrackDirChooser, n, 2)
        ##     self.initialTrackDirCheckBox = QCheckBox()
        ##     self.paradigm_widg_sizer.addWidget(self.initialTrackDirCheckBox, n, 0)

        ##     n = n+1
        ##     self.pcTrackedLabel = QLabel(self.tr("Percent Correct Tracked"), self)
        ##     self.paradigm_widg_sizer.addWidget(self.pcTrackedLabel, n, 1)
        ##     self.pcTrackedTF = Qt.QLineEdit()
        ##     self.pcTrackedTF[:setText]("75")
        ##     self.pcTrackedTF[:setValidator](Qt.QDoubleValidator(self))
        ##     self.paradigm_widg_sizer.addWidget(self.pcTrackedTF, n, 2)
        ##     self.pcTrackedCheckBox = QCheckBox()
        ##     self.paradigm_widg_sizer.addWidget(self.pcTrackedCheckBox, n, 0)

        ##     #n = n+1
        ##     self.initialStepSizeLabel = QLabel(self.tr("Initial Step Size"), self)
        ##     self.paradigm_widg_sizer.addWidget(self.initialStepSizeLabel, n, 4)
        ##     self.initialStepSizeTF = Qt.QLineEdit()
        ##     self.initialStepSizeTF[:setText]("5")
        ##     self.initialStepSizeTF[:setValidator](Qt.QIntValidator(self))
        ##     self.paradigm_widg_sizer.addWidget(self.initialStepSizeTF, n, 5)
        ##     self.initialStepSizeCheckBox = QCheckBox()
        ##     self.paradigm_widg_sizer.addWidget(self.initialStepSizeCheckBox, n, 3)

        ##     n = n+1
        ##     self.minStepSizeLabel = QLabel(self.tr("Minimum Step Size"), self)
        ##     self.paradigm_widg_sizer.addWidget(self.minStepSizeLabel, n, 1)
        ##     self.minStepSizeTF = Qt.QLineEdit()
        ##     self.minStepSizeTF[:setText]("1")
        ##     self.minStepSizeTF[:setValidator](Qt.QDoubleValidator(self))
        ##     self.paradigm_widg_sizer.addWidget(self.minStepSizeTF, n, 2)
        ##     self.minStepSizeCheckBox = QCheckBox()
        ##     self.paradigm_widg_sizer.addWidget(self.minStepSizeCheckBox, n, 0)

        ##     #n = n+1
        ##     self.maxStepSizeLabel = QLabel(self.tr("Maximum Step Size"), self)
        ##     self.paradigm_widg_sizer.addWidget(self.maxStepSizeLabel, n, 4)
        ##     self.maxStepSizeTF = Qt.QLineEdit()
        ##     self.maxStepSizeTF[:setText]("10")
        ##     self.maxStepSizeTF[:setValidator](Qt.QDoubleValidator(self))
        ##     self.paradigm_widg_sizer.addWidget(self.maxStepSizeTF, n, 5)
        ##     self.maxStepSizeCheckBox = QCheckBox()
        ##     self.paradigm_widg_sizer.addWidget(self.maxStepSizeCheckBox, n, 3)

        ##     n = n+1
        ##     self.WLabel = QLabel(self.tr("W"), self)
        ##     self.paradigm_widg_sizer.addWidget(self.WLabel, n, 1)
        ##     self.WTF = Qt.QLineEdit()
        ##     self.WTF[:setText]("1.5")
        ##     self.WTF[:setValidator](Qt.QDoubleValidator(self))
        ##     self.paradigm_widg_sizer.addWidget(self.WTF, n, 2)
        ##     self.WCheckBox = QCheckBox()
        ##     self.paradigm_widg_sizer.addWidget(self.WCheckBox, n, 0)

        ##     self.paradigmChooserList = [self.adaptiveTypeChooser, self.initialTrackDirChooser]
        ##     self.paradigmChooserLabelList = [self.adaptiveTypeChooserLabel, self.initialTrackDirChooserLabel]
        ##     self.paradigmChooserOptionsList = [self.prm["adaptiveTypeChoices"], [self.tr("Up"), self.tr("Down")]]
        ##     self.paradigmChooserCheckBoxList = [self.adaptiveTypeCheckBox, self.initialTrackDirCheckBox]

        ##     self.paradigmFieldList = [self.initialStepSizeTF, self.minStepSizeTF, self.maxStepSizeTF,
        ##                               self.WTF, self.pcTrackedTF]
        ##     self.paradigmFieldLabelList = [self.initialStepSizeLabel, self.minStepSizeLabel,
        ##                                    self.maxStepSizeLabel, self.WLabel, self.pcTrackedLabel]
        ##     self.paradigmFieldCheckBoxList = [self.initialStepSizeCheckBox, self.minStepSizeCheckBox,
        ##                                       self.maxStepSizeCheckBox, self.WCheckBox, self.pcTrackedCheckBox]

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
setAdditionalWidgets() 

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
## loadParametersButton.setSizePolicy(QSizePolicy.Expanding, QSizePolicy.Expanding)
pw_buttons_sizer[:addWidget](loadParametersButton, n, 0)

#SAVE PARAMETERS BUTTON
saveParametersButton = Qt.QPushButton("Save Prm")
## saveParametersButton.setIcon(QIcon.fromTheme("document-save", QIcon(":/document-save")))
## saveParametersButton.setIconSize(QtCore.QSize(min_pw_icon_size, min_pw_icon_size))
saveParametersButton[:clicked][:connect](onClickSaveParametersButton)
saveParametersButton[:setToolTip]("Save a parameters file")
saveParametersButton[:setWhatsThis]("Save the current experimental parameters to a file")
## saveParametersButton.setSizePolicy(QSizePolicy.Expanding, QSizePolicy.Expanding)
pw_buttons_sizer[:addWidget](saveParametersButton, n, 1)

#DELETE PARAMETERS BUTTON
deleteParametersButton = Qt.QPushButton("Delete")
deleteParametersButton[:clicked][:connect](onClickDeleteParametersButton)
## deleteParametersButton.setIcon(QIcon.fromTheme("edit-delete", QIcon(":/edit-delete")))
## deleteParametersButton.setIconSize(QtCore.QSize(min_pw_icon_size, min_pw_icon_size))
deleteParametersButton[:setToolTip]("Delete current Block")
## deleteParametersButton.setSizePolicy(QSizePolicy.Expanding, QSizePolicy.Expanding)
pw_buttons_sizer[:addWidget](deleteParametersButton, n, 2)


undoUnsavedButton = Qt.QPushButton("Undo Unsaved")
## undoUnsavedButton[:clicked][:connect](onClickUndoUnsavedButton)
## undoUnsavedButton.setIcon(QIcon.fromTheme("edit-undo", QIcon(":/edit-undo")))
## undoUnsavedButton.setIconSize(QtCore.QSize(min_pw_icon_size, min_pw_icon_size))
undoUnsavedButton[:setToolTip]("Undo unsaved changes")
## undoUnsavedButton.setSizePolicy(QSizePolicy.Expanding, QSizePolicy.Expanding)
pw_buttons_sizer[:addWidget](undoUnsavedButton, n, 3)

## #---- SECOND ROW
n = n+1
storeParametersButton = Qt.QPushButton("Store")
## storeParametersButton[:clicked][:connect](onClickStoreParametersButton)
## storeParametersButton.setIcon(QIcon.fromTheme("media-flash-memory-stick", QIcon(":/media-flash-memory-stick")))
## storeParametersButton.setIconSize(QtCore.QSize(min_pw_icon_size, min_pw_icon_size))
storeParametersButton[:setToolTip]("Store current Block")
## storeParametersButton.setSizePolicy(QSizePolicy.Expanding, QSizePolicy.Expanding)
pw_buttons_sizer[:addWidget](storeParametersButton, n, 0)

storeandaddParametersButton = Qt.QPushButton("Store 'n' add!")
## storeandaddParametersButton[:clicked][:connect](onClickStoreandaddParametersButton)
storeandaddParametersButton[:setToolTip]("Store current Block and add a new one")
## storeandaddParametersButton.setSizePolicy(QSizePolicy.Expanding, QSizePolicy.Expanding)
pw_buttons_sizer[:addWidget](storeandaddParametersButton, n, 1)

storeandgoParametersButton = Qt.QPushButton("Store 'n' go!")
## storeandgoParametersButton[:clicked][:connect](onClickStoreandgoParametersButton)
storeandgoParametersButton[:setToolTip]("Store current Block and move to the next")
## storeandgoParametersButton.setSizePolicy(QSizePolicy.Expanding, QSizePolicy.Expanding)
pw_buttons_sizer[:addWidget](storeandgoParametersButton, n, 2)

newBlockButton = Qt.QPushButton("New Block")
##newBlockButton[:clicked][:connect](onClickNewBlockButton)
## newBlockButton.setIcon(QIcon.fromTheme("document-new", QIcon(":/document-new")))
## newBlockButton.setIconSize(QtCore.QSize(min_pw_icon_size, min_pw_icon_size))
newBlockButton[:setToolTip]("Append a new block")
## newBlockButton.setSizePolicy(QSizePolicy.Expanding, QSizePolicy.Expanding)
pw_buttons_sizer[:addWidget](newBlockButton, n, 3)

      
      

#---- THIRD ROW
n = n+1
prevBlockButton = Qt.QPushButton("Previous")
## prevBlockButton[:clicked][:connect](onClickPrevBlockButton)
## prevBlockButton.setIcon(QIcon.fromTheme("go-previous", QIcon(":/go-previous")))
## prevBlockButton.setIconSize(QtCore.QSize(min_pw_icon_size, min_pw_icon_size))
prevBlockButton[:setToolTip]("Move to previous block")
## prevBlockButton.setSizePolicy(QSizePolicy.Expanding, QSizePolicy.Expanding)
pw_buttons_sizer[:addWidget](prevBlockButton, n, 0)

nextBlockButton = Qt.QPushButton("Next")
##nextBlockButton[:clicked][:connect](onClickNextBlockButton)
## nextBlockButton.setIcon(QIcon.fromTheme("go-next", QIcon(":/go-next")))
## nextBlockButton.setIconSize(QtCore.QSize(min_pw_icon_size, min_pw_icon_size))
nextBlockButton[:setToolTip]("Move to next block")
## nextBlockButton.setSizePolicy(QSizePolicy.Expanding, QSizePolicy.Expanding)
pw_buttons_sizer[:addWidget](nextBlockButton, n, 1)

shuffleBlocksButton = Qt.QPushButton("Shuffle")
## shuffleBlocksButton[:clicked][:connect](onClickShuffleBlocksButton)
## shuffleBlocksButton.setIcon(QIcon.fromTheme("media-playlist-shuffle", QIcon(":/media-playlist-shuffle")))
## shuffleBlocksButton.setIconSize(QtCore.QSize(min_pw_icon_size, min_pw_icon_size))
shuffleBlocksButton[:setToolTip]("Shuffle blocks")
## shuffleBlocksButton.setSizePolicy(QSizePolicy.Expanding, QSizePolicy.Expanding)
pw_buttons_sizer[:addWidget](shuffleBlocksButton, n, 2)

resetParametersButton = Qt.QPushButton("Reset")
## resetParametersButton[:clicked][:connect](onClickResetParametersButton)
## resetParametersButton.setIcon(QIcon.fromTheme("go-home", QIcon(":/go-home")))
## resetParametersButton.setIconSize(QtCore.QSize(min_pw_icon_size, min_pw_icon_size))
resetParametersButton[:setToolTip]("Reset parameters")
## resetParametersButton.setSizePolicy(QSizePolicy.Expanding, QSizePolicy.Expanding)
pw_buttons_sizer[:addWidget](resetParametersButton, n, 3)
## n = n+1
## pw_buttons_sizer.addItem(QSpacerItem(10,10,QSizePolicy.Expanding), n, 0, 1, 4)


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


## n = n+1
## #spacer
## pw_buttons_sizer.addItem(QSpacerItem(10,10,QSizePolicy.Expanding), n, 5)


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
#pw[:layout]()[:setSizeConstraint](qt_enum("SetFixedSize"))
#pw[:layout]()[:setSizeConstraint](Qt[:QLayout][:SetFixedSize])
#cw[:layout]()[:setSizeConstraint](QLayout.SetFixedSize)
pw_scrollarea = Qt.QScrollArea()
pw_scrollarea[:setWidget](pw)
splitter[:addWidget](pw_scrollarea)

screen = Qt.QDesktopWidget()[:screenGeometry]()
w[:setGeometry](80, 100, int((2/3)*screen[:width]()), int((7/10)*screen[:height]()))
splitter[:setSizes]([(2/6)*screen[:width](), (2/6)*screen[:width]()])



w[:setCentralWidget](splitter)
raise(w)

