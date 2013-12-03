<%

' Get competition ID 
Dim cid As Integer = Request.Params("cid")
   
' Get results table
'Dim sSql As String = "Select * From tblResults where cid = " & cid & " ORDER BY class, CASE WHEN lap4 = '0:00:00.0' THEN 1 ELSE 0 END,CASE WHEN lap3 = '0:00:00.0' THEN 1 ELSE 0 END,CASE WHEN lap2 = '0:00:00.0' THEN 1 ELSE 0 END,CASE WHEN lap1 = '0:00:00.0' THEN 1 ELSE 0 END, finaltime ASC"

Dim sSql As String = "Select * From tblResults where cid = " & cid & " ORDER BY class, CASE WHEN lap1 = '0:00:00.0' THEN 1 ELSE 0 END, CASE WHEN lap2 = '0:00:00.0' THEN 1 ELSE 0 END, CASE WHEN lap3 = '0:00:00.0' THEN 1 ELSE 0 END, CASE WHEN lap4 = '0:00:00.0' THEN 1 ELSE 0 END, CASE WHEN finaltime = '0:00:00.0' THEN 1 ELSE 0 END, lap1, lap2, lap3, lap4, finaltime"

Dim sqlDtSet As System.Data.DataSet = fnGetDataSetInDB(sSql, "Results")

' Output variable  
s = "<div class='biabres'>"

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
    if m = 0 OR List(m)(6) <> sOldClass Then
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

' Order Youth, Senior, Junior, dumb way
Dim showAl as new ArrayList
For Each item As ArrayList In newAL
    If item(0)(6).Contains( "Cadet Male Youth" ) Then
        showAL.add( item )
    End If      
Next
For Each item As ArrayList In newAL
    If item(0)(6).Contains( "Cadet Female Youth" ) Then
        showAL.add( item )
    End If      
Next
For Each item As ArrayList In newAL
    If item(0)(6).Contains( "Cadet Male Sr" ) Then
        showAL.add( item )
    End If      
Next
For Each item As ArrayList In newAL
    If item(0)(6).Contains( "Cadet Female Sr" ) Then
        showAL.add( item )
    End If      
Next
For Each item As ArrayList In newAL
    If item(0)(6).Contains( "Cadet Male Jr" ) Then
        showAL.add( item )
    End If      
Next
For Each item As ArrayList In newAL
    If item(0)(6).Contains( "Cadet Female Jr" ) Then
        showAL.add( item )
    End If      
Next

' Build table header            
If sqlDtSetComp.Tables("Comp").Rows.Count >= 1 Then
    s += "<h1>" & sqlDtSetComp.Tables("Comp").Rows(0)("title-fr") & " | " &  sqlDtSetComp.Tables("Comp").Rows(0)("title-en") & "</h1>"
    s += "<h3>R&eacute;sultats int&eacute;rimaires | Interim results</h3>"
    s += "<table width='545' border='1'>"
    s += "<tr class='columns'><td>Competitors<br/>Comp&eacute;titeurs</td><td>&Eacute;quipe<br />Team</td><td>S1<br />T1</td><td>S2<br />T2</td><td>S3<br />T3</td><td>S4<br />T4</td><td>Lap 1<br />Passage 1</td><td>Lap 2<br />Passage 2</td><td>Lap 3<br />Passage 3</td><td>Lap 4<br />Passage 4</td><td>Final time<br />Temps final</td><td>Rank<br />Position</td></tr>"

    For Each item As ArrayList In showAL
        s +="<tr class='shootclass'><td colspan=18 align=center>" & fnParseClass( item(0)(6) ) & "</td></tr>"
       
       Dim n As Integer
       Dim rowType As String
       For n = 0 To item.count() -1
           
           ' Put bgcolor to row
           if n Mod 2 then 
               rowType = "row-even" 
           else 
               rowType = "row-odd" 
           End if

           s += "<tr class='rank" & (n+1) & " " & rowType & "'>"
         '   s += "<td>" & i+1 & "</td>"
            s += "<td>("& item(n)(4) &") " & item(n)(2) & "<br />" & item(n)(3) & "</td>"
           ' s += "<td>" & sqlDtSet.Tables("Results").Rows(i)("firstname") & "</td>"
         '   s += "<td>" & sqlDtSet.Tables("Results").Rows(i)("class") & "</td>"
            s += "<td class='club'>" & item(n)(7) & "</td>"
            s += "<td class='misses'>" & fnParseShoot( item(n)(8) ) & "</td>"
            s += "<td class='misses'>" & fnParseShoot( item(n)(9) ) & "</td>"
            s += "<td class='misses'>" & fnParseShoot( item(n)(10) ) & "</td>"
            s += "<td class='misses'>" & fnParseShoot( item(n)(11) ) & "</td>"
            s += "<td class='time'>" & fnParseLap( item(n)(12) ) & "</td>"
            s += "<td class='time'>" & fnParseLap( item(n)(13) ) & "</td>"
            s += "<td class='time'>" & fnParseLap( item(n)(14) ) & "</td>"
            s += "<td class='time'>" & fnParseLap( item(n)(15) ) & "</td>"
         '   s += "<td>" & sqlDtSet.Tables("Results").Rows(i)("runtime") & "</td>"
            s += "<td class='time'>" & item(n)(18) & "</td>"
            s += "<td class='rank'>" & n+1 & "</td>"
            s+= "</tr>"
      Next

    Next

    s += "</table></div>"

Else 
    s = "<h2>Aucun r&eacutesultats pour le moment</h2><h2>No result for the moment</h2><div>"
End If

%>

