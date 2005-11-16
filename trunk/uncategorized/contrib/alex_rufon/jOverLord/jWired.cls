VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "jWired"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Attribute VB_Ext_KEY = "SavedWithClassBuilder6" ,"Yes"
Attribute VB_Ext_KEY = "Top_Level" ,"Yes"
Option Explicit

Public Function createString(ByVal sizeOfString As Double) As String
Attribute createString.VB_UserMemId = 0
Dim strTemp As String
'Dim nI As Double
'Dim nCtr As Integer
'
'    strTemp = vbNullString
'    nCtr = 65
'    For nI = 0 To sizeOfString
'        If nCtr > 122 Then nCtr = 65
'        strTemp = strTemp & Chr(nCtr)
'        nCtr = nCtr + 1
'    Next nI
strTemp = String(sizeOfString, "@")
createString = strTemp
End Function

