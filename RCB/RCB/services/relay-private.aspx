<%

' Get competition ID 
Dim cid As Integer = Request.Params("cid")

' Get results table
' Dim sSql As String = "Select * From tblResults where cid = " & cid & " ORDER BY bibnumber, class ASC"
'Dim sSql As String = "Select * From tblResults where cid = " & cid & " GROUP BY bibnumber, cid, id, lastname, firstname, bibcolor, class, club, ms1, ms2, ms3, ms4, lap1, lap2, lap3, lap4, penalty, runtime, finaltime, rank, status, starttime ORDER BY class, finaltime DESC, CASE WHEN lap4 = '0:00:00.0' THEN 1 ELSE 0 END,CASE WHEN lap3 = '0:00:00.0' THEN 1 ELSE 0 END,CASE WHEN lap2 = '0:00:00.0' THEN 1 ELSE 0 END,CASE WHEN lap1 = '0:00:00.0' THEN 1 ELSE 0 END, bibnumber ASC "

Dim sSql As String = "Select * From tblResults where cid = " & cid & " GROUP BY bibnumber, cid, id, lastname, firstname, bibcolor, class, club, ms1, ms2, ms3, ms4, penalty, runtime, finaltime, rank, status, lap1, lap2, lap3, lap4, starttime ORDER BY class, CASE bibcolor WHEN 'r' THEN 1 WHEN 'g' THEN 2 WHEN 'y' THEN 3 ELSE 999 END, CASE lap1 WHEN '0:00:00.0' THEN 0 ELSE 1 END ASC, CASE lap2 WHEN '-' THEN 0 ELSE 1 END ASC, CASE lap3 WHEN '-' THEN 0 ELSE 1 END ASC, CASE lap4 WHEN '-' THEN 0 ELSE 1 END ASC, CASE finaltime WHEN '0:00:00.0' THEN 0 ELSE 1 END ASC, lap1 DESC, lap2 DESC, lap3 DESC, lap4 DESC, finaltime DESC "
Dim sqlDtSet As System.Data.DataSet = fnGetDataSetInDB(sSql, "Results")

' Event info
Dim sSqlEvent As String
sSqlEvent = "Select * From tblEvents where id = " & sqlDtSetComp.Tables("Comp").Rows(0)("eid")
Dim sqlDtSetEvent As System.Data.DataSet = fnGetDataSetInDB(sSqlEvent, "Event")

' Convert to array first 
Dim List( sqlDtSet.Tables("Results").Rows.Count -1 ) As Array      
If sqlDtSet.Tables("Results").Rows.Count >= 1 Then
    Dim i, j As Integer
    For i = 0 To sqlDtSet.Tables("Results").Rows.Count -1
        Dim player( sqlDtSet.Tables("Results").Rows(i).ItemArray.Length -1 ) As String
        For j = 0 To sqlDtSet.Tables("Results").Rows(i).ItemArray.Length -1
            player(j) = sqlDtSet.Tables("Results").Rows(i).Item(j)
        Next
        List(i) = player
    Next
End If

' Order by classes
Dim sOldClass As String 
Dim newAL As New ArrayList()
Dim myAL As New ArrayList()
Dim temp As Integer
Dim m As Integer
For m = 0 To List.length -1
    temp = 0   
    if m = 0 OR StrComp( List(m)(6),sOldClass) <> 0 Then
        sOldClass = List(m)(6)
        if m <> 0 then
            newAL.add( myAL.clone() )
        End if
        if m  > 0 then 
            myAL.clear()
        End if
        temp = 1
    End If  
    myAL.Add( List(m) )
Next
newAL.add( myAL.clone() )

' Build table header            
If sqlDtSetComp.Tables("Comp").Rows.Count >= 1 Then
    s += "<div class='body'><div id='headerRight'></div><h1>" & sqlDtSetComp.Tables("Comp").Rows(0)("title-fr") & " | " &  sqlDtSetComp.Tables("Comp").Rows(0)("title-en") & "</h1>"
    s += "<h3>R&eacute;sultats int&eacute;rimaires | Interim results</h3>"
    s += "<table border='1'>"
    s += "<tr class='columns'><td>Competitors<br/>Comp&eacute;titeurs</td><td>Bib #<br />Dossard</td><td>&Eacute;quipe<br />Team</td><td>S1<br />T1</td><td>S2<br />T2</td><td>Lap 1<br />Passage 1</td><td>Lap 2<br />Passage 2</td><td>Lap 3<br />Passage 3</td><td>Final time<br />Temps final</td></tr>"
Else 
    s = "<h2>Aucun r&eacutesultat pour le moment</h2><h2>No result for the moment</h2>"
End If

Dim s2 As String
For Each item As ArrayList In newAL
   s +="<tr class='teamclass'><td colspan=18 align=center>" & item(0)(6) & "</td></tr>"
   
   Dim n, p, q, origP As Integer
   Dim sOldTeam as String = ""
   Dim sTemp, sTempBib, s3 as String
   sTemp = ""
   sTempBib = ""
   p = 0

   ' number of teams per classes
   For n = 0 To item.count() -1
       sTempBib = "x" & item(n)(4) & "x"
       if n = 0 OR sTemp.Contains( sTempBib ) = False then
          p += 1
       End If
       sTemp += "x" & item(n)(4) & "x" 
   Next

   sTemp = ""
   sTempBib = ""
   origP = p   
   For n = 0 To item.count() -1
       sTempBib = "x" & item(n)(4) & "x"
       if n = 0 OR sTemp.Contains( sTempBib ) = False then
          s3 ="<tr class='unitclass'><td colspan=8 align=center> Team / &Eacute;quipe " & item(n)(7) & "</td><td class='rank" & p & "'>" & p & "</td></tr>"
          p -= 1
          s3 += fnGetRelayTeam( item, item(n)(4) )
          s2 = s3 + s2
       End If
       sTemp += "x" & item(n)(4) & "x" 

  Next
  s += s2
  s2 = ""
Next

s += "</table></div>"

%>
