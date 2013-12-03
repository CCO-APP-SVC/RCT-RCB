<%

' Get competition ID 
Dim cid As Integer = Request.Params("cid")

' Output variable  
s = "<div class='biabres'>"

' Get results table
' Dim sSql As String = "Select * From tblResults where cid = " & cid & " ORDER BY bibnumber, class ASC"
' Dim sSql As String = "Select * From tblResults where cid = " & cid & " GROUP BY bibnumber, cid, id, lastname, firstname, bibcolor, class, club, ms1, ms2, ms3, ms4, lap1, lap2, lap3, lap4, penalty, runtime, finaltime, rank, status, starttime ORDER BY starttime ASC "

Dim sSql As String = "Select * From tblResults where cid = " & cid & " GROUP BY bibnumber, cid, id, lastname, firstname, bibcolor, class, club, ms1, ms2, ms3, ms4, lap1, lap2, lap3, lap4, penalty, runtime, finaltime, rank, status, starttime ORDER BY class, starttime DESC "
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
    s += "<div width='545px'><h1>" & sqlDtSetComp.Tables("Comp").Rows(0)("title-fr") & " | " &  sqlDtSetComp.Tables("Comp").Rows(0)("title-en") & "</h1>"
    s += "<h3>Liste de d&eacute;part | Start list</h3>"
    s += "<table border='1'>"
    s += "<tr class='columns'><td>Competitors<br/>Comp&eacute;titeurs</td><td>Bib #<br />Dossard</td><td>Unit&eacute;<br />Unit</td><td>Cat&eacute;gorie<br />Class</td><td>Temps de d&eacute;part<br />Start time</td></tr>"
Else 
    s = "<h2>Aucun r&eacutesultats pour le moment</h2><h2>No result for the moment</h2>"
End If

Dim s2 As String
For Each item As ArrayList In newAL
   s +="<tr class='teamclass'><td colspan=18 align=center>" & item(0)(6) & "</td></tr>"
   
   Dim n, p, q As Integer
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
   For n = 0 To item.count() -1
       sTempBib = "x" & item(n)(4) & "x"
       if n = 0 OR sTemp.Contains( sTempBib ) = False then
          s3 ="<tr class='unitclass'><td colspan=11 align=center> Team / &Eacute;quipe " & item(n)(7) & "</td></tr>"
          p -= 1
          s3 +=  fnGetRelayTeamStart( item, item(n)(4) )
          s2 = s3 + s2
       End If
       sTemp += "x" & item(n)(4) & "x" 
  Next
  s += s2
  s2 = ""
Next

s += "</table></div>"
%>

