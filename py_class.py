
from PySide import QtGui, QtCore
from PySide.QtCore import Qt, QEvent, QThread, QDate, QTime, QDateTime
from PySide.QtGui import QAction, QApplication, QComboBox, QFileDialog, QFrame, QGridLayout, QInputDialog, QLabel, QLineEdit, QMainWindow, QMessageBox, QPainter, QProgressBar, QPushButton, QScrollArea, QShortcut, QSizePolicy, QSpacerItem, QVBoxLayout, QWidget, QWidgetItem
import time
 
class responseLight(QWidget):
    def __init__(self, parent):
        super(responseLight, self).__init__(parent)
        self.setSizePolicy(QSizePolicy(QSizePolicy.Expanding,
                                       QSizePolicy.Expanding))
        self.borderColor = Qt.black
        self.lightColor = Qt.black
    def giveFeedback(self, feedback, duration):
        self.setStatus(feedback)
        self.parent().repaint()
        QApplication.processEvents()
        #currBlock = 'b'+ str(self.parent().parent().prm['currentBlock'])
        time.sleep(duration)#self.parent().parent().prm[currBlock]['responseLightDuration']/1000.)
        self.setStatus('off')
        self.parent().repaint()
        QApplication.processEvents()
    def setStatus(self, status):
        if status == 'correct':
            self.lightColor = Qt.green
        elif status == 'incorrect':
            self.lightColor = Qt.red
        elif status == 'neutral':
            self.lightColor = Qt.white
        elif status == 'off':
            self.lightColor = Qt.black
    def paintEvent(self, event=None):
        painter = QPainter(self)
        painter.setViewport(0,0,self.width(),self.height())
        painter.setPen(self.borderColor)
        painter.setBrush(self.lightColor)
        painter.drawRect(self.width()/60, self.height()/60, self.width()-self.width()/30, self.height())


class intervalLight(QFrame):

    def __init__(self, parent):
        QFrame.__init__(self, parent)
        self.setSizePolicy(QSizePolicy(QSizePolicy.Expanding, QSizePolicy.Expanding))
        self.borderColor = Qt.red
        self.lightColor = Qt.black
    def setStatus(self, status):
        if status == 'on':
            self.lightColor = Qt.white
        elif status == 'off':
            self.lightColor = Qt.black
        self.parent().repaint()
        QApplication.processEvents()
    def paintEvent(self, event=None):
        painter = QPainter(self)
        painter.setViewport(0, 0, self.width(),self.height())
        painter.setPen(self.borderColor)
        painter.setBrush(self.lightColor)
        painter.fillRect(self.width()/60, self.height()/60, self.width()-self.width()/30, self.height(), self.lightColor)


class threadedPlayer(QThread):
    def __init__(self, parent):
        QThread.__init__(self, parent)
    def playThreadedSound(self, sound, sampRate, bits, cmd, writewav, fName):
        self.sound = sound
        self.sampRate = sampRate
        self.bits = bits
        self.cmd = cmd
        self.writewav = writewav
        self.fName = fName
        self.start()
        self.audioManager = self.parent().audioManager
    def run(self):
        self.audioManager.playSound(self.sound, self.sampRate, self.bits, self.cmd, self.writewav, self.fName)


class commandExecuter(QThread):
    def __init__(self, parent):
        QThread.__init__(self, parent)
    def executeCommand(self, cmd):
        self.cmd = cmd
        self.start()
    def run(self):
        for i in range(len(self.cmd)):
            os.system(self.cmd[i])


# class emailSender(QThread):
#     def __init__(self, parent):
#         QThread.__init__(self, parent)
#     def sendEmail(self, subject='', body='', attachments=[]):
#         self.subject = subject
#         self.body = body
#         self.attachments = attachments
#         self.start()
#     def run(self):
#         experimenterIdx = self.parent().prm['experimenter']['experimenter_id'].index(self.parent().prm['allBlocks']['currentExperimenter'])
#         decoded_passwd = bytes(self.parent().prm['pref']['email']['fromPassword'], "utf-8")
#         decoded_passwd = base64.b64decode(decoded_passwd)
#         decoded_passwd = str(decoded_passwd, "utf-8")
#         msg = MIMEMultipart()
#         msg["From"] = self.parent().prm['pref']['email']['fromUsername']
#         msg["To"] =  self.parent().prm['experimenter']['experimenter_email'][experimenterIdx]
#         msg["Subject"] = self.subject
#         part1 = MIMEText(self.body, 'plain')
#         msg.attach(part1)

#         for item in self.attachments:
#             part = MIMEBase('application', "octet-stream")
#             filePath = item
#             part.set_payload(open(filePath, "rb").read())
#             encoders.encode_base64(part)
#             part.add_header('Content-Disposition', 'attachment; filename="%s"' % os.path.basename(filePath))
#             msg.attach(part)
        
#         if checkEmailValid(msg["To"]) == False:
#             errMsg = self.parent().tr("Experimenter {} e-mail's address {} not valid \n Please specify a valid address for the current experimenter \n in the Edit -> Experimenters dialog".format(self.parent().parent().prm['experimenter']['experimenter_id'][experimenterIdx], msg["To"]))
#             print(errMsg, file=sys.stderr)
#             return
#         elif checkUsernameValid(msg["From"]) == False:
#             errMsg = self.parent().tr("username invalid")
#             print(errMsg, file=sys.stderr)
#             return
#         elif checkServerValid(self.parent().prm["pref"]["email"]['SMTPServer']) == False:
#             errMsg = self.parent().tr("SMTP server name invalid")
#             print(errMsg, file=sys.stderr)
#             return

       
#         if self.parent().prm["pref"]["email"]["serverRequiresAuthentication"] == True:
#             if  self.parent().prm["pref"]["email"]['SMTPServerSecurity'] == "TLS/SSL (a)":
#                 try:
#                     server = smtplib.SMTP_SSL(self.parent().prm["pref"]["email"]['SMTPServer'], self.parent().prm["pref"]["email"]['SMTPServerPort'])
#                 except Exception as ex:
#                     errMsg = self.parent().tr("Something went wrong, try to change server settings \n {}".format(ex))
#                     print(errMsg, file=sys.stderr)
#                     return 
#             elif self.parent().prm["pref"]["email"]['SMTPServerSecurity'] == "TLS/SSL (b)":
#                 try:
#                     server = smtplib.SMTP(self.parent().prm["pref"]["email"]['SMTPServer'], self.parent().prm["pref"]["email"]['SMTPServerPort'])
#                     server.ehlo()
#                     server.starttls()
#                 except Exception as ex:
#                     errMsg = self.parent().tr("Something went wrong, try to change server settings \n {}".format(ex))
#                     print(errMsg, file=sys.stderr)
#                     return 
#             elif self.parent().prm["pref"]["email"]['SMTPServerSecurity'] == "none":
#                 try:
#                     server = smtplib.SMTP(self.parent().prm["pref"]["email"]['SMTPServer'], self.parent().prm["pref"]["email"]['SMTPServerPort'])
#                 except Exception as ex:
#                     errMsg = self.parent().tr("Something went wrong, try to change server settings \n {}".format(ex))
#                     print(errMsg, file=sys.stderr)
#                     return 
#             # now attempt login    
#             try:
#                 server.login(self.parent().prm['pref']['email']['fromUsername'],  decoded_passwd)
#             except Exception as ex:
#                 errMsg = self.parent().tr("Something went wrong, try to change server settings \n {}".format(ex))
#                 print(errMsg, file=sys.stderr)
#                 return 
#         else:
#             try:
#                 server = smtplib.SMTP(self.parent().prm["pref"]["email"]['SMTPServer'], self.parent().prm["pref"]["email"]['SMTPServerPort'])
#             except Exception as ex:
#                 errMsg = self.parent().tr("Something went wrong, try to change server settings \n {}".format(ex))
#                 print(errMsg, file=sys.stderr)
#                 return 
#         try:
#             server.sendmail(msg["From"], msg["To"], msg.as_string())
#             print('e-mail sent successfully', file=sys.stdout)
#         except Exception as ex:
#             errMsg = self.parent().tr("Something went wrong, try to change server settings \n {}".format(ex))
#             print(errMsg, file=sys.stderr)
#             return 

