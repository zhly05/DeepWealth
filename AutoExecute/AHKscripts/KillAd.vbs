Set objWord = CreateObject("Word.Application")
Set colTasks = objWord.Tasks
strTitle = "ͬ��˳��Ѷ��ѡ"
Do
    If colTasks.Exists(strTitle) Then
	colTasks(strTitle).Close
    End If
    WScript.Sleep 1000
Loop