<%

' Get competition ID 
Dim cid As Integer = Request.Params("cid")
   
Dim sSql As String = "Select * From tblResults where cid = " & cid & " ORDER BY class, finaltime ASC"

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
    s += "<h3>R&eacute;sultats finaux | Final results</h3>"
    s += "<table width='545' border='1'>"
    s += "<tr class='columns'><td>Rank<br />Position</td><td>Bib<br />Dos</td><td>Competitors<br/>Comp&eacute;titeurs</td><td>&Eacute;quipe<br />Team</td><td>S1<br />T1</td><td>S2<br />T2</td><td>S3<br />T3</td><td>S4<br />T4</td><td>T</td><td>Result<br />R&eacute;sultat</td><td>Behind<br />&Eacute;cart</td><td>%</td><td>Pts</td><td>Remarks<br />Notes</td></tr>"

    For Each item As ArrayList In showAL
        s +="<tr class='shootclass'><td colspan=14 align=center>" & fnParseClass( item(0)(6) ) & "</td></tr>"
       
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
           s += "<td class='club'>" & n+1 & "</td>"
           s += "<td class='club'>" & item(n)(4) & "</td>"
           s += "<td>" & item(n)(2) & "<br />" & item(n)(3) & "</td>"
           s += "<td class='club'>" & item(n)(7) & "</td>"
           s += "<td class='misses'>" & fnParseShoot( item(n)(8) ) & "</td>"
           s += "<td class='misses'>" & fnParseShoot( item(n)(9) ) & "</td>"
           s += "<td class='misses'>" & fnParseShoot( item(n)(10) ) & "</td>"
           s += "<td class='misses'>" & fnParseShoot( item(n)(11) ) & "</td>"
           s += "<td class='misses'>" & item(n)(17) & "</td>"
           s += "<td class='time'>" & item(n)(18) & "</td>"
           s += "<td class='time'>" & item(n)(16) & "</td>"
           s += "<td class='time'>" & item(n)(19) & "</td>"
           s += "<td class='time'></td>"
           s += "<td class='time'></td>"
           s+= "</tr>"
      Next

    Next

    s += "</table></div>"

Else 
    s = "<h2>Aucun r&eacutesultat pour le moment</h2><h2>No result for the moment</h2><div>"
End If

%>

