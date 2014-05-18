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


using PyCall
#pyinitialize("python3")
using PySide

include("audio_manager.jl")
include("global_parameters.jl")
include("default_experiments/default_experiments.jl")
pysis = pyimport("sys") 
pyos = pyimport("os") 
pysis["path"][:insert](0, "foo")
pysis["path"][:insert](0, pyos["path"][:abspath]("."))
PyCall.pyimport("qrc_resources") 

QtGui = pyimport("PySide.QtGui")


szp = Qt.QSizePolicy()

prm = (String => Any)[]
wd = (String => Any)[] #widgets
wdc = (String => Any)[] #widget containers (like lists of widgets)
prm = get_prefs(prm)
prm = set_global_parameters(prm)

prm["hideWins"] = false
prm["progbar"] = false
prm["blockProgbar"] = false
prm["currentRepetition"] = 1

#-------------------
#LOCALE SETTINGS
    ## #LOCALE LOADING
    ## # qtTranslator is the translator for default qt component labels (OK, cancel button dialogs etc...)
    ## locale = QtCore.QLocale().system().name() #returns a string such as en_US
    ## qtTranslator = QtCore.QTranslator()
    ## if qtTranslator.load("qt_" + locale, ":/translations/"):
    ##     app.installTranslator(qtTranslator)
    ## # appTranslator is the translator for labels created for the program
    ## appTranslator = QtCore.QTranslator()
    ## if appTranslator.load("pychoacoustics_" + locale, ":/translations/"):
    ##     app.installTranslator(appTranslator)
    ## prm['currentLocale'] = QtCore.QLocale(locale)
    ## QtCore.QLocale.setDefault(prm['currentLocale'])
    ## prm['currentLocale'].setNumberOptions(prm['currentLocale'].OmitGroupSeparator | prm['currentLocale'].RejectGroupSeparator)

    ## if prm['pref']['country'] != "System Settings":
    ##     locale =  prm['pref']['language']  + '_' + prm['pref']['country']#returns a string such as en_US
    ##     qtTranslator = QtCore.QTranslator()
    ##     if qtTranslator.load("qt_" + locale, ":/translations/"):
    ##         app.installTranslator(qtTranslator)
    ##     appTranslator = QtCore.QTranslator()
    ##     if appTranslator.load("pychoacoustics_" + locale, ":/translations/") or locale == "en_US":
    ##         app.installTranslator(appTranslator)
    ##         prm['currentLocale'] = QtCore.QLocale(locale)
    ##         QtCore.QLocale.setDefault(prm['currentLocale'])
    ##         prm['currentLocale'].setNumberOptions(prm['currentLocale'].OmitGroupSeparator | prm['currentLocale'].RejectGroupSeparator)
responseBoxLocale =  string(prm["pref"]["responseBoxLanguage"], "_", prm["pref"]["responseBoxCountry"])#returns a string such as en_US
responseBoxTranslator = QtCore[:QTranslator]()
responseBoxTranslator[:load](string("pychoacoustics_", responseBoxLocale), ":/translations/")
respButtTranslator = QtCore[:QTranslator]()

    ## if labexp_exists == True:
    ##     respButtTransPath = os.path.dirname(labexp.__file__) + '/translations/labexp_' + responseBoxLocale
    ##     respButtTranslator.load(respButtTransPath)
    prm["rbTrans"] = responseBoxTranslator
    prm["buttonTranslator"] = respButtTranslator
        
include("control_window_functions.jl")


prm["currExp"] = None
prm["prevExp"] = None
prm["currParadigm"] = None
prm["prevParadigm"] = None
prm["currentBlock"] = 1
prm["storedBlocks"] = 0
par = (Any)[]
qnew_class("pychowin", "QtGui.QMainWindow") ## QtGui -- not just Qt.
w = qnew_class_instance("pychowin")
qset_method(w, :closeEvent) do e
 w[:close]()
 rbw[:close]()
 notify(closeCondition)
 
end
#w = Qt.QMainWindow()
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
exitButton = Qt.QAction(QtGui["QIcon"][:fromTheme]("application-exit", Qt.QIcon(":/application-exit")), "Exit", w)
exitButton[:setShortcut]("Ctrl+Q")
exitButton[:setStatusTip]("Exit application")
exitButton[:triggered][:connect](close_w)

processResultsMenu = fileMenu[:addMenu]("&Process Results")

processResultsLinearButton = Qt.QAction("&Process Results (Plain Text)", w)
processResultsLinearButton[:setStatusTip]("Process Results (Plain Text)")
#@processResultsLinearButton[:triggered][:connect](processResultsLinearDialog)

processResultsTableButton = Qt.QAction("&Process Results Table", w)
processResultsTableButton[:setStatusTip]("Process Results Table")
#@processResultsTableButton[:triggered][:connect](processResultsTableDialog)


openResultsButton = Qt.QAction(QtGui["QIcon"][:fromTheme]("document-open", Qt.QIcon(":/document-open")), "Open Results File", w)
openResultsButton[:setStatusTip]("Open Results File")
#@openResultsButton[:triggered][:connect](onClickOpenResultsButton)

processResultsMenu[:addAction](processResultsLinearButton)
processResultsMenu[:addAction](processResultsTableButton)
        
## fileMenu.addAction(openResultsButton)
fileMenu[:addAction](exitButton)
        
#EDIT MENU
editMenu = menubar[:addMenu]("&Edit")
editPrefAction = Qt.QAction(QtGui["QIcon"][:fromTheme]("preferences-other", Qt.QIcon(":/preferences-other")), "Preferences", w)
editMenu[:addAction](editPrefAction)
#@editPrefAction[:triggered][:connect](onEditPref)

editPhonesAction = Qt.QAction(QtGui["QIcon"][:fromTheme]("audio-headphones", Qt.QIcon(":/audio-headphones")), "Phones", w)
editMenu[:addAction](editPhonesAction)
#@editPhonesAction[:triggered][:connect](onEditPhones)

editExperimentersAction = Qt.QAction(QtGui["QIcon"][:fromTheme]("system-users", Qt.QIcon(":/system-users")), "Experimenters", w)
editMenu[:addAction](editExperimentersAction)
#@editExperimentersAction[:triggered][:connect](onEditExperimenters)

#TOOLS MENU
toolsMenu = menubar[:addMenu]("&Tools")
swapBlocksAction = Qt.QAction("Swap Blocks", w)
toolsMenu[:addAction](swapBlocksAction)
swapBlocksAction[:triggered][:connect](onSwapBlocksAction)

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
        
onAboutAction = Qt.QAction(QtGui["QIcon"][:fromTheme]("help-about", Qt.QIcon(":/help-about")), "About pychoacoustics", w)
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
qconnect(paradigmChooser, :activated, (str) -> onParadigmChange(prm[prm["currExp"]["paradigmChoices"]][str+1]))

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
saveResultsButton[:setIcon](QtGui["QIcon"][:fromTheme]("document-save", Qt.QIcon(":/document-save")))
saveResultsButton[:setIconSize](QtCore[:QSize](min_pw_icon_size, min_pw_icon_size))
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
autoPCorrTF[:setValidator](Qt.QDoubleValidator(0, 100, 6, w))
def_widg_sizer2[:addWidget](autoPCorrTF, 2, 3)
autoPCorrLabel[:hide]()
autoPCorrTF[:hide]()


paradigm_widg_sizer = Qt.QGridLayout()
pw_sizer = Qt.QVBoxLayout()
pw_buttons_sizer = Qt.QGridLayout()
min_pw_butt_size = 22
min_pw_icon_size = 20
pw_buttons_sizer[:setRowMinimumHeight](0, min_pw_butt_size)
pw_buttons_sizer[:setRowMinimumHeight](1, min_pw_butt_size)
pw_buttons_sizer[:setRowMinimumHeight](2, min_pw_butt_size)


## #---- FIRST ROW
n = 0
#LOAD PARAMETERS BUTTON
loadParametersButton = Qt.QPushButton("Load Prm")
loadParametersButton[:setIcon](QtGui["QIcon"][:fromTheme]("document-open", Qt.QIcon(":/document-open")))
loadParametersButton[:setIconSize](QtCore[:QSize](min_pw_icon_size, min_pw_icon_size))
loadParametersButton[:clicked][:connect](onClickLoadParametersButton)
loadParametersButton[:setToolTip]("Load a parameters file")
loadParametersButton[:setWhatsThis]("Load a file containing the parameters for an experimental session")
loadParametersButton[:setSizePolicy](szp[:Expanding], szp[:Expanding])
pw_buttons_sizer[:addWidget](loadParametersButton, n, 0)

#SAVE PARAMETERS BUTTON
saveParametersButton = Qt.QPushButton("Save Prm")
saveParametersButton[:setIcon](QtGui["QIcon"][:fromTheme]("document-save", Qt.QIcon(":/document-save")))
saveParametersButton[:setIconSize](QtCore[:QSize](min_pw_icon_size, min_pw_icon_size))
saveParametersButton[:clicked][:connect](onClickSaveParametersButton)
saveParametersButton[:setToolTip]("Save a parameters file")
saveParametersButton[:setWhatsThis]("Save the current experimental parameters to a file")
saveParametersButton[:setSizePolicy](szp[:Expanding], szp[:Expanding])
pw_buttons_sizer[:addWidget](saveParametersButton, n, 1)

#DELETE PARAMETERS BUTTON
deleteParametersButton = Qt.QPushButton("Delete")
deleteParametersButton[:clicked][:connect](onClickDeleteParametersButton)
deleteParametersButton[:setIcon](QtGui["QIcon"][:fromTheme]("edit-delete", Qt.QIcon(":/edit-delete")))
deleteParametersButton[:setIconSize](QtCore[:QSize](min_pw_icon_size, min_pw_icon_size))
deleteParametersButton[:setToolTip]("Delete current Block")
deleteParametersButton[:setSizePolicy](szp[:Expanding], szp[:Expanding])
pw_buttons_sizer[:addWidget](deleteParametersButton, n, 2)


undoUnsavedButton = Qt.QPushButton("Undo Unsaved")
undoUnsavedButton[:clicked][:connect](onClickUndoUnsavedButton)
undoUnsavedButton[:setIcon](QtGui["QIcon"][:fromTheme]("edit-undo", Qt.QIcon(":/edit-undo")))
undoUnsavedButton[:setIconSize](QtCore[:QSize](min_pw_icon_size, min_pw_icon_size))
undoUnsavedButton[:setToolTip]("Undo unsaved changes")
undoUnsavedButton[:setSizePolicy](szp[:Expanding], szp[:Expanding])
pw_buttons_sizer[:addWidget](undoUnsavedButton, n, 3)

## #---- SECOND ROW
n = n+1
storeParametersButton = Qt.QPushButton("Store")
storeParametersButton[:clicked][:connect](onClickStoreParametersButton)
storeParametersButton[:setIcon](QtGui["QIcon"][:fromTheme]("media-flash-memory-stick", Qt.QIcon(":/media-flash-memory-stick")))
storeParametersButton[:setIconSize](QtCore[:QSize](min_pw_icon_size, min_pw_icon_size))
storeParametersButton[:setToolTip]("Store current Block")
storeParametersButton[:setSizePolicy](szp[:Expanding], szp[:Expanding])
pw_buttons_sizer[:addWidget](storeParametersButton, n, 0)

storeandaddParametersButton = Qt.QPushButton("Store 'n' add!")
storeandaddParametersButton[:clicked][:connect](onClickStoreandaddParametersButton)
storeandaddParametersButton[:setToolTip]("Store current Block and add a new one")
storeandaddParametersButton[:setSizePolicy](szp[:Expanding], szp[:Expanding])
pw_buttons_sizer[:addWidget](storeandaddParametersButton, n, 1)

storeandgoParametersButton = Qt.QPushButton("Store 'n' go!")
storeandgoParametersButton[:clicked][:connect](onClickStoreandgoParametersButton)
storeandgoParametersButton[:setToolTip]("Store current Block and move to the next")
storeandgoParametersButton[:setSizePolicy](szp[:Expanding], szp[:Expanding])
pw_buttons_sizer[:addWidget](storeandgoParametersButton, n, 2)

newBlockButton = Qt.QPushButton("New Block")
newBlockButton[:clicked][:connect](onClickNewBlockButton)
newBlockButton[:setIcon](QtGui["QIcon"][:fromTheme]("document-new", Qt.QIcon(":/document-new")))
newBlockButton[:setIconSize](QtCore[:QSize](min_pw_icon_size, min_pw_icon_size))
newBlockButton[:setToolTip]("Append a new block")
newBlockButton[:setSizePolicy](szp[:Expanding], szp[:Expanding])
pw_buttons_sizer[:addWidget](newBlockButton, n, 3)

      
      

#---- THIRD ROW
n = n+1
prevBlockButton = Qt.QPushButton("Previous")
prevBlockButton[:clicked][:connect](onClickPrevBlockButton)
prevBlockButton[:setIcon](QtGui["QIcon"][:fromTheme]("go-previous", Qt.QIcon(":/go-previous")))
prevBlockButton[:setIconSize](QtCore[:QSize](min_pw_icon_size, min_pw_icon_size))
prevBlockButton[:setToolTip]("Move to previous block")
prevBlockButton[:setSizePolicy](szp[:Expanding], szp[:Expanding])
pw_buttons_sizer[:addWidget](prevBlockButton, n, 0)

nextBlockButton = Qt.QPushButton("Next")
nextBlockButton[:clicked][:connect](onClickNextBlockButton)
nextBlockButton[:setIcon](QtGui["QIcon"][:fromTheme]("go-next", Qt.QIcon(":/go-next")))
nextBlockButton[:setIconSize](QtCore[:QSize](min_pw_icon_size, min_pw_icon_size))
nextBlockButton[:setToolTip]("Move to next block")
nextBlockButton[:setSizePolicy](szp[:Expanding], szp[:Expanding])
pw_buttons_sizer[:addWidget](nextBlockButton, n, 1)

shuffleBlocksButton = Qt.QPushButton("Shuffle")
shuffleBlocksButton[:clicked][:connect](onClickShuffleBlocksButton)
shuffleBlocksButton[:setIcon](QtGui["QIcon"][:fromTheme]("media-playlist-shuffle", Qt.QIcon(":/media-playlist-shuffle")))
shuffleBlocksButton[:setIconSize](QtCore[:QSize](min_pw_icon_size, min_pw_icon_size))
shuffleBlocksButton[:setToolTip]("Shuffle blocks")
shuffleBlocksButton[:setSizePolicy](szp[:Expanding], szp[:Expanding])
pw_buttons_sizer[:addWidget](shuffleBlocksButton, n, 2)

resetParametersButton = Qt.QPushButton("Reset")
resetParametersButton[:clicked][:connect](onClickResetParametersButton)
resetParametersButton[:setIcon](QtGui["QIcon"][:fromTheme]("go-home", Qt.QIcon(":/go-home")))
resetParametersButton[:setIconSize](QtCore[:QSize](min_pw_icon_size, min_pw_icon_size))
resetParametersButton[:setToolTip]("Reset parameters")
resetParametersButton[:setSizePolicy](szp[:Expanding], szp[:Expanding])
pw_buttons_sizer[:addWidget](resetParametersButton, n, 3)
n = n+1
pw_buttons_sizer[:addItem](Qt.QSpacerItem(10,10,szp[:Expanding]), n, 0, 1, 4)


## #----FOURTH ROW
n = n+1
currentBlockLabel = Qt.QLabel("Current Block:")
pw_buttons_sizer[:addWidget](currentBlockLabel, n, 0)

currentBlockCountLabel = Qt.QLabel(string(prm["currentBlock"]))
pw_buttons_sizer[:addWidget](currentBlockCountLabel, n, 1)

storedBlocksLabel = Qt.QLabel("Stored Blocks:")
pw_buttons_sizer[:addWidget](storedBlocksLabel, n, 2)

storedBlocksCountLabel = Qt.QLabel(string(prm["storedBlocks"]))
pw_buttons_sizer[:addWidget](storedBlocksCountLabel, n, 3)

#FIFTH ROW
n = n+1
currentBlockPositionLabelLabel = Qt.QLabel("Block Position:")
pw_buttons_sizer[:addWidget](currentBlockPositionLabelLabel, n, 0)
currentBlockPositionLabel = Qt.QLabel(string(prm["currentBlock"]))
pw_buttons_sizer[:addWidget](currentBlockPositionLabel, n, 1)

jumpToBlockLabel = Qt.QLabel("Jump to Block:")
jumpToBlockChooser = Qt.QComboBox()
qconnect(jumpToBlockChooser, :activated, (str) -> onJumpToBlockChange(str))
pw_buttons_sizer[:addWidget](jumpToBlockLabel, n, 2)
pw_buttons_sizer[:addWidget](jumpToBlockChooser, n, 3)
#SIXTH ROW
n = n+1
prevBlockPositionButton = Qt.QPushButton("Previous Position")
prevBlockPositionButton[:clicked][:connect](onClickPrevBlockPositionButton)
prevBlockPositionButton[:setIcon](QtGui["QIcon"][:fromTheme]("go-previous", Qt.QIcon(":/go-previous")))
prevBlockPositionButton[:setToolTip]("Move to previous block position")
pw_buttons_sizer[:addWidget](prevBlockPositionButton, n, 0)

nextBlockPositionButton = Qt.QPushButton("Next Position")
nextBlockPositionButton[:clicked][:connect](onClickNextBlockPositionButton)
nextBlockPositionButton[:setIcon](QtGui["QIcon"][:fromTheme]("go-next", Qt.QIcon(":/go-next")))
nextBlockPositionButton[:setToolTip]("Move to next block position")
pw_buttons_sizer[:addWidget](nextBlockPositionButton, n, 1)

jumpToPositionLabel = Qt.QLabel("Jump to Position:")
jumpToPositionChooser = Qt.QComboBox()
qconnect(jumpToPositionChooser, :activated, (str) -> onJumpToPositionChange(str))
pw_buttons_sizer[:addWidget](jumpToPositionLabel, n, 2)
pw_buttons_sizer[:addWidget](jumpToPositionChooser, n, 3)

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

pw[:layout]()[:setSizeConstraint](QtGui["QLayout"][:SetFixedSize])
cw[:layout]()[:setSizeConstraint](QtGui["QLayout"][:SetFixedSize])

pw_scrollarea = Qt.QScrollArea()
pw_scrollarea[:setWidget](pw)
splitter[:addWidget](pw_scrollarea)

screen = Qt.QDesktopWidget()[:screenGeometry]()
w[:setGeometry](80, 100, int((2/3)*screen[:width]()), int((7/10)*screen[:height]()))
splitter[:setSizes]([(2/6)*screen[:width](), (2/6)*screen[:width]()])


w[:setWindowIcon](Qt.QIcon(":/Machovka_Headphones.svg"))
w[:setWindowTitle]("PsychoJulia")
w[:setCentralWidget](splitter)

raise(w)
include("response_box.jl")
## while true
    
## end
closeCondition = Condition()
wait(closeCondition)



#end
