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

py_class = pyimport("py_class")
include("response_box_functions.jl")

rbw = Qt.QMainWindow(w)
rbw[:setWindowFlags](qt_enum(["Window", "CustomizeWindowHint", "WindowMinimizeButtonHint", "WindowMaximizeButtonHint"], how="|"))
rbw[:setWindowModality](PySide.QtNamespace[:NonModal])



                     
rbw[:setWindowTitle]("Response Box")
spx = prm["pref"]["interface"]["responseButtonSize"]
rbw[:setStyleSheet]("QPushButton[responseBoxButton='true'] {font-weight:bold; font-size: $spx;} ")
##         self.menubar = self.menuBar()
rbwMenubar = rbw[:menuBar]()
##         #FILE MENU
fileMenu = rbwMenubar[:addMenu]("-")
       
toggleControlWin = Qt.QAction(w[:tr]("Show/Hide Control Window"), w)
toggleControlWin[:setShortcut]("Ctrl+C")
toggleControlWin[:setCheckable](true)
toggleControlWin[:setStatusTip]("Toggle Control Window")
toggleControlWin[:triggered][:connect](onToggleControlWin)
if prm["hideWins"] == true
    toggleControlWin[:setChecked](false)
else
    toggleControlWin[:setChecked](true)
end
        
toggleGauge = Qt.QAction("Show/Hide Progress Bar", w)
toggleGauge[:setShortcut]("Ctrl+P")
toggleGauge[:setCheckable](true)
toggleGauge[:triggered][:connect](onToggleGauge)

toggleBlockGauge = Qt.QAction("Show/Hide Block Progress Bar", w)
toggleBlockGauge[:setShortcut]("Ctrl+B")
toggleBlockGauge[:setCheckable](true)
toggleBlockGauge[:triggered][:connect](onToggleBlockGauge)

##         #statusBar()
fileMenu[:addAction](toggleControlWin)
fileMenu[:addAction](toggleGauge)
fileMenu[:addAction](toggleBlockGauge)
        
rb = Qt.QFrame()
rb[:setFrameStyle](QtGui["QFrame"]["StyledPanel"])
rb[:setFrameStyle](QtGui["QFrame"]["Sunken"])
rb_sizer = Qt.QVBoxLayout()
intervalSizer = Qt.QGridLayout()
responseButtonSizer = Qt.QGridLayout()
       
statusButton = Qt.QPushButton(prm["rbTrans"][:translate]("rb", "Wait"), rbw)
#statusButton = Qt.QPushButton("Wait", rbw)
statusButton[:clicked][:connect](onClickStatusButton)
statusButton[:setSizePolicy](Qt.QSizePolicy(szp[:Expanding], szp[:Expanding]))
statusButton[:setProperty]("responseBoxButton", true)
statBtnShortcut = Qt.QShortcut("Ctrl+R", rbw, activated = onClickStatusButton)
statusButton[:setToolTip](prm["rbTrans"][:translate]("rb", "Press Ctrl+R to activate"))
        
responseLight = py_class[:responseLight](rbw)

gauge = Qt.QProgressBar()
gauge[:setRange](0, 100)
blockGauge = Qt.QProgressBar()

        
rb_sizer[:addWidget](statusButton)
rb_sizer[:addSpacing](20)
rb_sizer[:addWidget](responseLight)
rb_sizer[:addSpacing](20)
intervalLight = (Any)[]
wdc["responseButton"] = (Any)[]
setupLights()
rb_sizer[:addLayout](intervalSizer)
rb_sizer[:addSpacing](5)
rb_sizer[:addLayout](responseButtonSizer)
rb_sizer[:addSpacing](20)
rb_sizer[:addWidget](gauge)
rb_sizer[:addWidget](blockGauge)

if prm["progbar"] == true
    toggleGauge[:setChecked](true)
    onToggleGauge()
else
    toggleGauge[:setChecked](false)
    onToggleGauge()
end
if prm["blockProgbar"] == true
    toggleBlockGauge[:setChecked](true)
    onToggleBlockGauge()
else
    toggleBlockGauge[:setChecked](false)
    onToggleBlockGauge()
end

rb[:setLayout](rb_sizer)
rbw[:setCentralWidget](rb)
prm["listener"] = listenerTF[:text]()
prm["sessionLabel"] = sessionLabelTF[:text]()
if prm["hideWins"] == true
    w[:hide]()
end
   
rbw[:resize](int((1/4)*screen[:width]()), int((1/3)*screen[:height]()))
raise(rbw) 
          
