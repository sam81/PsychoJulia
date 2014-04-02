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

function set_global_parameters(prm)
    locale = QtCore[:QLocale]()[:system]()[:name]()
    prm["currentLocale"] = QtCore[:QLocale](locale)
    prm["tmpParametersFile"] = ".tmp_prm.prm"
    ## prm["nAlternatives"] = 3
    prm["experimentsChoices"] = (String)[]
    ## prm["shuffled"] = False
    for i in 1:length(default_experiments.exps)
        prm = eval(parse(string("default_experiments.initialize_", default_experiments.exps[i], "(prm)")))
    end
    ## if labexp_exists == True:
    ##     for item in labexp.__all__:
    ##         methodToCall1 = getattr(labexp, item)
    ##         methodToCall2 = getattr(methodToCall1, 'initialize_'+item)
    ##         prm = methodToCall2(prm)
    opts =  ["hasISIBox", "hasAlternativesChooser", "hasFeedback", "hasIntervalLights",
             "hasPreTrialInterval", "hasPrecursorInterval", "hasPostcursorInterval",
             "hasNTracksChooser", "hasNDifferencesChooser", "hasAltReps"]

    for exp in prm["experimentsChoices"]
        for opt in opts
            if opt in prm[exp]["opts"]
                prm[exp][opt] = true
            else
                prm[exp][opt] = false
            end
        end
    end
    prm["nIntervalsChoices"] = ["2", "3", "4", "5", "6", "7", "8", "9"]
    prm["adaptiveTypeChoices"] = ["Arithmetic", "Geometric"]
    prm["tnpToAverageChoices"] = ["All final stepsize (even)", "First N final stepsize", "Last N final stepsize",""]
    prm["nBitsChoices"] = ["16", "32"]
    prm["shuffleChoices"] = ["No", "Ask", "Auto"]
    prm["responseModeChoices"] = ["Real Listener", "Automatic", "Simulated Listener"]
    prm["trialRunning"] = false
    prm["currentBlock"] = 1
    prm["storedBlocks"] = 0
    prm["blocks"] = (String => Any)[]
    prm["appData"] = (String => Any)[]
    prm["appData"]["plotting_available"] = false
    ## prm['backupDirectoryName'] = os.path.expanduser("~") +'/.local/share/data/pychoacoustics/data_backup/'
    ## if os.path.exists(prm['backupDirectoryName']) == False:
    ##     os.makedirs(prm['backupDirectoryName'])

    ## prm['appData']['alsaaudioAvailable'] = alsaaudioAvailable
    ## if matplotlib_available and pandas_available:
    ##     prm['appData']['plotting_available'] = True
    ## else:
    ##     prm['appData']['plotting_available'] = False

    #@ TO BE DONE
    prm["appData"]["available_play_commands"] = ["aplay", "play", "sndfile-play", "custom"]
    ## if platform.system() == 'Windows':
    ##     prm['appData']['available_play_commands'] = ["winsound"]
    ##     if pyaudioAvailable == True:
    ##         prm['appData']['available_play_commands'].append("pyaudio")
    ##         prm['appData']['pyaudioAvailable'] = True
    ##     else:
    ##         prm['appData']['pyaudioAvailable'] = False
    ##     if os.system("where sndfile-play") == 0:
    ##         prm['appData']['available_play_commands'].append("sndfile-play")

    ##     prm['appData']['available_play_commands'].append(QApplication.translate("","custom",""))
    ## elif platform.system() == 'Linux':
    ##     prm['appData']['available_play_commands'] = []
    ##     if alsaaudioAvailable == True:
    ##         prm['appData']['available_play_commands'].append("alsaaudio")
    ##     if pyaudioAvailable == True:
    ##         prm['appData']['available_play_commands'].append("pyaudio")
    ##         prm['appData']['pyaudioAvailable'] = True
    ##     else:
    ##         prm['appData']['pyaudioAvailable'] = False
    ##     if os.system("which aplay") == 0:
    ##         prm['appData']['available_play_commands'].append("aplay")
    ##     if os.system("which play") == 0:
    ##         prm['appData']['available_play_commands'].append("play")
    ##     if os.system("which sndfile-play") == 0:
    ##         prm['appData']['available_play_commands'].append("sndfile-play")
    ##     if pactypesAvailable == True:
    ##         prm['appData']['available_play_commands'].append("pactypes")
      

    ##     prm['appData']['available_play_commands'].append(QApplication.translate("","custom",""))
    ## else:
    ##     prm['appData']['available_play_commands'] = [QApplication.translate("","custom","")]
    ##     if pyaudioAvailable == True:
    ##         prm['appData']['available_play_commands'].append("pyaudio")
    ##         prm['appData']['pyaudioAvailable'] = True
    ##     else:
    ##         prm['appData']['pyaudioAvailable'] = False
    prm["appData"]["wavmanagers"] = ["WAV"]
    
    ## prm['appData']['available_languages'] = [QApplication.translate("","System Settings",""),
    ##                                   QApplication.translate("","en",""),
    ##                                   QApplication.translate("","it",""),
    ##                                   QApplication.translate("","fr",""),
    ##                                   QApplication.translate("","es",""),
    ##                                   QApplication.translate("","el","")]

    ## prm['appData']['available_countries'] = {}
    ## prm['appData']['available_countries'][QApplication.translate("","System Settings","")] = [QApplication.translate("","System Settings","")]
    ## prm['appData']['available_countries']['en'] = [QApplication.translate("","US",""),
    ##                                                      QApplication.translate("","GB","")]

    ## prm['appData']['available_countries']['it'] = [QApplication.translate("","IT",""),
    ##                                                      QApplication.translate("","CH","")]
    ## prm['appData']['available_countries']['fr'] = [QApplication.translate("","FR",""),
    ##                                                      QApplication.translate("","CA","")]

    ## prm['appData']['available_countries']['es'] = [QApplication.translate("","ES",""),
    ##                                                      QApplication.translate("","BO",""),
    ##                                                      QApplication.translate("","CL","")]

    ## prm['appData']['available_countries']['el'] = [QApplication.translate("","GR",""),
    ##                                                      QApplication.translate("","CY","")]

   

    ## prm["appData"]["fortunesList"] = []

    ## prm["appData"]["fortunesList"].append({"quote": """How often do you hear a single sound by itself? Only when doing psychoacoustic experiments in a soundproof booth!""", "author": "Christopher Darwin", "source": "Pitch and auditory grouping. In: Plack CJ, Oxenham AJ (eds) Pitch: neural coding and perception.Springer, New York"})

    ## prm["appData"]["fortunesList"].append({'quote': """A major contributor to the increased activity in masking, as well as the increased chaos, is informational masking.""", 'author': 'Nat Durlach', 'source': 'J Acoust Soc Am. 2006 Oct;120(4):1787-90.'})
     
    ## prm["appData"]["fortunesList"].append({'quote': """Breaking News 4 July 2011 \n    KEMAR GETS CLEAN SHIRT \n 
    ## Readers of Signals, Sound, and Sensation will know that the Michigan State KEMAR wears a cotton polo shirt with green and white stripes. It was  announced today that after 15 years of continuous use, KEMAR's shirt has been washed. Professor W.M. Hartmann, head of psychoacoustics and chief of laundry, explained, The MSU KEMAR lives in a clean environment where a dedicated HVAC system serves the anechoic room and reverberation room. However, over the years, KEMAR has been in intimate contact with a large number of graduate students, and it was thought that a good wash was timely.""", 'author': "William Hartmann", 'source': "Auditory list posting"})

    ## prm["appData"]["fortunesList"].append({'quote': """Imagine you hear a shout: 'Fire!' If you are part of a firing squad, you might pull a trigger; and if you are on the receiving end of the firing squad, you might merely brace yourself for the inevitable. If you are in your hotel room watching TV, you might decide to put on your slippers and see what the commotion is about; if you are, however, reading the latest issue of Hearing Research, it will be very hard to distract your attention by any outcry.""", 'author': 'Tomás Hromádka and Anthony M Zador', 'source': 'Toward the mechanisms of auditory attention. Hearing Research 229, 180-185 (2007)'})

   

    ## prm["appData"]["fortunesList"].append({"quote": """Unfortunately, contrary to the once predominant view among auditory scientists, the central auditory system is a lot more than just an appendix to the cochlea.""", "author": "Christophe Micheyl", "source": "Cosyne 2006 Workshops"})

  
    ## prm["appData"]["fortunesList"].append({'quote': """It is not at all difficult to accept that some of the defining characteristics of a complex behavioral phenomenon like overshoot could be determined at the cochlea, and some other defining characteristics could be determined beyond the cochlea [...]. After all, an entire nervous system does lie between the cochlea and behavior.""", 'author': 'Walsh, K.P., Pasanen, E.G., and McFadden, D', 'source': 'Hearing Research, 2009, 252, 37-48. '})

    ## prm["appData"]["fortunesList"].append({"quote": """It is possible that the term psychoacoustics was first coined by T.W. Forbes when he described the research he and his team were conducting in the United States during Second World War [...] To the disappointment of warmongers everywhere, the team were unable to produce anything close to an acoustic death beam, although it did develop a sound system for broadcasting propaganda from aircraft.""", "author": "Chris Plack", "source": "The sense of hearing. London: Lawrence Erlbaum Associates"})

    return prm
end



function def_pref(prm)
    prm["pref"] = (String => Any)[]
    prm["pref"]["general"] = (String => Any)[]
    ## #prm["pref"]["phones"] = {}
    ## prm["pref"]["sound"] = {}
    ## prm["pref"]["email"] = {}
    ## prm["pref"]["exp"] = {}
    prm["pref"]["interface"] = (String => Any)[]

    ## prm["pref"]["general"]["triggerONOFF"] = False
    ## prm["pref"]["general"]["ONTrigger"] = 254
    ## prm["pref"]["general"]["OFFTrigger"] = 253
    ## prm["pref"]["general"]["triggerDur"] = 1
    ## prm["pref"]["general"]["defaultISI"] = "500"
    prm["pref"]["general"]["preTrialSilence"] = "200"
    prm["pref"]["general"]["responseLightDuration"] = "500"
    ## prm["pref"]["general"]["maxRecursionDepth"] = sys.getrecursionlimit()
   

    ## prm["pref"]["general"]["endMessageFiles"] = []
    ## prm["pref"]["general"]["endMessageFilesID"] = []
    ## prm["pref"]["general"]["endMessageFilesUse"] = []
    ## prm["pref"]["general"]["endMessageLevels"] = []
    
    prm["pref"]["general"]["defaultShuffle"] = "Ask"
    prm["pref"]["general"]["defaultResponseMode"] = "Real Listener"
    prm["pref"]["general"]["listenerNameWarn"] = true
    prm["pref"]["general"]["sessionLabelWarn"] = true
    prm["pref"]["general"]["playEndMessage"] = false
    prm["pref"]["general"]["processResultsEnd"] = true
    prm["pref"]["interface"]["responseButtonSize"] = 20
    ## prm["pref"]["general"]["resFileFormat"] = "fixed"
    ## prm["pref"]["general"]["resFileFixedString"] = "test.txt"
    ## prm["pref"]["general"]["csvSeparator"] = ";"
    ## prm["pref"]["general"]["fullFileSuffix"] = "_full"
    ## prm["pref"]["general"]["resFileSuffix"] = "_res"
    ## prm["pref"]["general"]["resTableFileSuffix"] = "_table"
    ## prm["pref"]["general"]["automaticFileExtension"] = True
    ## prm["pref"]["general"]["nBlocksCustomCommand"] = ""
    ## prm["pref"]["general"]["atEndCustomCommand"] = ""
    ## prm["pref"]["general"]["dprimeCorrection"] = True

    ## prm["pref"]["general"]["precision"] = 12
    ## # 'variable'
    ## prm["pref"]["email"]["notifyEnd"] = False
    ## prm["pref"]["email"]["nBlocksNotify"] = 1
    ## prm["pref"]["email"]["sendData"] = False
    ## prm["pref"]["email"]["SMTPServer"] = "localhost"
    ## prm["pref"]["email"]["SMTPServerPort"] = 25
    ## prm["pref"]["email"]["SMTPServerSecurity"] = "TLS/SSL (a)"
    ## prm["pref"]["email"]["serverRequiresAuthentication"] = True
    ## prm["pref"]["email"]["fromUsername"] = ""
    ## if sys.version_info[0] == 2: #with python2.x there are problems here
    ##     passwd = ""
    ##     encoded_passwd = ""
    ## elif sys.version_info[0] == 3:
    ##     passwd = bytes('default','utf-8')
    ##     encoded_passwd = base64.b64encode(passwd)
    ##     encoded_passwd = str(encoded_passwd, "utf-8")
    ## prm["pref"]["email"]['fromPassword'] = encoded_passwd
   

    ## prm["pref"]["language"] = QApplication.translate("","en","")
    ## prm["pref"]["country"] = QApplication.translate("","US","")
    prm["pref"]["responseBoxLanguage"] = "en"
    prm["pref"]["responseBoxCountry"] = "US"

    ## #Sound preferences
    prm["pref"]["sound"] = (String => Any)[]
    prm["pref"]["sound"]["defaultNBits"] = "32"
    prm["pref"]["sound"]["defaultSampleRate"] = "48000"
    prm["pref"]["sound"]["writewav"] = true
    prm["pref"]["sound"]["writeSndSeqSegments"] = false
    ## prm["pref"]["sound"]["wavmanager"] = "scipy"
    ## prm["pref"]["sound"]["bufferSize"] = 1024
    prm["pref"]["sound"]["appendSilence"] = 0

    ## if platform.system() == "Windows":
    ##     prm["pref"]["sound"]["playCommand"] = "winsound"
    ##     prm["pref"]["sound"]["playCommandType"] = "winsound"
    ## else:
    ##     prm["pref"]["sound"]["playCommand"] = "aplay"
    ##     prm["pref"]["sound"]["playCommandType"] = QApplication.translate("","custom","")
    ## if alsaaudioAvailable == True:
    ##     prm["pref"]["sound"]["alsaaudioDevice"] = "default"
    ## if pyaudioAvailable == True:
    ##     prm["pref"]["sound"]["pyaudioDevice"] = 0
    ## #if pactypesAvailable == True:
    ## prm["pref"]["sound"]["pactypesDevice"] = 1

    #PHONES
    prm["phones"] = (String => Any)[]
    prm["phones"]["phonesChoices"] = ["Phones 1", "Phones 2"]
    prm["phones"]["phonesMaxLevel"] = [100, 100]
    prm["phones"]["phonesID"] = ["0", "1"]
    prm["phones"]["defaultPhones"] = ["\u2713", "\u2012"]

    ## #EXPERIMENTERS
    prm["experimenter"] = (String => Any)[]
    prm["experimenter"]["defaultExperimenter"] = ["\u2713", "\u2012"]
    prm["experimenter"]["experimenter_id"] = ["Experimenter 1", "Experimenter 2"]
    prm["experimenter"]["experimenter_name"] = ["", ""]
    prm["experimenter"]["experimenter_surname"] = ["", ""]
    prm["experimenter"]["experimenter_email"] = ["", ""]
    prm["experimenter"]["experimenter_address"] = ["", ""]
    prm["experimenter"]["experimenter_address2"] = ["", ""]
    prm["experimenter"]["experimenter_telephone"] = ["", ""]
    prm["experimenter"]["experimenter_mobile"] = ["", ""]

    prm["warningInterval"] = false
    prm["preTrialInterval"] = false
    prm["precursorInterval"] = false
    prm["postcursorInterval"] = false
    prm["intervalLights"] = "Yes"

    return prm

end

function get_prefs(prm)
    prm = def_pref(prm)
##     prm["prefFile"] = os.path.expanduser("~") +"/.config/pychoacoustics/preferences.py"
##     prm["phonesPrefFile"] = os.path.expanduser("~") +"/.config/pychoacoustics/phones.py"
##     prm["experimenterPrefFile"] = os.path.expanduser("~") +"/.config/pychoacoustics/experimenter.py"
##     if os.path.exists(os.path.expanduser("~") +"/.config/") == False:
##         os.mkdir(os.path.expanduser("~") +"/.config/")
##     if os.path.exists(os.path.expanduser("~") +"/.config/pychoacoustics/") == False:
##         os.mkdir(os.path.expanduser("~") +"/.config/pychoacoustics/")

##     local_dir = os.path.expanduser("~") +"/.local/share/data/pychoacoustics/"
##     if os.path.exists(local_dir) == False:
##         os.makedirs(local_dir)
##     stdoutFile = os.path.expanduser("~") +"/.local/share/data/pychoacoustics/pychoacoustics_stdout_log.txt"
##     sys.stdout = redirectStreamToFile(stdoutFile)
##     #sys.stderr = redirectStreamToFile(stdoutFile)
##     # if there is a preferences file stored load it
##     cmdOutFileName = os.path.expanduser("~") +"/.local/share/data/pychoacoustics/pychoacoustics_cmdout_log.txt"
##     prm["cmdOutFileHandle"] = open(cmdOutFileName, "a")
##     if os.path.exists(prm["prefFile"]):
##         fIn = open(prm["prefFile"], "rb")
##         prm["tmp"] = pickle.load(fIn)
##         fIn.close()
##         for k in prm["pref"].keys():
##             if k in prm["tmp"]:
##                 if type(prm["pref"][k]).__name__=="dict":
##                     for j in prm["pref"][k].keys():
##                         if j in prm["tmp"][k]:
##                             prm["pref"][k][j] = prm["tmp"][k][j]
##                 else:
##                      prm["pref"][k] = prm["tmp"][k]

##     # if there are phones settings stored, load them
##     if os.path.exists(prm["phonesPrefFile"]):
##         fIn = open(prm["phonesPrefFile"], "rb")
##         prm["tmp"] = pickle.load(fIn)
##         fIn.close()
##         for k in prm["phones"].keys():
##             if k in prm["tmp"]:
##                 prm["phones"][k] = prm["tmp"][k]

##     # if there are experimenter settings stored, load them
##     if os.path.exists(prm["experimenterPrefFile"]):
##         fIn = open(prm["experimenterPrefFile"], "rb")
##         prm["tmp"] = pickle.load(fIn)
##         fIn.close()
##         for k in prm["experimenter"].keys():
##             if k in prm["tmp"]:
##                 prm["experimenter"][k] = prm["tmp"][k]
    return prm

end
