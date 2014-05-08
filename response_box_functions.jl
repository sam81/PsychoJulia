
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


function onClickStatusButton()
##         parent().compareGuiStoredParameters()
    if (prm["storedBlocks"] == 0) | (statusButton[:text]() == prm["rbTrans"][:translate]("rb", "Running")) | (statusButton[:text]() == prm["rbTrans"][:translate]("rb", "Finished"))
        println(statusButton[:text]())
        return
    end

    if prm["currentBlock"] > prm["storedBlocks"] #the user did not choose to store the unsaved block, move to first block
        moveToBlockPosition(1)    
    end
    ## if parent().listenerTF.text() == "" and prm["pref"]["general"]["listenerNameWarn"] == True:
    ##     msg = prm["rbTrans"].translate("rb", "Please, enter the listener"s name:") 
    ##     text, ok = QInputDialog.getText(self, prm["rbTrans"].translate("rb", "Input Dialog:") , msg)
    ##     if ok:
    ##         parent().listenerTF.setText(text)
    ##         prm["listener"] = text
    
    ##     return
    ## if parent().sessionLabelTF.text() == "" and prm["pref"]["general"]["sessionLabelWarn"] == True:
    ##     msg = prm["rbTrans"].translate("rb", "Please, enter the session label:") 
    ##     text, ok = QInputDialog.getText(self, prm["rbTrans"].translate("rb", "Input Dialog:") , msg)
    ##     if ok:
    ##         parent().sessionLabelTF.setText(text)
    ##         prm["sessionLabel"] = text
    ##     return
    
    ## if int(prm["b"+str(prm["currentBlock"])]["blockPosition"]) == 1 and prm["allBlocks"]["shuffleMode"] == tr("Ask") and prm["shuffled"] == False and prm["storedBlocks"] > 1 :
    ##     reply = QMessageBox.question(self, prm["rbTrans"].translate("rb", "Message"),
    ##                                        prm["rbTrans"].translate("rb", "Do you want to shuffle the blocks?"), QMessageBox.Yes | 
    ##                                        QMessageBox.No, QMessageBox.No)
    ##     if reply == QMessageBox.Yes:
    ##         parent().onClickShuffleBlocksButton()
    ##         prm["shuffled"] = True
    ## elif int(prm["b"+str(prm["currentBlock"])]["blockPosition"]) == 1 and prm["shuffled"] == False and prm["allBlocks"]["shuffleMode"] == tr("Auto") and prm["storedBlocks"] > 1 :
    
    ##     parent().onClickShuffleBlocksButton()
    ##     prm["shuffled"] = True
    
    prm["startOfBlock"] = true
    statusButton[:setText](prm["rbTrans"][:translate]("rb", "Running"))
    prm["trialRunning"] = true
    QtGui["QApplication"][:processEvents]()
    
    ## if prm["allBlocks"]["sendTriggers"] == True:
    ##     thisSnd = pureTone(440, 0, -200, 980, 10, "Both", prm["allBlocks"]["sampRate"], 100)
    ##     #playCmd = prm["pref"]["sound"]["playCommand"]
    ##     audioManager.playSoundWithTrigger(thisSnd, prm["allBlocks"]["sampRate"], prm["allBlocks"]["nBits"], False, "ONTrigger.wav", prm["pref"]["general"]["ONTrigger"])
    ##     print("SENDING START TRIGGER", prm["pref"]["general"]["ONTrigger"])
    ## if prm["currentBlock"] > prm["storedBlocks"]:
    ##     parent().onClickNextBlockPositionButton()
    doTrial()
end


function clearLayout(layout)
    if layout != nothing
        while layout[:count]() > 0
            item = layout[:takeAt](0)
            widget = item[:widget]()
            if widget != nothing
                widget[:deleteLater]()
            else
               clearLayout(item[:layout]())
            end
        end
    end
end
             
function setupLights()
        nIntervals = prm["nIntervals"]
        nResponseIntervals = nIntervals
        #remove previous lights and buttons
    
        clearLayout(intervalSizer)
        intervalLight = (Any)[]
     
        clearLayout(responseButtonSizer)
        wdc["responseButton"] = (Any)[]

        n = 1
        if prm["warningInterval"] == true
            push!(intervalLight, py_class[:intervalLight](rbw))
            intervalSizer[:addWidget](intervalLight[n], 0, n)
            n = n+1
        end
                
        if prm[prm["currExp"]]["hasAlternativesChooser"] == true
            nAlternatives =  prm["currentLocale"][:toInt](wd["nAlternativesChooser"][:currentText]())[1] 
        else
            nAlternatives = nIntervals
        end
        
    if  in (prm["currParadigm"], ["Transformed Up-Down", "Weighted Up-Down",
                           "Constant m-Intervals n-Alternatives",
                           "Transformed Up-Down Interleaved",
                           "Weighted Up-Down Interleaved",
                           "Multiple Constants m-Intervals n-Alternatives",
                           "PEST"])

        if prm["preTrialInterval"] == true
            push!(intervalLight, py_class[:intervalLight](rbw))
            intervalSizer[:addWidget](intervalLight[n], 0, n)
            n = n+1
        end

        for i=1:nIntervals
            if prm["precursorInterval"] == true
                push!(intervalLight, py_class[:intervalLight](rbw))
                intervalSizer[:addWidget](intervalLight[n], 0, n)
                n = n+1
            end
                
            push!(intervalLight, py_class[:intervalLight](rbw))
            intervalSizer[:addWidget](intervalLight[n], 0, n)
            n = n+1
            
            if prm["postcursorInterval"] == true
                push!(intervalLight, py_class[:intervalLight](rbw))
                intervalSizer[:addWidget](intervalLight[n], 0, n)
                n = n+1
            end
        end

        r = 0
        if prm["warningInterval"] == true
            responseButtonSizer[:addItem](Qt.QSpacerItem(-1, -1, szp[:Expanding]), 0, r)
            r = r+1
        end
        if prm["preTrialInterval"] == true
            responseButtonSizer[:addItem](Qt.QSpacerItem(-1, -1, szp[:Expanding]), 0, r)
            r = r+1
        end
        if nAlternatives == nIntervals
            for i=1:nAlternatives
                if prm["precursorInterval"] == true
                    responseButtonSizer[:addItem](Qt.QSpacerItem(-1, -1, szp[:Expanding]), 0, r)
                    r = r+1
                end
                push!(wdc["responseButton"], Qt.QPushButton(string(i)))
                responseButtonSizer[:addWidget](wdc["responseButton"][i], 1, r)
                wdc["responseButton"][i][:setSizePolicy](Qt.QSizePolicy(szp[:Expanding], szp[:Expanding]))
                wdc["responseButton"][i][:setProperty]("responseBoxButton", true)
                r = r+1

                if prm[prm["currExp"]]["hasPostcursorInterval"] == true
                    responseButtonSizer[:addItem](Qt.QSpacerItem(-1, -1, szp[:Expanding]), 0, r)
                    r = r+1
                end
                wdc["responseButton"][i][:clicked][:connect](sortResponseButton)
                wdc["responseButton"][i][:setFocusPolicy](PySide.QtNamespace[:NoFocus])
           
            end
            
        elseif nAlternatives == nIntervals-1
            for i=1:nAlternatives
                if prm[prm["currExp"]]["hasPrecursorInterval"] == true
                    responseButtonSizer[:addItem](Qt.QSpacerItem(-1, -1, szp[:Expanding]), 0, r)
                    r = r+1
                end
                if i == 1
                    responseButtonSizer[:addItem](Qt.QSpacerItem(-1, -1, szp[:Expanding]), 0, r)
                    r = r+1
                end
                
                push!(wdc["responseButton"], Qt.QPushButton(string(i)))
                responseButtonSizer[:addWidget](wdc["responseButton"][i], 1, r)
                wdc["responseButton"][i][:setSizePolicy](Qt.QSizePolicy(szp[:Expanding], szp[:Expanding]))
                wdc["responseButton"][i][:setProperty]("responseBoxButton", true)
                r = r+1
                wdc["responseButton"][i][:clicked][:connect](sortResponseButton)
                wdc["responseButton"][i][:setFocusPolicy](PySide.QtNamespace[:NoFocus])
                if prm[prm["currExp"]]["hasPostcursorInterval"] == true
                    responseButtonSizer[:addItem](Qt.QSpacerItem(-1, -1, szp[:Expanding]), 0, r)
                    r = r+1
                end
            end
        end
        
        ## elif parent().currParadigm in ["Constant 1-Interval 2-Alternatives", "Multiple Constants 1-Interval 2-Alternatives",
        ##                            "Constant 1-Pair Same/Different"]:
        ##     for i in range(nIntervals):
        ##         intervalLight.append(intervalLight(self))
        ##         intervalSizer[:addWidget](intervalLight[n], 0, n)
        ##         n = n+1
        ##     end
                
        ##     for i in range(prm["nAlternatives"]):
        ##         responseButton.append(QPushButton(prm[tr(parent().experimentChooser.currentText())]["buttonLabels"][i], self))
            
        ##         responseButtonSizer[:addWidget](responseButton[i], 1, i)
        ##         responseButton[i].setSizePolicy(QSizePolicy(szp[:Expanding], szp[:Expanding]))
        ##         responseButton[i].setProperty("responseBoxButton", True)
        ##         responseButton[i][:clicked][:connect](sortResponseButton)
        ##         responseButton[i].setFocusPolicy(Qt.NoFocus)
        ##     end
        ## elif parent().currParadigm in ["Odd One Out"]:
        ##     for i in range(nIntervals):
        ##         intervalLight.append(intervalLight(self))
        ##         intervalSizer[:addWidget](intervalLight[n], 0, n)
        ##         n = n+1
        ##     end

        ##     r = 0
        ##     if prm["warningInterval"] == True:
        ##         responseButtonSizer[:addItem](Qt.QSpacerItem(-1, -1, szp[:Expanding]), 0, r)
        ##         r = r+1
        ##     end
        ##     for i in range(prm["nAlternatives"]):
        ##         responseButton.append(QPushButton(str(i+1), self))
        ##         responseButtonSizer[:addWidget](responseButton[i], 1, i+r)
        ##         responseButton[i].setSizePolicy(QSizePolicy(szp[:Expanding], szp[:Expanding]))
        ##         responseButton[i].setProperty("responseBoxButton", True)
        ##         responseButton[i][:clicked][:connect](sortResponseButton)
        ##         responseButton[i].setFocusPolicy(Qt.NoFocus)
        ##     end
    end

        ## showHideIntervalLights(prm["intervalLights"])
end



##     def showHideIntervalLights(self, status):
##         if status == tr("Yes"):
##             for light in intervalLight:
##                 light.show()
##         else:
##             for light in intervalLight:
##                 light.hide()

function onToggleControlWin()
    if toggleControlWin[:isChecked]() == true
        w[:show]()
    elseif toggleControlWin[:isChecked]() == false
        w[:hide]()
    end
##             if prm["storedBlocks"] > 0:
##                 if parent().listenerTF.text() == "" and prm["pref"]["general"]["listenerNameWarn"] == True:
##                     msg = prm["rbTrans"].translate("rb", "Please, enter the listener"s name:") 
##                     text, ok = QInputDialog.getText(self, prm["rbTrans"].translate("rb", "Input Dialog:") , msg)
##                     if ok:
##                         parent().listenerTF.setText(text)
##                         prm["listener"] = text
##                 if parent().sessionLabelTF.text() == "" and prm["pref"]["general"]["sessionLabelWarn"] == True:
##                     msg = prm["rbTrans"].translate("rb", "Please, enter the session label:") 
##                     text, ok = QInputDialog.getText(self, prm["rbTrans"].translate("rb", "Input Dialog:") , msg)
##                     if ok:
##                         parent().sessionLabelTF.setText(text)
##                         prm["sessionLabel"] = text
##                 if "resultsFile" not in prm:
##                     onAskSaveResultsButton()

end
##     def onAskSaveResultsButton(self):
##         ftow = QFileDialog.getSaveFileName(self, tr("Choose file to write results"), "", tr("All Files (*)"), "", QFileDialog.DontConfirmOverwrite)[0]
##         if os.path.exists(ftow) == False and len(ftow) > 0:
##                 fName = open(ftow, "w")
##                 fName.write("")
##                 fName.close()
##         if len(ftow) > 0:
##             if fnmatch.fnmatch(ftow, "*.txt") == False:
##                 ftow = ftow + ".txt"
##             prm["resultsFile"] = ftow
##             parent().statusBar().showMessage(tr("Saving results to file: ") + prm["resultsFile"])
           
function onToggleGauge()
    if toggleGauge[:isChecked]() == true
        gauge[:show]()
    elseif toggleGauge[:isChecked]() == false
        gauge[:hide]()
    end
end

function onToggleBlockGauge()
    if toggleBlockGauge[:isChecked]() == true
        blockGauge[:show]()
    elseif toggleBlockGauge[:isChecked]() == false
        blockGauge[:hide]()
    end
end



##     def playRandomisedIntervals(self, stimulusCorrect, stimulusIncorrect, preTrialStim=None, precursorStim=None, postCursorStim=None):
##         # this randint function comes from numpy and has different behaviour than in the python "random" module
##         # Return random integers x such that low <= x < high
##         currBlock = "b"+ str(prm["currentBlock"])
##         nAlternatives = prm[currBlock]["nAlternatives"]
##         nIntervals = prm[currBlock]["nIntervals"]
##         #cmd = prm["pref"]["sound"]["playCommand"]
##         if nAlternatives == nIntervals:
##             correctInterval = numpy.random.randint(0, nIntervals)
##             correctButton = correctInterval + 1
##         elif nAlternatives == nIntervals-1:
##             correctInterval = numpy.random.randint(1, nIntervals)
##             correctButton = correctInterval 
##         soundList = []
        
##         for i in range(nIntervals):
##             if i == correctInterval:
##                 soundList.append(stimulusCorrect)
##             else:
##                 foo = stimulusIncorrect.pop()
##                 soundList.append(foo)

##         nLight = 0
##         if prm["warningInterval"] == True:
##             intervalLight[nLight].setStatus("on")
##             time.sleep(prm[currBlock]["warningIntervalDur"]/1000)
##             intervalLight[nLight].setStatus("off")
##             nLight = nLight+1
##             time.sleep(prm[currBlock]["warningIntervalISI"]/1000)

##         if prm["preTrialInterval"] == True:
##             intervalLight[nLight].setStatus("on")
##             audioManager.playSound(preTrialStim, prm["allBlocks"]["sampRate"], prm["allBlocks"]["nBits"], prm["pref"]["sound"]["writewav"], "pre-trial_interval" +".wav")
##             intervalLight[nLight].setStatus("off")
##             nLight = nLight+1
##             time.sleep(prm[currBlock]["preTrialIntervalISI"]/1000)

##         for i in range(nIntervals):
##             if prm["precursorInterval"] == True:
##                 intervalLight[nLight].setStatus("on")
##                 audioManager.playSound(precursorStim, prm["allBlocks"]["sampRate"], prm["allBlocks"]["nBits"], prm["pref"]["sound"]["writewav"], "precursor_interval"+str(i+1) +".wav")
##                 intervalLight[nLight].setStatus("off")
##                 nLight = nLight+1
##                 time.sleep(prm[currBlock]["precursorIntervalISI"]/1000)
##             intervalLight[nLight].setStatus("on")
##             audioManager.playSound(soundList[i], prm["allBlocks"]["sampRate"], prm["allBlocks"]["nBits"], prm["pref"]["sound"]["writewav"], "interval"+str(i+1) +".wav")
##             intervalLight[nLight].setStatus("off")
##             nLight = nLight+1
##             if prm["postcursorInterval"] == True:
##                 intervalLight[nLight].setStatus("on")
##                 audioManager.playSound(postcursorStim, prm["allBlocks"]["sampRate"], prm["allBlocks"]["nBits"], prm["pref"]["sound"]["writewav"], "postcursor_interval"+str(i+1) +".wav")
##                 intervalLight[nLight].setStatus("off")
##                 nLight = nLight+1
##                 time.sleep(prm[currBlock]["postcursorIntervalISI"]/1000)
##             if i < nIntervals-1:
##                 time.sleep(prm["isi"]/1000.)

##     def playSequentialIntervals(self, sndList, ISIList=[], trigNum=None):
##         currBlock = "b"+ str(prm["currentBlock"])
##         #cmd = prm["pref"]["sound"]["playCommand"]
##         for i in range(len(sndList)):
##             if prm["pref"]["sound"]["writeSndSeqSegments"] == True:
##                 audioManager.scipy_wavwrite("sndSeq%i.wav"%(i+1), prm["allBlocks"]["sampRate"], prm["allBlocks"]["nBits"], sndList[i])
##         nLight = 0
##         if prm["warningInterval"] == True:
##             intervalLight[nLight].setStatus("on")
##             time.sleep(prm[currBlock]["warningIntervalDur"]/1000)
##             intervalLight[nLight].setStatus("off")
##             nLight = nLight+1
##             time.sleep(prm[currBlock]["warningIntervalISI"]/1000)
##         for i in range(len(sndList)):
##             intervalLight[nLight].setStatus("on")
##             if trigNum != None:
##                 audioManager.playSoundWithTrigger(sndList[i], prm["allBlocks"]["sampRate"], prm["allBlocks"]["nBits"], prm["pref"]["sound"]["writewav"], "soundSequence.wav", trigNum)
##             else:
##                 audioManager.playSound(sndList[i], prm["allBlocks"]["sampRate"], prm["allBlocks"]["nBits"], prm["pref"]["sound"]["writewav"], "soundSequence.wav")
##             intervalLight[nLight].setStatus("off")
##             nLight = nLight+1

##             if i < (len(sndList) - 1):
##                 time.sleep(ISIList[i]/1000)


##     def playSoundsWavComp(self, soundList, fsList, nBitsList):
##         currBlock = "b"+ str(prm["currentBlock"])
##         nIntervals = prm["nIntervals"]
##         #cmd = prm["pref"]["sound"]["playCommand"]

##         nLight = 0
##         if prm["warningInterval"] == True:
##             intervalLight[nLight].setStatus("on")
##             time.sleep(prm[currBlock]["warningIntervalDur"]/1000)
##             intervalLight[nLight].setStatus("off")
##             nLight = nLight+1
##             time.sleep(prm[currBlock]["warningIntervalISI"]/1000)
            
##         for i in range(nIntervals):
##             intervalLight[nLight].setStatus("on")
##             audioManager.playSound(soundList[i], fsList[i], nBitsList[i], prm["pref"]["sound"]["writewav"], "interval"+str(i+1) +".wav")
##             intervalLight[nLight].setStatus("off")
##             nLight = nLight+1
##             if i < nIntervals-1:
##                 time.sleep(prm["isi"]/1000)

function doTrial()
    prm["trialRunning"] = true
    prm["sortingResponse"] = false
    currBlock = string("b", prm["currentBlock"])
  
    #for compatibility otherwise need to change in all experiments
    prm["maxLevel"] = prm["allBlocks"]["maxLevel"]
    prm["sampRate"] = prm["allBlocks"]["sampRate"]
    prm["nBits"] = prm["allBlocks"]["nBits"]
   
    prm["paradigm"] = prm[currBlock]["paradigm"]
    if prm[prm["currExp"]]["hasISIBox"] == true
        prm["isi"] = prm[currBlock]["ISIVal"]
    end
    if prm[prm["currExp"]]["hasAlternativesChooser"] == true
            prm["nAlternatives"] = prm[currBlock]["nAlternatives"]
    end
    if prm[prm["currExp"]]["hasAltReps"] == true
        prm["altReps"] = prm[currBlock]["altReps"]
        prm["altRepsISI"] = prm[currBlock]["altRepsISI"]
    else
        prm["altReps"] = 0
    end
    prm["responseLight"] = prm[currBlock]["responseLight"]

    if prm["startOfBlock"] == true
        getStartTime()
    end

    if  in (prm["paradigm"], ["Transformed Up-Down Interleaved", "Weighted Up-Down Interleaved"]) == true
        prm["nDifferences"] = int(prm[currBlock]["paradigmChooser"][find(prm[currBlock]["paradigmChooserLabel"] == "No. Tracks:")])
        if prm["nDifferences"] == 1
            prm["maxConsecutiveTrials"] = "unlimited"
        else
            prm["maxConsecutiveTrials"] = prm[currBlock]["paradigmChooser"][find(prm[currBlock]["paradigmChooserLabel"] == "Max. Consecutive Trials x Track:")]
        end
    end
           

##             if prm["paradigm"] == tr("Transformed Up-Down"):
##                 prm["numberCorrectNeeded"] = int(prm[currBlock]["paradigmField"][prm[currBlock]["paradigmFieldLabel"].index(tr("Rule Down"))])
##                 prm["numberIncorrectNeeded"] = int(prm[currBlock]["paradigmField"][prm[currBlock]["paradigmFieldLabel"].index(tr("Rule Up"))])
##                 prm["initialTurnpoints"] = int(prm[currBlock]["paradigmField"][prm[currBlock]["paradigmFieldLabel"].index(tr("Initial Turnpoints"))])
##                 prm["totalTurnpoints"] = int(prm[currBlock]["paradigmField"][prm[currBlock]["paradigmFieldLabel"].index(tr("Total Turnpoints"))])
##                 prm["adaptiveStepSize1"] = prm[currBlock]["paradigmField"][prm[currBlock]["paradigmFieldLabel"].index(tr("Step Size 1"))]
##                 prm["adaptiveStepSize2"] = prm[currBlock]["paradigmField"][prm[currBlock]["paradigmFieldLabel"].index(tr("Step Size 2"))]
##                 prm["adaptiveType"] = prm[currBlock]["paradigmChooser"][prm[currBlock]["paradigmChooserLabel"].index(tr("Procedure:"))]
##                 prm["trackDir"] = prm[currBlock]["paradigmChooser"][prm[currBlock]["paradigmChooserLabel"].index(tr("Initial Track Direction:"))]
##             elif prm["paradigm"] == tr("Transformed Up-Down Interleaved"):
##                 prm["adaptiveType"] = prm[currBlock]["paradigmChooser"][prm[currBlock]["paradigmChooserLabel"].index(tr("Procedure:"))]
##                 prm["turnpointsToAverage"] = prm[currBlock]["paradigmChooser"][prm[currBlock]["paradigmChooserLabel"].index(tr("Turnpoints to average:"))]
                
##                 prm["numberCorrectNeeded"] = []
##                 prm["numberIncorrectNeeded"] = []
##                 prm["initialTurnpoints"] = []
##                 prm["totalTurnpoints"] = []
##                 prm["adaptiveStepSize1"] = []
##                 prm["adaptiveStepSize2"] = []
##                 prm["consecutiveTrialsCounter"] = []
##                 prm["trackDir"] = []
##                 for i in range(prm["nDifferences"]):
##                     prm["numberCorrectNeeded"].append(int(prm[currBlock]["paradigmField"][prm[currBlock]["paradigmFieldLabel"].index(tr("Rule Down Track " + str(i+1)))]))
##                     prm["numberIncorrectNeeded"].append(int(prm[currBlock]["paradigmField"][prm[currBlock]["paradigmFieldLabel"].index(tr("Rule Up Track " + str(i+1)))]))
##                     prm["initialTurnpoints"].append(int(prm[currBlock]["paradigmField"][prm[currBlock]["paradigmFieldLabel"].index(tr("Initial Turnpoints Track " + str(i+1)))]))
##                     prm["totalTurnpoints"].append(int(prm[currBlock]["paradigmField"][prm[currBlock]["paradigmFieldLabel"].index(tr("Total Turnpoints Track " + str(i+1)))]))
##                     prm["adaptiveStepSize1"].append(prm[currBlock]["paradigmField"][prm[currBlock]["paradigmFieldLabel"].index(tr("Step Size 1 Track " + str(i+1)))])
##                     prm["adaptiveStepSize2"].append(prm[currBlock]["paradigmField"][prm[currBlock]["paradigmFieldLabel"].index(tr("Step Size 2 Track " + str(i+1)))])
##                     prm["consecutiveTrialsCounter"].append(0)
##                     prm["trackDir"].append(prm[currBlock]["paradigmChooser"][prm[currBlock]["paradigmChooserLabel"].index(tr("Initial Track {0} Direction:".format(str(i+1))))])
##             elif prm["paradigm"] == tr("Weighted Up-Down"):
##                 prm["percentCorrectTracked"] = float(prm[currBlock]["paradigmField"][prm[currBlock]["paradigmFieldLabel"].index(tr("Percent Correct Tracked"))])

##                 prm["initialTurnpoints"] = int(prm[currBlock]["paradigmField"][prm[currBlock]["paradigmFieldLabel"].index(tr("Initial Turnpoints"))])
##                 prm["totalTurnpoints"] = int(prm[currBlock]["paradigmField"][prm[currBlock]["paradigmFieldLabel"].index(tr("Total Turnpoints"))])
##                 prm["adaptiveStepSize1"] = prm[currBlock]["paradigmField"][prm[currBlock]["paradigmFieldLabel"].index(tr("Step Size 1"))]
##                 prm["adaptiveStepSize2"] = prm[currBlock]["paradigmField"][prm[currBlock]["paradigmFieldLabel"].index(tr("Step Size 2"))]
##                 prm["adaptiveType"] = prm[currBlock]["paradigmChooser"][prm[currBlock]["paradigmChooserLabel"].index(tr("Procedure:"))]
##                 prm["trackDir"] = prm[currBlock]["paradigmChooser"][prm[currBlock]["paradigmChooserLabel"].index(tr("Initial Track Direction:"))]
##                 prm["numberCorrectNeeded"] = 1
##                 prm["numberIncorrectNeeded"] = 1

##             elif prm["paradigm"] == tr("Weighted Up-Down Interleaved"):
##                 prm["adaptiveType"] = prm[currBlock]["paradigmChooser"][prm[currBlock]["paradigmChooserLabel"].index(tr("Procedure:"))]
##                 prm["turnpointsToAverage"] = prm[currBlock]["paradigmChooser"][prm[currBlock]["paradigmChooserLabel"].index(tr("Turnpoints to average:"))]
##                 prm["percentCorrectTracked"] = []
##                 prm["numberCorrectNeeded"] = []
##                 prm["numberIncorrectNeeded"] = []
##                 prm["initialTurnpoints"] = []
##                 prm["totalTurnpoints"] = []
##                 prm["adaptiveStepSize1"] = []
##                 prm["adaptiveStepSize2"] = []
##                 prm["consecutiveTrialsCounter"] = []
##                 prm["trackDir"] = []
##                 for i in range(prm["nDifferences"]):
##                     prm["numberCorrectNeeded"].append(1)
##                     prm["numberIncorrectNeeded"].append(1)
##                     prm["percentCorrectTracked"].append(float(prm[currBlock]["paradigmField"][prm[currBlock]["paradigmFieldLabel"].index(tr("Percent Correct Tracked Track " + str(i+1)))]))
##                     prm["initialTurnpoints"].append(int(prm[currBlock]["paradigmField"][prm[currBlock]["paradigmFieldLabel"].index(tr("Initial Turnpoints Track " + str(i+1)))]))
##                     prm["totalTurnpoints"].append(int(prm[currBlock]["paradigmField"][prm[currBlock]["paradigmFieldLabel"].index(tr("Total Turnpoints Track " + str(i+1)))]))
##                     prm["adaptiveStepSize1"].append(prm[currBlock]["paradigmField"][prm[currBlock]["paradigmFieldLabel"].index(tr("Step Size 1 Track " + str(i+1)))])
##                     prm["adaptiveStepSize2"].append(prm[currBlock]["paradigmField"][prm[currBlock]["paradigmFieldLabel"].index(tr("Step Size 2 Track " + str(i+1)))])
##                     prm["consecutiveTrialsCounter"].append(0)
##                     prm["trackDir"].append(prm[currBlock]["paradigmChooser"][prm[currBlock]["paradigmChooserLabel"].index(tr("Initial Track {0} Direction:".format(str(i+1))))])
##             elif prm["paradigm"] in [tr("Constant m-Intervals n-Alternatives"), tr("Constant 1-Interval 2-Alternatives"),
##                                           tr("Constant 1-Pair Same/Different")]:
##                 prm["nTrials"] = int(prm[currBlock]["paradigmField"][prm[currBlock]["paradigmFieldLabel"].index(tr("No. Trials"))])
##                 prm["nPracticeTrials"] = int(prm[currBlock]["paradigmField"][prm[currBlock]["paradigmFieldLabel"].index(tr("No. Practice Trials"))])
##             elif prm["paradigm"] in [tr("Multiple Constants 1-Interval 2-Alternatives"), tr("Multiple Constants m-Intervals n-Alternatives"),
##                                           tr("Odd One Out")]:
##                 prm["nTrials"] = int(prm[currBlock]["paradigmField"][prm[currBlock]["paradigmFieldLabel"].index(tr("No. Trials"))])
##                 prm["nPracticeTrials"] = int(prm[currBlock]["paradigmField"][prm[currBlock]["paradigmFieldLabel"].index(tr("No. Practice Trials"))])
##                 prm["nDifferences"] = int(prm[currBlock]["paradigmChooser"][prm[currBlock]["paradigmChooserLabel"].index(tr("No. Differences:"))])
##                 if prm["startOfBlock"] == True:
##                     prm["currentDifference"] = numpy.random.randint(prm["nDifferences"])
##             elif prm["paradigm"] == tr("PEST"):
##                 prm["trackDir"] = prm[currBlock]["paradigmChooser"][prm[currBlock]["paradigmChooserLabel"].index(tr("Initial Track Direction:"))]
##                 prm["adaptiveType"] = prm[currBlock]["paradigmChooser"][prm[currBlock]["paradigmChooserLabel"].index(tr("Procedure:"))]
##                 prm["initialStepSize"] = float(prm[currBlock]["paradigmField"][prm[currBlock]["paradigmFieldLabel"].index(tr("Initial Step Size"))])
##                 prm["minStepSize"] = float(prm[currBlock]["paradigmField"][prm[currBlock]["paradigmFieldLabel"].index(tr("Minimum Step Size"))])
##                 prm["maxStepSize"] = float(prm[currBlock]["paradigmField"][prm[currBlock]["paradigmFieldLabel"].index(tr("Maximum Step Size"))])
##                 prm["percentCorrectTracked"] = float(prm[currBlock]["paradigmField"][prm[currBlock]["paradigmFieldLabel"].index(tr("Percent Correct Tracked"))])
##                 prm["W"] = float(prm[currBlock]["paradigmField"][prm[currBlock]["paradigmFieldLabel"].index(tr("W"))])
        
##         if prm["startOfBlock"] == True and "resultsFile" not in prm:
##             if prm["pref"]["general"]["resFileFormat"] == "fixed":
##                 prm["resultsFile"] = prm["pref"]["general"]["resFileFixedString"]
##                 resFileToOpen = copy.copy(prm["pref"]["general"]["resFileFixedString"])

##                 fName = open(resFileToOpen, "w")
##                 fName.write("")
##                 fName.close()
##             elif prm["pref"]["general"]["resFileFormat"] == "variable":
##                 prm["resultsFile"] = prm["listener"] + "_" + time.strftime("%y-%m-%d_%H-%M-%S", time.localtime())

##         if prm["paradigm"] in [tr("Transformed Up-Down Interleaved"), tr("Weighted Up-Down Interleaved")]:
##             if prm["maxConsecutiveTrials"] == tr("unlimited"):
##                 prm["currentDifference"] = numpy.random.randint(prm["nDifferences"])
##             elif  max(prm["consecutiveTrialsCounter"]) < int(prm["maxConsecutiveTrials"]):
##                 prm["currentDifference"] = numpy.random.randint(prm["nDifferences"])
##             else:
##                 choices = list(range(prm["nDifferences"]))
##                 choices.pop(prm["consecutiveTrialsCounter"].index(max(prm["consecutiveTrialsCounter"])))
##                 prm["currentDifference"] = random.choice(choices)
##             for i in range(prm["nDifferences"]):
##                 if i == prm["currentDifference"]:
##                     prm["consecutiveTrialsCounter"][prm["currentDifference"]] = prm["consecutiveTrialsCounter"][prm["currentDifference"]] + 1
##                 else:
##                     prm["consecutiveTrialsCounter"][i] = 0
     

##         currExp = tr(prm[currBlock]["experiment"])
##         pychovariables =           ["[resDir]",
##                                          "[resFile]",
##                                          "[resFileFull]",
##                                          "[resFileRes]",
##                                          "[resTable]",
##                                          "[listener]",
##                                          "[experimenter]",
##                                          "[resTableProcessed]",
##                                          "[pdfPlot]"]
##         pychovariablesSubstitute = [os.path.dirname(prm["resultsFile"]),
##                                          prm["resultsFile"],
##                                          prm["resultsFile"].split(".txt")[0]+"_full.txt",
##                                          prm["resultsFile"].split(".txt")[0]+"_res.txt",
##                                          prm["resultsFile"].split(".txt")[0]+"_table.csv",
##                                          prm["listener"], prm["experimenter"],
##                                          prm["resultsFile"].split(".txt")[0]+"_table_processed.csv",
##                                          prm["resultsFile"].split(".txt")[0]+"_table_processed.pdf"]
      

        
##         time.sleep(prm[currBlock]["preTrialSilence"]/1000)
##         execString = prm[currExp]["execString"]
      
##         try:
##             methodToCall1 = getattr(default_experiments, execString)
##         except:
##             pass
##         try:
##             methodToCall1 = getattr(labexp, execString)
##         except:
##             pass
        
##         methodToCall2 = getattr(methodToCall1, "doTrial_"+ execString)
##         result = methodToCall2(self)
##         QApplication.processEvents()
##         prm["trialRunning"] = False
##         if prm["allBlocks"]["responseMode"] == tr("Automatic"):
##             if numpy.random.uniform(0, 1, 1)[0] < prm["allBlocks"]["autoPCCorr"]:
##                 sortResponse(correctButton)
##             else:
##                 sortResponse(random.choice(numpy.delete(numpy.arange(prm["nAlternatives"])+1, correctButton-1)))
##        #==================================================================
end

function sortResponseButton()
##         buttonClicked = responseButton.index(sender())+1
##         sortResponse(buttonClicked)
end

##     def keyPressEvent(self, event):
##         if (event.type() == QEvent.KeyPress): 
##             if event.key()==Qt.Key_0:
##                 buttonClicked = 0
##             elif event.key()==Qt.Key_1:
##                 buttonClicked = 1
##             elif event.key()==Qt.Key_2:
##                 buttonClicked = 2
##             elif event.key()==Qt.Key_3:
##                 buttonClicked = 3
##             elif event.key()==Qt.Key_4:
##                 buttonClicked = 4
##             elif event.key()==Qt.Key_5:
##                 buttonClicked = 5
##             elif event.key()==Qt.Key_6:
##                 buttonClicked = 6
##             elif event.key()==Qt.Key_7:
##                 buttonClicked = 7
##             elif event.key()==Qt.Key_8:
##                 buttonClicked = 8
##             elif event.key()==Qt.Key_9:
##                 buttonClicked = 9
##             else:
##                 buttonClicked = 0
##             sortResponse(buttonClicked)
##         return 
       
##     def sortResponse(self, buttonClicked):
        
##         currBlock = "b"+ str(prm["currentBlock"])
##         if buttonClicked == 0: #0 is not a response option
##             return
##         if buttonClicked > prm["nAlternatives"] or statusButton.text() != prm["rbTrans"].translate("rb", "Running"): #tr("Running"): #1) do not accept responses outside the possible alternatives and 2) if the block is not running (like wait or finished)
##             return
##         if buttonClicked < (prm["nAlternatives"]+1) and prm["trialRunning"] == True: #1) can"t remember why I put the first condition 2) do not accept responses while the trial is running
##             return
##         if prm["sortingResponse"] == True: #Do not accept other responses while processing the current one
##             return
##         prm["sortingResponse"] = True

##         if prm["paradigm"] == tr("Transformed Up-Down"):
##             sortResponseAdaptive(buttonClicked, "transformedUpDown")
##         elif prm["paradigm"] == tr("Transformed Up-Down Interleaved"):
##             sortResponseAdaptiveInterleaved(buttonClicked, "transformedUpDown")
##         elif prm["paradigm"] == tr("Weighted Up-Down"):
##             sortResponseAdaptive(buttonClicked, "weightedUpDown")
##         elif prm["paradigm"] == tr("Weighted Up-Down Interleaved"):
##             sortResponseAdaptiveInterleaved(buttonClicked, "weightedUpDown")
##         elif prm["paradigm"] == tr("Constant 1-Interval 2-Alternatives"):
##             sortResponseConstant1Interval2Alternatives(buttonClicked)
##         elif prm["paradigm"] == tr("Multiple Constants 1-Interval 2-Alternatives"):
##             sortResponseMultipleConstants1Interval2Alternatives(buttonClicked)
##         elif prm["paradigm"] == tr("Constant m-Intervals n-Alternatives"):
##             sortResponseConstantMIntervalsNAlternatives(buttonClicked)
##         elif prm["paradigm"] == tr("Multiple Constants m-Intervals n-Alternatives"):
##             sortResponseMultipleConstantsMIntervalsNAlternatives(buttonClicked)
##         elif prm["paradigm"] == tr("Constant 1-Pair Same/Different"):
##             sortResponseConstant1PairSameDifferent(buttonClicked)
##         elif prm["paradigm"] == tr("PEST"):
##             sortResponsePEST(buttonClicked)
##         elif prm["paradigm"] == tr("Odd One Out"):
##             sortResponseOddOneOut(buttonClicked)
##         prm["sortingResponse"] = False
            
##     def sortResponseAdaptive(self, buttonClicked, method):
##         if prm["startOfBlock"] == True:
##             prm["correctCount"] = 0
##             prm["incorrectCount"] = 0
##             prm["nTurnpoints"] = 0
##             prm["startOfBlock"] = False
##             prm["turnpointVal"] = []
##             fullFileLines = []
##             prm["buttonCounter"] = [0 for i in range(prm["nAlternatives"])]
##         prm["buttonCounter"][buttonClicked-1] = prm["buttonCounter"][buttonClicked-1] + 1

##         if method == "transformedUpDown":
##             if prm["nTurnpoints"] < prm["initialTurnpoints"]:
##                 stepSizeDown = prm["adaptiveStepSize1"]
##                 stepSizeUp   = prm["adaptiveStepSize1"]
##             else:
##                 stepSizeDown = prm["adaptiveStepSize2"]
##                 stepSizeUp   = prm["adaptiveStepSize2"]
##         elif method == "weightedUpDown":
##             if prm["nTurnpoints"] < prm["initialTurnpoints"]:
##                 stepSizeDown = prm["adaptiveStepSize1"]
##                 if prm["adaptiveType"] == tr("Arithmetic"):
##                     stepSizeUp = prm["adaptiveStepSize1"] * (prm["percentCorrectTracked"] / (100-prm["percentCorrectTracked"]))
##                 elif prm["adaptiveType"] == tr("Geometric"):
##                     stepSizeUp = prm["adaptiveStepSize1"] ** (prm["percentCorrectTracked"] / (100-prm["percentCorrectTracked"]))
##             else:
##                 stepSizeDown = prm["adaptiveStepSize2"]
##                 if prm["adaptiveType"] == tr("Arithmetic"):
##                     stepSizeUp = prm["adaptiveStepSize2"] * (prm["percentCorrectTracked"] / (100-prm["percentCorrectTracked"]))
##                 elif prm["adaptiveType"] == tr("Geometric"):
##                     stepSizeUp = prm["adaptiveStepSize2"] ** (prm["percentCorrectTracked"] / (100-prm["percentCorrectTracked"]))
            
##         if buttonClicked == correctButton:
##             if prm["responseLight"] == tr("Feedback"):
##                 responseLight.giveFeedback("correct")
##             elif prm["responseLight"] == tr("Neutral"):
##                 responseLight.giveFeedback("neutral")
##             elif prm["responseLight"] == tr("None"):
##                 responseLight.giveFeedback("off")
            
##             fullFileLog.write(str(prm["adaptiveDifference"]) + "; ")
##             fullFileLines.append(str(prm["adaptiveDifference"]) + "; ")
##             fullFileLog.write("1; ")
##             fullFileLines.append("1; ")
##             if "additional_parameters_to_write" in prm:
##                 for p in range(len(prm["additional_parameters_to_write"])):
##                     fullFileLog.write(str(prm["additional_parameters_to_write"][p]))
##                     fullFileLines.append(str(prm["additional_parameters_to_write"][p]))
##                     fullFileLog.write(" ;")
##                     fullFileLines.append(" ;")
##             fullFileLog.write("\n")
##             fullFileLines.append("\n")
##             prm["correctCount"] = prm["correctCount"] + 1
##             prm["incorrectCount"] = 0

##             if prm["correctCount"] == prm["numberCorrectNeeded"]:
##                 prm["correctCount"] = 0
##                 if prm["trackDir"] == tr("Up"):
##                     prm["turnpointVal"].append(prm["adaptiveDifference"])
##                     prm["nTurnpoints"] = prm["nTurnpoints"] +1
##                     prm["trackDir"] = tr("Down")
                        
##                 if prm["adaptiveType"] == tr("Arithmetic"):
##                     prm["adaptiveDifference"] = prm["adaptiveDifference"] - stepSizeDown
##                 elif prm["adaptiveType"] == tr("Geometric"):
##                     prm["adaptiveDifference"] = prm["adaptiveDifference"] / stepSizeDown
                
##         elif buttonClicked != correctButton:
##             if prm["responseLight"] == tr("Feedback"):
##                 responseLight.giveFeedback("incorrect")
##             elif prm["responseLight"] == tr("Neutral"):
##                 responseLight.giveFeedback("neutral")
##             elif prm["responseLight"] == tr("None"):
##                 responseLight.giveFeedback("off")
                
##             fullFileLog.write(str(prm["adaptiveDifference"]) + "; ")
##             fullFileLines.append(str(prm["adaptiveDifference"]) + "; ")
##             fullFileLog.write("0; ")
##             fullFileLines.append("0; ")
##             if "additional_parameters_to_write" in prm:
##                 for p in range(len(prm["additional_parameters_to_write"])):
##                     fullFileLog.write(str(prm["additional_parameters_to_write"][p]))
##                     fullFileLines.append(str(prm["additional_parameters_to_write"][p]))
##                     fullFileLog.write("; ")
##                     fullFileLines.append("; ")
##             fullFileLog.write("\n")
##             fullFileLines.append("\n")
            
##             prm["incorrectCount"] = prm["incorrectCount"] + 1
##             prm["correctCount"] = 0

##             if prm["incorrectCount"] == prm["numberIncorrectNeeded"]:
##                 prm["incorrectCount"] = 0
##                 if prm["trackDir"] == tr("Down"):
##                     prm["turnpointVal"].append(prm["adaptiveDifference"])
##                     prm["nTurnpoints"] = prm["nTurnpoints"] +1
##                     prm["trackDir"] = tr("Up")
                    
##                 if prm["adaptiveType"] == tr("Arithmetic"):
##                     prm["adaptiveDifference"] = prm["adaptiveDifference"] + stepSizeUp
##                 elif prm["adaptiveType"] == tr("Geometric"):
##                     prm["adaptiveDifference"] = prm["adaptiveDifference"] * stepSizeUp

##         fullFileLog.flush()
##         pcDone = (prm["nTurnpoints"] / prm["totalTurnpoints"]) * 100
##         bp = int(prm["b"+str(prm["currentBlock"])]["blockPosition"])
##         pcThisRep = (bp-1) / prm["storedBlocks"]*100 + 1 / prm["storedBlocks"]*pcDone
##         pcTot = (prm["currentRepetition"] - 1) / prm["allBlocks"]["repetitions"]*100 + 1 / prm["allBlocks"]["repetitions"]*pcThisRep
##         gauge.setValue(pcTot)
##         if prm["nTurnpoints"] == prm["totalTurnpoints"]:
##             writeResultsHeader("standard")
##             #process results
##             fullFileLog.write("\n")
##             fullFileLines.append("\n")
##             for i in range(len(fullFileLines)):
##                 fullFile.write(fullFileLines[i])
##             for i in range(len(prm["turnpointVal"])):
##                 if i == prm["initialTurnpoints"]:
##                     resFile.write("| ")
##                 resFile.write("%5.2f " %prm["turnpointVal"][i])
##                 resFileLog.write("%5.2f " %prm["turnpointVal"][i])
##                 if i == prm["totalTurnpoints"]-1:
##                     resFile.write("| ")
##             if prm["adaptiveType"] == tr("Arithmetic"):
##                 turnpointMean = mean(prm["turnpointVal"][prm["initialTurnpoints"] : prm["totalTurnpoints"]])
##                 turnpointSd = std(prm["turnpointVal"][prm["initialTurnpoints"] : prm["totalTurnpoints"]], ddof=1)
##                 resFile.write("\n\n")
##                 resFile.write("turnpointMean = %5.2f, s.d. = %5.2f \n" %(turnpointMean,turnpointSd))
##                 resFileLog.write("\n\n")
##                 resFileLog.write("turnpointMean = %5.2f, s.d. = %5.2f \n" %(turnpointMean,turnpointSd))
##             elif prm["adaptiveType"] == tr("Geometric"):
##                 turnpointMean = geoMean(prm["turnpointVal"][prm["initialTurnpoints"] : prm["totalTurnpoints"]])
##                 turnpointSd = geoSd(prm["turnpointVal"][prm["initialTurnpoints"] : prm["totalTurnpoints"]])
##                 resFile.write("\n\n")
##                 resFile.write("geometric turnpointMean = %5.2f, s.d. = %5.2f \n" %(turnpointMean,turnpointSd))
##                 resFileLog.write("\n\n")
##                 resFileLog.write("geometric turnpointMean = %5.2f, s.d. = %5.2f \n" %(turnpointMean,turnpointSd))

##             for i in range(prm["nAlternatives"]):
##                 resFile.write("B{0} = {1}".format(i+1, prm["buttonCounter"][i]))
##                 resFileLog.write("B{0} = {1}".format(i+1, prm["buttonCounter"][i]))
##                 if i != prm["nAlternatives"]-1:
##                     resFile.write(", ")
##                     resFileLog.write(", ")
##             resFile.write("\n\n")
##             resFile.flush()
##             resFileLog.write("\n\n")
##             resFileLog.flush()
##             getEndTime()

##             currBlock = "b" + str(prm["currentBlock"])
##             durString = "{0:5.3f}".format(prm["blockEndTime"] - prm["blockStartTime"])
##             resLineToWrite = "{0:5.3f}".format(turnpointMean) + prm["pref"]["general"]["csvSeparator"] + \
##                              "{0:5.3f}".format(turnpointSd) + prm["pref"]["general"]["csvSeparator"] + \
##                              prm[currBlock]["conditionLabel"] + prm["pref"]["general"]["csvSeparator"] + \
##                              prm["listener"] + prm["pref"]["general"]["csvSeparator"] + \
##                              prm["sessionLabel"] + prm["pref"]["general"]["csvSeparator"] + \
##                              prm["allBlocks"]["experimentLabel"] + prm["pref"]["general"]["csvSeparator"] +\
##                              prm["blockEndDateString"] + prm["pref"]["general"]["csvSeparator"] + \
##                              prm["blockEndTimeString"] + prm["pref"]["general"]["csvSeparator"] + \
##                              durString + prm["pref"]["general"]["csvSeparator"] + \
##                              prm[currBlock]["blockPosition"] + prm["pref"]["general"]["csvSeparator"] + \
##                              prm[currBlock]["experiment"] + prm["pref"]["general"]["csvSeparator"] +\
##                              prm[currBlock]["paradigm"] + prm["pref"]["general"]["csvSeparator"]
##             resLineToWrite = getCommonTabFields(resLineToWrite)
##             resLineToWrite = resLineToWrite + "\n"
            
##             if method == "transformedUpDown":
##                 writeResultsSummaryLine("Transformed Up-Down", resLineToWrite)
##             elif method == "weightedUpDown":
##                 writeResultsSummaryLine("Weighted Up-Down", resLineToWrite)

##             atBlockEnd()
            
##         else:
##             doTrial()


##     def sortResponseAdaptiveInterleaved(self, buttonClicked, method):
##         if prm["startOfBlock"] == True:
##             prm["correctCount"] = [0 for number in range(prm["nDifferences"])]
##             prm["incorrectCount"] = [0 for number in range(prm["nDifferences"])]
##             prm["nTurnpoints"] = [0 for number in range(prm["nDifferences"])]
##             prm["startOfBlock"] = False
##             prm["turnpointVal"] = [[] for number in range(prm["nDifferences"])]
##             fullFileLines = []
##             prm["buttonCounter"] = [[0 for a in range(prm["nAlternatives"])] for i in range(prm["nDifferences"])]
           
##         trackNumber = prm["currentDifference"]
##         prm["buttonCounter"][trackNumber][buttonClicked-1] = prm["buttonCounter"][trackNumber][buttonClicked-1] + 1
            
##         if method == "weightedUpDown":
##             if prm["nTurnpoints"][trackNumber] < prm["initialTurnpoints"][trackNumber]:
##                 stepSizeDown = prm["adaptiveStepSize1"][trackNumber]
##                 if prm["adaptiveType"] == tr("Arithmetic"):
##                     stepSizeUp   = prm["adaptiveStepSize1"][trackNumber] * (prm["percentCorrectTracked"][trackNumber] / (100-prm["percentCorrectTracked"][trackNumber]))
##                 elif prm["adaptiveType"] == tr("Geometric"):
##                     stepSizeUp   = prm["adaptiveStepSize1"][trackNumber] ** (prm["percentCorrectTracked"][trackNumber] / (100-prm["percentCorrectTracked"][trackNumber]))
##             else:
##                 stepSizeDown = prm["adaptiveStepSize2"][trackNumber]
##                 if prm["adaptiveType"] == tr("Arithmetic"):
##                     stepSizeUp   = prm["adaptiveStepSize2"][trackNumber] * (prm["percentCorrectTracked"][trackNumber] / (100-prm["percentCorrectTracked"][trackNumber]))
##                 elif prm["adaptiveType"] == tr("Geometric"):
##                     stepSizeUp   = prm["adaptiveStepSize2"][trackNumber] ** (prm["percentCorrectTracked"][trackNumber] / (100-prm["percentCorrectTracked"][trackNumber]))
##         elif method == "transformedUpDown":
##             if prm["nTurnpoints"][trackNumber] < prm["initialTurnpoints"][trackNumber]:
##                 stepSizeDown = prm["adaptiveStepSize1"][trackNumber]
##                 stepSizeUp   = prm["adaptiveStepSize1"][trackNumber]
##             else:
##                 stepSizeDown = prm["adaptiveStepSize2"][trackNumber]
##                 stepSizeUp   = prm["adaptiveStepSize2"][trackNumber]
            
##         if buttonClicked == correctButton:
##             if prm["responseLight"] == tr("Feedback"):
##                 responseLight.giveFeedback("correct")
##             elif prm["responseLight"] == tr("Neutral"):
##                 responseLight.giveFeedback("neutral")
##             elif prm["responseLight"] == tr("None"):
##                 responseLight.giveFeedback("off")
            
##             fullFileLog.write(str(prm["adaptiveDifference"][trackNumber]) + "; ")
##             fullFileLines.append(str(prm["adaptiveDifference"][trackNumber]) + "; ")
##             fullFileLog.write("TRACK %d; 1; " %(trackNumber+1))
##             fullFileLines.append("TRACK %d; 1; " %(trackNumber+1))
##             if "additional_parameters_to_write" in prm:
##                 for p in range(len(prm["additional_parameters_to_write"])):
##                     fullFileLog.write(str(prm["additional_parameters_to_write"][p]))
##                     fullFileLines.append(str(prm["additional_parameters_to_write"][p]))
##                     fullFileLog.write("; ")
##                     fullFileLines.append("; ")
##             fullFileLog.write("\n")
##             fullFileLines.append("\n")
##             prm["correctCount"][trackNumber] = prm["correctCount"][trackNumber] + 1
##             prm["incorrectCount"][trackNumber] = 0

##             if prm["correctCount"][trackNumber] == prm["numberCorrectNeeded"][trackNumber]:
##                 prm["correctCount"][trackNumber] = 0
##                 if prm["trackDir"][trackNumber] == tr("Up"):
##                     prm["turnpointVal"][trackNumber].append(prm["adaptiveDifference"][trackNumber])
##                     prm["nTurnpoints"][trackNumber] = prm["nTurnpoints"][trackNumber] +1
##                     prm["trackDir"][trackNumber] = tr("Down")
                        
##                 if prm["adaptiveType"] == tr("Arithmetic"):
##                     prm["adaptiveDifference"][trackNumber] = prm["adaptiveDifference"][trackNumber] - stepSizeDown
##                 elif prm["adaptiveType"] == tr("Geometric"):
##                     prm["adaptiveDifference"][trackNumber] = prm["adaptiveDifference"][trackNumber] / stepSizeDown
                
##         elif buttonClicked != correctButton:
##             if prm["responseLight"] == tr("Feedback"):
##                 responseLight.giveFeedback("incorrect")
##             elif prm["responseLight"] == tr("Neutral"):
##                 responseLight.giveFeedback("neutral")
##             elif prm["responseLight"] == tr("None"):
##                 responseLight.giveFeedback("off")
                
##             fullFileLog.write(str(prm["adaptiveDifference"][trackNumber]) + "; ")
##             fullFileLines.append(str(prm["adaptiveDifference"][trackNumber]) + "; ")
##             fullFileLog.write("TRACK %d; 0; " %(trackNumber+1))
##             fullFileLines.append("TRACK %d; 0; " %(trackNumber+1))
##             if "additional_parameters_to_write" in prm:
##                 for p in range(len(prm["additional_parameters_to_write"])):
##                     fullFileLog.write(str(prm["additional_parameters_to_write"][p]))
##                     fullFileLines.append(str(prm["additional_parameters_to_write"][p]))
##                     fullFileLog.write("; ")
##                     fullFileLines.append("; ")
##             fullFileLog.write("\n")
##             fullFileLines.append("\n")
            
##             prm["incorrectCount"][trackNumber] = prm["incorrectCount"][trackNumber] + 1
##             prm["correctCount"][trackNumber] = 0

##             if prm["incorrectCount"][trackNumber] == prm["numberIncorrectNeeded"][trackNumber]:
##                 prm["incorrectCount"][trackNumber] = 0
##                 if prm["trackDir"][trackNumber] == tr("Down"):
##                     prm["turnpointVal"][trackNumber].append(prm["adaptiveDifference"][trackNumber])
##                     prm["nTurnpoints"][trackNumber] = prm["nTurnpoints"][trackNumber] +1
##                     prm["trackDir"][trackNumber] = tr("Up")
                    
##                 if prm["adaptiveType"] == tr("Arithmetic"):
##                     prm["adaptiveDifference"][trackNumber] = prm["adaptiveDifference"][trackNumber] + stepSizeUp
##                 elif prm["adaptiveType"] == tr("Geometric"):
##                     prm["adaptiveDifference"][trackNumber] = prm["adaptiveDifference"][trackNumber] * stepSizeUp
      
##         fullFileLog.flush()
##         currNTurnpoints = 0
##         currTotTurnpoints = 0
##         for i in range(prm["nDifferences"]):
##             currNTurnpoints = currNTurnpoints + min(prm["nTurnpoints"][i], prm["totalTurnpoints"][i])
##             currTotTurnpoints = currTotTurnpoints + prm["totalTurnpoints"][i]
##         pcDone = (currNTurnpoints / currTotTurnpoints) * 100
##         bp = int(prm["b"+str(prm["currentBlock"])]["blockPosition"])
##         pcThisRep = (bp-1) / prm["storedBlocks"]*100 + 1 / prm["storedBlocks"]*pcDone
##         pcTot = (prm["currentRepetition"] - 1) / prm["allBlocks"]["repetitions"]*100 + 1 / prm["allBlocks"]["repetitions"]*pcThisRep
##         gauge.setValue(pcTot)

##         finished = 0
##         for i in range(prm["nDifferences"]):
##             if prm["nTurnpoints"][i] >=  prm["totalTurnpoints"][i]:
##                 finished = finished + 1
##         if finished == prm["nDifferences"]:
##             writeResultsHeader("standard")
##             #process results
##             fullFileLog.write("\n")
##             fullFileLines.append("\n")
##             for i in range(len(fullFileLines)):
##                 fullFile.write(fullFileLines[i])
##             turnpointMeanList = []
##             turnpointSdList = []
##             for j in range(prm["nDifferences"]):
##                 resFile.write("TRACK %d:\n" %(j+1))
##                 resFileLog.write("TRACK %d:\n" %(j+1))
##                 if prm["turnpointsToAverage"] == tr("All final stepsize (even)"):
##                     tnpStart = prm["initialTurnpoints"][j]
##                     tnpEnd = len(prm["turnpointVal"][j])
##                     if (tnpEnd-tnpStart)%2 > 0: #odd number of turnpoints
##                         tnpStart = prm["initialTurnpoints"][j] + 1
##                 elif prm["turnpointsToAverage"] == tr("First N final stepsize"):
##                     tnpStart = prm["initialTurnpoints"][j]
##                     tnpEnd = prm["totalTurnpoints"][j]
##                 elif prm["turnpointsToAverage"] == tr("Last N final stepsize"):
##                     tnpStart = len(prm["turnpointVal"][j]) - (prm["totalTurnpoints"][j] - prm["initialTurnpoints"][j])
##                     tnpEnd = len(prm["turnpointVal"][j])
##                 for i in range(len(prm["turnpointVal"][j])):
##                     if i == (tnpStart):
##                         resFile.write("| ")
##                         resFileLog.write("| ")
##                     resFile.write("%5.2f " %prm["turnpointVal"][j][i])
##                     resFileLog.write("%5.2f " %prm["turnpointVal"][j][i])
##                     if i == (tnpEnd-1):
##                         resFile.write("| ")
##                         resFileLog.write("| ")
##                 if prm["adaptiveType"] == tr("Arithmetic"):
##                     turnpointMean = mean(prm["turnpointVal"][j][tnpStart : tnpEnd])
##                     turnpointSd = std(prm["turnpointVal"][j][tnpStart : tnpEnd], ddof=1)
##                     resFile.write("\n\n")
##                     resFile.write("turnpointMean = %5.2f, s.d. = %5.2f \n" %(turnpointMean,turnpointSd))
##                     resFileLog.write("\n\n")
##                     resFileLog.write("turnpointMean = %5.2f, s.d. = %5.2f \n" %(turnpointMean,turnpointSd))
##                     turnpointMeanList.append(turnpointMean)
##                     turnpointSdList.append(turnpointSd)
##                 elif prm["adaptiveType"] == tr("Geometric"):
##                     turnpointMean = geoMean(prm["turnpointVal"][j][tnpStart : tnpEnd])
##                     turnpointSd = geoSd(prm["turnpointVal"][j][tnpStart : tnpEnd])
##                     resFile.write("\n\n")
##                     resFile.write("geometric turnpointMean = %5.2f, s.d. = %5.2f \n" %(turnpointMean,turnpointSd))
##                     resFileLog.write("\n\n")
##                     resFileLog.write("geometric turnpointMean = %5.2f, s.d. = %5.2f \n" %(turnpointMean,turnpointSd))
##                     turnpointMeanList.append(turnpointMean)
##                     turnpointSdList.append(turnpointSd)
##                 for a in range(prm["nAlternatives"]):
##                     resFile.write("B{0} = {1}".format(a+1, prm["buttonCounter"][j][a]))
##                     resFileLog.write("B{0} = {1}".format(a+1, prm["buttonCounter"][j][a]))
##                     if a != prm["nAlternatives"]-1:
##                         resFile.write(", ")
##                         resFileLog.write(", ")
##                 if j != prm["nDifferences"]-1:
##                     resFile.write("\n\n")
##                     resFileLog.write("\n\n")
##             resFile.write("\n.\n")
##             resFile.flush()
##             resFileLog.write("\n.\n")
##             resFileLog.flush()
##             getEndTime()


##             currBlock = "b" + str(prm["currentBlock"])
##             durString = "{0:5.3f}".format(prm["blockEndTime"] - prm["blockStartTime"])
##             resLineToWrite = ""
##             for j in range(prm["nDifferences"]):
##                  resLineToWrite = resLineToWrite + "{0:5.3f}".format(turnpointMeanList[j]) + prm["pref"]["general"]["csvSeparator"] + \
##                                   "{0:5.3f}".format(turnpointSdList[j]) + prm["pref"]["general"]["csvSeparator"] 
           
##             resLineToWrite = resLineToWrite + prm[currBlock]["conditionLabel"] + prm["pref"]["general"]["csvSeparator"] + \
##                              prm["listener"] + prm["pref"]["general"]["csvSeparator"] + \
##                              prm["sessionLabel"] + prm["pref"]["general"]["csvSeparator"] + \
##                              prm["allBlocks"]["experimentLabel"] + prm["pref"]["general"]["csvSeparator"] +\
##                              prm["blockEndDateString"] + prm["pref"]["general"]["csvSeparator"] + \
##                              prm["blockEndTimeString"] + prm["pref"]["general"]["csvSeparator"] + \
##                              durString + prm["pref"]["general"]["csvSeparator"] + \
##                              prm[currBlock]["blockPosition"] + prm["pref"]["general"]["csvSeparator"] + \
##                              prm[currBlock]["experiment"] + prm["pref"]["general"]["csvSeparator"] + \
##                              prm[currBlock]["paradigm"] + prm["pref"]["general"]["csvSeparator"]

##             resLineToWrite = getCommonTabFields(resLineToWrite)
##             resLineToWrite = resLineToWrite + "\n"
            
##             if method == "transformedUpDown":
##                 writeResultsSummaryLine("Transformed Up-Down Interleaved", resLineToWrite)
##             elif  method == "weightedUpDown":
##                 writeResultsSummaryLine("Weighted Up-Down Interleaved", resLineToWrite)
            
##             atBlockEnd()
          
##         else:
##             doTrial()

##     def sortResponseConstantMIntervalsNAlternatives(self, buttonClicked):
##         if prm["startOfBlock"] == True:
##             prm["startOfBlock"] = False

##             fullFileLines = []
##             trialCount = 0
##             correctCount = 0
##             trialCountAll = 0

##         trialCountAll = trialCountAll + 1
##         if trialCountAll > prm["nPracticeTrials"]:
##             trialCount = trialCount + 1
##         if buttonClicked == correctButton:
##             if prm["responseLight"] == tr("Feedback"):
##                 responseLight.giveFeedback("correct")
##             elif prm["responseLight"] == tr("Neutral"):
##                 responseLight.giveFeedback("neutral")
##             elif prm["responseLight"] == tr("None"):
##                 responseLight.giveFeedback("off")

##             if trialCountAll > prm["nPracticeTrials"]:
##                 correctCount = correctCount + 1
##             resp = "1"
##         elif buttonClicked != correctButton:
##             if prm["responseLight"] == tr("Feedback"):
##                 responseLight.giveFeedback("incorrect")
##             elif prm["responseLight"] == tr("Neutral"):
##                 responseLight.giveFeedback("neutral")
##             elif prm["responseLight"] == tr("None"):
##                 responseLight.giveFeedback("off")
##             resp = "0"
##         fullFileLog.write(resp + "; ")
##         fullFileLines.append(resp + "; ")
##         if "additional_parameters_to_write" in prm:
##             for p in range(len(prm["additional_parameters_to_write"])):
##                 fullFileLog.write(str(prm["additional_parameters_to_write"][p]))
##                 fullFileLines.append(str(prm["additional_parameters_to_write"][p]))
##                 fullFileLog.write("; ")
##                 fullFileLines.append("; ")
##         fullFileLog.write("\n")
##         fullFileLines.append("\n")
##         fullFileLog.flush()
       
##         pcDone = trialCountAll / (prm["nTrials"]+prm["nPracticeTrials"]) * 100
##         bp = int(prm["b"+str(prm["currentBlock"])]["blockPosition"])
##         pcThisRep = (bp-1) / prm["storedBlocks"]*100 + 1 / prm["storedBlocks"]*pcDone
##         pcTot = (prm["currentRepetition"] - 1) / prm["allBlocks"]["repetitions"]*100 + 1 / prm["allBlocks"]["repetitions"]*pcThisRep
##         gauge.setValue(pcTot)
        
##         if trialCountAll >= (prm["nTrials"] + prm["nPracticeTrials"]): # Block is completed
##             writeResultsHeader("standard")
##             for i in range(len(fullFileLines)):
##                 fullFile.write(fullFileLines[i])
##             fullFileLog.write("\n")
##             fullFile.write("\n")
            
##             propCorr = correctCount/trialCount
##             dp = dprime_mAFC(propCorr, prm["nAlternatives"])
##             for ftyp in [resFile, resFileLog]:
##                 ftyp.write("No. Correct = %d\n" %(correctCount))
##                 ftyp.write("No. Total = %d\n" %(trialCount))
##                 ftyp.write("Percent Correct = %5.2f \n" %(correctCount/trialCount))
##                 ftyp.write("d-prime = %5.3f \n" %(dp))
##                 ftyp.write("\n")
          
##                 ftyp.flush()
##                 ftyp.flush()
            
##             fullFile.flush()
##             fullFileLog.flush()

##             getEndTime()

##             currBlock = "b" + str(prm["currentBlock"])
##             durString = "{0:5.3f}".format(prm["blockEndTime"] - prm["blockStartTime"])
            
##             #"dprime condition listener session experimentLabel nCorrectA nTotalA nCorrectB nTotalB nCorrect nTotal date time duration block experiment"
##             resLineToWrite = ""
##             resLineToWrite = resLineToWrite + "{0:5.3f}".format(dp) + prm["pref"]["general"]["csvSeparator"] + \
##                              "{0:5.2f}".format(correctCount/trialCount*100) + prm["pref"]["general"]["csvSeparator"] + \
##                              str(correctCount) + prm["pref"]["general"]["csvSeparator"] + \
##                              str(trialCount) + prm["pref"]["general"]["csvSeparator"] +\
##                              prm[currBlock]["conditionLabel"] + prm["pref"]["general"]["csvSeparator"] + \
##                              prm["listener"] + prm["pref"]["general"]["csvSeparator"] + \
##                              prm["sessionLabel"] + prm["pref"]["general"]["csvSeparator"] + \
##                              prm["allBlocks"]["experimentLabel"] + prm["pref"]["general"]["csvSeparator"] +\
##                              prm["blockEndDateString"] + prm["pref"]["general"]["csvSeparator"] + \
##                              prm["blockEndTimeString"] + prm["pref"]["general"]["csvSeparator"] + \
##                              durString + prm["pref"]["general"]["csvSeparator"] + \
##                              prm[currBlock]["blockPosition"] + prm["pref"]["general"]["csvSeparator"] + \
##                              prm[currBlock]["experiment"] + prm["pref"]["general"]["csvSeparator"] + \
##                              prm[currBlock]["paradigm"] + prm["pref"]["general"]["csvSeparator"]

##             resLineToWrite = resLineToWrite + str(prm[currBlock]["nIntervals"]) + prm["pref"]["general"]["csvSeparator"] 
##             resLineToWrite = resLineToWrite + str(prm[currBlock]["nAlternatives"]) + prm["pref"]["general"]["csvSeparator"]
##             resLineToWrite = getCommonTabFields(resLineToWrite)

##             resLineToWrite = resLineToWrite + "\n"
##             writeResultsSummaryLine("Constant m-Intervals n-Alternatives", resLineToWrite)

##             atBlockEnd()
           
##         else: #block is not finished, move on to next trial
##             doTrial()

##     def sortResponseMultipleConstantsMIntervalsNAlternatives(self, buttonClicked):
##         if prm["startOfBlock"] == True:
##             prm["startOfBlock"] = False

##             fullFileLines = []
##             trialCount = {}
##             correctCount = {}
##             trialCountCnds = {}
##             correctCountCnds = {}
##             trialCountAllCnds = {}
##             for i in range(len(prm["conditions"])):
##                 trialCountCnds[prm["conditions"][i]] = 0
##                 correctCountCnds[prm["conditions"][i]] = 0
##                 trialCountAllCnds[prm["conditions"][i]] = 0
##                 trialCount[i] = 0
##                 correctCount[i] = 0
##             trialCountAll = 0

##         trialCountAll = trialCountAll + 1
##         trialCountAllCnds[currentCondition] = trialCountAllCnds[currentCondition] + 1
##         if trialCountAllCnds[currentCondition] > prm["nPracticeTrials"]:
##             trialCountCnds[currentCondition] = trialCountCnds[currentCondition] + 1
##             trialCount[prm["currentDifference"]] = trialCount[prm["currentDifference"]] + 1
##         if buttonClicked == correctButton:
##             if prm["responseLight"] == tr("Feedback"):
##                 responseLight.giveFeedback("correct")
##             elif prm["responseLight"] == tr("Neutral"):
##                 responseLight.giveFeedback("neutral")
##             elif prm["responseLight"] == tr("None"):
##                 responseLight.giveFeedback("off")

##             if trialCountAllCnds[currentCondition] > prm["nPracticeTrials"]:#if trialCountAll > prm["nPracticeTrials"]:
##                 correctCountCnds[currentCondition] = correctCountCnds[currentCondition] + 1
##                 correctCount[prm["currentDifference"]] = correctCount[prm["currentDifference"]] + 1
##             resp = "1"
##         elif buttonClicked != correctButton:
##             if prm["responseLight"] == tr("Feedback"):
##                 responseLight.giveFeedback("incorrect")
##             elif prm["responseLight"] == tr("Neutral"):
##                 responseLight.giveFeedback("neutral")
##             elif prm["responseLight"] == tr("None"):
##                 responseLight.giveFeedback("off")
##             resp = "0"
##         fullFileLog.write(currentCondition + "; " + resp + "; ")
##         fullFileLines.append(currentCondition + "; " + resp + "; ")
##         if "additional_parameters_to_write" in prm:
##             for p in range(len(prm["additional_parameters_to_write"])):
##                 fullFileLog.write(str(prm["additional_parameters_to_write"][p]))
##                 fullFileLines.append(str(prm["additional_parameters_to_write"][p]))
##                 fullFileLog.write("; ")
##                 fullFileLines.append("; ")
##         fullFileLog.write("\n")
##         fullFileLines.append("\n")
##         fullFileLog.flush()
      
##         pcDone = trialCountAll / (prm["nTrials"] + prm["nPracticeTrials"])*100
##         bp = int(prm["b"+str(prm["currentBlock"])]["blockPosition"])
##         pcThisRep = (bp-1) / prm["storedBlocks"]*100 + 1 / prm["storedBlocks"]*pcDone
##         pcTot = (prm["currentRepetition"] - 1) / prm["allBlocks"]["repetitions"]*100 + 1 / prm["allBlocks"]["repetitions"]*pcThisRep
##         gauge.setValue(pcTot)

##         if trialCountAll >= (prm["nTrials"] + prm["nPracticeTrials"])*len(prm["conditions"]): # Block is completed
##             totalCorrectCount = 0
##             totalTrialCount = 0
##             for i in range(len(prm["conditions"])):
##                 totalTrialCount = totalTrialCount + trialCount[i]
##                 totalCorrectCount = totalCorrectCount + correctCountCnds[prm["conditions"][i]]
##             writeResultsHeader("standard")
##             for i in range(len(fullFileLines)):
##                 fullFile.write(fullFileLines[i])
##             fullFileLog.write("\n")
##             fullFile.write("\n")

##             dprimeList = []
##             for i in range(len(prm["conditions"])):
##                 thisPropCorr = (correctCountCnds[prm["conditions"][i]])/trialCountCnds[prm["conditions"][i]]
##                 thisdprime = dprime_mAFC(thisPropCorr, prm["nAlternatives"])
##                 dprimeList.append(thisdprime)
##                 for ftyp in [resFile, resFileLog]:
##                     ftyp.write("CONDITION, " + str(i+1) + "; " + prm["conditions"][i] + "\n")
##                     ftyp.write("No. Correct = %d\n" %(correctCountCnds[prm["conditions"][i]]))
##                     ftyp.write("No. Total = %d \n" %((trialCountCnds[prm["conditions"][i]])))
##                     ftyp.write("Percent Correct = %5.2f \n" %(thisPropCorr*100))
##                     ftyp.write("d-prime = %5.3f \n" %(thisdprime))
##                     ftyp.write("\n")

##             propCorrAll = totalCorrectCount/totalTrialCount
##             dprimeAll = dprime_mAFC(propCorrAll, prm["nAlternatives"])
##             for ftyp in [resFile, resFileLog]:
##                 ftyp.write("CONDITION, ALL \n")
##                 ftyp.write("No. Correct = %d\n" %(totalCorrectCount))
##                 ftyp.write("No. Total = %d\n" %(totalTrialCount))
##                 ftyp.write("Percent Correct = %5.2f \n" %(propCorrAll*100))
##                 ftyp.write("d-prime = %5.3f \n" %(dprimeAll))
          
##                 ftyp.write("\n.\n\n")
##                 ftyp.flush()
##             fullFile.flush()
##             fullFileLog.flush()

##             getEndTime()

##             currBlock = "b" + str(prm["currentBlock"])
##             durString = "{0:5.3f}".format(prm["blockEndTime"] - prm["blockStartTime"])
            
##             resLineToWrite = ""
##             for i in range(len(prm["conditions"])):
##                 resLineToWrite = resLineToWrite + "{0:5.3f}".format(dprimeList[i]) + prm["pref"]["general"]["csvSeparator"] + \
##                                  "{0:5.2f}".format((correctCountCnds[prm["conditions"][i]]*100)/trialCountCnds[prm["conditions"][i]]) + prm["pref"]["general"]["csvSeparator"] + \
##                                  str(correctCountCnds[prm["conditions"][i]]) + prm["pref"]["general"]["csvSeparator"] + \
##                                  str(trialCountCnds[prm["conditions"][i]]) + prm["pref"]["general"]["csvSeparator"] 

##             resLineToWrite = resLineToWrite + "{0:5.3f}".format(dprimeAll) + prm["pref"]["general"]["csvSeparator"] + \
##                              str(totalCorrectCount/totalTrialCount*100) + prm["pref"]["general"]["csvSeparator"] + \
##                              str(totalCorrectCount) + prm["pref"]["general"]["csvSeparator"] + \
##                              str(totalTrialCount) + prm["pref"]["general"]["csvSeparator"] + \
##                              prm[currBlock]["conditionLabel"] + prm["pref"]["general"]["csvSeparator"] + \
##                              prm["listener"] + prm["pref"]["general"]["csvSeparator"] + \
##                              prm["sessionLabel"] + prm["pref"]["general"]["csvSeparator"] + \
##                              prm["allBlocks"]["experimentLabel"] + prm["pref"]["general"]["csvSeparator"] +\
##                              prm["blockEndDateString"] + prm["pref"]["general"]["csvSeparator"] + \
##                              prm["blockEndTimeString"] + prm["pref"]["general"]["csvSeparator"] + \
##                              durString + prm["pref"]["general"]["csvSeparator"] + \
##                              prm[currBlock]["blockPosition"] + prm["pref"]["general"]["csvSeparator"] + \
##                              prm[currBlock]["experiment"] + prm["pref"]["general"]["csvSeparator"] + \
##                              prm[currBlock]["paradigm"] + prm["pref"]["general"]["csvSeparator"]

##             resLineToWrite = resLineToWrite + str(prm[currBlock]["nIntervals"]) + prm["pref"]["general"]["csvSeparator"] 
##             resLineToWrite = resLineToWrite + str(prm[currBlock]["nAlternatives"]) + prm["pref"]["general"]["csvSeparator"]
##             resLineToWrite = getCommonTabFields(resLineToWrite)

##             resLineToWrite = resLineToWrite + "\n"
##             writeResultsSummaryLine("Multiple Constants m-Intervals n-Alternatives", resLineToWrite)

##             atBlockEnd()
            
##         else: #block is not finished, move on to next trial
##             remainingDifferences = []
##             for key in trialCount.keys():
##                 if trialCount[key] < prm["nTrials"]:
##                     remainingDifferences.append(key)
##             prm["currentDifference"] = random.choice(remainingDifferences)
##             doTrial()
            

##     def sortResponseConstant1Interval2Alternatives(self, buttonClicked):
##         if prm["startOfBlock"] == True: #Initialize counts and data structures
##             prm["startOfBlock"] = False

##             fullFileLines = []
##             correctCount = 0 #count of correct trials 
##             trialCount = 0 #count of total trials 
##             correctCountCnds = {} #count of correct trials by condition
##             trialCountCnds = {} #count of total trials by condition
            
##             for i in range(len(prm["conditions"])):
##                 trialCountCnds[prm["conditions"][i]] = 0
##                 correctCountCnds[prm["conditions"][i]] = 0
##             trialCountAll = 0

##         #Add one to trial counts
##         trialCountAll = trialCountAll + 1
##         if trialCountAll > prm["nPracticeTrials"]:
##             trialCountCnds[currentCondition] = trialCountCnds[currentCondition] + 1
##             trialCount = trialCount + 1
        
##         #if correct response, add one to correct resp. count
##         if buttonClicked == correctButton: 
##             if prm["responseLight"] == tr("Feedback"):
##                 responseLight.giveFeedback("correct")
##             elif prm["responseLight"] == tr("Neutral"):
##                 responseLight.giveFeedback("neutral")
##             elif prm["responseLight"] == tr("None"):
##                 responseLight.giveFeedback("off")
##             if trialCountAll > prm["nPracticeTrials"]:
##                 correctCountCnds[currentCondition] = correctCountCnds[currentCondition] + 1
##                 correctCount = correctCount + 1
##             resp = "1"
##         elif buttonClicked != correctButton:
##             if prm["responseLight"] == tr("Feedback"):
##                 responseLight.giveFeedback("incorrect")
##             elif prm["responseLight"] == tr("Neutral"):
##                 responseLight.giveFeedback("neutral")
##             elif prm["responseLight"] == tr("None"):
##                 responseLight.giveFeedback("off")
##             resp = "0"
            
##         fullFileLog.write(currentCondition + "; " + resp + "; ")
##         fullFileLines.append(currentCondition + "; " + resp + "; ")
##         if "additional_parameters_to_write" in prm:
##             for p in range(len(prm["additional_parameters_to_write"])):
##                 fullFileLog.write(str(prm["additional_parameters_to_write"][p]))
##                 fullFileLines.append(str(prm["additional_parameters_to_write"][p]))
##                 fullFileLog.write("; ")
##                 fullFileLines.append("; ")
##         fullFileLog.write("\n")
##         fullFileLines.append("\n")
##         fullFileLog.flush()

##         #move percent done bar
##         pcDone = trialCountAll/(prm["nTrials"] + prm["nPracticeTrials"])*100
##         bp = int(prm["b"+str(prm["currentBlock"])]["blockPosition"])
##         pcThisRep = (bp-1) / prm["storedBlocks"]*100 + 1 / prm["storedBlocks"]*pcDone
##         pcTot = (prm["currentRepetition"] - 1) / prm["allBlocks"]["repetitions"]*100 + 1 / prm["allBlocks"]["repetitions"]*pcThisRep
##         gauge.setValue(pcTot)

##         #Completed all trials, compute stats
##         if trialCountAll >= prm["nPracticeTrials"] + prm["nTrials"]: # Block is completed
##             writeResultsHeader("standard")
##             for i in range(len(fullFileLines)):
##                 fullFile.write(fullFileLines[i])
##             fullFileLog.write("\n")
##             fullFile.write("\n")
##             fullFile.flush()
##             fullFileLog.flush()
             
##             A_correct = correctCountCnds[prm["conditions"][0]]
##             A_total = trialCountCnds[prm["conditions"][0]]
##             B_correct = correctCountCnds[prm["conditions"][1]]
##             B_total = trialCountCnds[prm["conditions"][1]]

##             try:
##                 dp = dprime_yes_no_from_counts(A_correct, A_total, B_correct, B_total, prm["pref"]["general"]["dprimeCorrection"])
##             except:
##                 dp = nan

##             for ftyp in [resFile, resFileLog]:
##                 ftyp.write("No. Correct = %d\n" %(correctCount))
##                 ftyp.write("No. Total = %d\n" %(trialCount))
##                 ftyp.write("Percent Correct = %5.2f \n" %(correctCount/trialCount*100))
##                 ftyp.write("d-prime = %5.3f \n\n" %(dp))
            
##                 for i in range(len(prm["conditions"])):
##                     try:
##                         thisPercentCorrect = (correctCountCnds[prm["conditions"][i]]*100)/trialCountCnds[prm["conditions"][i]]
##                     except:
##                         thisPercentCorrect = nan
##                     ftyp.write("No. Correct Condition %s = %d\n" %(prm["conditions"][i], correctCountCnds[prm["conditions"][i]]))
##                     ftyp.write("No. Total Condition %s = %d \n" %(prm["conditions"][i], trialCountCnds[prm["conditions"][i]]))
##                     ftyp.write("Percent Correct Condition %s = %5.2f \n" %(prm["conditions"][i], thisPercentCorrect))
                
##                 ftyp.write("\n\n")
##                 ftyp.flush()
          
##             getEndTime()
           
            
##             currBlock = "b" + str(prm["currentBlock"])
##             durString = "{0:5.3f}".format(prm["blockEndTime"] - prm["blockStartTime"])
            
##             #"dprime condition listener session experimentLabel nCorrectA nTotalA nCorrectB nTotalB nCorrect nTotal date time duration block experiment"
##             resLineToWrite = "{0:5.3f}".format(dp) + prm["pref"]["general"]["csvSeparator"] 
##             resLineToWrite = resLineToWrite + str(trialCount) + prm["pref"]["general"]["csvSeparator"]
##             for i in range(len(prm["conditions"])):
##                 resLineToWrite = resLineToWrite + str(correctCountCnds[prm["conditions"][i]]) + prm["pref"]["general"]["csvSeparator"] + \
##                                  str(trialCountCnds[prm["conditions"][i]]) + prm["pref"]["general"]["csvSeparator"]
##             resLineToWrite = resLineToWrite + prm[currBlock]["conditionLabel"] + prm["pref"]["general"]["csvSeparator"] + \
##                              prm["listener"] + prm["pref"]["general"]["csvSeparator"] + \
##                              prm["sessionLabel"] + prm["pref"]["general"]["csvSeparator"] + \
##                              prm["allBlocks"]["experimentLabel"] + prm["pref"]["general"]["csvSeparator"] +\
##                              prm["blockEndDateString"] + prm["pref"]["general"]["csvSeparator"] + \
##                              prm["blockEndTimeString"] + prm["pref"]["general"]["csvSeparator"] + \
##                              durString + prm["pref"]["general"]["csvSeparator"] + \
##                              prm[currBlock]["blockPosition"] + prm["pref"]["general"]["csvSeparator"] + \
##                              prm[currBlock]["experiment"] + prm["pref"]["general"]["csvSeparator"] + \
##                              prm[currBlock]["paradigm"] + prm["pref"]["general"]["csvSeparator"]
##             resLineToWrite = getCommonTabFields(resLineToWrite)
##             resLineToWrite = resLineToWrite + "\n"
            
##             writeResultsSummaryLine("Constant 1-Interval 2-Alternatives", resLineToWrite)

##             atBlockEnd()
           
##         else: #block is not finished, move on to next trial
##             doTrial()

 
##     def sortResponseMultipleConstants1Interval2Alternatives(self, buttonClicked):
##         if prm["startOfBlock"] == True:
##             prm["startOfBlock"] = False

##             fullFileLines = []
##             trialCount = {}
##             correctCount = {}
##             trialCountCnds = {}
##             correctCountCnds = {}
##             trialCountAllCnds = {}
##             for i in range(len(prm["conditions"])):
##                 trialCount[i] = 0
##                 correctCount[i] = 0
##                 trialCountCnds[prm["conditions"][i]] = {}
##                 correctCountCnds[prm["conditions"][i]] = {}
##                 trialCountAllCnds[prm["conditions"][i]] = 0
##                 for j in range(len(prm["subconditions"])):
##                     trialCountCnds[prm["conditions"][i]][prm["subconditions"][j]] = 0
##                     correctCountCnds[prm["conditions"][i]][prm["subconditions"][j]] = 0
##             trialCountAll = 0

##         trialCountAll = trialCountAll + 1
##         trialCountAllCnds[currentCondition] =  trialCountAllCnds[currentCondition] + 1
##         if trialCountAllCnds[currentCondition] > prm["nPracticeTrials"]:
##             trialCountCnds[currentCondition][currentSubcondition] = trialCountCnds[currentCondition][currentSubcondition] + 1
##             trialCount[prm["currentDifference"]] = trialCount[prm["currentDifference"]] + 1

##         if buttonClicked == correctButton:
##             if prm["responseLight"] == tr("Feedback"):
##                 responseLight.giveFeedback("correct")
##             elif prm["responseLight"] == tr("Neutral"):
##                 responseLight.giveFeedback("neutral")
##             elif prm["responseLight"] == tr("None"):
##                 responseLight.giveFeedback("off")
##             if trialCountAllCnds[currentCondition] > prm["nPracticeTrials"]:
##                 correctCountCnds[currentCondition][currentSubcondition] = correctCountCnds[currentCondition][currentSubcondition] + 1
##                 correctCount[prm["currentDifference"]] = correctCount[prm["currentDifference"]] + 1

##             resp = "1"
##         elif buttonClicked != correctButton:
##             if prm["responseLight"] == tr("Feedback"):
##                 responseLight.giveFeedback("incorrect")
##             elif prm["responseLight"] == tr("Neutral"):
##                 responseLight.giveFeedback("neutral")
##             elif prm["responseLight"] == tr("None"):
##                 responseLight.giveFeedback("off")
##             resp = "0"
##         fullFileLog.write(currentCondition + "; " + currentSubcondition + "; " + resp + "; ")
##         fullFileLines.append(currentCondition + "; " + currentSubcondition + "; " + resp + "; ")
##         if "additional_parameters_to_write" in prm:
##             for p in range(len(prm["additional_parameters_to_write"])):
##                 fullFileLog.write(str(prm["additional_parameters_to_write"][p]))
##                 fullFileLines.append(str(prm["additional_parameters_to_write"][p]))
##                 fullFileLog.write("; ")
##                 fullFileLines.append("; ")
##         fullFileLog.write("\n")
##         fullFileLines.append("\n")
##         fullFileLog.flush()
     
##         pcDone = (trialCountAll / ((prm["nTrials"]+prm["nPracticeTrials"]) * len(prm["conditions"])))*100
##         bp = int(prm["b"+str(prm["currentBlock"])]["blockPosition"])
##         pcThisRep = (bp-1) / prm["storedBlocks"]*100 + 1 / prm["storedBlocks"]*pcDone
##         pcTot = (prm["currentRepetition"] - 1) / prm["allBlocks"]["repetitions"]*100 + 1 / prm["allBlocks"]["repetitions"]*pcThisRep
##         gauge.setValue(pcTot)

        
##         if trialCountAll >= (prm["nTrials"] + prm["nPracticeTrials"])*len(prm["conditions"]): # Block is completed

##             writeResultsHeader("standard")
##             for i in range(len(fullFileLines)):
##                 fullFile.write(fullFileLines[i])
##             fullFileLog.write("\n")
##             fullFile.write("\n")

##             totalCorrectCount = 0
##             subconditionTrialCount = [0 for number in range(len(prm["subconditions"]))]
##             subconditionCorrectCount = [0 for number in range(len(prm["subconditions"]))]
##             A_correct = []
##             A_total = []
##             B_correct = []
##             B_total = []
##             dp = []
##             totalTrialCount = 0
##             for i in range(len(prm["conditions"])):
##                 totalTrialCount = totalTrialCount + trialCount[i]
##                 thisCondTotalCorrectCount = 0
##                 for j in range(len(prm["subconditions"])):
##                     thisCondTotalCorrectCount = thisCondTotalCorrectCount + correctCountCnds[prm["conditions"][i]][prm["subconditions"][j]]
##                     subconditionCorrectCount[j] = subconditionCorrectCount[j] + correctCountCnds[prm["conditions"][i]][prm["subconditions"][j]]
##                     subconditionTrialCount[j] = subconditionTrialCount[j] + trialCountCnds[prm["conditions"][i]][prm["subconditions"][j]]
##                 totalCorrectCount = totalCorrectCount + thisCondTotalCorrectCount

##                 #compute d-prime for each condition
##                 A_correct.append(correctCountCnds[prm["conditions"][i]][prm["subconditions"][0]]) 
##                 A_total.append(trialCountCnds[prm["conditions"][i]][prm["subconditions"][0]])
##                 B_correct.append(correctCountCnds[prm["conditions"][i]][prm["subconditions"][1]]) 
##                 B_total.append(trialCountCnds[prm["conditions"][i]][prm["subconditions"][1]])

##                 try:
##                     this_dp = dprime_yes_no_from_counts(nCA=A_correct[i], nTA=A_total[i], nCB=B_correct[i], nTB=B_total[i], corr=prm["pref"]["general"]["dprimeCorrection"])
##                 except:
##                     this_dp = nan
##                 dp.append(this_dp)
                
##                 for ftyp in [resFile, resFileLog]:
##                     ftyp.write("CONDITION: %d; %s \n" %(i+1, prm["conditions"][i]))
##                     ftyp.write("No. Correct = %d\n" %(thisCondTotalCorrectCount))
##                     ftyp.write("No. Total = %d\n" %(prm["nTrials"]))
##                     ftyp.write("Percent Correct = %5.2f \n" %(thisCondTotalCorrectCount/trialCount[i]*100))
##                     ftyp.write("d-prime = %5.3f \n\n" %(this_dp))
                    

##                 for j in range(len(prm["subconditions"])):
##                     try:
##                         thisPercentCorrect = correctCountCnds[prm["conditions"][i]][prm["subconditions"][j]]/trialCountCnds[prm["conditions"][i]][prm["subconditions"][j]]*100
##                     except:
##                         thisPercentCorrect = nan
##                     for ftyp in [resFile, resFileLog]:
##                         ftyp.write("No. Correct Subcondition %s = %d\n" %(prm["subconditions"][j], correctCountCnds[prm["conditions"][i]][prm["subconditions"][j]]))
##                         ftyp.write("No. Total Subcondition %s = %d \n" %(prm["subconditions"][j], trialCountCnds[prm["conditions"][i]][prm["subconditions"][j]]))
##                         ftyp.write("Percent Correct Subcondition %s = %5.2f \n" %(prm["subconditions"][j], thisPercentCorrect))
                
##                 resFile.write("\n\n")
##                 resFileLog.write("\n\n")


##             A_correct_ALL = subconditionCorrectCount[0]
##             A_total_ALL = subconditionTrialCount[0]
##             B_correct_ALL = subconditionCorrectCount[1]
##             B_total_ALL = subconditionTrialCount[1]
##             try:
##                 dp_ALL = dprime_yes_no_from_counts(nCA=A_correct_ALL, nTA=A_total_ALL, nCB=B_correct_ALL, nTB=B_total_ALL, corr=prm["pref"]["general"]["dprimeCorrection"])
##             except:
##                 dp_ALL = nan

##             for ftyp in [resFile, resFileLog]:
##                 ftyp.write("CONDITION: ALL \n")
##                 ftyp.write("No. Correct = %d\n" %(totalCorrectCount))
##                 ftyp.write("No Total = %d\n" %(totalTrialCount))
##                 ftyp.write("Percent Correct = %5.2f \n" %(totalCorrectCount/totalTrialCount*100))
##                 ftyp.write("d-prime = %5.3f \n\n" %(dp_ALL))

##             for j in range(len(prm["subconditions"])):
##                 try:
##                     thisPercentCorrect = subconditionCorrectCount[j]/subconditionTrialCount[j]*100
##                 except:
##                     thisPercentCorrect = nan

##                 for ftyp in [resFile, resFileLog]:
##                     ftyp.write("No. Correct Subcondition %s = %d\n" %(prm["subconditions"][j], subconditionCorrectCount[j]))
##                     ftyp.write("No. Total Subcondition %s = %d \n" %(prm["subconditions"][j], subconditionTrialCount[j]))
##                     ftyp.write("Percent Correct Subcondition %s = %5.2f \n" %(prm["subconditions"][j], thisPercentCorrect))

##             resFile.write("\n")
##             resFileLog.write("\n")
     
            
##             resFile.write(".\n\n")
##             resFile.flush()
##             resFileLog.write(".\n\n")
##             resFileLog.flush()
##             fullFile.flush()
##             fullFileLog.flush()

##             getEndTime()

##             currBlock = "b" + str(prm["currentBlock"])
##             durString = "{0:5.3f}".format(prm["blockEndTime"] - prm["blockStartTime"])
           
            
##             ## #"dprime condition listener session experimentLabel nCorrectA nTotalA nCorrectB nTotalB nCorrect nTotal date time duration block experiment"
##             resLineToWrite = "{0:5.3f}".format(dp_ALL) + prm["pref"]["general"]["csvSeparator"] 
##             resLineToWrite = resLineToWrite + str(totalTrialCount) + prm["pref"]["general"]["csvSeparator"]
##             for j in range(len(prm["subconditions"])):
##                 resLineToWrite = resLineToWrite + str(subconditionCorrectCount[j]) + prm["pref"]["general"]["csvSeparator"] + \
##                                  str(subconditionTrialCount[j]) + prm["pref"]["general"]["csvSeparator"]
##             for i in range(len(prm["conditions"])):
##                 resLineToWrite = resLineToWrite + "{0:5.3f}".format(dp[i]) + prm["pref"]["general"]["csvSeparator"] 
##                 resLineToWrite = resLineToWrite + str(trialCountCnds[prm["conditions"][i]][prm["subconditions"][0]] + trialCountCnds[prm["conditions"][i]][prm["subconditions"][1]]) + prm["pref"]["general"]["csvSeparator"]
##                 for j in range(len(prm["subconditions"])):
##                     resLineToWrite = resLineToWrite + str(correctCountCnds[prm["conditions"][i]][prm["subconditions"][j]]) + prm["pref"]["general"]["csvSeparator"] + \
##                             str(trialCountCnds[prm["conditions"][i]][prm["subconditions"][j]])  + prm["pref"]["general"]["csvSeparator"]

##             resLineToWrite = resLineToWrite + prm[currBlock]["conditionLabel"] + prm["pref"]["general"]["csvSeparator"] + \
##                              prm["listener"] + prm["pref"]["general"]["csvSeparator"] + \
##                              prm["sessionLabel"] + prm["pref"]["general"]["csvSeparator"] + \
##                              prm["allBlocks"]["experimentLabel"] + prm["pref"]["general"]["csvSeparator"] +\
##                              prm["blockEndDateString"] + prm["pref"]["general"]["csvSeparator"] + \
##                              prm["blockEndTimeString"] + prm["pref"]["general"]["csvSeparator"] + \
##                              durString + prm["pref"]["general"]["csvSeparator"] + \
##                              prm[currBlock]["blockPosition"] + prm["pref"]["general"]["csvSeparator"] + \
##                              prm[currBlock]["experiment"] + prm["pref"]["general"]["csvSeparator"] + \
##                              prm[currBlock]["paradigm"] + prm["pref"]["general"]["csvSeparator"]
##             resLineToWrite = getCommonTabFields(resLineToWrite)
##             resLineToWrite = resLineToWrite + "\n"
##             writeResultsSummaryLine("Multiple Constants 1-Interval 2-Alternatives", resLineToWrite)

##             atBlockEnd()
           
##         else: #block is not finished, move on to next trial
##             remainingDifferences = []
##             for key in trialCount.keys():
##                 if trialCount[key] < prm["nTrials"]:
##                     remainingDifferences.append(key)
##             prm["currentDifference"] = random.choice(remainingDifferences)
##             doTrial()


##     def sortResponseConstant1PairSameDifferent(self, buttonClicked):
##         if prm["startOfBlock"] == True:
##             prm["startOfBlock"] = False

##             fullFileLines = []
##             trialCount = 0
##             trialCountCnds = {}
##             correctCountCnds = {}
##             for i in range(len(prm["conditions"])):
##                 trialCountCnds[prm["conditions"][i]] = 0
##                 correctCountCnds[prm["conditions"][i]] = 0
##             trialCountAll = 0 #this includes as well the practice trials

##         trialCountAll = trialCountAll + 1
##         if trialCountAll > prm["nPracticeTrials"]:
##             trialCountCnds[currentCondition] = trialCountCnds[currentCondition] + 1
##             trialCount = trialCount + 1
##         if buttonClicked == correctButton:
##             if prm["responseLight"] == tr("Feedback"):
##                 responseLight.giveFeedback("correct")
##             elif prm["responseLight"] == tr("Neutral"):
##                 responseLight.giveFeedback("neutral")
##             elif prm["responseLight"] == tr("None"):
##                 responseLight.giveFeedback("off")
##             if trialCountAll > prm["nPracticeTrials"]:
##                 correctCountCnds[currentCondition] = correctCountCnds[currentCondition] + 1
##             resp = "1"
##         elif buttonClicked != correctButton:
##             if prm["responseLight"] == tr("Feedback"):
##                 responseLight.giveFeedback("incorrect")
##             elif prm["responseLight"] == tr("Neutral"):
##                 responseLight.giveFeedback("neutral")
##             elif prm["responseLight"] == tr("None"):
##                 responseLight.giveFeedback("off")
##             resp = "0"
##         fullFileLog.write(currentCondition + "; " + resp + "; ")
##         fullFileLines.append(currentCondition + "; " + resp + "; ")
##         if "additional_parameters_to_write" in prm:
##             for p in range(len(prm["additional_parameters_to_write"])):
##                 fullFileLog.write(str(prm["additional_parameters_to_write"][p]))
##                 fullFileLines.append(str(prm["additional_parameters_to_write"][p]))
##                 fullFileLog.write("; ")
##                 fullFileLines.append("; ")
##         fullFileLog.write("\n")
##         fullFileLines.append("\n")
##         fullFileLog.flush()
##         cnt = 0
##         for i in range(len(prm["conditions"])):
##             cnt = cnt + trialCountCnds[prm["conditions"][i]]
##         pcDone = cnt / prm["nTrials"] * 100
##         bp = int(prm["b"+str(prm["currentBlock"])]["blockPosition"])
##         pcThisRep = (bp-1) / prm["storedBlocks"]*100 + 1 / prm["storedBlocks"]*pcDone
##         pcTot = (prm["currentRepetition"] - 1) / prm["allBlocks"]["repetitions"]*100 + 1 / prm["allBlocks"]["repetitions"]*pcThisRep
##         gauge.setValue(pcTot)

        
##         if trialCountAll >= prm["nTrials"] + prm["nPracticeTrials"]: # Block is completed
##             totalCorrectCount = 0
##             for i in range(len(prm["conditions"])):
##                 totalCorrectCount = totalCorrectCount + correctCountCnds[prm["conditions"][i]]
##             writeResultsHeader("standard")
##             for i in range(len(fullFileLines)):
##                 fullFile.write(fullFileLines[i])
##             fullFileLog.write("\n")
##             fullFile.write("\n")
##             fullFile.flush()
##             fullFileLog.flush()
            
##             A_correct = correctCountCnds[prm["conditions"][0]]
##             A_total = trialCountCnds[prm["conditions"][0]]
##             B_correct = correctCountCnds[prm["conditions"][1]]
##             B_total = trialCountCnds[prm["conditions"][1]]

##             try:
##                 dp_IO = dprime_SD_from_counts(nCA=A_correct, nTA=A_total, nCB=B_correct, nTB=B_total, meth="IO", corr=prm["pref"]["general"]["dprimeCorrection"])
##             except:
##                 dp_IO = nan
##             try:
##                 dp_diff = dprime_SD_from_counts(nCA=A_correct, nTA=A_total, nCB=B_correct, nTB=B_total, meth="diff", corr=prm["pref"]["general"]["dprimeCorrection"])
##             except:
##                 dp_diff = nan

##             for ftyp in [resFile, resFileLog]:
##                 ftyp.write("No. Correct = %d\n" %(totalCorrectCount))
##                 ftyp.write("No. Total = %d\n" %(trialCount))
##                 ftyp.write("Percent Correct = %5.2f \n" %(totalCorrectCount/trialCount*100))
##                 ftyp.write("d-prime IO = %5.3f \n" %(dp_IO))
##                 ftyp.write("d-prime diff = %5.3f \n\n" %(dp_diff))
                
##                 for i in range(len(prm["conditions"])):
##                     try:
##                         thisPercentCorrect = (correctCountCnds[prm["conditions"][i]]*100)/trialCountCnds[prm["conditions"][i]]
##                     except:
##                         thisPercentCorrect = nan
##                     ftyp.write("No. Correct Condition %s = %d\n" %(prm["conditions"][i], correctCountCnds[prm["conditions"][i]]))
##                     ftyp.write("No. Total Condition %s = %d \n" %(prm["conditions"][i], trialCountCnds[prm["conditions"][i]]))
##                     ftyp.write("Percent Correct Condition %s= %5.2f \n" %(prm["conditions"][i], thisPercentCorrect))
            
##                 ftyp.write("\n\n")
##                 ftyp.flush()

##             getEndTime()
           
##             currBlock = "b" + str(prm["currentBlock"])
##             durString = "{0:5.3f}".format(prm["blockEndTime"] - prm["blockStartTime"])
            
##             #"dprime condition listener session experimentLabel nCorrectA nTotalA nCorrectB nTotalB nCorrect nTotal date time duration block experiment"
##             resLineToWrite = "{0:5.3f}".format(dp_IO) + prm["pref"]["general"]["csvSeparator"]
##             resLineToWrite = resLineToWrite + "{0:5.3f}".format(dp_diff) + prm["pref"]["general"]["csvSeparator"] 
##             resLineToWrite = resLineToWrite + str(trialCount) + prm["pref"]["general"]["csvSeparator"]
##             for i in range(len(prm["conditions"])):
##                 resLineToWrite = resLineToWrite + str(correctCountCnds[prm["conditions"][i]]) + prm["pref"]["general"]["csvSeparator"] + \
##                                  str(trialCountCnds[prm["conditions"][i]]) + prm["pref"]["general"]["csvSeparator"]
##             resLineToWrite = resLineToWrite + prm[currBlock]["conditionLabel"] + prm["pref"]["general"]["csvSeparator"] + \
##                              prm["listener"] + prm["pref"]["general"]["csvSeparator"] + \
##                              prm["sessionLabel"] + prm["pref"]["general"]["csvSeparator"] + \
##                              prm["allBlocks"]["experimentLabel"] + prm["pref"]["general"]["csvSeparator"] +\
##                              prm["blockEndDateString"] + prm["pref"]["general"]["csvSeparator"] + \
##                              prm["blockEndTimeString"] + prm["pref"]["general"]["csvSeparator"] + \
##                              durString + prm["pref"]["general"]["csvSeparator"] + \
##                              prm[currBlock]["blockPosition"] + prm["pref"]["general"]["csvSeparator"] + \
##                              prm[currBlock]["experiment"] + prm["pref"]["general"]["csvSeparator"] + \
##                              prm[currBlock]["paradigm"] + prm["pref"]["general"]["csvSeparator"]
##             resLineToWrite = getCommonTabFields(resLineToWrite)
##             resLineToWrite = resLineToWrite + "\n"
##             writeResultsSummaryLine("Constant 1-Pair Same/Different", resLineToWrite)

##             atBlockEnd()
           
##         else: #block is not finished, move on to next trial
##             doTrial()

##     def sortResponsePEST(self, buttonClicked):
##         #PEST SUPPORT IS EXPERIMENTAL AND VERY LITTLE TESTED!
##         if prm["startOfBlock"] == True:
##             prm["correctCount"] = 0
##             prm["startOfBlock"] = False
##             prm["currStepSize"] = copy.copy(prm["initialStepSize"])
##             prm["nTrialsCurrStepSize"] = 0
##             prm["nSteps"] = 0
##             prm["lastStepDoubled"] = False
##             prm["stepBeforeLastReversalDoubled"] = False
            
##             fullFileLines = []
##             prm["buttonCounter"] = [0 for i in range(prm["nAlternatives"])]
##         prm["buttonCounter"][buttonClicked-1] = prm["buttonCounter"][buttonClicked-1] + 1

##         #increment number of trials
##         prm["nTrialsCurrStepSize"] = prm["nTrialsCurrStepSize"] +1
            
##         if buttonClicked == correctButton:
##             if prm["responseLight"] == tr("Feedback"):
##                 responseLight.giveFeedback("correct")
##             elif prm["responseLight"] == tr("Neutral"):
##                 responseLight.giveFeedback("neutral")
##             elif prm["responseLight"] == tr("None"):
##                 responseLight.giveFeedback("off")
            
##             fullFileLog.write(str(prm["adaptiveDifference"]) + "; ")
##             fullFileLines.append(str(prm["adaptiveDifference"]) + "; ")
##             fullFileLog.write("1; ")
##             fullFileLines.append("1; ")
##             if "additional_parameters_to_write" in prm:
##                 for p in range(len(prm["additional_parameters_to_write"])):
##                     fullFileLog.write(str(prm["additional_parameters_to_write"][p]))
##                     fullFileLines.append(str(prm["additional_parameters_to_write"][p]))
##                     fullFileLog.write(" ;")
##                     fullFileLines.append(" ;")
##             fullFileLog.write("\n")
##             fullFileLines.append("\n")
##             prm["correctCount"] = prm["correctCount"] + 1
##         elif buttonClicked != correctButton:
##             if prm["responseLight"] == tr("Feedback"):
##                 responseLight.giveFeedback("incorrect")
##             elif prm["responseLight"] == tr("Neutral"):
##                 responseLight.giveFeedback("neutral")
##             elif prm["responseLight"] == tr("None"):
##                 responseLight.giveFeedback("off")
                               
##             fullFileLog.write(str(prm["adaptiveDifference"]) + "; ")
##             fullFileLines.append(str(prm["adaptiveDifference"]) + "; ")
##             fullFileLog.write("0; ")
##             fullFileLines.append("0; ")
##             if "additional_parameters_to_write" in prm:
##                 for p in range(len(prm["additional_parameters_to_write"])):
##                     fullFileLog.write(str(prm["additional_parameters_to_write"][p]))
##                     fullFileLines.append(str(prm["additional_parameters_to_write"][p]))
##                     fullFileLog.write("; ")
##                     fullFileLines.append("; ")
##             fullFileLog.write("\n")
##             fullFileLines.append("\n")
            

##         #perform test
##         expectedNCorrect = prm["percentCorrectTracked"]/100*prm["nTrialsCurrStepSize"]
##         print("Correct count: ", prm["correctCount"])
##         print("ExpectedNCorrect: ", expectedNCorrect)
##         newStepSize = copy.copy(prm["currStepSize"])#temporary, it will be changed later if necessary
##         if prm["correctCount"] > expectedNCorrect + prm["W"]:
##             print("prm["correctCount"] > expectedNCorrect + prm["W"]")
##             if prm["trackDir"] == tr("Up"): #CALL REVERSAL
##                 prm["trackDir"] = tr("Down")
##                 #halve step size at reversal
##                 newStepSize = prm["currStepSize"]/2
##                 #reset counters
##                 if prm["lastStepDoubled"] == True:
##                     prm["stepBeforeLastReversalDoubled"] = True
##                 lastStepDoubled = False
##                 prm["nSteps"] = 0
##             elif prm["trackDir"] == tr("Down"):
##                 prm["nSteps"] = prm["nSteps"] + 1
##                 if prm["nSteps"] < 3:
##                     prm["lastStepDoubled"] = False
##                 elif prm["nSteps"] == 3:
##                     if prm["stepBeforeLastReversalDoubled"] == False:
##                         newStepSize = prm["currStepSize"]*2
##                         prm["lastStepDoubled"] = True
##                     else:
##                         prm["lastStepDoubled"] = False
##                 elif prm["nSteps"] > 3:
##                     newStepSize = prm["currStepSize"]*2
##                     prm["lastStepDoubled"] = True

##             #limit maximum step size
##             if newStepSize > prm["maxStepSize"]:
##                 newStepSize = prm["maxStepSize"]
##             #only reset nTrials counter if step size has really changed
##             if prm["currStepSize"] != newStepSize:
##                 prm["nTrialsCurrStepSize"] = 0
##                 prm["correctCount"] = 0
##             prm["currStepSize"] = newStepSize

##             if prm["adaptiveType"] == tr("Arithmetic"):
##                 prm["adaptiveDifference"] = prm["adaptiveDifference"] - prm["currStepSize"]
##             elif prm["adaptiveType"] == tr("Geometric"):
##                 prm["adaptiveDifference"] = prm["adaptiveDifference"] / prm["currStepSize"]

##         elif prm["correctCount"] < expectedNCorrect - prm["W"]:
##             print("prm["correctCount"] < expectedNCorrect - prm["W"]")
##             if prm["trackDir"] == tr("Down"): #call for reversal
##                 prm["trackDir"] = tr("Up")
##                 #halve step size at reversal
##                 newStepSize = prm["currStepSize"]/2
##                 #reset counters
##                 if prm["lastStepDoubled"] == True:
##                     prm["stepBeforeLastReversalDoubled"] = True
##                 prm["nSteps"] = 0
##             elif prm["trackDir"] == tr("Up"):
##                 prm["nSteps"] = prm["nSteps"] + 1
##                 if prm["nSteps"] < 3:
##                     prm["lastStepDoubled"] = False
##                     newStepSize = copy.copy(prm["currStepSize"])
##                 elif prm["nSteps"] == 3:
##                     if prm["stepBeforeLastReversalDoubled"] == False:
##                         newStepSize = prm["currStepSize"]*2
##                         prm["lastStepDoubled"] = True
##                     else:
##                         prm["lastStepDoubled"] = False
##                 elif prm["nSteps"] > 3:
##                     newStepSize = prm["currStepSize"]*2
##                     prm["lastStepDoubled"] = True

##             #limit maximum step size
##             if newStepSize > prm["maxStepSize"]:
##                 newStepSize = prm["maxStepSize"]
##             #only reset nTrials counter if step size has really changed
##             if prm["currStepSize"] != newStepSize:
##                 prm["nTrialsCurrStepSize"] = 0
##                 prm["correctCount"] = 0
##             prm["currStepSize"] = newStepSize
       
            
##             if prm["adaptiveType"] == tr("Arithmetic"):
##                 prm["adaptiveDifference"] = prm["adaptiveDifference"] + prm["currStepSize"]
##             elif prm["adaptiveType"] == tr("Geometric"):
##                 prm["adaptiveDifference"] = prm["adaptiveDifference"] * prm["currStepSize"]
                

##         fullFileLog.flush()
##         pcDone = 0#(prm["nTurnpoints"] / prm["totalTurnpoints"]) * 100
##         bp = int(prm["b"+str(prm["currentBlock"])]["blockPosition"])
##         pcThisRep = (bp-1) / prm["storedBlocks"]*100 + 1 / prm["storedBlocks"]*pcDone
##         pcTot = (prm["currentRepetition"] - 1) / prm["allBlocks"]["repetitions"]*100 + 1 / prm["allBlocks"]["repetitions"]*pcThisRep
##         gauge.setValue(pcTot)
##         if prm["currStepSize"] < prm["minStepSize"]:
##             writeResultsHeader("standard")
##             #process results
##             fullFileLog.write("\n")
##             fullFileLines.append("\n")
##             for i in range(len(fullFileLines)):
##                 fullFile.write(fullFileLines[i])
##             if prm["adaptiveType"] == tr("Arithmetic"):
##                 resFile.write("\n\n")
##                 resFile.write("Threshold = %5.2f \n" %(prm["adaptiveDifference"]))
##                 resFileLog.write("\n\n")
##                 resFileLog.write("Threshold = %5.2f \n" %(prm["adaptiveDifference"]))
##             elif prm["adaptiveType"] == tr("Geometric"):
##                 resFile.write("\n\n")
##                 resFile.write("Geometric Threshold = %5.2f \n" %(prm["adaptiveDifference"]))
##                 resFileLog.write("\n\n")
##                 resFileLog.write("Geometric Threshold = %5.2f \n" %(prm["adaptiveDifference"]))

##             for i in range(prm["nAlternatives"]):
##                 resFile.write("B{0} = {1}".format(i+1, prm["buttonCounter"][i]))
##                 resFileLog.write("B{0} = {1}".format(i+1, prm["buttonCounter"][i]))
##                 if i != prm["nAlternatives"]-1:
##                     resFile.write(", ")
##                     resFileLog.write(", ")
##             resFile.write("\n\n")
##             resFile.flush()
##             resFileLog.write("\n\n")
##             resFileLog.flush()
##             getEndTime()

##             currBlock = "b" + str(prm["currentBlock"])
##             durString = "{0:5.3f}".format(prm["blockEndTime"] - prm["blockStartTime"])
##             resLineToWrite = "{0:5.3f}".format(prm["adaptiveDifference"]) + prm["pref"]["general"]["csvSeparator"] + \
##                              prm[currBlock]["conditionLabel"] + prm["pref"]["general"]["csvSeparator"] + \
##                              prm["listener"] + prm["pref"]["general"]["csvSeparator"] + \
##                              prm["sessionLabel"] + prm["pref"]["general"]["csvSeparator"] + \
##                              prm["allBlocks"]["experimentLabel"] + prm["pref"]["general"]["csvSeparator"] +\
##                              prm["blockEndDateString"] + prm["pref"]["general"]["csvSeparator"] + \
##                              prm["blockEndTimeString"] + prm["pref"]["general"]["csvSeparator"] + \
##                              durString + prm["pref"]["general"]["csvSeparator"] + \
##                              prm[currBlock]["blockPosition"] + prm["pref"]["general"]["csvSeparator"] + \
##                              prm[currBlock]["experiment"] + prm["pref"]["general"]["csvSeparator"] +\
##                              prm[currBlock]["paradigm"] + prm["pref"]["general"]["csvSeparator"]
##             resLineToWrite = getCommonTabFields(resLineToWrite)
##             resLineToWrite = resLineToWrite + "\n"

##             writeResultsSummaryLine("PEST", resLineToWrite)

##             atBlockEnd()
            
##         else:
##             doTrial()


##     def sortResponseOddOneOut(self, buttonClicked):
##         if prm["startOfBlock"] == True: #Initialize counts and data structures
##             prm["startOfBlock"] = False

##             prm["ones"] = 0
##             prm["twos"] = 0
##             prm["threes"] = 0
##             fullFileLines = []
##             stimCount = {}
##             trialCountCnds = {}
##             for i in range(prm["nDifferences"]):
##                 stimCount[prm["conditions"][i]] = [0,0,0]
##                 trialCountCnds[prm["conditions"][i]] = 0
##             prm["buttonCounter"] = [0 for i in range(prm["nAlternatives"])]
##         prm["buttonCounter"][buttonClicked-1] = prm["buttonCounter"][buttonClicked-1] +1

##         trialCountCnds[currentCondition] = trialCountCnds[currentCondition] +1
##         print(buttonClicked)
##         if trialCountCnds[currentCondition] > prm["nPracticeTrials"]:
##             if buttonClicked == 1:
##                 #prm["ones"] = prm["ones"] + 1
##                 stimCount[currentCondition][prm["currStimOrder"][0]] = stimCount[currentCondition][prm["currStimOrder"][0]]+1   
##             elif buttonClicked == 2:
##                 #prm["twos"] = prm["twos"] + 1
##                 stimCount[currentCondition][prm["currStimOrder"][1]] = stimCount[currentCondition][prm["currStimOrder"][1]]+1   
##             elif buttonClicked == 3:
##                 #prm["threes"] = prm["threes"] + 1
##                 stimCount[currentCondition][prm["currStimOrder"][2]] = stimCount[currentCondition][prm["currStimOrder"][2]]+1   

##         resp = str(prm["currStimOrder"][buttonClicked-1]+1)
##         fullFileLog.write(currentCondition + "; " + resp + "; ")
##         fullFileLines.append(currentCondition + "; " + resp + "; ")
##         if "additional_parameters_to_write" in prm:
##             for p in range(len(prm["additional_parameters_to_write"])):
##                 fullFileLog.write(str(prm["additional_parameters_to_write"][p]))
##                 fullFileLines.append(str(prm["additional_parameters_to_write"][p]))
##                 fullFileLog.write("; ")
##                 fullFileLines.append("; ")
##         fullFileLog.write("\n")
##         fullFileLines.append("\n")
##         fullFileLog.flush()
##         cnt = 0
##         for i in range(len(prm["conditions"])):
##             cnt = cnt + trialCountCnds[prm["conditions"][i]]
##         pcDone = cnt / prm["nTrials"] *len(prm["conditions"]) * 100
##         bp = int(prm["b"+str(prm["currentBlock"])]["blockPosition"])
##         pcThisRep = (bp-1) / prm["storedBlocks"]*100 + 1 / prm["storedBlocks"]*pcDone
##         pcTot = (prm["currentRepetition"] - 1) / prm["allBlocks"]["repetitions"]*100 + 1 / prm["allBlocks"]["repetitions"]*pcThisRep
##         gauge.setValue(pcTot)
        

##         if trialCountCnds[currentCondition] == prm["nTrials"]:
##             prm["comparisonChoices"].remove(currentCondition)
##         if len(prm["comparisonChoices"]) == 0: #Block is completed
##             writeResultsHeader("standard")
##             for i in range(len(fullFileLines)):
##                 fullFile.write(fullFileLines[i])
##             fullFileLog.write("\n")
##             fullFile.write("\n")
            
##             for ftyp in [resFile, resFileLog]:
##                 for cnd in prm["conditions"]:
##                     ftyp.write("Condition %s\n" %(cnd))
##                     ftyp.write("Stimulus 1 = %d/%d; Percent = %5.2f\n" %(stimCount[cnd][0], prm["nTrials"], stimCount[cnd][0]/prm["nTrials"]*100))
##                     ftyp.write("Stimulus 2 = %d/%d; Percent = %5.2f\n" %(stimCount[cnd][1], prm["nTrials"], stimCount[cnd][1]/prm["nTrials"]*100))
##                     ftyp.write("Stimulus 3 = %d/%d; Percent = %5.2f\n" %(stimCount[cnd][2], prm["nTrials"], stimCount[cnd][2]/prm["nTrials"]*100))
##                     ftyp.write("\n\n")

##                 for i in range(prm["nAlternatives"]):
##                      ftyp.write("B{0} = {1}".format(i+1, prm["buttonCounter"][i]))
##                      if i != prm["nAlternatives"]-1:
##                          ftyp.write(", ")
##                 ftyp.write("\n\n")

##                 ftyp.flush()
            
##             fullFile.flush()
##             fullFileLog.flush()

##             getEndTime()

##             currBlock = "b" + str(prm["currentBlock"])
##             durString = "{0:5.3f}".format(prm["blockEndTime"] - prm["blockStartTime"])
            
##             resLineToWrite = str(prm["nTrials"]) + prm["pref"]["general"]["csvSeparator"]
##             for cnd in prm["conditions"]:
##                 resLineToWrite = resLineToWrite + str(stimCount[cnd][0]) + prm["pref"]["general"]["csvSeparator"] + \
##                                  str(stimCount[cnd][0]/prm["nTrials"]*100) + prm["pref"]["general"]["csvSeparator"] + \
##                                  str(stimCount[cnd][1]) + prm["pref"]["general"]["csvSeparator"] + \
##                                  str(stimCount[cnd][1]/prm["nTrials"]*100) + prm["pref"]["general"]["csvSeparator"] + \
##                                  str(stimCount[cnd][2]) + prm["pref"]["general"]["csvSeparator"] + \
##                                  str(stimCount[cnd][2]/prm["nTrials"]*100) + prm["pref"]["general"]["csvSeparator"] 
                                 
##             resLineToWrite = resLineToWrite + prm[currBlock]["conditionLabel"] + prm["pref"]["general"]["csvSeparator"] + \
##             prm["listener"] + prm["pref"]["general"]["csvSeparator"] + \
##             prm["sessionLabel"] + prm["pref"]["general"]["csvSeparator"] + \
##             prm["allBlocks"]["experimentLabel"] + prm["pref"]["general"]["csvSeparator"] +\
##             prm["blockEndDateString"] + prm["pref"]["general"]["csvSeparator"] + \
##             prm["blockEndTimeString"] + prm["pref"]["general"]["csvSeparator"] + \
##             durString + prm["pref"]["general"]["csvSeparator"] + \
##             prm[currBlock]["blockPosition"] + prm["pref"]["general"]["csvSeparator"] + \
##             prm[currBlock]["experiment"] + prm["pref"]["general"]["csvSeparator"] + \
##             prm[currBlock]["paradigm"] + prm["pref"]["general"]["csvSeparator"]

##             resLineToWrite = getCommonTabFields(resLineToWrite)

##             resLineToWrite = resLineToWrite + "\n"
##             writeResultsSummaryLine("Odd One Out", resLineToWrite)

##             atBlockEnd()
          

##         else:
##             doTrial()

            
##     def whenFinished(self):
##         if prm["currentRepetition"] == prm["allBlocks"]["repetitions"]:
##             statusButton.setText(prm["rbTrans"].translate("rb", "Finished"))
##             gauge.setValue(100)
##             QApplication.processEvents()
##             fullFile.close()
##             resFile.close()
##             fullFileLog.close()
##             resFileLog.close()
##             prm["shuffled"] = False
##             if prm["allBlocks"]["procRes"] == True:
##                 processResultsEnd()
##             if prm["allBlocks"]["procResTable"] == True:
##                 processResultsTableEnd()
##             if prm["allBlocks"]["winPlot"] == True or prm["allBlocks"]["pdfPlot"] == True:
##                plotDataEnd(winPlot=prm["allBlocks"]["winPlot"], pdfPlot = prm["allBlocks"]["pdfPlot"])

##             if prm["pref"]["general"]["playEndMessage"] == True:
##                 playEndMessage()
##             if prm["pref"]["email"]["sendData"] == True:
##                 sendData()

       
##             commandsToExecute = []
##             cmd1 = parseCustomCommandArguments(prm["allBlocks"]["endExpCommand"])
##             cmd2 = parseCustomCommandArguments(prm["pref"]["general"]["atEndCustomCommand"])
##             if len(cmd1) > 0:
##                 commandsToExecute.append(cmd1)
##             if len(cmd2) > 0:
##                 commandsToExecute.append(cmd2)
##             if len(commandsToExecute) > 0:
##                 executerThread.executeCommand(commandsToExecute)
      
##             if prm["quit"] == True:
##                 parent().deleteLater()
##         else:
##             prm["currentRepetition"] = prm["currentRepetition"] + 1
##             parent().moveToBlockPosition(1)
##             if prm["allBlocks"]["shuffleMode"] == tr("Auto"):
##                 parent().onClickShuffleBlocksButton()
##                 prm["shuffled"] = True
##             elif prm["allBlocks"]["shuffleMode"] == tr("Ask") and prm["shuffled"] == True:
##                 #if user shuffled on first repetion, then shuffle on each repetition, otherwise don"t shuffle
##                 parent().onClickShuffleBlocksButton()
##                 prm["shuffled"] = True

##             if prm["allBlocks"]["responseMode"] == tr("Automatic") or prm["allBlocks"]["responseMode"] == tr("Simulated Listener"):
##                 onClickStatusButton()
                
##     def atBlockEnd(self):
##         writeResultsFooter("log");  writeResultsFooter("standard")

##         bp = int(prm["b"+str(prm["currentBlock"])]["blockPosition"])
##         cb = (prm["currentRepetition"]-1)*prm["storedBlocks"]+bp
##         blockGauge.setValue(cb)
##         blockGauge.setFormat(prm["rbTrans"].translate("rb", "Blocks Completed") +  ": " + str(cb) + "/" + str(prm["storedBlocks"]*prm["allBlocks"]["repetitions"]))
        
##         if prm["allBlocks"]["sendTriggers"] == True:
##             thisSnd = pureTone(440, 0, -200, 80, 10, "Both", prm["allBlocks"]["sampRate"], 100)
##             #playCmd = prm["pref"]["sound"]["playCommand"]
##             time.sleep(1)
##             audioManager.playSoundWithTrigger(thisSnd, prm["allBlocks"]["sampRate"], prm["allBlocks"]["nBits"], False, "OFFTrigger.wav", prm["pref"]["general"]["OFFTrigger"])
##             print("SENDING END TRIGGER", prm["pref"]["general"]["OFFTrigger"])

##         if prm["currentRepetition"] == prm["allBlocks"]["repetitions"] and int(prm["b"+str(prm["currentBlock"])]["blockPosition"]) + prm["pref"]["email"]["nBlocksNotify"] == prm["storedBlocks"]:
##             cmd = parseCustomCommandArguments(prm["pref"]["general"]["nBlocksCustomCommand"])
##             if len(cmd) > 0:
##                 executerThread.executeCommand([cmd])
##             if prm["pref"]["email"]["notifyEnd"] == True:
##                 sendEndNotification()
##         if int(prm["b"+str(prm["currentBlock"])]["blockPosition"]) < prm["storedBlocks"]:
##             parent().onClickNextBlockPositionButton()
##             if prm["allBlocks"]["responseMode"] == tr("Automatic") or prm["allBlocks"]["responseMode"] == tr("Simulated Listener"):
##                 onClickStatusButton()
##             else:
##                 return
##         else:
##             whenFinished()
##         prm["cmdOutFileHandle"].flush()
        
function getEndTime()
    prm["blockEndTime"] = time()
    prm["blockEndTimeStamp"] = pycall(QtCore["QDateTime"]["toString"], PyAny, QtCore["QDateTime"][:currentDateTime](), prm["currentLocale"][:dateTimeFormat](prm["currentLocale"][:ShortFormat]))
    prm["blockEndDateString"] = pycall(QtCore["QDate"]["toString"], PyAny, QtCore["QDate"][:currentDate](), prm["currentLocale"][:dateFormat](prm["currentLocale"][:ShortFormat])) 
    prm["blockEndTimeString"] = pycall(QtCore["QTime"]["toString"], PyAny, QtCore["QTime"][:currentTime](), prm["currentLocale"][:timeFormat](prm["currentLocale"][:ShortFormat]))
end
        
function getStartTime()
    prm["blockStartTime"] = time()
    prm["blockStartTimeStamp"] = pycall(QtCore["QDateTime"]["toString"], PyAny, QtCore["QDateTime"][:currentDateTime](), prm["currentLocale"][:dateTimeFormat](prm["currentLocale"][:ShortFormat]))
    prm["blockStartDateString"] = pycall(QtCore["QDate"]["toString"], PyAny, QtCore["QDate"][:currentDate](), prm["currentLocale"][:dateFormat](prm["currentLocale"][:ShortFormat])) 
    prm["blockStartTimeString"] = pycall(QtCore["QTime"]["toString"], PyAny, QtCore["QTime"][:currentTime](), prm["currentLocale"][:timeFormat](prm["currentLocale"][:ShortFormat]))
end        

##     def writeResultsHeader(self, fileType):
##         if fileType == "log":
##             resLogFilePath = prm["backupDirectoryName"]  + time.strftime("%y-%m-%d_%H-%M-%S", time.localtime()) + "_" + prm["listener"] + "_log"
##             resLogFullFilePath = prm["backupDirectoryName"]  + time.strftime("%y-%m-%d_%H-%M-%S", time.localtime()) + "_" + prm["listener"] + "full_log"
##             resFileLog = open(resLogFilePath, "a")
##             fullFileLog = open(resLogFullFilePath, "a")
##             filesToWrite = [resFileLog, fullFileLog]
##         elif fileType == "standard":
##             resFilePath = prm["resultsFile"]
##             fullFilePath = prm["resultsFile"].split(".txt")[0] + prm["pref"]["general"]["fullFileSuffix"] + ".txt"
##             resFile = open(resFilePath, "a")
##             fullFile = open(fullFilePath, "a")
##             filesToWrite = [resFile, fullFile]
            
##         currBlock = "b" + str(prm["currentBlock"])
##         for i in range(2):
##             thisFile = filesToWrite[i]
##             thisFile.write("*******************************************************\n")
##             thisFile.write("pychoacoustics version: " + prm["version"] + "; build date: " +  prm["builddate"] + "\n")
##             if "version" in prm[parent().currExp]:
##                 thisFile.write("Experiment version: " + prm[parent().currExp]["version"] + "\n") 
##             thisFile.write("Block Number: " + str(prm["currentBlock"]) + "\n")
##             thisFile.write("Block Position: " + prm["b"+str(prm["currentBlock"])]["blockPosition"] + "\n")
##             thisFile.write("Start: " + prm["blockStartTimeStamp"]+ "\n") 
##             thisFile.write("+++++++++++++++++++++++++++++++++++++++++++++++++++++++\n\n")
##             thisFile.write("Experiment Label: " + prm["allBlocks"]["experimentLabel"] + "\n")
##             thisFile.write("Session Label: " + prm["sessionLabel"] + "\n")
##             thisFile.write("Condition Label: " + prm[currBlock]["conditionLabel"] + "\n")
##             thisFile.write("Experiment:    " + prm[currBlock]["experiment"] + "\n")
##             thisFile.write("Listener:      " + prm["listener"] + "\n")
##             thisFile.write("Response Mode: " + prm["allBlocks"]["responseMode"] + "\n")
##             if prm["allBlocks"]["responseMode"] == tr("Automatic"):
##                 thisFile.write("Auto Resp. Mode Perc. Corr.: " + str(prm["allBlocks"]["autoPCCorr"]) + "\n")
##             thisFile.write("Paradigm:      " + prm["paradigm"] +"\n")
##             thisFile.write("Intervals:     " + currLocale.toString(prm["nIntervals"]) + "\n")
##             thisFile.write("Alternatives:  " + currLocale.toString(prm["nAlternatives"]) + "\n")
##             for j in range(len(prm[currBlock]["paradigmChooser"])):
##                 thisFile.write(prm[currBlock]["paradigmChooserLabel"][j] +  " " + prm[currBlock]["paradigmChooser"][j] + "\n")
##             for j in range(len(prm[currBlock]["paradigmField"])):
##                 thisFile.write(prm[currBlock]["paradigmFieldLabel"][j] +  ": " + currLocale.toString(prm[currBlock]["paradigmField"][j], precision=prm["pref"]["general"]["precision"]) + "\n")
##             thisFile.write("Phones:        " + prm["allBlocks"]["currentPhones"] + "\n")
##             thisFile.write("Sample Rate:   " + currLocale.toString(prm["allBlocks"]["sampRate"]) + "\n")
##             thisFile.write("Bits:          " + currLocale.toString(prm["allBlocks"]["nBits"]) + "\n")
##             thisFile.write("Pre-Trial Silence (ms): " + currLocale.toString(prm[currBlock]["preTrialSilence"]) + "\n")
##             thisFile.write("Warning Interval: " + str(prm[currBlock]["warningInterval"]) + "\n")
##             thisFile.write("Interval Lights: " + prm[currBlock]["intervalLights"] + "\n")
##             if prm[currBlock]["warningInterval"] == tr("Yes"):
##                 thisFile.write("Warning Interval Duration (ms): " + currLocale.toString(prm[currBlock]["warningIntervalDur"]) + "\n")
##                 thisFile.write("Warning Interval ISI (ms): " + currLocale.toString(prm[currBlock]["warningIntervalISI"]) + "\n")
##             thisFile.write("Response Light: " + prm["responseLight"] + "\n")
##             thisFile.write("Response Light Duration (ms): " + currLocale.toString(prm[currBlock]["responseLightDuration"]) + "\n")
##             if prm[parent().currExp]["hasISIBox"] == True:
##                 thisFile.write("ISI:           " + currLocale.toString(prm["isi"]) + "\n")
##             if prm[parent().currExp]["hasPreTrialInterval"] == True:
##                 thisFile.write("Pre-Trial Interval:           " + prm[currBlock]["preTrialInterval"] + "\n")
##                 if prm[currBlock]["preTrialInterval"] == tr("Yes"):
##                     thisFile.write("Pre-Trial Interval ISI:           " + currLocale.toString(prm[currBlock]["preTrialIntervalISI"]) + "\n")
##             if prm[parent().currExp]["hasPrecursorInterval"] == True:
##                 thisFile.write("Precursor Interval:           " + prm[currBlock]["precursorInterval"] + "\n")
##                 if prm[currBlock]["precursorInterval"] == tr("Yes"):
##                     thisFile.write("Precursor Interval ISI:           " + currLocale.toString(prm[currBlock]["precursorIntervalISI"]) + "\n")
##             if prm[parent().currExp]["hasPostcursorInterval"] == True:
##                 thisFile.write("Postcursor Interval:           " + prm[currBlock]["postcursorInterval"] + "\n")
##                 if prm[currBlock]["postcursorInterval"] == tr("Yes"):
##                     thisFile.write("Postcursor Interval ISI:           " + currLocale.toString(prm[currBlock]["postcursorIntervalISI"]) + "\n")
##             if prm[parent().currExp]["hasAltReps"] == True:
##                 thisFile.write("Alternated (AB) Reps.:         " + currLocale.toString(prm["altReps"]) + "\n")
##                 thisFile.write("Alternated (AB) Reps. ISI (ms):         " + currLocale.toString(prm["altRepsISI"]) + "\n")

##             thisFile.write("\n")

##             for j in range(len(prm[currBlock]["chooser"])):
##                 if j not in parent().choosersToHide:
##                     thisFile.write(parent().chooserLabel[j].text() + " " + prm[currBlock]["chooser"][j] + "\n")
##             for j in range(len(prm[currBlock]["fileChooser"])):
##                 if j not in parent().fileChoosersToHide:
##                     thisFile.write(parent().fileChooserButton[j].text() + " " + prm[currBlock]["fileChooser"][j] + "\n")
##             for j in range(len(prm[currBlock]["field"])):
##                 if j not in parent().fieldsToHide and parent().fieldLabel[j].text()!= "Random Seed":
##                     thisFile.write(parent().fieldLabel[j].text() + ":  " + currLocale.toString(prm[currBlock]["field"][j]) + "\n")
##             thisFile.write("+++++++++++++++++++++++++++++++++++++++++++++++++++++++\n\n")

##             thisFile.flush()

##     def writeResultsFooter(self, fileType):
##         if fileType == "log":
##             filesToWrite = [resFileLog, fullFileLog]
##         elif fileType == "standard":
##             filesToWrite = [resFile, fullFile]
##         for i in range(2):
##             thisFile = filesToWrite[i]
##             #thisFile.write("*******************************************************\n\n")
##             thisFile.write("End: " + prm["blockEndTimeStamp"] + "\n") 
##             thisFile.write("Duration: {} min. \n".format( (prm["blockEndTime"] - prm["blockStartTime"]) / 60 ))
##             thisFile.write("\n")
##             thisFile.flush()
            
##     def writeResultsSummaryLine(self, paradigm, resultsLine):
##         if paradigm in ["Transformed Up-Down", "Weighted Up-Down"]:
##             headerToWrite = "threshold_" +  prm["adaptiveType"].lower() + prm["pref"]["general"]["csvSeparator"] + \
##                             "SD" + prm["pref"]["general"]["csvSeparator"] + \
##                             "condition" + prm["pref"]["general"]["csvSeparator"] + \
##                             "listener" + prm["pref"]["general"]["csvSeparator"] + \
##                             "session"+ prm["pref"]["general"]["csvSeparator"] + \
##                             "experimentLabel"+ prm["pref"]["general"]["csvSeparator"] + \
##                             "date"+ prm["pref"]["general"]["csvSeparator"] + \
##                             "time"+ prm["pref"]["general"]["csvSeparator"] + \
##                             "duration"+ prm["pref"]["general"]["csvSeparator"] + \
##                             "block"+ prm["pref"]["general"]["csvSeparator"] + \
##                             "experiment" + prm["pref"]["general"]["csvSeparator"] + \
##                             "paradigm" + prm["pref"]["general"]["csvSeparator"] 

##         elif paradigm in ["Transformed Up-Down Interleaved", "Weighted Up-Down Interleaved"]:
##             headerToWrite = ""
##             for j in range(prm["nDifferences"]):
##                 headerToWrite = headerToWrite + "threshold_" + prm["adaptiveType"].lower() + "_track" + str(j+1) +  prm["pref"]["general"]["csvSeparator"] + \
##                                 "SD_track"+ str(j+1) + prm["pref"]["general"]["csvSeparator"]
##             headerToWrite =  headerToWrite + "condition" + prm["pref"]["general"]["csvSeparator"] + \
##                             "listener" + prm["pref"]["general"]["csvSeparator"] + \
##                             "session"+ prm["pref"]["general"]["csvSeparator"] + \
##                             "experimentLabel"+ prm["pref"]["general"]["csvSeparator"] + \
##                             "date"+ prm["pref"]["general"]["csvSeparator"] + \
##                             "time"+ prm["pref"]["general"]["csvSeparator"] + \
##                             "duration"+ prm["pref"]["general"]["csvSeparator"] + \
##                             "block"+ prm["pref"]["general"]["csvSeparator"] + \
##                             "experiment" + prm["pref"]["general"]["csvSeparator"] + \
##                             "paradigm" + prm["pref"]["general"]["csvSeparator"] 
##         elif paradigm in ["Constant 1-Interval 2-Alternatives"]:
##             headerToWrite =  "dprime" +  prm["pref"]["general"]["csvSeparator"] + \
##                             "nTotal"+ prm["pref"]["general"]["csvSeparator"] + \
##                             "nCorrectA"+ prm["pref"]["general"]["csvSeparator"] + \
##                             "nTotalA"+ prm["pref"]["general"]["csvSeparator"] + \
##                             "nCorrectB"+ prm["pref"]["general"]["csvSeparator"] + \
##                             "nTotalB"+ prm["pref"]["general"]["csvSeparator"] + \
##                             "condition" + prm["pref"]["general"]["csvSeparator"] + \
##                             "listener" + prm["pref"]["general"]["csvSeparator"] + \
##                             "session"+ prm["pref"]["general"]["csvSeparator"] + \
##                             "experimentLabel"+ prm["pref"]["general"]["csvSeparator"] + \
##                             "date"+ prm["pref"]["general"]["csvSeparator"] + \
##                             "time"+ prm["pref"]["general"]["csvSeparator"] + \
##                             "duration"+ prm["pref"]["general"]["csvSeparator"] + \
##                             "block"+ prm["pref"]["general"]["csvSeparator"] + \
##                             "experiment" + prm["pref"]["general"]["csvSeparator"] +\
##                             "paradigm" + prm["pref"]["general"]["csvSeparator"]
##         elif paradigm in ["Constant 1-Pair Same/Different"]:
##             headerToWrite =  "dprime_IO" +  prm["pref"]["general"]["csvSeparator"] + \
##                             "dprime_diff" +  prm["pref"]["general"]["csvSeparator"] + \
##                             "nTotal"+ prm["pref"]["general"]["csvSeparator"] + \
##                             "nCorrectA"+ prm["pref"]["general"]["csvSeparator"] + \
##                             "nTotalA"+ prm["pref"]["general"]["csvSeparator"] + \
##                             "nCorrectB"+ prm["pref"]["general"]["csvSeparator"] + \
##                             "nTotalB"+ prm["pref"]["general"]["csvSeparator"] + \
##                             "condition" + prm["pref"]["general"]["csvSeparator"] + \
##                             "listener" + prm["pref"]["general"]["csvSeparator"] + \
##                             "session"+ prm["pref"]["general"]["csvSeparator"] + \
##                             "experimentLabel"+ prm["pref"]["general"]["csvSeparator"] + \
##                             "date"+ prm["pref"]["general"]["csvSeparator"] + \
##                             "time"+ prm["pref"]["general"]["csvSeparator"] + \
##                             "duration"+ prm["pref"]["general"]["csvSeparator"] + \
##                             "block"+ prm["pref"]["general"]["csvSeparator"] + \
##                             "experiment" + prm["pref"]["general"]["csvSeparator"] + \
##                             "paradigm" + prm["pref"]["general"]["csvSeparator"]
##         elif paradigm in ["Multiple Constants 1-Interval 2-Alternatives"]:
##             headerToWrite =  "dprime_ALL" +  prm["pref"]["general"]["csvSeparator"] + \
##                             "nTotal_ALL"+ prm["pref"]["general"]["csvSeparator"] + \
##                             "nCorrectA_ALL"+ prm["pref"]["general"]["csvSeparator"] + \
##                             "nTotalA_ALL"+ prm["pref"]["general"]["csvSeparator"] + \
##                             "nCorrectB_ALL"+ prm["pref"]["general"]["csvSeparator"] + \
##                             "nTotalB_ALL"+ prm["pref"]["general"]["csvSeparator"] 
##             for j in range(len(prm["conditions"])):
##                 headerToWrite =  headerToWrite +  "dprime_subc" + str(j+1)+ prm["pref"]["general"]["csvSeparator"] + \
##                                 "nTotal_subc"+  str(j+1) + prm["pref"]["general"]["csvSeparator"] + \
##                                 "nCorrectA_subc"+  str(j+1)+ prm["pref"]["general"]["csvSeparator"] + \
##                                 "nTotalA_subc"+  str(j+1)+ prm["pref"]["general"]["csvSeparator"] + \
##                                 "nCorrectB_subc"+  str(j+1)+ prm["pref"]["general"]["csvSeparator"] + \
##                                 "nTotalB_subc"+  str(j+1)+ prm["pref"]["general"]["csvSeparator"]
                                
##             headerToWrite = headerToWrite + "condition" + prm["pref"]["general"]["csvSeparator"] + \
##                             "listener" + prm["pref"]["general"]["csvSeparator"] + \
##                             "session"+ prm["pref"]["general"]["csvSeparator"] + \
##                             "experimentLabel"+ prm["pref"]["general"]["csvSeparator"] + \
##                             "date"+ prm["pref"]["general"]["csvSeparator"] + \
##                             "time"+ prm["pref"]["general"]["csvSeparator"] + \
##                             "duration"+ prm["pref"]["general"]["csvSeparator"] + \
##                             "block"+ prm["pref"]["general"]["csvSeparator"] + \
##                             "experiment" + prm["pref"]["general"]["csvSeparator"] + \
##                             "paradigm" + prm["pref"]["general"]["csvSeparator"] 
##         elif paradigm in ["Constant m-Intervals n-Alternatives"]:
##             headerToWrite = ""
          
##             headerToWrite = headerToWrite + "dprime" +  prm["pref"]["general"]["csvSeparator"] + \
##                             "perc_corr" +  prm["pref"]["general"]["csvSeparator"] + \
##                             "n_corr"+ prm["pref"]["general"]["csvSeparator"] +\
##                             "n_trials" + prm["pref"]["general"]["csvSeparator"]+\
##                             "condition" + prm["pref"]["general"]["csvSeparator"] + \
##                             "listener" + prm["pref"]["general"]["csvSeparator"] + \
##                             "session"+ prm["pref"]["general"]["csvSeparator"] + \
##                             "experimentLabel"+ prm["pref"]["general"]["csvSeparator"] + \
##                             "date"+ prm["pref"]["general"]["csvSeparator"] + \
##                             "time"+ prm["pref"]["general"]["csvSeparator"] + \
##                             "duration" + prm["pref"]["general"]["csvSeparator"] + \
##                             "block"+ prm["pref"]["general"]["csvSeparator"] + \
##                             "experiment" + prm["pref"]["general"]["csvSeparator"] +\
##                             "paradigm" + prm["pref"]["general"]["csvSeparator"] +\
##                             "nIntervals" + prm["pref"]["general"]["csvSeparator"] + \
##                             "nAlternatives" + prm["pref"]["general"]["csvSeparator"]

##         elif paradigm in ["Multiple Constants m-Intervals n-Alternatives"]:
##             headerToWrite = ""
##             for i in range(len(prm["conditions"])):
##                 headerToWrite = headerToWrite + "dprime_subc" + str(i+1) +  prm["pref"]["general"]["csvSeparator"] + \
##                                 "perc_corr_subc" + str(i+1) +  prm["pref"]["general"]["csvSeparator"] + \
##                                 "n_corr_subc"+ str(i+1) + prm["pref"]["general"]["csvSeparator"] +\
##                                 "n_trials_subc"+ str(i+1) + prm["pref"]["general"]["csvSeparator"]
                
##             headerToWrite =  headerToWrite + "tot_dprime" + prm["pref"]["general"]["csvSeparator"] + \
##                             "tot_perc_corr" + prm["pref"]["general"]["csvSeparator"] + \
##                             "tot_n_corr" + prm["pref"]["general"]["csvSeparator"] + \
##                             "tot_n_trials" + prm["pref"]["general"]["csvSeparator"] + \
##                             "condition" + prm["pref"]["general"]["csvSeparator"] + \
##                             "listener" + prm["pref"]["general"]["csvSeparator"] + \
##                             "session"+ prm["pref"]["general"]["csvSeparator"] + \
##                             "experimentLabel"+ prm["pref"]["general"]["csvSeparator"] + \
##                             "date"+ prm["pref"]["general"]["csvSeparator"] + \
##                             "time"+ prm["pref"]["general"]["csvSeparator"] + \
##                             "duration"+ prm["pref"]["general"]["csvSeparator"] + \
##                             "block"+ prm["pref"]["general"]["csvSeparator"] + \
##                             "experiment" + prm["pref"]["general"]["csvSeparator"] +\
##                             "paradigm" + prm["pref"]["general"]["csvSeparator"] +\
##                             "nIntervals" + prm["pref"]["general"]["csvSeparator"] + \
##                             "nAlternatives" + prm["pref"]["general"]["csvSeparator"]

##         elif paradigm in ["PEST"]:
##             headerToWrite = "threshold_" +  prm["adaptiveType"].lower() + prm["pref"]["general"]["csvSeparator"] + \
##                             "condition" + prm["pref"]["general"]["csvSeparator"] + \
##                             "listener" + prm["pref"]["general"]["csvSeparator"] + \
##                             "session"+ prm["pref"]["general"]["csvSeparator"] + \
##                             "experimentLabel"+ prm["pref"]["general"]["csvSeparator"] + \
##                             "date"+ prm["pref"]["general"]["csvSeparator"] + \
##                             "time"+ prm["pref"]["general"]["csvSeparator"] + \
##                             "duration"+ prm["pref"]["general"]["csvSeparator"] + \
##                             "block"+ prm["pref"]["general"]["csvSeparator"] + \
##                             "experiment" + prm["pref"]["general"]["csvSeparator"] + \
##                             "paradigm" + prm["pref"]["general"]["csvSeparator"]
##         elif paradigm in ["Odd One Out"]:
##             headerToWrite = "nTials" + prm["pref"]["general"]["csvSeparator"]
##             for i in range(len(prm["conditions"])):
##                 headerToWrite = headerToWrite + "cnd"+str(i+1)+"_stim1_count"+ prm["pref"]["general"]["csvSeparator"] + \
##                                 "cnd"+str(i+1) + "_stim1_percent"+ prm["pref"]["general"]["csvSeparator"] + \
##                                 "cnd"+str(i+1) + "_stim2_count"+ prm["pref"]["general"]["csvSeparator"] + \
##                                 "cnd"+str(i+1)+ "_stim2_percent"+ prm["pref"]["general"]["csvSeparator"] + \
##                                 "cnd"+str(i+1) + "_stim2_count"+ prm["pref"]["general"]["csvSeparator"] + \
##                                 "cnd"+str(i+1)+ "_stim3_percent"+ prm["pref"]["general"]["csvSeparator"] 
                                
##             headerToWrite = headerToWrite + "condition" + prm["pref"]["general"]["csvSeparator"] + \
##                             "listener" + prm["pref"]["general"]["csvSeparator"] + \
##                             "session"+ prm["pref"]["general"]["csvSeparator"] + \
##                             "experimentLabel"+ prm["pref"]["general"]["csvSeparator"] + \
##                             "date"+ prm["pref"]["general"]["csvSeparator"] + \
##                             "time"+ prm["pref"]["general"]["csvSeparator"] + \
##                             "duration"+ prm["pref"]["general"]["csvSeparator"] + \
##                             "block"+ prm["pref"]["general"]["csvSeparator"] + \
##                             "experiment" + prm["pref"]["general"]["csvSeparator"] + \
##                             "paradigm" + prm["pref"]["general"]["csvSeparator"]
            

##         currBlock = "b"+str(prm["currentBlock"])
##         for i in range(len(prm[currBlock]["fieldCheckBox"])):
##             if prm[currBlock]["fieldCheckBox"][i] == True:
##                 headerToWrite = headerToWrite + prm[currBlock]["fieldLabel"][i] + prm["pref"]["general"]["csvSeparator"]
##         for i in range(len(prm[currBlock]["chooserCheckBox"])):
##             if prm[currBlock]["chooserCheckBox"][i] == True:
##                 headerToWrite = headerToWrite + prm[currBlock]["chooserLabel"][i] + prm["pref"]["general"]["csvSeparator"]
##         for i in range(len(prm[currBlock]["fileChooserCheckBox"])):
##             if prm[currBlock]["fileChooserCheckBox"][i] == True:
##                 headerToWrite = headerToWrite + prm[currBlock]["fileChooserButton"][i] + prm["pref"]["general"]["csvSeparator"]
##         for i in range(len(prm[currBlock]["paradigmFieldCheckBox"])):
##             if prm[currBlock]["paradigmFieldCheckBox"][i] == True:
##                 headerToWrite = headerToWrite + prm[currBlock]["paradigmFieldLabel"][i] + prm["pref"]["general"]["csvSeparator"]
##         for i in range(len(prm[currBlock]["paradigmChooserCheckBox"])):
##             if prm[currBlock]["paradigmChooserCheckBox"][i] == True:
##                 headerToWrite = headerToWrite + prm[currBlock]["paradigmChooserLabel"][i] + prm["pref"]["general"]["csvSeparator"]

##         if prm[parent().currExp]["hasISIBox"] == True:
##             if prm[currBlock]["ISIValCheckBox"] == True:
##                 headerToWrite = headerToWrite + "ISI (ms)" + prm["pref"]["general"]["csvSeparator"]

##         if paradigm not in ["Constant m-Intervals n-Alternatives", "Multiple Constants m-Intervals n-Alternatives"]:
##             if prm[parent().currExp]["hasAlternativesChooser"] == True:
##                 if prm[currBlock]["nIntervalsCheckBox"] == True:
##                     headerToWrite = headerToWrite + "Intervals" + prm["pref"]["general"]["csvSeparator"] 
##                 if prm[currBlock]["nAlternativesCheckBox"] == True:
##                     headerToWrite = headerToWrite + "Alternatives" + prm["pref"]["general"]["csvSeparator"]

##         if prm[parent().currExp]["hasAltReps"] == True:
##             if prm[currBlock]["altRepsCheckBox"] == True:
##                 headerToWrite = headerToWrite + "Alternated (AB) Reps." + prm["pref"]["general"]["csvSeparator"]
##                 headerToWrite = headerToWrite + "Alternated (AB) Reps. ISI (ms)" + prm["pref"]["general"]["csvSeparator"]
                
##         if prm[currBlock]["responseLightCheckBox"] == True:
##             headerToWrite = headerToWrite + "Response Light" + prm["pref"]["general"]["csvSeparator"]
##         if prm[currBlock]["responseLightDurationCheckBox"] == True:
##             headerToWrite = headerToWrite + "Response Light Duration" + prm["pref"]["general"]["csvSeparator"]
              
##         headerToWrite = headerToWrite + "\n"
##         if os.path.exists(prm["resultsFile"].split(".txt")[0]+ prm["pref"]["general"]["resTableFileSuffix"]+".csv") == False: #case 1 file does not exist yet
##             resFileSummary = open(prm["resultsFile"].split(".txt")[0]+ prm["pref"]["general"]["resTableFileSuffix"]+".csv", "w")
##             resFileSummary.write(headerToWrite)
##             resFileSummary.write(resultsLine)
##             resFileSummary.close()
##         else:
##             resFileSummary = open(prm["resultsFile"].split(".txt")[0]+ prm["pref"]["general"]["resTableFileSuffix"]+".csv", "r")
##             allLines = resFileSummary.readlines()
##             resFileSummary.close()
##             try:
##                 h1idx = allLines.index(headerToWrite)
##                 headerPresent = True
##             except:
##                 headerPresent = False

##             if headerPresent == True:
##                 #("Header already present")
##                 nextHeaderFound = False
##                 for i in range(h1idx+1, len(allLines)):
##                     #look for next "experiment or end of file"
##                     if  allLines[i][0:6] == "dprime" or allLines[i][0:4] == "perc" or allLines[i][0:9] == "threshold":
##                         nextHeaderFound = True
##                         h2idx = i
##                         break
##                 if nextHeaderFound == True:
##                     #("Next Header Found")
##                     allLines.insert(h2idx, resultsLine)
##                 else:
##                     allLines.append(resultsLine)
##                     #("Next Header Not Found Appending")
##             elif headerPresent == False:
##                 allLines.append(headerToWrite)
##                 allLines.append(resultsLine)
##             resFileSummary = open(prm["resultsFile"].split(".txt")[0]+ prm["pref"]["general"]["resTableFileSuffix"]+".csv", "w")
##             resFileSummary.writelines(allLines)
##             resFileSummary.close()
            
##     def getCommonTabFields(self, resLineToWrite):
##         currBlock = "b" + str(prm["currentBlock"])
##         for i in range(len(prm[currBlock]["fieldCheckBox"])):
##             if prm[currBlock]["fieldCheckBox"][i] == True:
##                 resLineToWrite = resLineToWrite + currLocale.toString(prm[currBlock]["field"][i], precision=prm["pref"]["general"]["precision"]) + prm["pref"]["general"]["csvSeparator"]
##         for i in range(len(prm[currBlock]["chooserCheckBox"])):
##             if prm[currBlock]["chooserCheckBox"][i] == True:
##                 resLineToWrite = resLineToWrite + prm[currBlock]["chooser"][i].split(":")[0] + prm["pref"]["general"]["csvSeparator"]

##         for i in range(len(prm[currBlock]["fileChooserCheckBox"])):
##             if prm[currBlock]["fileChooserCheckBox"][i] == True:
##                 resLineToWrite = resLineToWrite + prm[currBlock]["fileChooser"][i].split(":")[0] + prm["pref"]["general"]["csvSeparator"]

##         for i in range(len(prm[currBlock]["paradigmFieldCheckBox"])):
##             if prm[currBlock]["paradigmFieldCheckBox"][i] == True:
##                 resLineToWrite = resLineToWrite + currLocale.toString(prm[currBlock]["paradigmField"][i],
##                                                                            precision=prm["pref"]["general"]["precision"]) + prm["pref"]["general"]["csvSeparator"]

##         for i in range(len(prm[currBlock]["paradigmChooserCheckBox"])):
##             if prm[currBlock]["paradigmChooserCheckBox"][i] == True:
##                 resLineToWrite = resLineToWrite + prm[currBlock]["paradigmChooser"][i].split(":")[0] + prm["pref"]["general"]["csvSeparator"]

##         if prm[parent().currExp]["hasISIBox"] == True:
##             if prm[currBlock]["ISIValCheckBox"] == True:
##                 resLineToWrite = resLineToWrite + str(prm[currBlock]["ISIVal"]) + prm["pref"]["general"]["csvSeparator"]

##         if  prm["paradigm"] not in ["Constant m-Intervals n-Alternatives", "Multiple Constants m-Intervals n-Alternatives"]:
##             if prm[parent().currExp]["hasAlternativesChooser"] == True:
##                 if prm[currBlock]["nIntervalsCheckBox"] == True:
##                     resLineToWrite = resLineToWrite + str(prm[currBlock]["nIntervals"]) + prm["pref"]["general"]["csvSeparator"] 
##                 if prm[currBlock]["nAlternativesCheckBox"] == True:
##                     resLineToWrite = resLineToWrite + str(prm[currBlock]["nAlternatives"]) + prm["pref"]["general"]["csvSeparator"]

##         if prm[parent().currExp]["hasAltReps"] == True:
##             if prm[currBlock]["altRepsCheckBox"] == True:
##                 resLineToWrite = resLineToWrite + str(prm[currBlock]["altReps"]) + prm["pref"]["general"]["csvSeparator"]
##                 resLineToWrite = resLineToWrite + str(prm[currBlock]["altRepsISI"]) + prm["pref"]["general"]["csvSeparator"]
       
##         if prm[currBlock]["responseLightCheckBox"] == True:
##             resLineToWrite = resLineToWrite + prm[currBlock]["responseLight"] + prm["pref"]["general"]["csvSeparator"]

##         if prm[currBlock]["responseLightDurationCheckBox"] == True:
##                 resLineToWrite = resLineToWrite + currLocale.toString(prm[currBlock]["responseLightDuration"]) + prm["pref"]["general"]["csvSeparator"]

##         return resLineToWrite

##     def sendEndNotification(self):
##         currBlock = "b"+ str(prm["currentBlock"])
##         subject = tr("Pychoacoustics Notification: Listener ") + prm["listener"] + tr(" has ") \
##                + str(prm["pref"]["email"]["nBlocksNotify"]) + tr(" block(s) to go")
##         body = subject + "\n" + tr("Experiment: ") + parent().currExp + \
##               "\n" + tr("Completed Blocks: ") + str(prm["currentBlock"]) + tr(" Stored Blocks: ") + str(prm["storedBlocks"])
##         emailThread.sendEmail(subject, body)

##     def sendData(self):
##         currBlock = "b"+ str(prm["currentBlock"])
##         subject = "Pychoacoustics Data, Listener: " + prm["listener"] +  ", Experiment: " + \
##                parent().currExp
##         body = ""
##         filesToSend = [pychovariablesSubstitute[pychovariables.index("[resFile]")],
##                        pychovariablesSubstitute[pychovariables.index("[resFileFull]")],
##                        pychovariablesSubstitute[pychovariables.index("[resTable]")]] #prm["resultsFile"], prm["resultsFile"].split(".txt")[0]+prm["pref"]["general"]["fullFileSuffix"]+".txt"]
##         if prm["allBlocks"]["procRes"] == True:
##             filesToSend.append(pychovariablesSubstitute[pychovariables.index("[resFileRes]")])#prm["resultsFile"].split(".txt")[0] + prm["pref"]["general"]["resFileSuffix"]+".txt")
##         if prm["allBlocks"]["procResTable"] == True:
##             filesToSend.append(pychovariablesSubstitute[pychovariables.index("[resTableProcessed]")])
##         if prm["allBlocks"]["pdfPlot"] == True:
##             filesToSend.append(pychovariablesSubstitute[pychovariables.index("[pdfPlot]")])
##         filesToSendChecked = []
##         for fName in filesToSend:
##             if os.path.exists(fName):
##                 filesToSendChecked.append(fName)
##             else:
##                 print("Could not find: ", fName)
                       
                
##         emailThread.sendEmail(subject, body, filesToSendChecked)


##     def processResultsEnd(self):
##         resFilePath = prm["resultsFile"]
##         if prm["paradigm"] in [tr("Transformed Up-Down"), tr("Weighted Up-Down"), tr("PEST")]:
##             processResultsAdaptive([resFilePath])
##         elif prm["paradigm"] in [tr("Transformed Up-Down Interleaved"), tr("Weighted Up-Down Interleaved")]:
##             processResultsAdaptiveInterleaved([resFilePath])
##         elif prm["paradigm"] in [tr("Constant 1-Interval 2-Alternatives")]:
##             processResultsConstant1Interval2Alternatives([resFilePath], dprimeCorrection=prm["pref"]["general"]["dprimeCorrection"])
##         elif prm["paradigm"] in [tr("Multiple Constants 1-Interval 2-Alternatives")]:
##             processResultsMultipleConstants1Interval2Alternatives([resFilePath], dprimeCorrection=prm["pref"]["general"]["dprimeCorrection"])
##         elif prm["paradigm"] in [tr("Constant m-Intervals n-Alternatives")]:
##             processResultsConstantMIntervalsNAlternatives([resFilePath])
##         elif prm["paradigm"] in [tr("Multiple Constants m-Intervals n-Alternatives")]:
##             processResultsMultipleConstantsMIntervalsNAlternatives([resFilePath])
##         elif prm["paradigm"] in [tr("Constant 1-Pair Same/Different")]:
##             processResultsConstant1PairSameDifferent([resFilePath], dprimeCorrection=prm["pref"]["general"]["dprimeCorrection"])


##     def processResultsTableEnd(self):
##         separator = parent().prm["pref"]["general"]["csvSeparator"]
##         resFilePath = pychovariablesSubstitute[pychovariables.index("[resTable]")]
##         if prm["paradigm"] in [tr("Transformed Up-Down"), tr("Weighted Up-Down"), tr("PEST")]:
##             processResultsTableAdaptive([resFilePath], fout=None, separator=separator)
##         elif prm["paradigm"] in [tr("Transformed Up-Down Interleaved"), tr("Weighted Up-Down Interleaved")]:
##             processResultsTableAdaptiveInterleaved([resFilePath], fout=None, separator=separator)
##         elif prm["paradigm"] in [tr("Constant 1-Interval 2-Alternatives")]:
##             processResultsTableConstant1Int2Alt([resFilePath], fout=None, separator=separator, dprimeCorrection=prm["pref"]["general"]["dprimeCorrection"])
##         elif prm["paradigm"] in [tr("Multiple Constants 1-Interval 2-Alternatives")]:
##             processResultsTableMultipleConstants1Int2Alt([resFilePath], fout=None, separator=separator, dprimeCorrection=prm["pref"]["general"]["dprimeCorrection"])
##         elif prm["paradigm"] in [tr("Constant m-Intervals n-Alternatives")]:
##             processResultsTableConstantMIntNAlt([resFilePath], fout=None, separator=separator)
##         elif prm["paradigm"] in [tr("Multiple Constants m-Intervals n-Alternatives")]:
##             processResultsTableMultipleConstantsMIntNAlt([resFilePath], fout=None, separator=separator)
##         elif prm["paradigm"] in [tr("Constant 1-Pair Same/Different")]:
##             processResultsTableConstant1PairSameDifferent([resFilePath], fout=None, separator=separator, dprimeCorrection=prm["pref"]["general"]["dprimeCorrection"])


##     def plotDataEnd(self, winPlot, pdfPlot):
##         if prm["appData"]["plotting_available"]: 
##             resFilePath = pychovariablesSubstitute[pychovariables.index("[resTable]")]
##             summaryResFilePath = resFilePath.split(".csv")[0] + "_processed.csv"
##             separator = parent().prm["pref"]["general"]["csvSeparator"]

##             if prm["paradigm"] in [tr("Transformed Up-Down"), tr("Weighted Up-Down"), tr("PEST")]:
##                 paradigm = "adaptive"
##             elif prm["paradigm"] in [tr("Transformed Up-Down Interleaved"), tr("Weighted Up-Down Interleaved")]:
##                 paradigm = "adaptive_interleaved"
##             elif prm["paradigm"] in [tr("Constant 1-Interval 2-Alternatives")]:
##                 paradigm = "constant1Interval2Alternatives"
##             elif prm["paradigm"] in [tr("Multiple Constants 1-Interval 2-Alternatives")]:
##                 paradigm = "multipleConstants1Interval2Alternatives"
##             elif prm["paradigm"] in [tr("Constant m-Intervals n-Alternatives")]:
##                 paradigm ="constantMIntervalsNAlternatives"
##             elif prm["paradigm"] in [tr("Multiple Constants m-Intervals n-Alternatives")]:
##                 paradigm = "multipleConstantsMIntervalsNAlternatives"
##             elif prm["paradigm"] in [tr("Constant 1-Pair Same/Different")]:
##                 paradigm = "constant1PairSD"

##             categoricalPlot(self, "average", summaryResFilePath, winPlot, pdfPlot, paradigm, separator, None, prm)

                
##     def parseCustomCommandArguments(self, cmd):
##         cmdList = []
##         cmdSplit = cmd.split()
##         for i in range(len(cmdSplit)):
##             if cmdSplit[i] in pychovariables:
##                 idx = pychovariables.index(cmdSplit[i])
##                 cmdList.append(pychovariablesSubstitute[idx])
##             else:
##                 cmdList.append(cmdSplit[i])
##         parsedCmd = " ".join(cmdList)
##         return parsedCmd
                
##     def playEndMessage(self):
##         idx = get_list_indices(prm["pref"]["general"]["endMessageFilesUse"], "\u2713")
##         idChosen = random.choice(idx)
##         msgSnd, fs = audioManager.loadWavFile(prm["pref"]["general"]["endMessageFiles"][idChosen], prm["pref"]["general"]["endMessageLevels"][idChosen], prm["allBlocks"]["maxLevel"], "Both")
##         playThread.playThreadedSound(msgSnd, fs, prm["allBlocks"]["nBits"], prm["pref"]["sound"]["playCommand"], False, "foo.wav")

