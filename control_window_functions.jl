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

function advanced_shuffle(seq)
        ## seq = self.parseShuffleSeq(seq)
        ## try:
        ##     seq = eval(seq)
        ## except:
        ##     print('could not evaluate seq')
        ##     return

        ## x = self.check_and_shuffle(seq)

        ## return x
end

function autoSetGaugeValue()
    bp = int(prm[string("b", prm["currentBlock"])]["blockPosition"])
    pcThisRep = (bp-1)/prm["storedBlocks"]*100
    pcTot = (prm["currentRepetition"] - 1) / prm["allBlocks"]["repetitions"]*100 + 1 / prm["allBlocks"]["repetitions"]*pcThisRep
    gauge[:setValue](pcTot)
    blockGauge[:setRange](0, prm["storedBlocks"]*prm["allBlocks"]["repetitions"])

    cb = (prm["currentRepetition"]-1)*prm["storedBlocks"]+bp
    blockGauge[:setValue](cb-1)
    blockGauge[:setFormat](string(prm["rbTrans"][:translate]("rb", "Completed"), " ", cb-1, "/", prm["storedBlocks"]*prm["allBlocks"]["repetitions"], " ", prm["rbTrans"][:translate]("rb", "Blocks")))
    #self.responseBox.blockGauge.setFormat(self.prm['rbTrans'].translate('rb', "Completed") +  ' ' + str(cb-1) + '/' + str(self.prm['storedBlocks']*self.prm['allBlocks']['repetitions']) + ' ' + self.prm['rbTrans'].translate('rb', "Blocks"))
end

function check_and_shuffle(seq)
        ## if isinstance(seq, list) == True:
        ##     random.shuffle(seq)
        ## for i in range(len(seq)):
        ##     if isinstance(seq[i], list) == True or isinstance(seq[i], tuple) == True:
        ##         self.check_and_shuffle(seq[i])
        ## return seq
end
            
function close_w()
    w[:close]()
    rbw[:close]()
end

function closeEvent(self, event):
        ## #here we need to check if parameters file and temporary parameters file are the same or not
        ## self.compareGuiStoredParameters()
        ## if self.prm["storedBlocks"] > 0:
        ##     if self.parametersFile == None:
        ##         ret = QMessageBox.warning(self, self.tr("Warning"),
        ##                                         self.tr("The parameters have not been saved to a file. \n Do you want to save them before exiting?"),
        ##                                         QMessageBox.Yes | QMessageBox.No)
        ##         if ret == QMessageBox.Yes:
        ##             self.onClickSaveParametersButton()
        ##     else:
        ##         f1 = open(self.parametersFile, "r"); f2 = open(self.prm["tmpParametersFile"], "r")
        ##         l1c = f1.readlines(); l2c = f2.readlines()
        ##         f1.close(); f2.close()
        ##         l1 = []; l2 = []

        ##         for line in l1c:
        ##             if line[0:14] != "Block Position":
        ##                 l1.append(line)
        ##         for line in l2c:
        ##             if line[0:14] != "Block Position":
        ##                 l2.append(line)
        ##         if  l1 != l2:
        ##             ret = QMessageBox.warning(self, self.tr("Warning"),
        ##                                             self.tr("The parameters in memory differ from the parameters on file. \n Do you want to save the parameters stored in memory them before exiting?"),
        ##                                             QMessageBox.Yes | QMessageBox.No)
        ##             if ret == QMessageBox.Yes:
        ##                 self.onClickSaveParametersButton()
        ##     #else:
        ##     #    if os.path.exists(self.parametersFile) == True:
        ##     #        os.remove(self.parametersFile)

        ## event.accept()
end

function compareGuiStoredParameters()
        ## tmpPrm = copy.copy(self.prm)
        ## nStoredDifferent = False
        ## prmChanged = False
        
        ## if tmpPrm["currentBlock"] > tmpPrm["storedBlocks"]:
        ##     #this needs to be controlled first of all, because otherwise we may indavertently call an unstored block
        ##     nStoredDifferent = True
        ## elif self.tr(self.experimentChooser.currentText()) != self.prm["b" + str(tmpPrm["currentBlock"])]["experiment"]:
        ##     #the experiment has changed, this needs to be checked before the other things, because the keys to compare differ between different experiments
        ##     # and anyway if the experiment is different we can skip all other checks
        ##     prmChanged = True
        ## ## elif self.warningInterval.isChecked() != self.prm["b" + str(tmpPrm["currentBlock"])]["warningInterval"]:
        ## ##     prmChanged = True
        ## else:
        ##     currExp =  self.tr(self.experimentChooser.currentText())

        ##     tmpPrm["allBlocks"] = {}
        ##     tmpPrm["allBlocks"]["experimentLabel"] = self.experimentLabelTF.text()
        ##     tmpPrm["allBlocks"]["endExpCommand"] = self.endExpCommandTF.text()
        ##     tmpPrm["allBlocks"]["currentExperimenter"] = self.experimenterChooser.currentText()
        ##     tmpPrm["allBlocks"]["currentPhones"] = self.phonesChooser.currentText()
        ##     tmpPrm["allBlocks"]["maxLevel"] = float(self.prm["phones"]["phonesMaxLevel"][self.phonesChooser[:currentIndex]()])
        ##     tmpPrm["allBlocks"]["sampRate"] =  self.currLocale[:toInt](self.sampRateTF.text())[0]
        ##     tmpPrm["allBlocks"]["nBits"] = self.currLocale[:toInt](self.nBitsChooser.currentText())[0]
        ##     tmpPrm["allBlocks"]["responseMode"] = self.responseModeChooser.currentText()
        ##     tmpPrm["allBlocks"]["autoPCCorr"] = self.currLocale.toDouble(self.autoPCorrTF.text())[0]/100
        ##     tmpPrm["allBlocks"]["sendTriggers"] = self.triggerCheckBox.isChecked()
        ##     tmpPrm["allBlocks"]["shuffleMode"] = self.shuffleChooser.currentText()
        ##     tmpPrm["allBlocks"]["repetitions"] =  self.currLocale[:toInt](self.repetitionsTF.text())[0]
        ##     tmpPrm["allBlocks"]["procRes"] = self.procResCheckBox.isChecked()
        ##     tmpPrm["allBlocks"]["procResTable"] = self.procResTableCheckBox.isChecked()
        ##     tmpPrm["allBlocks"]["winPlot"] = self.winPlotCheckBox.isChecked()
        ##     tmpPrm["allBlocks"]["pdfPlot"] = self.pdfPlotCheckBox.isChecked()
            


        ##     currParadigm = self.tr(self.paradigmChooser.currentText())
        ##     currBlock = "b" + str(tmpPrm["currentBlock"])
        ##     tmpPrm[currBlock] = {}
        ##     tmpPrm[currBlock]["conditionLabel"] = self.conditionLabelTF.text()
        ##     tmpPrm[currBlock]["experiment"] = currExp
        ##     tmpPrm[currBlock]["paradigm"] = currParadigm
        ##     tmpPrm[currBlock]["field"] = list(range(tmpPrm["nFields"]))
        ##     tmpPrm[currBlock]["fieldCheckBox"] = list(range(tmpPrm["nFields"]))
        ##     tmpPrm[currBlock]["chooser"] = list(range(tmpPrm["nChoosers"]))
        ##     tmpPrm[currBlock]["chooserCheckBox"] = list(range(tmpPrm["nChoosers"]))
        ##     tmpPrm[currBlock]["fileChooser"] = list(range(tmpPrm["nFileChoosers"]))
        ##     tmpPrm[currBlock]["fileChooserCheckBox"] = list(range(tmpPrm["nFileChoosers"]))
        ##     tmpPrm[currBlock]["paradigmChooser"] = []
        ##     tmpPrm[currBlock]["paradigmField"] = []
        ##     tmpPrm[currBlock]["paradigmChooserCheckBox"] = []
        ##     tmpPrm[currBlock]["paradigmFieldCheckBox"] = []
         

        ##     otherKeysToCompare = ["preTrialSilence", "intervalLights", "responseLight", "responseLightDuration", "conditionLabel", "warningInterval", "warningIntervalDur", "warningIntervalISI"]
        
        ##     tmpPrm[currBlock]["preTrialSilence"] = self.currLocale[:toInt](self.preTrialSilenceTF.text())[0]
        ##     tmpPrm[currBlock]["intervalLights"] = self.intervalLightsChooser.currentText()
        ##     tmpPrm[currBlock]["warningInterval"] = self.warningIntervalChooser.currentText()
        ##     tmpPrm[currBlock]["warningIntervalDur"] = self.currLocale[:toInt](self.warningIntervalDurTF.text())[0]
        ##     tmpPrm[currBlock]["warningIntervalISI"] = self.currLocale[:toInt](self.warningIntervalISITF.text())[0]
        ##     tmpPrm[currBlock]["responseLight"] = self.responseLightChooser.currentText()
        ##     tmpPrm[currBlock]["responseLightCheckBox"] = self.responseLightCheckBox.isChecked()
        ##     tmpPrm[currBlock]["responseLightDuration"] = self.currLocale[:toInt](self.responseLightDurationTF.text())[0]
        ##     tmpPrm[currBlock]["responseLightDurationCheckBox"] = self.responseLightDurationCheckBox.isChecked()
        
        ##     if tmpPrm[currExp]["hasISIBox"] == True:
        ##         tmpPrm[currBlock]["ISIVal"] = self.currLocale[:toInt](self.ISIBox.text())[0]
        ##         tmpPrm[currBlock]["ISIValCheckBox"] = self.ISIBoxCheckBox.isChecked()
        ##         otherKeysToCompare.append("ISIVal")
        ##     if tmpPrm[currExp]["hasPreTrialInterval"] == True:
        ##         tmpPrm[currBlock]["preTrialInterval"] = self.preTrialIntervalChooser.currentText()
        ##         tmpPrm[currBlock]["preTrialIntervalCheckBox"] = self.preTrialIntervalCheckBox.isChecked()
        ##         otherKeysToCompare.append("preTrialInterval")
        ##         tmpPrm[currBlock]["preTrialIntervalISI"] = self.currLocale[:toInt](self.preTrialIntervalISITF.text())[0]
        ##         tmpPrm[currBlock]["preTrialIntervalISICheckBox"] = self.preTrialIntervalISICheckBox.isChecked()
        ##         otherKeysToCompare.append("preTrialIntervalISI")
        ##     if tmpPrm[currExp]["hasPrecursorInterval"] == True:
        ##         tmpPrm[currBlock]["precursorInterval"] = self.precursorIntervalChooser.currentText()
        ##         tmpPrm[currBlock]["precursorIntervalCheckBox"] = self.precursorIntervalCheckBox.isChecked()
        ##         otherKeysToCompare.append("precursorInterval")
        ##         tmpPrm[currBlock]["precursorIntervalISI"] = self.currLocale[:toInt](self.precursorIntervalISITF.text())[0]
        ##         tmpPrm[currBlock]["precursorIntervalISICheckBox"] = self.precursorIntervalISICheckBox.isChecked()
        ##         otherKeysToCompare.append("precursorIntervalISI")
        ##     if tmpPrm[currExp]["hasPostcursorInterval"] == True:
        ##         tmpPrm[currBlock]["postcursorInterval"] = self.postcursorIntervalChooser.currentText()
        ##         tmpPrm[currBlock]["postcursorIntervalCheckBox"] = self.postcursorIntervalCheckBox.isChecked()
        ##         otherKeysToCompare.append("postcursorInterval")
        ##         tmpPrm[currBlock]["postcursorIntervalISI"] = self.currLocale[:toInt](self.postcursorIntervalISITF.text())[0]
        ##         tmpPrm[currBlock]["postcursorIntervalISICheckBox"] = self.postcursorIntervalISICheckBox.isChecked()
        ##         otherKeysToCompare.append("postcursorIntervalISI")
        ##     if tmpPrm[currExp]["hasAlternativesChooser"] == True:
        ##         tmpPrm[currBlock]["nIntervals"] = self.currLocale[:toInt](self.nIntervalsChooser.currentText())[0]
        ##         tmpPrm[currBlock]["nIntervalsCheckBox"] = self.nIntervalsCheckBox.isChecked()
        ##         tmpPrm[currBlock]["nAlternatives"] = self.currLocale[:toInt](self.nAlternativesChooser.currentText())[0]
        ##         tmpPrm[currBlock]["nAlternativesCheckBox"] = self.nAlternativesCheckBox.isChecked()
        ##         otherKeysToCompare.extend(["nIntervals", "nAlternatives"])
        ##     if tmpPrm[currExp]["hasAltReps"] == True:
        ##         tmpPrm[currBlock]["altReps"] = self.currLocale[:toInt](self.altRepsBox.text())[0]
        ##         tmpPrm[currBlock]["altRepsCheckBox"] = self.altRepsBoxCheckBox.isChecked()
        ##         tmpPrm[currBlock]["altRepsISI"] = self.currLocale[:toInt](self.altRepsISIBox.text())[0]
        ##         tmpPrm[currBlock]["altRepsISICheckBox"] = self.altRepsISIBoxCheckBox.isChecked()
          

        ##     for f in range(tmpPrm["nFields"]):
        ##         tmpPrm[currBlock]["field"][f] = self.currLocale.toDouble(self.field[f].text())[0]
        ##         tmpPrm[currBlock]["fieldCheckBox"][f] = self.fieldCheckBox[f].isChecked()
            
        ##     for c in range(tmpPrm["nChoosers"]):
        ##         tmpPrm[currBlock]["chooser"][c] =  self.chooserOptions[c][self.chooser[c][:currentIndex]()]
        ##         tmpPrm[currBlock]["chooserCheckBox"][c] =  self.chooserCheckBox[c].isChecked()

        ##     for f in range(tmpPrm["nFileChoosers"]):
        ##         tmpPrm[currBlock]["fileChooser"][f] = self.fileChooser[f].text()
        ##         tmpPrm[currBlock]["fileChooserCheckBox"][f] = self.fileChooserCheckBox[f].isChecked()
            
        ##     for i in range(len(self.paradigmFieldList)):
        ##         tmpPrm[currBlock]["paradigmField"].append(self.currLocale.toDouble(self.paradigmFieldList[i].text())[0])
        ##         tmpPrm[currBlock]["paradigmFieldCheckBox"].append(self.paradigmFieldCheckBoxList[i].isChecked())

        ##     for i in range(len(self.paradigmChooserList)):
        ##         tmpPrm[currBlock]["paradigmChooser"].append(self.paradigmChooserOptionsList[i][self.paradigmChooserList[i][:currentIndex]()])
        ##         tmpPrm[currBlock]["paradigmChooserCheckBox"].append(self.paradigmChooserCheckBoxList[i].isChecked())


        ##     i = tmpPrm["currentBlock"] -1
        ##     if tmpPrm["b"+str(i+1)]["field"] != self.prm["b"+str(i+1)]["field"]:
        ##         prmChanged = True
        ##     if tmpPrm["b"+str(i+1)]["chooser"] != self.prm["b"+str(i+1)]["chooser"]:
        ##         prmChanged = True
        ##     if tmpPrm["b"+str(i+1)]["fileChooser"] != self.prm["b"+str(i+1)]["fileChooser"]:
        ##         prmChanged = True
        ##     if tmpPrm["b"+str(i+1)]["fieldCheckBox"] != self.prm["b"+str(i+1)]["fieldCheckBox"]:
        ##         prmChanged = True
        ##     if tmpPrm["b"+str(i+1)]["chooserCheckBox"] != self.prm["b"+str(i+1)]["chooserCheckBox"]:
        ##         prmChanged = True
        ##     if tmpPrm["b"+str(i+1)]["fileChooserCheckBox"] != self.prm["b"+str(i+1)]["fileChooserCheckBox"]:
        ##         prmChanged = True
        ##     if tmpPrm["b"+str(i+1)]["paradigmField"] != self.prm["b"+str(i+1)]["paradigmField"]:
        ##         prmChanged = True
        ##     if tmpPrm["b"+str(i+1)]["paradigmFieldCheckBox"] != self.prm["b"+str(i+1)]["paradigmFieldCheckBox"]:
        ##         prmChanged = True
        ##     if tmpPrm["b"+str(i+1)]["paradigmChooser"] != self.prm["b"+str(i+1)]["paradigmChooser"]:
        ##         prmChanged = True
        ##     if tmpPrm["b"+str(i+1)]["paradigmChooserCheckBox"] != self.prm["b"+str(i+1)]["paradigmChooserCheckBox"]:
        ##         prmChanged = True

        ##     for j in range(len(otherKeysToCompare)):
        ##         thisKey = otherKeysToCompare[j]
        ##         if tmpPrm["b"+str(i+1)][otherKeysToCompare[j]] != self.prm["b"+str(i+1)][thisKey]:
        ##             prmChanged = True
        ##         if thisKey not in ["conditionLabel", "preTrialSilence", "warningInterval", #these ones don"t have check boxes
        ##                            "warningIntervalDur", "warningIntervalISI", "intervalLights"]:
        ##             if tmpPrm["b"+str(i+1)][otherKeysToCompare[j]+"CheckBox"] != self.prm["b"+str(i+1)][thisKey+"CheckBox"]:
        ##                 prmChanged = True

        ##     for key in tmpPrm["allBlocks"]:
        ##         if tmpPrm["allBlocks"][key] != self.prm["allBlocks"][key]:
        ##             prmChanged = True

                
        ## if nStoredDifferent == True:
        ##     ret = QMessageBox.warning(self, self.tr("Warning"),
        ##                                     self.tr("Last block has not been stored. Do you want to store it?"),
        ##                                     QMessageBox.Yes | QMessageBox.No)
        ##     if ret == QMessageBox.Yes:
        ##         self.onClickStoreParametersButton()
        ## elif prmChanged == True:
           
        ##     ret = QMessageBox.warning(self, self.tr("Warning"),
        ##                                     self.tr("Some parameters have been modified but not stored. Do you want to store them?"),
        ##                                     QMessageBox.Yes | QMessageBox.No)
        ##     if ret == QMessageBox.Yes:
        ##         self.onClickStoreParametersButton()
end

function fileChooserButtonClicked()
        ## sender = self.sender()
        ## fName = QFileDialog.getOpenFileName(self, self.tr("Choose file"), "", self.tr("file;;All Files (*)"))[0]
        ## lbls = []
 
        ## if len(fName) > 0: #if the user didn"t press cancel
        ##     for i in range(self.prm["nFileChoosers"]):
        ##         lbls.append(self.fileChooserButton[i].text())
        ##     self.fileChooser[lbls.index(sender.text())].setText(fName)
        ## #print(sender.text())
end
            
function loadParameters(fName)
        ## self.parametersFile = fName
        ## self.prm["shuffled"] = False
        ## self.prm["currentRepetition"] = 1
        ## fStream = open(fName, "r")
        ## allLines = fStream.readlines()
        ## fStream.close()
        ## tmp = {}
        ## foo = {}
        ## blockNumber = 0
        ## for i in range(len(allLines)):
        ##     if allLines[i].split(":")[0] == "Phones":
        ##         phonesToSelect = allLines[i].split(":")[1].strip()
        ##         try:
        ##             self.phonesChooser.setCurrentIndex(self.prm["phones"]["phonesChoices"].index(phonesToSelect))
        ##         except:
        ##             errMsg = self.tr("Phones stored in prm file {} not found in database\n Leaving phones chooser untouched".format(phonesToSelect))
        ##             print(errMsg, file=sys.stderr)
        ##             QMessageBox.warning(self, self.tr("Warning"), errMsg)
        ##     elif allLines[i].split(":")[0] == "Shuffle Mode":
        ##         shuffleMode = allLines[i].split(":")[1].strip()
        ##         self.shuffleChooser.setCurrentIndex(self.prm["shuffleChoices"].index(shuffleMode))
        ##     elif allLines[i].split(":")[0] == "Response Mode":
        ##         responseMode = allLines[i].split(":")[1].strip()
        ##         self.responseModeChooser.setCurrentIndex(self.prm["responseModeChoices"].index(responseMode))
        ##     elif allLines[i].split(":")[0] == "Auto Resp. Mode Perc. Corr.":
        ##         autoRespPercCorr = allLines[i].split(":")[1].strip()
        ##         self.autoPCorrTF.setText(autoRespPercCorr)
        ##     elif allLines[i].split(":")[0] == "Sample Rate":
        ##         sampRateToSet = allLines[i].split(":")[1].strip()
        ##         self.sampRateTF.setText(sampRateToSet)
        ##     elif allLines[i].split(":")[0] == "No. Repetitions":
        ##         repetitionsToSet = allLines[i].split(":")[1].strip()
        ##         self.repetitionsTF.setText(repetitionsToSet)
        ##     elif allLines[i].split(":")[0] == "Bits":
        ##         bitsToSet = allLines[i].split(":")[1].strip()
        ##         self.nBitsChooser.setCurrentIndex(self.prm["nBitsChoices"].index(bitsToSet))
        ##     elif allLines[i].split(":")[0] == "Experiment Label":
        ##         experimentLabelToSet = allLines[i].split(":")[1].strip()
        ##         self.experimentLabelTF.setText(experimentLabelToSet)
        ##     elif allLines[i].split(":")[0] == "End Command":
        ##         endExpCommandToSet = allLines[i].split(":")[1].strip()
        ##         self.endExpCommandTF.setText(endExpCommandToSet)
        ##     elif allLines[i].split(":")[0] == "Shuffling Scheme":
        ##         shufflingSchemeToSet = allLines[i].split(":")[1].strip()
        ##         self.shufflingSchemeTF.setText(shufflingSchemeToSet)
        ##     elif allLines[i].split(":")[0] == "Trigger On/Off":
        ##         triggerOnOff = allLines[i].split(":")[1].strip()
        ##         if triggerOnOff == "True":
        ##             self.triggerCheckBox.setChecked(True)
        ##         else:
        ##             self.triggerCheckBox.setChecked(False)
        ##     elif allLines[i].split(":")[0] == "Proc. Res.":
        ##         procResOnOff = allLines[i].split(":")[1].strip()
        ##         if procResOnOff == "True":
        ##             self.procResCheckBox.setChecked(True)
        ##         else:
        ##             self.procResCheckBox.setChecked(False)
        ##     elif allLines[i].split(":")[0] == "Proc. Res. Table":
        ##         procResTableOnOff = allLines[i].split(":")[1].strip()
        ##         if procResTableOnOff == "True":
        ##             self.procResTableCheckBox.setChecked(True)
        ##         else:
        ##             self.procResTableCheckBox.setChecked(False)
        ##     elif allLines[i].split(":")[0] == "Plot":
        ##         winPlotOnOff = allLines[i].split(":")[1].strip()
        ##         ## if self.prm["appData"]["plotting_available"] == False:
        ##         ##      winPlotOnOff = "False"
        ##         if winPlotOnOff == "True":
        ##             self.winPlotCheckBox.setChecked(True)
        ##         else:
        ##             self.winPlotCheckBox.setChecked(False)
        ##     elif allLines[i].split(":")[0] == "PDF Plot":
        ##         pdfPlotOnOff = allLines[i].split(":")[1].strip()
        ##         ## if self.prm["appData"]["plotting_available"] == False:
        ##         ##      pdfPlotOnOff = "False"
        ##         if pdfPlotOnOff == "True":
        ##             self.pdfPlotCheckBox.setChecked(True)
        ##         else:
        ##             self.pdfPlotCheckBox.setChecked(False)
        ##     if allLines[i] == "*******************************************************\n":
        ##         startBlock = True
        ##         blockNumber = blockNumber + 1
        ##         currBlock = "b"+str(blockNumber)
        ##         tmp["b"+str(blockNumber)] = {}
        ##         foo["b"+str(blockNumber)] = {}

        ##         #assign some default values to be overwritten if present in file
        ##         tmp["b"+str(blockNumber)]["warningIntervalDur"] = 500
        ##         tmp["b"+str(blockNumber)]["warningIntervalISI"] = 500
        ##         tmp["b"+str(blockNumber)]["preTrialIntervalISI"] = 500
        ##         tmp["b"+str(blockNumber)]["preTrialIntervalISICheckBox"] = False
        ##         tmp["b"+str(blockNumber)]["precursorIntervalISI"] = 500
        ##         tmp["b"+str(blockNumber)]["precursorIntervalISICheckBox"] = False
        ##         tmp["b"+str(blockNumber)]["postcursorIntervalISI"] = 500
        ##         tmp["b"+str(blockNumber)]["postcursorIntervalISICheckBox"] = False
                
        ##     if allLines[i].split(":")[0] == "Block Position":
        ##         tmp["b"+str(blockNumber)]["blockPosition"] = allLines[i].split(":")[1].strip()
        ##     if allLines[i].split(":")[0] == "Condition Label":
        ##         tmp["b"+str(blockNumber)]["conditionLabel"] = allLines[i].split(":")[1].strip()
        ##     if allLines[i].split(":")[0] == "Experiment":
        ##         tmp["b"+str(blockNumber)]["experiment"] = allLines[i].split(":")[1].strip()
        ##     if allLines[i].split(":")[0] == "Paradigm":
        ##         tmp["b"+str(blockNumber)]["paradigm"] = allLines[i].split(":")[1].strip()
        ##     if allLines[i].split(":")[0] == "Alternatives":
        ##         tmp["b"+str(blockNumber)]["nAlternatives"] = self.currLocale[:toInt](allLines[i].split(":")[1].strip())[0]
        ##         tmp["b"+str(blockNumber)]["nAlternativesCheckBox"] = strToBoolean(allLines[i].split(":")[2].strip())
        ##     if allLines[i].split(":")[0] == "Intervals":
        ##         tmp["b"+str(blockNumber)]["nIntervals"] = self.currLocale[:toInt](allLines[i].split(":")[1].strip())[0]
        ##         tmp["b"+str(blockNumber)]["nIntervalsCheckBox"] = strToBoolean(allLines[i].split(":")[2].strip())
        ##     if allLines[i].split(":")[0] == "Pre-Trial Silence (ms)":
        ##         tmp["b"+str(blockNumber)]["preTrialSilence"] = self.currLocale[:toInt](allLines[i].split(":")[1].strip())[0]
        ##     if allLines[i].split(":")[0] == "Interval Lights":
        ##         tmp["b"+str(blockNumber)]["intervalLights"] = allLines[i].split(":")[1].strip()
        ##     if allLines[i].split(":")[0] == "Warning Interval":
        ##          tmp["b"+str(blockNumber)]["warningInterval"] = allLines[i].split(":")[1].strip()#strToBoolean(allLines[i].split(":")[1].strip())
        ##     if allLines[i].split(":")[0] == "Warning Interval Duration (ms)":
        ##         tmp["b"+str(blockNumber)]["warningIntervalDur"] = self.currLocale[:toInt](allLines[i].split(":")[1].strip())[0]
        ##     if allLines[i].split(":")[0] == "Warning Interval ISI (ms)":
        ##         tmp["b"+str(blockNumber)]["warningIntervalISI"] = self.currLocale[:toInt](allLines[i].split(":")[1].strip())[0]
        ##     if allLines[i].split(":")[0] == "ISI (ms)":
        ##         tmp["b"+str(blockNumber)]["ISIVal"] = self.currLocale[:toInt](allLines[i].split(":")[1].strip())[0]
        ##         tmp["b"+str(blockNumber)]["ISIValCheckBox"] = strToBoolean(allLines[i].split(":")[2].strip())
        ##     if allLines[i].split(":")[0] == "Pre-Trial Interval":
        ##         tmp["b"+str(blockNumber)]["preTrialInterval"] = allLines[i].split(":")[1].strip()
        ##         tmp["b"+str(blockNumber)]["preTrialIntervalCheckBox"] = strToBoolean(allLines[i].split(":")[2].strip())
        ##     if allLines[i].split(":")[0] == "Pre-Trial Interval ISI (ms)":
        ##         tmp["b"+str(blockNumber)]["preTrialIntervalISI"] = self.currLocale[:toInt](allLines[i].split(":")[1].strip())[0]
        ##         tmp["b"+str(blockNumber)]["preTrialIntervalISICheckBox"] = strToBoolean(allLines[i].split(":")[2].strip())
        ##     if allLines[i].split(":")[0] == "Precursor Interval":
        ##         tmp["b"+str(blockNumber)]["precursorInterval"] = allLines[i].split(":")[1].strip()
        ##         tmp["b"+str(blockNumber)]["precursorIntervalCheckBox"] = strToBoolean(allLines[i].split(":")[2].strip())
        ##     if allLines[i].split(":")[0] == "Precursor Interval ISI (ms)":
        ##         tmp["b"+str(blockNumber)]["precursorIntervalISI"] = self.currLocale[:toInt](allLines[i].split(":")[1].strip())[0]
        ##         tmp["b"+str(blockNumber)]["precursorIntervalISICheckBox"] = strToBoolean(allLines[i].split(":")[2].strip())
        ##     if allLines[i].split(":")[0] == "Postcursor Interval":
        ##         tmp["b"+str(blockNumber)]["postcursorInterval"] = allLines[i].split(":")[1].strip()
        ##         tmp["b"+str(blockNumber)]["postcursorIntervalCheckBox"] = strToBoolean(allLines[i].split(":")[2].strip())
        ##     if allLines[i].split(":")[0] == "Postcursor Interval ISI (ms)":
        ##         tmp["b"+str(blockNumber)]["postcursorIntervalISI"] = self.currLocale[:toInt](allLines[i].split(":")[1].strip())[0]
        ##         tmp["b"+str(blockNumber)]["postcursorIntervalISICheckBox"] = strToBoolean(allLines[i].split(":")[2].strip())
        ##     if allLines[i].split(":")[0] == "Alternated (AB) Reps.":
        ##         tmp["b"+str(blockNumber)]["altReps"] = self.currLocale[:toInt](allLines[i].split(":")[1].strip())[0]
        ##         tmp["b"+str(blockNumber)]["altRepsCheckBox"] = strToBoolean(allLines[i].split(":")[2].strip())
        ##     if allLines[i].split(":")[0] == "Alternated (AB) Reps. ISI (ms)":
        ##         tmp["b"+str(blockNumber)]["altRepsISI"] = self.currLocale[:toInt](allLines[i].split(":")[1].strip())[0]
        ##         tmp["b"+str(blockNumber)]["altRepsISICheckBox"] = strToBoolean(allLines[i].split(":")[2].strip())
        ##     if allLines[i].split(":")[0] == "Response Light":
        ##         tmp["b"+str(blockNumber)]["responseLight"] = allLines[i].split(":")[1].strip()
        ##         tmp["b"+str(blockNumber)]["responseLightCheckBox"] = strToBoolean(allLines[i].split(":")[2].strip())
        ##     if allLines[i].split(":")[0] == "Response Light Duration (ms)":
        ##         tmp["b"+str(blockNumber)]["responseLightDuration"] = self.currLocale[:toInt](allLines[i].split(":")[1].strip())[0]
        ##         tmp["b"+str(blockNumber)]["responseLightDurationCheckBox"] = strToBoolean(allLines[i].split(":")[2].strip())
        ##     if allLines[i].strip() == ".":
        ##         foo["b"+str(blockNumber)]["startParadigmChooser"] = i+1
        ##     if allLines[i].strip() == "..":
        ##         foo["b"+str(blockNumber)]["startParadigmField"] = i+1
        ##     if allLines[i].strip() == "...":
        ##         foo["b"+str(blockNumber)]["startChooser"] = i+1
        ##     if allLines[i].strip() == "....":
        ##         foo["b"+str(blockNumber)]["startFileChooser"] = i+1
        ##     if allLines[i].strip() == ".....":
        ##         foo["b"+str(blockNumber)]["startField"] = i+1
        ##     if allLines[i] == ("+++++++++++++++++++++++++++++++++++++++++++++++++++++++\n"):
        ##         foo["b"+str(blockNumber)]["endField"] = i

        ## nBlocks = blockNumber
        ## for j in range(blockNumber):
        ##     blockNumber = j+1
        ##     tmp["b"+str(blockNumber)]["paradigmChooser"] = []
        ##     tmp["b"+str(blockNumber)]["paradigmChooserCheckBox"] = []
        ##     tmp["b"+str(blockNumber)]["paradigmChooserLabel"] = []
        ##     tmp["b"+str(blockNumber)]["paradigmField"] = []
        ##     tmp["b"+str(blockNumber)]["paradigmFieldLabel"] = []
        ##     tmp["b"+str(blockNumber)]["paradigmFieldCheckBox"] = []
        ##     tmp["b"+str(blockNumber)]["chooser"] = []
        ##     tmp["b"+str(blockNumber)]["chooserLabel"] = []
        ##     tmp["b"+str(blockNumber)]["chooserCheckBox"] = []
        ##     tmp["b"+str(blockNumber)]["field"] = []
        ##     tmp["b"+str(blockNumber)]["fieldCheckBox"] = []
        ##     tmp["b"+str(blockNumber)]["fieldLabel"] = []
        ##     tmp["b"+str(blockNumber)]["fileChooser"] = []
        ##     tmp["b"+str(blockNumber)]["fileChooserCheckBox"] = []
        ##     tmp["b"+str(blockNumber)]["fileChooserButton"] = []
        ##     for i in range(foo["b"+str(blockNumber)]["startParadigmField"] - foo["b"+str(blockNumber)]["startParadigmChooser"] -1):
        ##         tmp["b"+str(blockNumber)]["paradigmChooser"].append(allLines[foo["b"+str(blockNumber)]["startParadigmChooser"]+i].split(":")[1].strip())
        ##         tmp["b"+str(blockNumber)]["paradigmChooserLabel"].append(allLines[foo["b"+str(blockNumber)]["startParadigmChooser"]+i].split(":")[0].strip()+":")
        ##         tmp["b"+str(blockNumber)]["paradigmChooserCheckBox"].append(strToBoolean(allLines[foo["b"+str(blockNumber)]["startParadigmChooser"]+i].split(":")[2].strip()))

        ##     for i in range(foo["b"+str(blockNumber)]["startChooser"] - foo["b"+str(blockNumber)]["startParadigmField"] -1):
        ##         tmp["b"+str(blockNumber)]["paradigmField"].append(self.currLocale.toDouble(allLines[foo["b"+str(blockNumber)]["startParadigmField"]+i].split(":")[1].strip())[0])
        ##         tmp["b"+str(blockNumber)]["paradigmFieldLabel"].append(allLines[foo["b"+str(blockNumber)]["startParadigmField"]+i].split(":")[0].strip())
        ##         tmp["b"+str(blockNumber)]["paradigmFieldCheckBox"].append(strToBoolean(allLines[foo["b"+str(blockNumber)]["startParadigmField"]+i].split(":")[2].strip()))

        ##     for i in range(foo["b"+str(blockNumber)]["startFileChooser"] - foo["b"+str(blockNumber)]["startChooser"] -1):
        ##         tmp["b"+str(blockNumber)]["chooser"].append(allLines[foo["b"+str(blockNumber)]["startChooser"]+i].split(":")[1].strip())
        ##         tmp["b"+str(blockNumber)]["chooserLabel"].append(allLines[foo["b"+str(blockNumber)]["startChooser"]+i].split(":")[0].strip()+":")
        ##         tmp["b"+str(blockNumber)]["chooserCheckBox"].append(strToBoolean(allLines[foo["b"+str(blockNumber)]["startChooser"]+i].split(":")[2].strip()))

        ##     for i in range(foo["b"+str(blockNumber)]["startField"] - foo["b"+str(blockNumber)]["startFileChooser"] -1):
        ##         tmp["b"+str(blockNumber)]["fileChooser"].append(allLines[foo["b"+str(blockNumber)]["startFileChooser"]+i].split(":")[1].strip())
        ##         tmp["b"+str(blockNumber)]["fileChooserButton"].append(allLines[foo["b"+str(blockNumber)]["startFileChooser"]+i].split(":")[0].strip()+":")
        ##         tmp["b"+str(blockNumber)]["fileChooserCheckBox"].append(strToBoolean(allLines[foo["b"+str(blockNumber)]["startFileChooser"]+i].split(":")[2].strip()))

        ##     for i in range(foo["b"+str(blockNumber)]["endField"] - foo["b"+str(blockNumber)]["startField"] ):
        ##         tmp["b"+str(blockNumber)]["field"].append(self.currLocale.toDouble(allLines[foo["b"+str(blockNumber)]["startField"]+i].split(":")[1].strip())[0])
        ##         tmp["b"+str(blockNumber)]["fieldLabel"].append(allLines[foo["b"+str(blockNumber)]["startField"]+i].split(":")[0].strip())
        ##         tmp["b"+str(blockNumber)]["fieldCheckBox"].append(strToBoolean(allLines[foo["b"+str(blockNumber)]["startField"]+i].split(":")[2].strip()))


              
                    
        ## for i in range(self.prm["storedBlocks"]):
        ##     del self.prm["b"+str(i+1)]
        ## for i in range(nBlocks):
        ##     self.prm["b"+str(i+1)] = tmp["b"+str(i+1)]
        ## self.prm["storedBlocks"] = nBlocks

        ## self.prm["allBlocks"] = {}
        ## self.prm["allBlocks"]["experimentLabel"] = self.experimentLabelTF.text()
        ## self.prm["allBlocks"]["endExpCommand"] = self.endExpCommandTF.text()
        ## self.prm["allBlocks"]["currentExperimenter"] = self.experimenterChooser.currentText()
        ## self.prm["allBlocks"]["currentPhones"] = self.phonesChooser.currentText()
        ## self.prm["allBlocks"]["maxLevel"] = float(self.prm["phones"]["phonesMaxLevel"][self.phonesChooser[:currentIndex]()])
        ## self.prm["allBlocks"]["sampRate"] =  self.currLocale[:toInt](self.sampRateTF.text())[0]
        ## self.prm["allBlocks"]["nBits"] = self.currLocale[:toInt](self.nBitsChooser.currentText())[0]
        ## self.prm["allBlocks"]["responseMode"] = self.responseModeChooser.currentText()
        ## self.prm["allBlocks"]["autoPCCorr"] = self.currLocale.toDouble(self.autoPCorrTF.text())[0]/100
        ## self.prm["allBlocks"]["sendTriggers"] = self.triggerCheckBox.isChecked()
        ## self.prm["allBlocks"]["shuffleMode"] = self.shuffleChooser.currentText()
        ## self.prm["allBlocks"]["repetitions"] =  self.currLocale[:toInt](self.repetitionsTF.text())[0]
        ## self.prm["allBlocks"]["procRes"] = self.procResCheckBox.isChecked()
        ## self.prm["allBlocks"]["procResTable"] = self.procResTableCheckBox.isChecked()
        ## self.prm["allBlocks"]["winPlot"] = self.winPlotCheckBox.isChecked()
        ## self.prm["allBlocks"]["pdfPlot"] = self.pdfPlotCheckBox.isChecked()
        ## #self.prm["allBlocks"]["listener"] = self.listenerTF.text()
        ## #self.prm["allBlocks"]["sessionLabel"] = self.sessionLabelTF.text()

        ## self.moveToBlockPosition(1)
        ## self.updateParametersWin()
        ## #for the moment here, but maybe should have a function for updating all possible dynamic default control widgets
        ## self.onResponseModeChange(responseMode)
        ## self.autoSetGaugeValue()
        ## self.responseBox.statusButton.setText(self.prm["rbTrans"].translate("rb", "Start"))
        ## self.saveParametersToFile(self.prm["tmpParametersFile"])
        ## self.audioManager.initializeAudio()
end

function moveNextBlock()
    if prm["storedBlocks"] > 0
        lastBlock = string("b", prm["currentBlock"])
        if prm["currentBlock"] >= prm["storedBlocks"]
            prm["currentBlock"] = 1
            lastBlock = string("b", prm["storedBlocks"])
        else
            prm["currentBlock"] = prm["currentBlock"] +1
        end
        if prm["storedBlocks"] > 0
            statusButton[:setText](prm["rbTrans"][:translate]("rb", "Start"))
        end
        updateParametersWin()
        autoSetGaugeValue()
    end
end

function moveToBlockPosition(position)
    if prm["storedBlocks"] < 1
        return
    end
    if position > prm["storedBlocks"]
        position = 1
    elseif position < 1
        position = prm["storedBlocks"]
    end
    
    for k=1:prm["storedBlocks"]
        if prm[string("b", k+1)]["blockPosition"] == string(position)
            blockNumber = k+1
        end
    end
                
    prm["currentBlock"] = blockNumber
    prm["tmpBlockPosition"] = prm[string("b", prm["currentBlock"])]["blockPosition"]
    setNewBlock(string("b", prm["currentBlock"]))
    if prm["storedBlocks"] > 0
        statusButton[:setText](prm["rbTrans"][:translate]("rb", "Start"))
        autoSetGaugeValue()
    end
end


function onAbout()
        ## if pyqtversion in [4, 5]:
        ##     QMessageBox.about(self, self.tr("About pychoacoustics"),
        ##                       self.tr("""<b>Python app for psychoacoustics</b> <br>
        ##                       - version: {0}; <br>
        ##                       - build date: {1} <br>
        ##                       <p> Copyright &copy; 2010-2013 Samuele Carcagno. <a href="mailto:sam.carcagno@gmail.com">sam.carcagno@gmail.com</a> 
        ##                       All rights reserved. <p>
        ##                       This program is free software: you can redistribute it and/or modify
        ##                       it under the terms of the GNU General Public License as published by
        ##                       the Free Software Foundation, either version 3 of the License, or
        ##                       (at your option) any later version.
        ##                       <p>
        ##                       This program is distributed in the hope that it will be useful,
        ##                       but WITHOUT ANY WARRANTY; without even the implied warranty of
        ##                       MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
        ##                       GNU General Public License for more details.
        ##                       <p>
        ##                       You should have received a copy of the GNU General Public License
        ##                       along with this program.  If not, see <a href="http://www.gnu.org/licenses/">http://www.gnu.org/licenses/</a>
        ##                       <p>Python {2} - Qt {3} - PyQt {4} on {5}""").format(__version__, self.prm["builddate"], platform.python_version(), QtCore.QT_VERSION_STR, QtCore.PYQT_VERSION_STR, platform.system()))
        ## elif pyqtversion in [-4]:
        ##     QMessageBox.about(self, self.tr("About pychoacoustics"),
        ##                       self.tr("""<b>Python app for psychoacoustics</b> <br>
        ##                       - version: {0}; <br>
        ##                       - build date: {1} <br>
        ##                       <p> Copyright &copy; 2010-2014 Samuele Carcagno. <a href="mailto:sam.carcagno@gmail.com">sam.carcagno@gmail.com</a> 
        ##                       All rights reserved. <p>
        ##                       This program is free software: you can redistribute it and/or modify
        ##                       it under the terms of the GNU General Public License as published by
        ##                       the Free Software Foundation, either version 3 of the License, or
        ##                       (at your option) any later version.
        ##                       <p>
        ##                       This program is distributed in the hope that it will be useful,
        ##                       but WITHOUT ANY WARRANTY; without even the implied warranty of
        ##                       MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
        ##                       GNU General Public License for more details.
        ##                       <p>
        ##                       You should have received a copy of the GNU General Public License
        ##                       along with this program.  If not, see <a href="http://www.gnu.org/licenses/">http://www.gnu.org/licenses/</a>
        ##                       <p>Python {2} - Qt {3} - PySide {4} on {5}""").format(__version__, self.prm["builddate"], platform.python_version(), PySide.QtCore.__version__, PySide.__version__, platform.system()))
end            

function onChangeNDifferences()
    ## nDifferences = prm["currentLocale"][:toInt](nDifferencesChooser[:currentText]())[1]
    ## removePrmWidgets()
    ## par["nDifferences"] = nDifferences
    ## setDefaultParameters(prm["currExp"], prm["currParadigm"], par)
end

function onChangeNTracks()
    ## nTracks = self.currLocale[:toInt](self.nTracksChooser.currentText())[0]
    ## self.removePrmWidgets()
    ## self.par["nDifferences"] = nTracks
    ## self.setDefaultParameters(self.currExp, self.currParadigm, self.par)
end

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


function onClickNextBlockButton()
    compareGuiStoredParameters()
    moveNextBlock()
end

function onClickNextBlockPositionButton()
    compareGuiStoredParameters()
    if self.prm["currentBlock"] > self.prm["storedBlocks"]
        position = 1
    else
        position = int(prm[string("b", prm["currentBlock"])]["blockPosition"])+1
    end
    moveToBlockPosition(position)
end
    
function onClickNewBlockButton()
    if prm["storedBlocks"] >= prm["currentBlock"]
        compareGuiStoredParameters()
        block =  currBlock = string("b", prm["currentBlock"])
        prm["currentBlock"] = prm["storedBlocks"] + 1
        prm["tmpBlockPosition"] = prm["storedBlocks"] + 1
        setNewBlock(block)
    else
        ret = Qt.QMessageBox[:warning](w, "Warning",
                                       "You need to store the current block before adding a new one.",
                                       Qt.QMessageBox.Ok)
    end
end

function onClickPrevBlockButton()
    compareGuiStoredParameters()
    if prm["storedBlocks"] > 0
        lastBlock = string("b", prm["currentBlock"])
        if (prm["currentBlock"] < 2) & (prm["storedBlocks"] > 0)
            prm["currentBlock"] = prm["storedBlocks"]
        elseif (prm["currentBlock"] < 2) & (prm["storedBlocks"] == 0)
            prm["currentBlock"] = 1
        else
            if prm["currentBlock"] > self.prm["storedBlocks"]
                lastBlock = string("b", prm["currentBlock"]-1)
                prm["currentBlock"] = prm["currentBlock"] -1
            end
        end
        statusButton[:setText](prm["rbTrans"][:translate]("rb", "Start"))
        updateParametersWin()
        autoSetGaugeValue()
    end
end

function onClickPrevBlockPositionButton()
    compareGuiStoredParameters()
    if prm["currentBlock"] > self.prm["storedBlocks"]
        position = self.prm["currentBlock"]-1
    else
        position = int(prm[string("b", prm["currentBlock"])]["blockPosition"])-1
    end
    moveToBlockPosition(position)
end
        
function onClickStoreParametersButton()
    currExp =  experimentChooser[:currentText]()
    currParadigm = paradigmChooser[:currentText]()
    currBlock = string("b", prm["currentBlock"])

    ## #FOR ALL BLOCKS
    prm["allBlocks"] =  (String => Any)[]
    prm["allBlocks"]["experimentLabel"] = experimentLabelTF[:text]()
    prm["allBlocks"]["endExpCommand"] = endExpCommandTF[:text]()
    prm["allBlocks"]["currentExperimenter"] = experimenterChooser[:currentText]()
    prm["allBlocks"]["currentPhones"] = phonesChooser[:currentText]()
    #prm["allBlocks"]["maxLevel"] = float(prm["phones"]["phonesMaxLevel"][phonesChooser[:currentIndex]()])
    prm["allBlocks"]["sampRate"] =  prm["currentLocale"][:toInt](sampRateTF[:text]())[1]
    prm["allBlocks"]["nBits"] = prm["currentLocale"][:toInt](nBitsChooser[:currentText]())[1]
    prm["allBlocks"]["responseMode"] = responseModeChooser[:currentText]()
    prm["allBlocks"]["autoPCCorr"] = prm["currentLocale"][:toDouble](autoPCorrTF[:text]())[1]/100
    prm["allBlocks"]["sendTriggers"] = triggerCheckBox[:isChecked]()
    prm["allBlocks"]["shuffleMode"] = shuffleChooser[:currentText]()
    prm["allBlocks"]["repetitions"] =  prm["currentLocale"][:toInt](repetitionsTF[:text]())[1]
    prm["allBlocks"]["procRes"] = procResCheckBox[:isChecked]()
    prm["allBlocks"]["procResTable"] = procResTableCheckBox[:isChecked]()
    prm["allBlocks"]["winPlot"] = winPlotCheckBox[:isChecked]()
    prm["allBlocks"]["pdfPlot"] = pdfPlotCheckBox[:isChecked]()
    #prm["allBlocks"]["listener"] = listenerTF"][:text]()
    #prm["allBlocks"]["sessionLabel"] = sessionLabelTF"][:text]()


    ## #BLOCK SPECIFIC
    prm[currBlock] = (String => Any)[]
    prm[currBlock]["conditionLabel"] = conditionLabelTF[:text]()
    prm[currBlock]["experiment"] = currExp
    prm[currBlock]["paradigm"] = currParadigm
    prm[currBlock]["field"] = (Any)[] #list(range(prm["nFields"]))
    prm[currBlock]["fieldLabel"] = (Any)[] #list(range(prm["nFields"]))
    prm[currBlock]["fieldCheckBox"] = (Any)[] #list(range(prm["nFields"]))
    prm[currBlock]["chooser"] = (Any)[] #list(range(prm["nChoosers"]))
    prm[currBlock]["chooserOptions"] = (Any)[] #list(range(prm["nChoosers"]))
    prm[currBlock]["chooserCheckBox"] = (Any)[] #list(range(prm["nChoosers"]))
    prm[currBlock]["chooserLabel"] = (Any)[] #list(range(prm["nChoosers"]))
    prm[currBlock]["fileChooser"] = (Any)[] #list(range(prm["nFileChoosers"]))
    prm[currBlock]["fileChooserButton"] = (Any)[] #list(range(prm["nFileChoosers"]))
    prm[currBlock]["fileChooserCheckBox"] = (Any)[] #list(range(prm["nFileChoosers"]))
    prm[currBlock]["paradigmChooser"] = (Any)[] #[]
    prm[currBlock]["paradigmChooserCheckBox"] = (Any)[] #[]
    prm[currBlock]["paradigmField"] = (Any)[] #[]
    prm[currBlock]["paradigmFieldCheckBox"] = (Any)[] #[]
    prm[currBlock]["paradigmChooserLabel"] = (Any)[] #[]
    prm[currBlock]["paradigmChooserOptions"] = (Any)[] #[]
    prm[currBlock]["paradigmFieldLabel"] = (Any)[] #[]
    prm[currBlock]["blockPosition"] = currentBlockPositionLabel[:text]()
    
    prm[currBlock]["preTrialSilence"] = prm["currentLocale"][:toInt](preTrialSilenceTF[:text]())[1]
    prm[currBlock]["intervalLights"] = intervalLightsChooser[:currentText]()
    prm[currBlock]["warningInterval"] = warningIntervalChooser[:currentText]()
    prm[currBlock]["warningIntervalDur"] = prm["currentLocale"][:toInt](warningIntervalDurTF[:text]())[1]
    prm[currBlock]["warningIntervalISI"] = prm["currentLocale"][:toInt](warningIntervalISITF[:text]())[1]
    if prm[currExp]["hasISIBox"] == true
        prm[currBlock]["ISIVal"] = prm["currentLocale"][:toInt](wd["ISIBox"][:text]())[1]
        prm[currBlock]["ISIValCheckBox"] = wd["ISIBoxCheckBox"][:isChecked]()
    end
    if prm[currExp]["hasPreTrialInterval"] == true
        prm[currBlock]["preTrialInterval"] = wd["preTrialIntervalChooser"][:currentText]()
        prm[currBlock]["preTrialIntervalCheckBox"] = wd["preTrialIntervalCheckBox"][:isChecked]()
        prm[currBlock]["preTrialIntervalISI"] = prm["currentLocale"][:toInt](wd["preTrialIntervalISITF"][:text]())[1]
        prm[currBlock]["preTrialIntervalISICheckBox"] = wd["preTrialIntervalISICheckBox"][:isChecked]()
    end
    if prm[currExp]["hasPrecursorInterval"] == true
        prm[currBlock]["precursorInterval"] = wd["precursorIntervalChooser"][:currentText]()
        prm[currBlock]["precursorIntervalCheckBox"] = wd["precursorIntervalCheckBox"][:isChecked]()
        prm[currBlock]["precursorIntervalISI"] = prm["currentLocale"][:toInt](wd["precursorIntervalISITF"][:text]())[1]
        prm[currBlock]["precursorIntervalISICheckBox"] = wd["precursorIntervalISICheckBox"][:isChecked]()
    end
    if prm[currExp]["hasPostcursorInterval"] == true
        prm[currBlock]["postcursorInterval"] = wd["postcursorIntervalChooser"][:currentText]()
        prm[currBlock]["postcursorIntervalCheckBox"] = wd["postcursorIntervalCheckBox"][:isChecked]()
        prm[currBlock]["postcursorIntervalISI"] = prm["currentLocale"][:toInt](wd["postcursorIntervalISITF"][:text]())[1]
        prm[currBlock]["postcursorIntervalISICheckBox"] = wd["postcursorIntervalISICheckBox"][:isChecked]()
    end
    if prm[currExp]["hasAlternativesChooser"] == true
        prm[currBlock]["nIntervals"] = prm["currentLocale"][:toInt](wd["nIntervalsChooser"][:currentText]())[1]
        prm[currBlock]["nIntervalsCheckBox"] = wd["nIntervalsCheckBox"][:isChecked]()
        prm[currBlock]["nAlternatives"] = prm["currentLocale"][:toInt](wd["nAlternativesChooser"][:currentText]())[1]
        prm[currBlock]["nAlternativesCheckBox"] = wd["nAlternativesCheckBox"][:isChecked]()
    end
    if prm[currExp]["hasAltReps"] == true
        prm[currBlock]["altReps"] = prm["currentLocale"][:toInt](wd["altRepsBox"][:text]())[1]
        prm[currBlock]["altRepsCheckBox"] = wd["altRepsBoxCheckBox"][:isChecked]()
        prm[currBlock]["altRepsISI"] = prm["currentLocale"][:toInt](wd["altRepsISIBox"][:text]())[1]
        prm[currBlock]["altRepsISICheckBox"] = wd["altRepsISIBoxCheckBox"][:isChecked]()
    end

    prm[currBlock]["responseLight"] = wd["responseLightChooser"][:currentText]()
    prm[currBlock]["responseLightCheckBox"] = wd["responseLightCheckBox"][:isChecked]()
    prm[currBlock]["responseLightDuration"] = prm["currentLocale"][:toInt](wd["responseLightDurationTF"][:text]())[1]
    prm[currBlock]["responseLightDurationCheckBox"] = wd["responseLightDurationCheckBox"][:isChecked]()

    
    for f=1:prm["nFields"]
        push!(prm[currBlock]["field"], prm["currentLocale"][:toDouble](wd["field"][f][:text]())[1])
        push!(prm[currBlock]["fieldLabel"], wd["fieldLabel"][f][:text]())
        push!(prm[currBlock]["fieldCheckBox"], wd["fieldCheckBox"][f][:isChecked]())
    end
    for c=1:prm["nChoosers"]
        push!(prm[currBlock]["chooser"], wd["chooserOptions"][c][wd["chooser"][c][:currentIndex]()+1])
        push!(prm[currBlock]["chooserOptions"], wd["chooserOptions"][c])
        push!(prm[currBlock]["chooserLabel"], wd["chooserLabel"][c][:text]())
        push!(prm[currBlock]["chooserCheckBox"], wd["chooserCheckBox"][c][:isChecked]())
    end
    
    for f=1:prm["nFileChoosers"]
        push!(prm[currBlock]["fileChooser"], wd["fileChooser"][f][:text]())
        push!(prm[currBlock]["fileChooserButton"], wd["fileChooserButton"][f][:text]())
        push!(prm[currBlock]["fileChooserCheckBox"], wd["fileChooserCheckBox"][f][:isChecked]())
    end
    for i=1:length(wdc["paradigmFieldList"])
        push!(prm[currBlock]["paradigmField"], prm["currentLocale"][:toDouble](wdc["paradigmFieldList"][i][:text]())[1])
        push!(prm[currBlock]["paradigmFieldLabel"], wdc["paradigmFieldLabelList"][i][:text]())
        push!(prm[currBlock]["paradigmFieldCheckBox"], wdc["paradigmFieldCheckBoxList"][i][:isChecked]())
    end
    for i=1:length(wdc["paradigmChooserList"])
        push!(prm[currBlock]["paradigmChooser"], wdc["paradigmChooserOptionsList"][i][wdc["paradigmChooserList"][i][:currentIndex]()+1])
        push!(prm[currBlock]["paradigmChooserLabel"], wdc["paradigmChooserLabelList"][i][:text]())
        push!(prm[currBlock]["paradigmChooserOptions"], wdc["paradigmChooserOptionsList"][i])
        push!(prm[currBlock]["paradigmChooserCheckBox"], wdc["paradigmChooserCheckBoxList"][i][:isChecked]())
    end
    
    if prm["currentBlock"] > prm["storedBlocks"]
        prm["storedBlocks"] = prm["storedBlocks"] + 1
    end
    storedBlocksCountLabel[:setText](string(prm["storedBlocks"]))
    for i=1:jumpToBlockChooser[:count]()
        jumpToBlockChooser[:removeItem](0)
        jumpToPositionChooser[:removeItem](0)
    end
    for i=1:prm["storedBlocks"]
        jumpToBlockChooser[:addItem](string(i))
        jumpToPositionChooser[:addItem](string(i))
    end
    jumpToBlockChooser[:setCurrentIndex](prm["currentBlock"]-1)
    jumpToPositionChooser[:setCurrentIndex](int(prm[currBlock]["blockPosition"])-1)
    statusButton[:setText](prm["rbTrans"][:translate]("rb", "Start"))
    saveParametersToFile(prm["tmpParametersFile"])
    autoSetGaugeValue()
end

function onClickStoreandaddParametersButton()
    onClickStoreParametersButton()
    onClickNewBlockButton()
end

function onClickStoreandgoParametersButton()
    onClickStoreParametersButton()
    moveNextBlock()
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


function onClickOpenResultsButton(self)
        ## if "resultsFile" in self.prm:
        ##     fileToOpen = self.prm["resultsFile"]
        ##     QDesktopServices.openUrl(QtCore.QUrl.fromLocalFile(fileToOpen))
        ## else:
        ##     ret = QMessageBox.information(self, self.tr("message"),
        ##                                         self.tr("No results file has been selected"),
        ##                                         QMessageBox.Ok | QMessageBox.Cancel)
end

function onClickResetParametersButton()
    if prm["storedBlocks"] == 0
        #pass
    else
        prm["currentBlock"] = 1
        for i=1: prm["storedBlocks"]
            prm[string("b", i+1)]["blockPosition"] = string(i+1)
        end
        updateParametersWin()
        prm["shuffled"] = false
        saveParametersToFile(prm["tmpParametersFile"])
        prm["currentRepetition"] = 1
        autoSetGaugeValue()
        statusButton[:setText](prm["rbTrans"][:translate]("rb", "Start"))
    end
end

function onClickLoadParametersButton()
    fd = Qt.QFileDialog()
    fName = fd[:getOpenFileName](w, "Choose parameters file to load", "", "prm files (*.prm *PRM *Prm);;All Files (*)")[1]
    if length(fName) > 0 #if the user didn't press cancel
        loadParameters(fName)
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
    ##         #    if os.path.exists(parametersFile) == true
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
    shiftBlock(prm["currentBlock"], "down")
end    

function onClickShiftBlockUpButton()
    shiftBlock(prm["currentBlock"], "up")
end

function onClickShuffleBlocksButton()
        ## self.compareGuiStoredParameters()
        ## if self.prm["storedBlocks"] > 1:
        ##     if len(self.shufflingSchemeTF[:text]()) == 0:
        ##         blockPositions = list(range(self.prm["storedBlocks"]))
        ##         random.shuffle(blockPositions)
        ##         for k in range(self.prm["storedBlocks"]):
        ##             self.prm["b"+str(k+1)]["blockPosition"] = str(blockPositions[k]+1)
        ##     else:
        ##         try:
        ##             shuffledSeq = self.advanced_shuffle(self.shufflingSchemeTF[:text]())
        ##             blockPositions = self.unpack_seq(shuffledSeq)
        ##         except:
        ##             ret = QMessageBox.warning(self, self.tr("Warning"),
        ##                                             self.tr("Shuffling failed :-( Something may be wrong with your shuffling scheme."),
        ##                                             QMessageBox.Ok | QMessageBox.Cancel)
        ##             return
        ##         if len(numpy.unique(blockPositions)) != self.prm["storedBlocks"]:
        ##             ret = QMessageBox.warning(self, self.tr("Warning"),
        ##                                             self.tr("Shuffling failed :-( The length of the shuffling sequence seems to be different than the number of stored blocks. Maybe you recently added of deleted a block."),
        ##                                             QMessageBox.Ok | QMessageBox.Cancel)
        ##             return
                    
        ##         for k in range(self.prm["storedBlocks"]):
        ##             self.prm["b"+str(k+1)]["blockPosition"] = str(blockPositions[k])

        ##     self.moveToBlockPosition(1)
        ##     self.prm["shuffled"] = True
        ##     self.saveParametersToFile(self.prm["tmpParametersFile"])
        ##     self.updateParametersWin()
        ##     self.responseBox.statusButton.setText(self.prm["rbTrans"].translate("rb", "Start"))
        ##     self.autoSetGaugeValue()
end

function onClickUndoUnsavedButton()
        ## if self.prm["currentBlock"] > self.prm["storedBlocks"]:
        ##     self.onExperimentChange(self.experimentChooser[:currentText]())
        ## else:
        ##     self.updateParametersWin()
end

function onDropPrmFile(l)
        ## lastFileDropped = l #l[len(l)-1]
        ## if os.path.exists(lastFileDropped):
        ##     reply = QMessageBox.question(self, self.tr("Message"), self.tr("Do you want to load the parameters file {0} ?").format(lastFileDropped), QMessageBox.Yes | 
        ##                                        QMessageBox.No, QMessageBox.Yes)
        ##     if reply == QMessageBox.Yes:
        ##         self.loadParameters(lastFileDropped)
        ##     else:
        ##         pass
end

function onEditExperimenters()
        ## dialog = experimentersDialog(self)
        ## if dialog.exec_():
        ##     dialog.onClickApplyButton()
end

function onEditPhones()
        ## currIdx = self.phonesChooser[:currentIndex]()
        ## dialog = phonesDialog(self)
        ## if dialog.exec_():
        ##     dialog.permanentApply()
     
        ## self.phonesChooser.setCurrentIndex(currIdx)
        ## if self.phonesChooser[:currentIndex]() == -1:
        ##     self.phonesChooser.setCurrentIndex(0)
end



function onEditPref()
        ## dialog = preferencesDialog(self)
        ## if dialog.exec_():
        ##     dialog.permanentApply()
        ##     self.audioManager.initializeAudio()
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

function onJumpToBlockChange()
        ## blockToJumpTo = self.jumpToBlockChooser[:currentIndex]() + 1
        ## self.compareGuiStoredParameters()
        ## self.prm["currentBlock"] = blockToJumpTo
        ## self.prm["tmpBlockPosition"] = self.prm["b"+str(self.prm["currentBlock"])]["blockPosition"]
        ## self.setNewBlock("b"+str(self.prm["currentBlock"]))
        ## if self.prm["storedBlocks"] > 0:
        ##     self.responseBox.statusButton.setText(self.prm["rbTrans"].translate("rb", "Start"))
        ##     self.updateParametersWin()
        ##     self.autoSetGaugeValue()
end  

function onJumpToPositionChange()
        ## position = self.jumpToPositionChooser[:currentIndex]() + 1
        ## self.compareGuiStoredParameters()
        ## self.moveToBlockPosition(position)
end

function onListenerChange()
    prm["listener"] = text(listenerTF)
end

function onNAlternativesChange(nAlternativesSelected)
    prm["nAlternatives"] = prm["currentLocale"][:toInt](wd["nAlternativesChooser"][:currentText]())[1]
    setupLights()
end

function onNIntervalsChange(nIntervalsSelected)
    for i=1:wd["nAlternativesChooser"][:count]()
            wd["nAlternativesChooser"][:removeItem](0)
    end
    wd["nAlternativesChooser"][:addItems]([string(prm["currentLocale"][:toInt](wd["nIntervalsChooser"][:currentText]())[1]-1), wd["nIntervalsChooser"][:currentText]()])
    wd["nAlternativesChooser"][:setCurrentIndex](1)
    prm["nIntervals"] = prm["currentLocale"][:toInt](wd["nIntervalsChooser"][:currentText]())[1]
    setupLights()
end

function onParadigmChange(paradigmSelected)
        prm["prevParadigm"] = copy(prm["currParadigm"])
        prm["currParadigm"] = paradigmSelected
        setParadigmWidgets(currParadigm, prevParadigm)
        setupLights()
end

function onPrecursorIntervalChange()
        ## if self.precursorIntervalChooser[:currentText]() == self.tr("Yes"):
        ##     self.prm["precursorInterval"] = True
        ##     self.precursorIntervalISILabel.show()
        ##     self.precursorIntervalISITF.show()
        ##     self.precursorIntervalISICheckBox.show()
        ## else:
        ##     self.prm["precursorInterval"] = False
        ##     self.precursorIntervalISILabel.hide()
        ##     self.precursorIntervalISITF.hide()
        ##     self.precursorIntervalISICheckBox.hide()
        ## self.onChooserChange(None)
        ## self.responseBox.setupLights()
end

function onPostcursorIntervalChange()
        ## if self.postcursorIntervalChooser[:currentText]() == self.tr("Yes"):
        ##     self.prm["postcursorInterval"] = True
        ##     self.postcursorIntervalISILabel.show()
        ##     self.postcursorIntervalISITF.show()
        ##     self.postcursorIntervalISICheckBox.show()
        ## else:
        ##     self.prm["postcursorInterval"] = False
        ##     self.postcursorIntervalISILabel.hide()
        ##     self.postcursorIntervalISITF.hide()
        ##     self.postcursorIntervalISICheckBox.hide()
        ## self.onChooserChange(None)
        ## self.responseBox.setupLights()
end

function onPreTrialIntervalChange()
        ## if self.preTrialIntervalChooser[:currentText]() == self.tr("Yes"):
        ##     self.prm["preTrialInterval"] = True
        ##     self.preTrialIntervalISILabel.show()
        ##     self.preTrialIntervalISITF.show()
        ##     self.preTrialIntervalISICheckBox.show()
        ## else:
        ##     self.prm["preTrialInterval"] = False
        ##     self.preTrialIntervalISILabel.hide()
        ##     self.preTrialIntervalISITF.hide()
        ##     self.preTrialIntervalISICheckBox.hide()
        ## self.onChooserChange(None)
        ## self.responseBox.setupLights()
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


function onShowFortune()
        ##dialog = showFortuneDialog(self)
end


function onShowManualPdf()
        ## fileToOpen = os.path.abspath(os.path.dirname(__file__)) + "/doc/_build/latex/pychoacoustics.pdf"
        ## QDesktopServices.openUrl(QtCore.QUrl.fromLocalFile(fileToOpen))
end

function onShowModulesDoc()
        ## fileToOpen = os.path.abspath(os.path.dirname(__file__)) + "/doc/_build/html/index.html"
        ## QDesktopServices.openUrl(QtCore.QUrl.fromLocalFile(fileToOpen))
end

function onSwapBlocksAction()
        ## dialog = swapBlocksDialog(self)
        ## if dialog.exec_():
        ##     blockA = self.prm["currentLocale"][:toInt](dialog.blockAWidget[:text]())[0]
        ##     blockB = self.prm["currentLocale"][:toInt](dialog.blockBWidget[:text]())[0]
        ##     if self.prm["storedBlocks"] < 1:
        ##         ret = QMessageBox.warning(self, self.tr("Warning"),
        ##                                         self.tr("There are no stored blocks to swap."),
        ##                                         QMessageBox.Ok | QMessageBox.Cancel)
        ##         return
        ##     if blockA < 1 or blockB < 1 or blockA > self.prm["storedBlocks"] or blockB > self.prm["storedBlocks"]:
        ##         ret = QMessageBox.warning(self, self.tr("Warning"),
        ##                                         self.tr("Block numbers specified out of range."),
        ##                                         QMessageBox.Ok | QMessageBox.Cancel)
        ##         return
        ##     else:
        ##         self.swapBlocks(blockA, blockB)
        ## return
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

function onWhatsThis(self)
        ## if QWhatsThis.inWhatsThisMode() == true
        ##     QWhatsThis.leaveWhatsThisMode()
        ## else:
        ##     QWhatsThis.enterWhatsThisMode()
end

function parseShuffleSeq(seq)
        ## seq = seq.replace(' ', '') #remove white space
        ## seqLen = len(seq)
        ## allowedChars = list(string.digits)
        ## allowedChars.extend([',', '-', '(', ')', '[', ']'])
        ## outSeq = ''
        ## for i in range(len(seq)):
        ##     if seq[i] not in allowedChars:
        ##         ret = QMessageBox.warning(self, self.tr("Warning"),
        ##                                         self.tr("Shuffling scheme contains non-allowed characters."),
        ##                                         QMessageBox.Ok | QMessageBox.Cancel)
        ##         return
        ## seqFound = False
        ## k = 0
        ## while seqFound == False:        
        ##     if seq[k] in ['(', ')', '[', ']', ',']:
        ##         outSeq = outSeq + seq[k]
        ##         k = k+1
        ##     elif seq[k] == '-':
        ##         prevDig = seq[k-1]
        ##         nextDig = seq[k+1]
        ##         delimiterFound = False
        ##         n = 2
        ##         while delimiterFound == False:
        ##             if seq[k-n] not in ['(', '[', ',']:
        ##                 prevDig = seq[k-n] + prevDig
        ##                 n = n+1
        ##             else:
        ##                 delimiterFound = True
        ##         delimiterFound = False
        ##         n = 2
        ##         while delimiterFound == False:
        ##             if seq[k+n] not in [')', ']', ',']:
        ##                 nextDig = nextDig + seq[k+n]
        ##                 n = n+1
        ##             else:
        ##                 delimiterFound = True
        ##         nextDigitLength = n-1
        ##         prevDig = int(prevDig)
        ##         nextDig = int(nextDig)
        ##         for j in range(prevDig+1, nextDig+1):
        ##             outSeq = outSeq + ',' + str(j)
        ##         k = k+n
        ##     else:
        ##         outSeq = outSeq + seq[k]
        ##         k = k+1
        ##     if k == len(seq):
        ##         seqFound = True
        ## return outSeq
end
                    
function processResultsLinearDialog()
        ## fList = QFileDialog.getOpenFileNames(self, self.tr("Choose results file to load"), '', self.tr("All Files (*)"))[0]
        ## sep = None
        ## if len(fList) > 0:
        ##     resformat = 'linear'

        ##     f = open(fList[0], 'r')
        ##     allLines = f.readlines()
        ##     f.close()
        ##     paradigmFound = False
        ##     lineNum = 0
        ##     while paradigmFound == False:
        ##         if allLines[lineNum].split(':')[0] == "Paradigm":
        ##             paradigm = allLines[lineNum].split(':')[1].strip()
        ##             paradigmFound = True
        ##         lineNum = lineNum+1
                
        ##     dialog = processResultsDialog(self, fList, resformat, paradigm, sep)
end
            

function processResultsTableDialog()
        ## fList = QFileDialog.getOpenFileNames(self, self.tr("Choose results file to load"), '', self.tr("All Files (*)"))[0]
        ## sep = None
        ## if len(fList) > 0:
           
        ##     resformat = 'table'
        ## #Determine paradigm

        ##     f = open(fList[0], "r")
        ##     thisLines = f.readlines()
        ##     f.close()

        ##     seps = [';', ',', ':', ' ']
        ##     for sep in seps:
        ##         try:
        ##             prdgCol = thisLines[0].split(sep).index('paradigm')
        ##         except:
        ##             prdgCol = None
        ##         if prdgCol != None:
        ##             break
        ##     if prdgCol == None:
        ##         sep, ok = QInputDialog.getText(self, self.tr('Input Dialog'), "CSV separator")
        ##         if ok == False:
        ##             return

        ##     paradigm = thisLines[1].split(sep)[prdgCol]
                
        ##     dialog = processResultsDialog(self, fList, resformat, paradigm, sep)
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

function saveParametersToFile(ftow)
        ## fName = open(ftow, 'w')
        ## fName.write('Phones: ' + self.phonesChooser[:currentText]() + '\n')
        ## fName.write('Shuffle Mode: ' + self.shuffleChooser[:currentText]() + '\n')
        ## fName.write('Response Mode: ' + self.responseModeChooser[:currentText]() + '\n')
        ## fName.write('Auto Resp. Mode Perc. Corr.: ' + self.autoPCorrTF.text() + '\n')
        ## fName.write('Sample Rate: ' + self.sampRateTF.text() + '\n')
        ## fName.write('Bits: ' + self.nBitsChooser[:currentText]() + '\n')
        ## fName.write('Trigger On/Off: ' + str(self.triggerCheckBox[:isChecked]()) + '\n')
        ## fName.write('Experiment Label: ' + self.experimentLabelTF[:text]() + '\n')
        ## fName.write('End Command: ' + self.endExpCommandTF[:text]() + '\n')
        ## fName.write('Shuffling Scheme: ' + self.shufflingSchemeTF[:text]() + '\n')
        ## fName.write('No. Repetitions: ' + self.repetitionsTF[:text]() + '\n')
        ## fName.write('Proc. Res.: ' + str(self.procResCheckBox[:isChecked]()) + '\n')
        ## fName.write('Proc. Res. Table: ' + str(self.procResTableCheckBox[:isChecked]()) + '\n')
        ## fName.write('Plot: ' + str(self.winPlotCheckBox[:isChecked]()) + '\n')
        ## fName.write('PDF Plot: ' + str(self.pdfPlotCheckBox[:isChecked]()) + '\n')
        ## for i in range(self.prm["storedBlocks"]):
        ##     currBlock = 'b'+str(i+1)
        ##     currExp = self.tr(self.prm[currBlock]['experiment'])
        ##     currParadigm = self.tr(self.prm[currBlock]['paradigm'])
        ##     fName.write('*******************************************************\n')
        ##     fName.write(self.tr('Block Position: ') + self.prm[currBlock]['blockPosition']+ '\n')
        ##     fName.write(self.tr('Condition Label: ') + self.prm[currBlock]['conditionLabel']+ '\n')
        ##     fName.write(self.tr('Experiment: ') + self.prm[currBlock]['experiment']+ '\n')
        ##     fName.write(self.tr('Paradigm: ') + self.prm[currBlock]['paradigm']+ '\n')
        ##     if self.prm[currExp]["hasAlternativesChooser"] == true
        ##         fName.write(self.tr('Intervals: ') + self.prm["currentLocale"][:toString](self.prm[currBlock]['nIntervals']) + ' :' + str(self.prm[currBlock]['nIntervalsCheckBox']) + '\n')
        ##         fName.write(self.tr('Alternatives: ') + self.prm["currentLocale"][:toString](self.prm[currBlock]['nAlternatives']) + ' :' + str(self.prm[currBlock]['nAlternativesCheckBox']) + '\n')
        ##     fName.write(self.tr('Pre-Trial Silence (ms): ') + self.prm["currentLocale"][:toString](self.prm[currBlock]['preTrialSilence']) + '\n')
        ##     fName.write(self.tr('Warning Interval: ') + str(self.prm[currBlock]['warningInterval']) + '\n')
        ##     if self.prm[currBlock]['warningInterval'] == self.tr("Yes"):
        ##         fName.write(self.tr('Warning Interval Duration (ms): ') + self.prm["currentLocale"][:toString](self.prm[currBlock]['warningIntervalDur']) + '\n')
        ##         fName.write(self.tr('Warning Interval ISI (ms): ') + self.prm["currentLocale"][:toString](self.prm[currBlock]['warningIntervalISI']) + '\n')
        ##     fName.write(self.tr('Interval Lights: ') + self.prm[currBlock]['intervalLights'] + '\n')
        ##     if self.prm[currExp]["hasISIBox"] == true
        ##         fName.write(self.tr('ISI (ms): ') + self.prm["currentLocale"][:toString](self.prm[currBlock]['ISIVal']) + ' :' + str(self.prm[currBlock]['ISIValCheckBox']) + '\n')
        ##     if self.prm[currExp]["hasPreTrialInterval"] == true
        ##         fName.write(self.tr('Pre-Trial Interval: ') + self.prm[currBlock]['preTrialInterval'] + ' :' + str(self.prm[currBlock]['preTrialIntervalCheckBox']) + '\n')
        ##         if self.prm[currBlock]['preTrialInterval'] == self.tr("Yes"):
        ##             fName.write(self.tr('Pre-Trial Interval ISI (ms): ') + self.prm["currentLocale"][:toString](self.prm[currBlock]['preTrialIntervalISI']) + ' :' + str(self.prm[currBlock]['preTrialIntervalISICheckBox']) + '\n')
        ##     if self.prm[currExp]["hasPrecursorInterval"] == true
        ##         fName.write(self.tr('Precursor Interval: ') + self.prm[currBlock]['precursorInterval'] + ' :' + str(self.prm[currBlock]['precursorIntervalCheckBox']) + '\n')
        ##         if self.prm[currBlock]['precursorInterval'] == self.tr("Yes"):
        ##             fName.write(self.tr('Precursor Interval ISI (ms): ') + self.prm["currentLocale"][:toString](self.prm[currBlock]['precursorIntervalISI']) + ' :' + str(self.prm[currBlock]['precursorIntervalISICheckBox']) + '\n')
        ##     if self.prm[currExp]["hasPostcursorInterval"] == true
        ##         fName.write(self.tr('Postcursor Interval: ') + self.prm[currBlock]['postcursorInterval'] + ' :' + str(self.prm[currBlock]['postcursorIntervalCheckBox']) + '\n')
        ##         if self.prm[currBlock]['postcursorInterval'] == self.tr("Yes"):
        ##             fName.write(self.tr('Postcursor Interval ISI (ms): ') + self.prm["currentLocale"][:toString](self.prm[currBlock]['postcursorIntervalISI']) + ' :' + str(self.prm[currBlock]['postcursorIntervalISICheckBox']) + '\n')
        ##     if self.prm[currExp]["hasAltReps"] == true
        ##         fName.write(self.tr('Alternated (AB) Reps.: ') + self.prm["currentLocale"][:toString](self.prm[currBlock]['altReps']) + ' :' + str(self.prm[currBlock]['altRepsCheckBox']) + '\n')
        ##         fName.write(self.tr('Alternated (AB) Reps. ISI (ms): ') + self.prm["currentLocale"][:toString](self.prm[currBlock]['altRepsISI']) + ' :' + str(self.prm[currBlock]['altRepsISICheckBox']) + '\n')
             

        ##     fName.write(self.tr('Response Light: ') + str(self.prm[currBlock]['responseLight']) + ' :' + str(self.prm[currBlock]['responseLightCheckBox']) + '\n')
        ##     fName.write(self.tr('Response Light Duration (ms): ') + self.prm["currentLocale"][:toString](self.prm[currBlock]['responseLightDuration']) + ' :' + str(self.prm[currBlock]['responseLightDurationCheckBox']) + '\n')
        ##     fName.write('.\n')
        ##     for k in range(len(self.prm[currBlock]['paradigmChooser'])):
        ##         fName.write(self.prm[currBlock]['paradigmChooserLabel'][k] +' ' + self.prm[currBlock]['paradigmChooser'][k] + ' :' + str(self.prm[currBlock]['paradigmChooserCheckBox'][k]) + '\n')
        ##     fName.write('..\n')
        ##     for k in range(len(self.prm[currBlock]['paradigmField'])):
        ##         fName.write(self.prm[currBlock]['paradigmFieldLabel'][k] + ': ' +  self.prm["currentLocale"][:toString](self.prm[currBlock]['paradigmField'][k], precision=self.prm["pref"]["general"]["precision"]) + ' :' + str(self.prm[currBlock]['paradigmFieldCheckBox'][k]) + '\n')
        ##     fName.write('...\n')
        ##     for k in range(len(self.prm[currBlock]['chooser'])):
        ##         fName.write(self.prm[currBlock]['chooserLabel'][k] +' ' + self.prm[currBlock]['chooser'][k] + ' :' + str(self.prm[currBlock]['chooserCheckBox'][k]) + '\n')
        ##     fName.write('....\n')
        ##     for k in range(len(self.prm[currBlock]['fileChooser'])):
        ##         fName.write(self.prm[currBlock]['fileChooserButton'][k] +': ' + self.prm[currBlock]['fileChooser'][k] + ' :' + str(self.prm[currBlock]['fileChooserCheckBox'][k]) + '\n')
        ##     fName.write('.....\n')
        ##     for k in range(len(self.prm[currBlock]['field'])):
        ##         fName.write(self.prm[currBlock]['fieldLabel'][k] + ': ' + self.prm["currentLocale"][:toString](self.prm[currBlock]['field'][k], precision=self.prm["pref"]["general"]["precision"]) + ' :' + str(self.prm[currBlock]['fieldCheckBox'][k]) + '\n')
        ##     fName.write('+++++++++++++++++++++++++++++++++++++++++++++++++++++++\n\n')
        ## fName.close()
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
        wd["ISILabel"] = Qt.QLabel("ISI (ms):")
        add_widg_sizer[:addWidget](wd["ISILabel"], n, 1)
        wd["ISIBox"] = Qt.QLineEdit()
        wd["ISIBox"][:setText]("500")
        wd["ISIBox"][:setValidator](Qt.QIntValidator())
        add_widg_sizer[:addWidget](wd["ISIBox"], n, 2)
        wd["ISIBoxCheckBox"] = Qt.QCheckBox()
        add_widg_sizer[:addWidget](wd["ISIBoxCheckBox"], n, 0)
        push!(wdc["additionalWidgetsIntFieldList"], wd["ISIBox"])
        push!(wdc["additionalWidgetsIntFieldLabelList"], wd["ISILabel"])
        push!(wdc["additionalWidgetsIntFieldCheckBoxList"], wd["ISIBoxCheckBox"])
        n = n+1
    end
    if prm[prm["currExp"]]["hasAlternativesChooser"] == true
        wd["nIntervalsLabel"] = Qt.QLabel("Intervals:")
        add_widg_sizer[:addWidget](wd["nIntervalsLabel"], n, 1)
        wd["nIntervalsChooser"] = Qt.QComboBox()
        wd["nIntervalsChooser"][:addItems](prm["nIntervalsChoices"])
        if haskey(prm, "nIntervals")
            wd["nIntervalsChooser"][:setCurrentIndex](find(prm["nIntervalsChoices"] .== string(prm["nIntervals"]))-1)
        else
            wd["nIntervalsChooser"][:setCurrentIndex](0)
        end
        add_widg_sizer[:addWidget](wd["nIntervalsChooser"], n, 2)
        qconnect(wd["nIntervalsChooser"], :activated, (str) -> onNIntervalsChange(prm["nIntervalsChoices"][str+1]))
        wd["nIntervalsCheckBox"] = Qt.QCheckBox()
        add_widg_sizer[:addWidget](wd["nIntervalsCheckBox"], n, 0)
        push!(wdc["additionalWidgetsChooserList"], wd["nIntervalsChooser"])
        push!(wdc["additionalWidgetsChooserLabelList"], wd["nIntervalsLabel"])
        push!(wdc["additionalWidgetsChooserCheckBoxList"], wd["nIntervalsCheckBox"])
        n = n+1
        wd["nAlternativesLabel"] = Qt.QLabel("Alternatives:")
        add_widg_sizer[:addWidget](wd["nAlternativesLabel"], n, 1)
        wd["nAlternativesChooser"] = Qt.QComboBox()
        wd["nAlternativesChooser"][:addItems]([string(prm["currentLocale"][:toInt](wd["nIntervalsChooser"][:currentText]())[1]-1), wd["nIntervalsChooser"][:currentText]()])
        wd["nAlternativesChooser"][:setCurrentIndex](wd["nAlternativesChooser"][:findText](string(prm["nAlternatives"])))
        add_widg_sizer[:addWidget](wd["nAlternativesChooser"], n, 2)
        qconnect(wd["nAlternativesChooser"], :activated, (str) -> onNAlternativesChange(str))
        wd["nAlternativesCheckBox"] = Qt.QCheckBox()
        add_widg_sizer[:addWidget](wd["nAlternativesCheckBox"], n, 0)
        push!(wdc["additionalWidgetsChooserList"], wd["nAlternativesChooser"])
        push!(wdc["additionalWidgetsChooserLabelList"], wd["nAlternativesLabel"])
        push!(wdc["additionalWidgetsChooserCheckBoxList"], wd["nAlternativesCheckBox"])
        n = n+1
    end
    if prm[prm["currExp"]]["hasAltReps"] == true
        wd["altRepsLabel"] = Qt.QLabel("Alternated (AB) Reps.:", w)
        add_widg_sizer[:addWidget](wd["altRepsLabel"], n, 1)
        wd["altRepsBox"] = Qt.QLineEdit()
        wd["altRepsBox"][:setText]("0")
        wd["altRepsBox"][:setValidator](Qt.QIntValidator(w))
        add_widg_sizer[:addWidget](wd["altRepsBox"], n, 2)
        wd["altRepsBoxCheckBox"] = Qt.QCheckBox()
        add_widg_sizer[:addWidget](wd["altRepsBoxCheckBox"], n, 0)
        push!(additionalWidgetsIntFieldList, wd["altRepsBox"])
        push!(additionalWidgetsIntFieldLabelList, wd["altRepsLabel"])
        push!(additionalWidgetsIntFieldCheckBoxList, wd["altRepsBoxCheckBox"])
        n = n+1
        wd["altRepsISILabel"] = Qt.QLabel("Alternated (AB) Reps. ISI (ms):", w)
        add_widg_sizer[:addWidget](wd["altRepsISILabel"], n, 1)
        wd["altRepsISIBox"] = Qt.QLineEdit()
        wd["altRepsISIBox"][:setText]("0")
        wd["altRepsISIBox"][:setValidator](Qt.QIntValidator(w))
        add_widg_sizer[:addWidget](wd["altRepsISIBox"], n, 2)
        wd["altRepsISIBoxCheckBox"] = Qt.QCheckBox()
        add_widg_sizer.addWidget(wd["altRepsISIBoxCheckBox"], n, 0)
        push!(additionalWidgetsIntFieldList, wd["altRepsISIBox"])
        push!(additionalWidgetsIntFieldLabelList, wd["altRepsISILabel"])
        push!(additionalWidgetsIntFieldCheckBoxList, wd["altRepsISIBoxCheckBox"])
        n = n+1
    end
    
    #Pre-Trial Interval
    if prm[prm["currExp"]]["hasPreTrialInterval"] == true
        wd["preTrialIntervalChooserLabel"] = Qt.QLabel("Pre-Trial Interval:")
        add_widg_sizer[:addWidget](wd["preTrialIntervalChooserLabel"], n, 1)
        wd["preTrialIntervalChooser"] = Qt.QComboBox()
        wd["preTrialIntervalChooser"][:addItems]([tr("Yes"), tr("No")])
        wd["preTrialIntervalChooser"][:setCurrentIndex](1)
        qconnect(wd["preTrialIntervalChooser"], :activated, (str) -> onPreTrialIntervalChange())
        add_widg_sizer[:addWidget](wd["preTrialIntervalChooser"], n, 2)
        wd["preTrialIntervalCheckBox"] = Qt.QCheckBox()
        add_widg_sizer[:addWidget](wd["preTrialIntervalCheckBox"], n, 0)
        push!(wdc["additionalWidgetsChooserList"], wd["preTrialIntervalChooser"])
        push!(wdc["additionalWidgetsChooserLabelList"], wd["preTrialIntervalChooserLabel"])
        push!(wdc["additionalWidgetsChooserCheckBoxList"], wd["preTrialIntervalCheckBox"])
        n = n+1
        wd["preTrialIntervalISILabel"] = Qt.QLabel("Pre-Trial Interval ISI (ms):")
        add_widg_sizer[:addWidget](wd["preTrialIntervalISILabel"], n, 1)
        
        wd["preTrialIntervalISITF"] = Qt.QLineEdit()
        wd["preTrialIntervalISITF"][:setText]("500")
        wd["preTrialIntervalISITF"][:setValidator](QIntValidator())
        wd["preTrialIntervalISITF"][:setWhatsThis]("Sets the duration of the silent interval between the pre-trial interval and the first observation interval")
        
        add_widg_sizer[:addWidget](wd["preTrialIntervalISITF"], n, 2)
        wd["preTrialIntervalISICheckBox"] = Qt.QCheckBox()
        add_widg_sizer[:addWidget](wd["preTrialIntervalISICheckBox"], n, 0)
        
        wd["preTrialIntervalISILabel"][:hide]()
        wd["preTrialIntervalISITF"][:hide]()
        wd["preTrialIntervalISICheckBox"][:hide]()
        
        push!(wdc["additionalWidgetsIntFieldList"], wd["preTrialIntervalISITF"])
        push!(wdc["additionalWidgetsIntFieldLabelList"], wd["preTrialIntervalISILabel"])
        push!(wdc["additionalWidgetsIntFieldCheckBoxList"], wd["preTrialIntervalISICheckBox"])
        n = n+1
    end
    
    #Precursor Interval
    if prm[prm["currExp"]]["hasPrecursorInterval"] == true
        wd["precursorIntervalChooserLabel"] = Qt.QLabel("Precursor Interval:")
        add_widg_sizer[:addWidget](wd["precursorIntervalChooserLabel"], n, 1)
        wd["precursorIntervalChooser"] = Qt.QComboBox()
        wd["precursorIntervalChooser"][:addItems](["Yes", "No"])
        wd["precursorIntervalChooser"][:setCurrentIndex](1)
        qconnect(wd["precursorIntervalChooser"], :activated, (str) -> onPrecursorIntervalChange())
        add_widg_sizer[:addWidget](wd["precursorIntervalChooser"], n, 2)
        wd["precursorIntervalCheckBox"] = Qt.QCheckBox()
        add_widg_sizer[:addWidget](wd["precursorIntervalCheckBox"], n, 0)
        push!(wdc["additionalWidgetsChooserList"], wd["precursorIntervalChooser"])
        push!(wdc["additionalWidgetsChooserLabelList"], wd["precursorIntervalChooserLabel"])
        push!(wdc["additionalWidgetsChooserCheckBoxList"], wd["precursorIntervalCheckBox"])
        n = n+1
        wd["precursorIntervalISILabel"] = Qt.QLabel("Precursor Interval ISI (ms):")
        add_widg_sizer[:addWidget](wd["precursorIntervalISILabel"], n, 1)
        
        wd["precursorIntervalISITF"] = Qt.QLineEdit()
        wd["precursorIntervalISITF"][:setText]("500")
        wd["precursorIntervalISITF"][:setValidator](Qt.QIntValidator())
        wd["precursorIntervalISITF"][:setWhatsThis]("Sets the duration of the silent interval between the precursor interval and the observation interval")
        
        add_widg_sizer[:addWidget](wd["precursorIntervalISITF"], n, 2)
        wd["precursorIntervalISICheckBox"] = Qt.QCheckBox()
        add_widg_sizer[:addWidget](wd["precursorIntervalISICheckBox"], n, 0)
        
        wd["precursorIntervalISILabel"][:hide]()
        wd["precursorIntervalISITF"][:hide]()
        wd["precursorIntervalISICheckBox"][:hide]()
        
        push!(wdc["additionalWidgetsIntFieldList"], wd["precursorIntervalISITF"])
        push!(wdc["additionalWidgetsIntFieldLabelList"], wd["precursorIntervalISILabe"]l)
        push!(wdc["additionalWidgetsIntFieldCheckBoxList"], wd["precursorIntervalISICheckBox"])
        n = n+1
    end
    
    #Postcursor Interval
    if prm[prm["currExp"]]["hasPostcursorInterval"] == true
        wd["postcursorIntervalChooserLabel"] = Qt.QLabel("Postcursor Interval:")
        add_widg_sizer[:addWidget](wd["postcursorIntervalChooserLabel"], n, 1)
        wd["postcursorIntervalChooser"] = Qt.QComboBox()
        wd["postcursorIntervalChooser"][:addItems](["Yes", "No"])
        wd["postcursorIntervalChooser"][:setCurrentIndex](1)
        qconnect(wd["postcursorIntervalChooser"], :activated, (str) -> onPostcursorIntervalChange())
        add_widg_sizer[:addWidget](wd["postcursorIntervalChooser"], n, 2)
        wd["postcursorIntervalCheckBox"] = Qt.QCheckBox()
        add_widg_sizer[:addWidget](wd["postcursorIntervalCheckBox"], n, 0)
        push!(wdc["additionalWidgetsChooserList"], wd["postcursorIntervalChooser"])
        push!(wdc["additionalWidgetsChooserLabelList"], wd["postcursorIntervalChooserLabel"])
        push!(wdc["additionalWidgetsChooserCheckBoxList"], wd["postcursorIntervalCheckBox"])
        n = n+1
        wd["postcursorIntervalISILabel"] = Qt.QLabel("Postcursor Interval ISI (ms):")
        add_widg_sizer[:addWidget](wd["postcursorIntervalISILabel"], n, 1)
        
        wd["postcursorIntervalISITF"] = QLineEdit()
        wd["postcursorIntervalISITF"][:setText]("500")
        wd["postcursorIntervalISITF"][:setValidator](Qt.QIntValidator())
        wd["postcursorIntervalISITF"][:setWhatsThis]("Sets the duration of the silent interval between the observation interval and the postcursor interval")
        
        add_widg_sizer[:addWidget](wd["postcursorIntervalISITF"], n, 2)
        wd["postcursorIntervalISICheckBox"] = Qt.QCheckBox()
        add_widg_sizer[:addWidget](wd["postcursorIntervalISICheckBox"], n, 0)
        
        wd["postcursorIntervalISILabel"][:hide]()
        wd["postcursorIntervalISITF"][:hide]()
        wd["postcursorIntervalISICheckBox"][:hide]()
        
        push!(wdc["additionalWidgetsIntFieldList"], wd["postcursorIntervalISITF"])
        push!(wdc["additionalWidgetsIntFieldLabelList"], wd["postcursorIntervalISILabel"])
        push!(wdc["additionalWidgetsIntFieldCheckBoxList"], wd["postcursorIntervalISICheckBox"])
        n = n+1
    end
    
    if prm[prm["currExp"]]["hasFeedback"] == true
        wd["responseLightLabel"] =  Qt.QLabel("Response Light:")
        wd["responseLightChooser"] = Qt.QComboBox()
        wd["responseLightChooser"][:addItems](["Feedback", "Neutral", "None"])
        add_widg_sizer[:addWidget](wd["responseLightLabel"], n, 1)
        add_widg_sizer[:addWidget](wd["responseLightChooser"], n, 2)
        wd["responseLightCheckBox"] = Qt.QCheckBox()
        add_widg_sizer[:addWidget](wd["responseLightCheckBox"], n, 0)
        push!(wdc["additionalWidgetsChooserList"], wd["responseLightChooser"])
        push!(wdc["additionalWidgetsChooserLabelList"], wd["responseLightLabel"])
        push!(wdc["additionalWidgetsChooserCheckBoxList"], wd["responseLightCheckBox"])
        n = n+1
        wd["responseLightDurationLabel"] = Qt.QLabel("Response Light Duration (ms):")
        add_widg_sizer[:addWidget](wd["responseLightDurationLabel"], n, 1)
        wd["responseLightDurationTF"] = Qt.QLineEdit()
        wd["responseLightDurationTF"][:setText](prm["pref"]["general"]["responseLightDuration"])
        wd["responseLightDurationTF"][:setValidator](Qt.QIntValidator())
        
        add_widg_sizer[:addWidget](wd["responseLightDurationTF"], n, 2)
        wd["responseLightDurationCheckBox"] = Qt.QCheckBox()
        add_widg_sizer[:addWidget](wd["responseLightDurationCheckBox"], n, 0)
        push!(wdc["additionalWidgetsIntFieldList"], wd["responseLightDurationTF"])
        push!(wdc["additionalWidgetsIntFieldLabelList"], wd["responseLightDurationLabel"])
        push!(wdc["additionalWidgetsIntFieldCheckBoxList"], wd["responseLightDurationCheckBox"])
        n = n+1
    else
        wd["responseLightLabel"] =  QLabel("Response Light:")
        wd["responseLightChooser"] = Qt.QComboBox()
        wd["responseLightChooser"][:addItems]([tr("Neutral"), tr("None")])
        add_widg_sizer[:addWidget](wd["responseLightLabel"], n, 1)
        add_widg_sizer[:addWidget](wd["responseLightChooser"], n, 2)
        wd["responseLightCheckBox"] = Qt.QCheckBox()
        add_widg_sizer[:addWidget](wd["responseLightCheckBox"], n, 0)
        push!(wdc["additionalWidgetsChooserList"], wd["responseLightChooser"])
        push!(wdc["additionalWidgetsChooserLabelList"], wd["responseLightLabel"])
        push!(wdc["additionalWidgetsChooserCheckBoxList"], wd["responseLightCheckBox"])
        n = n+1
        wd["responseLightDurationLabel"] = QLabel(tr("Response Light Duration (ms):"), self)
        add_widg_sizer[:addWidget](wd["responseLightDurationLabel"], n, 1)
        wd["responseLightDurationTF"] = QLineEdit()
        wd["responseLightDurationTF"][:setText](prm["pref"]["general"]["responseLightDuration"])
        wd["responseLightDurationTF"][:setValidator](Qt.QIntValidator())
        push!(wdc["additionalWidgetsIntFieldList"], wd["responseLightDurationTF"])
        push!(wdc["additionalWidgetsIntFieldLabelList"], wd["responseLightDurationLabel"])
        
        add_widg_sizer[:addWidget](wd["responseLightDurationTF"], n, 2)
        wd["responseLightDurationCheckBox"] = Qt.QCheckBox()
        add_widg_sizer[:addWidget](wd["responseLightDurationCheckBox"], n, 0)
        push!(wdc["additionalWidgetsIntFieldCheckBoxList"], wd["responseLightDurationCheckBox"])
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

function setNewBlock(block)
        removePrmWidgets()
        conditionLabelTF[:setText](prm[block]["conditionLabel"])

        ## currExp = tr(prm[block]['experiment'])
        ## paradigm = tr(prm[block]['paradigm'])
        ## experimentChooser.setCurrentIndex(prm['experimentsChoices'].index(currExp))
        ## for i in range(paradigmChooser.count()):
        ##     paradigmChooser.removeItem(0)
        ## paradigmChooser.addItems(prm[currExp]['paradigmChoices'])
        ## paradigmChooser.setCurrentIndex(prm[currExp]["paradigmChoices"].index(paradigm))

        ## if paradigm in [tr("Multiple Constants 1-Interval 2-Alternatives"), tr("Multiple Constants m-Intervals n-Alternatives"), tr("Odd One Out")]:
        ##     par['nDifferences'] = int(prm[block]['paradigmChooser'][prm[block]['paradigmChooserLabel'].index(tr("No. Differences:"))])
        ## if paradigm in [tr("Transformed Up-Down Interleaved"), tr("Weighted Up-Down Interleaved")]:
        ##     par['nDifferences'] = int(prm[block]['paradigmChooser'][prm[block]['paradigmChooserLabel'].index(tr("No. Tracks:"))])
      
        ## setDefaultParameters(currExp, tr(prm[block]['paradigm']), par)
        ## for f in range(len(field)):
        ##     field[f].setText(prm["currentLocale"][:toString](prm[block]['field'][f], precision=prm["pref"]["general"]["precision"]))
        ##     fieldCheckBox[f].setChecked(prm[block]['fieldCheckBox'][f])
        ## for c in range(len(chooser)):
        ##     chooser[c].setCurrentIndex(prm['chooserOptions'][c].index(prm[block]['chooser'][c]))
        ##     chooserCheckBox[c].setChecked(prm[block]['chooserCheckBox'][c])
        ## for f in range(len(fileChooser)):
        ##     fileChooser[f].setText(prm[block]['fileChooser'][f])
        ##     fileChooserCheckBox[f].setChecked(prm[block]['fileChooserCheckBox'][f])

        ## for f in range(len(paradigmFieldList)):
        ##     paradigmFieldList[f].setText(prm["currentLocale"][:toString](prm[block]['paradigmField'][f], precision=prm["pref"]["general"]["precision"]))
        ##     paradigmFieldCheckBoxList[f].setChecked(prm[block]['paradigmFieldCheckBox'][f])
        ## for c in range(len(paradigmChooserList)):
        ##     paradigmChooserList[c].setCurrentIndex(paradigmChooserList[c].findText(prm[block]['paradigmChooser'][c]))
        ##     paradigmChooserCheckBoxList[c].setChecked(prm[block]['paradigmChooserCheckBox'][c])

        ## preTrialSilenceTF.setText(prm["currentLocale"][:toString](prm[block]['preTrialSilence']))
        ## warningIntervalChooser.setCurrentIndex(warningIntervalChooser.findText(prm[block]['warningInterval']))
        ## onWarningIntervalChange()
        ## warningIntervalDurTF.setText(prm["currentLocale"][:toString](prm[block]['warningIntervalDur']))
        ## warningIntervalISITF.setText(prm["currentLocale"][:toString](prm[block]['warningIntervalISI']))
        ## intervalLightsChooser.setCurrentIndex(intervalLightsChooser.findText(prm[block]['intervalLights']))
        ## onIntervalLightsChange()

        ## if prm[currExp]["hasISIBox"] == true
        ##     ISIBox.setText(prm["currentLocale"][:toString](prm[block]['ISIVal']))
        ##     ISIBoxCheckBox.setChecked(prm[block]['ISIValCheckBox'])
        ## if prm[currExp]["hasPreTrialInterval"] == true
        ##     preTrialIntervalChooser.setCurrentIndex(preTrialIntervalChooser.findText(prm[block]['preTrialInterval']))
        ##     preTrialIntervalCheckBox.setChecked(prm[block]['preTrialIntervalCheckBox'])
        ##     onPreTrialIntervalChange()
        ##     preTrialIntervalISITF.setText(prm["currentLocale"][:toString](prm[block]['preTrialIntervalISI']))
        ##     preTrialIntervalISICheckBox.setChecked(prm[block]['preTrialIntervalISICheckBox'])
        ## if prm[currExp]["hasPrecursorInterval"] == true
        ##     precursorIntervalChooser.setCurrentIndex(precursorIntervalChooser.findText(prm[block]['precursorInterval']))
        ##     precursorIntervalCheckBox.setChecked(prm[block]['precursorIntervalCheckBox'])
        ##     onPrecursorIntervalChange()
        ##     precursorIntervalISITF.setText(prm["currentLocale"][:toString](prm[block]['precursorIntervalISI']))
        ##     precursorIntervalISICheckBox.setChecked(prm[block]['precursorIntervalISICheckBox'])
        ## if prm[currExp]["hasPostcursorInterval"] == true
        ##     postcursorIntervalChooser.setCurrentIndex(postcursorIntervalChooser.findText(prm[block]['postcursorInterval']))
        ##     postcursorIntervalCheckBox.setChecked(prm[block]['postcursorIntervalCheckBox'])
        ##     onPostcursorIntervalChange()
        ##     postcursorIntervalISITF.setText(prm["currentLocale"][:toString](prm[block]['postcursorIntervalISI']))
        ##     postcursorIntervalISICheckBox.setChecked(prm[block]['postcursorIntervalISICheckBox'])
        ## if prm[currExp]["hasAlternativesChooser"] == true
        ##     nIntervalsChooser.setCurrentIndex(nIntervalsChooser.findText(str(prm[block]['nIntervals'])))
        ##     nIntervalsCheckBox.setChecked(prm[block]['nIntervalsCheckBox'])
        ##     onNIntervalsChange(nIntervalsChooser.findText(str(prm[block]['nIntervals'])))
        ##     nAlternativesChooser.setCurrentIndex(nAlternativesChooser.findText(str(prm[block]['nAlternatives'])))
        ##     nAlternativesCheckBox.setChecked(prm[block]['nAlternativesCheckBox'])
        ## if prm[currExp]["hasAltReps"] == true
        ##     altRepsBox.setText(prm["currentLocale"][:toString](prm[block]['altReps']))
        ##     altRepsBoxCheckBox.setChecked(prm[block]['altRepsCheckBox'])
        ##     altRepsISIBox.setText(prm["currentLocale"][:toString](prm[block]['altRepsISI']))
        ##     altRepsISIBoxCheckBox.setChecked(prm[block]['altRepsISICheckBox'])
     
        ## responseLightChooser.setCurrentIndex(responseLightChooser.findText(prm[block]['responseLight']))
        ## responseLightCheckBox.setChecked(prm[block]['responseLightCheckBox'])
        ## responseLightDurationTF.setText(prm["currentLocale"][:toString](prm[block]['responseLightDuration']))
        ## responseLightDurationCheckBox.setChecked(prm[block]['responseLightDurationCheckBox'])
        ## currentBlockCountLabel.setText(str(prm["currentBlock"]))
        ## currentBlockPositionLabel.setText(str(prm["tmpBlockPosition"]))
        ## storedBlocksCountLabel.setText(str(prm["storedBlocks"]))
        ## for i in range(jumpToBlockChooser.count()):
        ##     jumpToBlockChooser.removeItem(0)
        ##     jumpToPositionChooser.removeItem(0)
        ## for i in range(prm["storedBlocks"]):
        ##     jumpToBlockChooser.addItem(str(i+1))
        ##     jumpToPositionChooser.addItem(str(i+1))
        ## jumpToBlockChooser.setCurrentIndex(prm["currentBlock"]-1)
        ## jumpToPositionChooser.setCurrentIndex(int(prm[block]['blockPosition'])-1)
   
        ## for c in range(len(chooser)):
        ##     chooser[c].activated[str].connect(onChooserChange)
        ## onChooserChange(None)
        ## responseBox.setupLights()
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
        ##     if prm[currExp]["hasNTracksChooser"] == true
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
        ##     if prm[currExp]["hasNTracksChooser"] == true
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
        ##     if prm[currExp]["hasNDifferencesChooser"] == true
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

function swapBlocks(b1, b2)
        ## compareGuiStoredParameters()
        ## if prm["storedBlocks"] < 1:
        ##     return
        ## if b1 > prm["storedBlocks"] or b2 > prm["storedBlocks"]:
        ##     ret = QMessageBox.warning(self, tr("Warning"),
        ##                                     tr("You're trying to swap the position of a block that has not been stored yet. Please, store the block first."),
        ##                                     QMessageBox.Ok | QMessageBox.Cancel)
        ##     return
        ## if prm["storedBlocks"] > 1 and b1 <= prm["storedBlocks"] and b2 <= prm["storedBlocks"]:
        ##     ol=copy.deepcopy(prm['b'+str(b1)])
        ##     prm['b'+str(b1)] = copy.deepcopy(prm['b'+str(b2)])
        ##     prm['b'+str(b2)] = copy.deepcopy(ol)
        ##     saveParametersToFile(prm["tmpParametersFile"])
        ## #
        ##     #updateParametersWin()
        ##     moveToBlockPosition(int(prm['b'+str(b2)]["blockPosition"]))
        ## return
end

function shiftBlock(blockNumber, direction)
        ## if direction == "up":
        ##     if blockNumber == prm["storedBlocks"]:
        ##         newBlockNumber = 1
        ##     else:
        ##         newBlockNumber = blockNumber + 1
        ## elif direction == "down":
        ##     if blockNumber == 1:
        ##         newBlockNumber = prm["storedBlocks"]
        ##     else:
        ##         newBlockNumber = blockNumber - 1
        ## swapBlocks(blockNumber, newBlockNumber)
end

function togglePdfPlotCheckBox()
    if pdfPlotCheckBox[:isChecked]() == true
        procResTableCheckBox[:setChecked](true)
    end
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

function unpack_seq(seq)
        ## newSeq = []
        ## for i in range(len(seq)):
        ##     if isinstance(seq[i], list) == True or isinstance(seq[i], tuple) == true
        ##         y = unpack_seq(seq[i])
        ##         newSeq.extend(y)
        ##     else:
        ##         newSeq.append(seq[i])
        ## return newSeq
end

function updateParametersWin()
    ## #if the next block is already stored show it, otherwise copy the values from the previous block
    currBlock = string("b", prm["currentBlock"])
    prevBlock = string("b", prm["currentBlock"]-1)
       
    if (prm["currentBlock"] > prm["storedBlocks"]) & (prm["storedBlocks"] > 0) #copy values from previous block
        block = prevBlock
    else
        block = currBlock
    end
    prm["tmpBlockPosition"] = prm[currBlock]["blockPosition"]
    setNewBlock(block)
end


## class dropFrame(QFrame):
##     drpd = QtCore.Signal(str) 
##     def __init__(self, parent):
##         QFrame.__init__(self, parent)
##         self.setAcceptDrops(True)
        
##     def dragEnterEvent(self, event):
##         if event.mimeData().hasUrls:
##             event.accept()
##         else:
##             event.ignore()

##     def dropEvent(self, event):
##         if event.mimeData().hasUrls:
##             event.setDropAction(Qt.CopyAction)
##             event.accept()
##             l = []
##             for url in event.mimeData().urls():
##                 l.append(str(url.toLocalFile()))
##                 self.drpd.emit(l[len(l)-1])
##         else:
##             event.ignore()

