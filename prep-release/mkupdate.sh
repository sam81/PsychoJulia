

pyside-rcc -o ../qrc_resources.py ../resources.qrc
pyside-lupdate -verbose pychoacoustics.pro
lrelease -verbose pychoacoustics.pro

mv *.qm ../translations/