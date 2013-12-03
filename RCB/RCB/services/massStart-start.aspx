<%

' Get competition ID 
Dim cid As Integer = Request.Params("cid")

' Get results table
Dim sSql As String = "Select * From tblResults where cid = " & cid & " ORDER BY starttime, bibnumber ASC "
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

' Build table header  
' 2 as minimum because the way gto reset is to insert one row of empty stuff          
If sqlDtSetComp.Tables("Comp").Rows.Count >= 2 Then
    s += "<h1>" & sqlDtSetComp.Tables("Comp").Rows(0)("title-fr") & " | " &  sqlDtSetComp.Tables("Comp").Rows(0)("title-en") & "</h1>"
    s += "<h3>Liste de d&eacute;part | Start list</h3>"
    s += "<table width='545' border='1'>"
    s += "<tr class='columns'><td>Competitors<br/>Comp&eacute;titeurs</td><td>Bib #<br />Dossard</td><td>&Eacute;quipe<br />Team</td><td>Cat&eacute;gorie<br />Class</td><td>Temps de d&eacute;part<br />Start time</td></tr>"

    For Each item As ArrayList In newAL
      's +="<tr class='shootclass'><td colspan=5 align=center>" & item(0)(6) & "</td></tr>"
       s +="<tr class='shootclass'><td colspan=5 align=center></td></tr>"
       Dim n As Integer
       Dim rowType As String
       For n = 0 To item.count() -1
           if n Mod 2 then 
               rowType = "row-even" 
           else 
               rowType = "row-odd" 
           End if
       s += "<tr class='" & rowType & "'>"
         '   s += "<td>" & i+1 & "</td>"
            s += "<td>" & item(n)(2) & " <br />" & item(n)(3) & "</td>"
            s += "<td class='club'>" & item(n)(4) & "</td>"
            s += "<td class='club'>" & item(n)(7) & "</td>"
            s += "<td class='club'>" & fnParseClass( item(n)(6) ) & "</td>"
            s += "<td class='club'>" & item(n)(21) & "</td>"
            s+= "</tr>"
      Next

    Next

    s += "</table></div>"
Else 
    s = "<h2>Aucune liste pour le moment</h2><h2>No list for the moment</h2></div>"
End If

%>

