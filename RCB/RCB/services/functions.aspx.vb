Partial Class functions
    Inherits System.Web.UI.Page

' ****** General functions ******

    ' SQL Insert function
    Public Function fnGetDataSetInDB(sSql As String, sDtSetName As String) As System.Data.DataSet
        Dim sqlDtSet As System.Data.DataSet = New System.Data.DataSet()
        Dim sqlConn As System.Data.SqlClient.SqlConnection = New System.Data.SqlClient.SqlConnection(ConfigurationManager.AppSettings("sConn"))
        Dim sqlDtAdapter As System.Data.SqlClient.SqlDataAdapter = New System.Data.SqlClient.SqlDataAdapter(sSql, sqlConn)
        sqlDtAdapter.Fill(sqlDtSet, sDtSetName)
        sqlConn.Close()
        Return sqlDtSet
    End Function

    ' SQL Query function
    Public Sub fnExecuteNonQueryInDB(sSql As String)
        Dim sqlConn As System.Data.SqlClient.SqlConnection = New System.Data.SqlClient.SqlConnection(ConfigurationManager.AppSettings("sConn"))
        Dim sqlCommand As System.Data.SqlClient.SqlCommand = New System.Data.SqlClient.SqlCommand(sSql, sqlConn)
        sqlConn.Open()
        sqlCommand.ExecuteNonQuery()
        sqlConn.Close()
    End Sub

    ' Replace single quotes
    ' Used to insert data in SQL or parse CSV file
    Public Function fnReplaceApostrophes(strOriginalText As String) As String
        Return strOriginalText.Replace("'", "''")
    End Function

' ****** Events related functions ******

    ' Delete event, linked competitions and results
    Public Function fnDeleteEvent(intEventId As Integer) As Boolean

        ' Get all competitions for this event
        Dim sSqlComp = "Select id From tblComp where eid=" & intEventId
        Dim sqlDtSet As System.Data.DataSet = fnGetDataSetInDB(sSqlComp, "Comps")
        
        ' Delete all results (csv imports)   
        Dim i As Integer
        For i = 0 To sqlDtSet.Tables("Comps").Rows.Count - 1
            Dim sSqlResults As String = "Delete from tblResults where cid=" & sqlDtSet.Tables("Comps").Rows(i)("id")
            fnExecuteNonQueryInDB(sSqlResults)
        Next

        ' Delete all competitions'
        Dim sSQLComps As String = "Delete From tblComp Where eid=" & intEventId
        fnExecuteNonQueryInDB(sSQLComps)

        ' Delete the event
        Dim sSQL As String = "Delete From tblEvents Where id=" & intEventId
        fnExecuteNonQueryInDB(sSQL)
        Return True
    End Function

    ' Delete event, linked competitions and results
    Public Function fnAddEvent(sNameFr As String, sNameEn As String) As Boolean
        Dim sSQL As String = "Insert Into tblEvents ([name-fr], [name-en]) Values ('" & sNameFr & "','" & sNameEn & "')"
        fnExecuteNonQueryInDB(sSQL)
        Return True
    End Function

    ' Update event informations
    Public Function fnUpdateEvent(eid As Integer, sNameFr As String, sNameEn As String) As Boolean
        Dim sSql As String = "Update tblEvents Set [Name-fr] =  '" & sNameFr & "', [Name-en] = '" & sNameEn & "' Where id = " & eid 
        Dim sqlDtSet As System.Data.DataSet = fnGetDataSetInDB(sSql, "EventId")
        fnExecuteNonQueryInDB(sSQL)
        Return True
    End Function

' ****** Competitions related functions ******

    ' Delete competition
    Public Function fnDeleteComp(intCompId As Integer) As Boolean
        Dim sSQL As String = "Delete From tblComp Where id=" & intCompId
        fnExecuteNonQueryInDB(sSQL)
        Dim sSQLResults As String = "Delete From tblResults Where cid=" & intCompId
        fnExecuteNonQueryInDB(sSQLResults)
        Return True
    End Function

    ' Add a new competition
    Public Function fnAddComp(eid As Integer, sTitleFr As String, sTitleEn As String, iType As Integer, iFinal As Integer) As Boolean
        Dim sSQL As String = "Insert Into tblComp ([eid], [title-fr], [title-en], [type], [showFinal]) Values (" & eid  & ", '" & sTitleFr & "','" & sTitleEn & "'," & iType & "," & iFinal & ")"
        fnExecuteNonQueryInDB(sSQL)
        Return True
    End Function

    ' Update competition informations
    Public Function fnUpdateComp(cid As Integer, sTitleFr As String, sTitleEn As String, iType As Integer, iFinal As Integer) As Boolean
        Dim sSql As String = "Update tblComp Set [Title-fr] =  '" & sTitleFr & "', [Title-en] = '" & sTitleEn & "', [type] = " & iType & ", [showFinal] = " & iFinal & " Where id = " & cid 
        Dim sqlDtSet As System.Data.DataSet = fnGetDataSetInDB(sSql, "CompId")
        fnExecuteNonQueryInDB(sSQL)
        Return True
    End Function

    ' Update last import time
    Public Function fnUpdateCompTime(cid As Integer, sLastDate As String ) As Boolean
        Dim sSql As String = "Update tblComp Set [lastDate] =  '" & sLastDate & "' Where id = " & cid 
        Dim sqlDtSet As System.Data.DataSet = fnGetDataSetInDB(sSql, "CompId")
        fnExecuteNonQueryInDB(sSQL)
        Return True
    End Function

' ****** Results related functions ******

    ' Update competition results for a given table
    ' start list, provisional results, final results
    Public Function fnUpdatePubRes(cid As Integer, sFile As String, sField As String ) As Boolean    
        Dim Str As System.IO.Stream
        Dim srRead As System.IO.StreamReader
        Dim strAll As String

        Dim newUrl as String
        newUrl = Request.Url.AbsoluteUri.Replace("import.aspx", sFile)

        ' make a Web request
        Dim req As System.Net.WebRequest = System.Net.WebRequest.Create(newUrl)
        Dim resp As System.Net.WebResponse = req.GetResponse
        StR = resp.GetResponseStream
        srRead = New System.IO.StreamReader(Str)
        strAll = srRead.ReadToEnd
        srRead.Close()
        Str.Close()

        Dim sSqL As String = "Update tblComp Set [" & sField & "] = '" & strAll.Replace("'", """") & "' Where id = " & cid 
        Dim sqlDtSet As System.Data.DataSet = fnGetDataSetInDB(sSql, "CompId")
        fnExecuteNonQueryInDB(sSQL)

        Return true
    End Function

    ' Update competition final Results
    Public Function fnUpdateFinalRes(cid As Integer, sFinalRes As String) As Boolean    
        Dim sSqL As String = "Update tblComp Set publicFinal = '" & sFinalRes.Replace("'", """") & "' Where id = " & cid 
        Dim sqlDtSet As System.Data.DataSet = fnGetDataSetInDB(sSql, "CompId")
        fnExecuteNonQueryInDB(sSQL)
        Return true
    End Function

    ' Add results from CSV input
    Public Function fnAddResults( cid As Integer, aRes() As String) As Boolean
        Dim sSQL As String = "Insert Into tblResults (cid, lastname, firstname, bibnumber, bibcolor, class, club, ms1, ms2, ms3, ms4, lap1, lap2, lap3, lap4, penalty, runtime, finaltime, rank, status, starttime ) Values ( " & cid & ",'" & fnReplaceApostrophes(aRes(0)) & "','" & fnReplaceApostrophes(aRes(1)) & "','" & aRes(2) & "','" & aRes(3) & "','" & aRes(4) & "','" & aRes(5) & "','" & aRes(6) & "','" & aRes(7) & "','" & aRes(8) & "','" & aRes(9) & "','" & aRes(10) & "','" & aRes(11) & "','" & aRes(12) & "','" & aRes(13) & "','" & aRes(14) & "','" & aRes(15) & "','" & aRes(16) & "','" & aRes(17) & "','" & aRes(18) & "','" & aRes(19) & "' )"
        fnExecuteNonQueryInDB(sSQL)
        Return True
    End Function

    ' Delete results
    Public Function fnDeleteResults(intCompId As Integer) As Boolean
        Dim sSQLResults As String = "Delete From tblResults Where cid=" & intCompId
        fnExecuteNonQueryInDB(sSQLResults)
        Return True
    End Function

    ' Parse shooting results
    Public Function fnParseShoot(strOriginalText As String) As String
        If String.IsNullOrEmpty(strOriginalText.Trim()) Then 
            Return "-"
        Else 
            Return strOriginalText
        End If 
    End Function

    ' Parse lap results
    Public Function fnParseLap(strOriginalText As String) As String
        If strOriginalText = "0:00:00.0" Then 
            Return "-"
        Else 
            Return strOriginalText
        End If 
    End Function

    ' Return flag image if team is province
    Public Function fnGetFlag(sProv As String) As String
        Dim sFlagFile As String
        sFlagFile = "<img width=24 src='../images/flags/"
        If String.Equals( sProv, "ON" ) Then
            sFlagFile += "Ontario.gif"
        Else If String.Equals( sProv, "QC" ) Then
            sFlagFile += "Quebec.gif"
        Else If String.Equals( sProv, "SK" ) Then
            sFlagFile += "Saskatchewan.gif"
        Else If String.Equals( sProv, "AB" ) Then
            sFlagFile += "Alberta.gif"
        Else If String.Equals( sProv, "BC" ) Then
            sFlagFile += "BritishColumbia.gif"
        Else If String.Equals( sProv, "MN" ) Then
            sFlagFile += "Manitoba.gif"
        Else If String.Equals( sProv, "NS" ) Then
            sFlagFile += "NovaScotia.gif"
        Else If String.Equals( sProv, "NB" ) Then
            sFlagFile += "NewBrunswick.gif"
        Else If String.Equals( sProv, "NV" ) Then
            sFlagFile += "Nunavut.gif"
        Else If String.Equals( sProv, "NL" ) Then
            sFlagFile += "Newfoundland.gif"
        Else If String.Equals( sProv, "PE" ) Then
            sFlagFile += "PrinceEdwardIsland.gif"
        Else If String.Equals( sProv, "NR" ) Then
            sFlagFile += "NorthwestTerritories.gif"
        Else
            Return ""
        End If
        sFlagFile += "' />"
        Return sFlagFile
    End Function

    ' Return flag image if team is province
    Public Function fnGetFlagRelay(sProv As String) As String
        Dim sFlagFile As String
        sFlagFile = "<img width=24 src='../images/flags/"
        If sProv.Contains( "ON - " ) Then
            sFlagFile += "Ontario.gif"
        Else If sProv.Contains( "QC - " ) Then
            sFlagFile += "Quebec.gif"
        Else If sProv.Contains( "SK - " ) Then
            sFlagFile += "Saskatchewan.gif"
        Else If sProv.Contains( "AB - " ) Then
            sFlagFile += "Alberta.gif"
        Else If sProv.Contains( "BC - " ) Then
            sFlagFile += "BritishColumbia.gif"
        Else If sProv.Contains( "MN - " ) Then
            sFlagFile += "Manitoba.gif"
        Else If sProv.Contains( "NS - " ) Then
            sFlagFile += "NovaScotia.gif"
        Else If sProv.Contains( "NB - " ) Then
            sFlagFile += "NewBrunswick.gif"
        Else If sProv.Contains( "NV - " ) Then
            sFlagFile += "Nunavut.gif"
        Else If sProv.Contains( "NL - " ) Then
            sFlagFile += "Newfoundland.gif"
        Else If sProv.Contains( "PE - " ) Then
            sFlagFile += "PrinceEdwardIsland.gif"
        Else If sProv.Contains( "NR - " ) Then
            sFlagFile += "NorthwestTerritories.gif"
        Else
            Return ""
        End If
        sFlagFile += "' />"
        Return sFlagFile
    End Function

    ' Return better class string
    Public Function fnParseClass(sClass As String) As String
        Dim sRet As String
        If sClass.contains("Cadet Male Youth" ) Then
            sRet = "Youth Male <br /> Benjamin Masculin"
        Else If sClass.contains("Cadet Male Jr") Then
            sRet = "Junior Male <br /> Junior Masculin"
        Else If sClass.contains("Cadet Male Sr") Then
            sRet = "Senior Male <br /> S&eacute;nior Masculin"
        Else If sClass.contains("Cadet Female Youth") Then
            sRet = "Youth Female <br /> Benjamin F&eacute;minin"
        Else If sClass.contains("Cadet Female Jr") Then
            sRet = "Junior Female <br /> Junior F&eacute;minin"
        Else If sClass.contains("Cadet Female Sr") Then
           sRet = "Senior Female <br /> S&eacute;nior F&eacute;minin"
        Else 
           sRet = sClass 
        End If
        Return sRet
    End Function

    Public Function fnGetRelayTeam( list As ArrayList, bibnumber As Integer )
        Dim s As String
        Dim n As String
        For Each item As String() In list

            if item(4) = bibnumber.toString then
               s += "<tr>"
                 '   s += "<td>" & i+1 & "</td>"
                    s += "<td>" & item(2) & ", " & item(3) & "</td>"
                   ' s += "<td>" & sqlDtSet.Tables("Results").Rows(i)("firstname") & "</td>"
                    s += "<td class='bibnumber bib" & item(5) & "'>" & item(4) & "</td>"
                 '   s += "<td>" & sqlDtSet.Tables("Results").Rows(i)("class") & "</td>"
                    s += "<td class='club'>" & fnGetFlagRelay( item(7) ) & " " &item(7) & "</td>"
                    s += "<td class='misses'>" & fnParseShoot( item(8) ) & "</td>"
                    s += "<td class='misses'>" & fnParseShoot( item(9) ) & "</td>"
                    s += "<td class='time'>" & fnParseLap( item(12) ) & "</td>"
                    s += "<td class='time'>" & fnParseLap( item(13) ) & "</td>"
                    s += "<td class='time'>" & fnParseLap( item(14) ) & "</td>"
                 '   s += "<td>" & sqlDtSet.Tables("Results").Rows(i)("runtime") & "</td>"
                    s += "<td class='time'>" & item(18) & "</td>"
                    s+= "</tr>"
            End If
        Next

    Return s
    End Function

    ' Same function but for public side
    Public Function fnGetRelayTeamPublic( list As ArrayList, bibnumber As Integer )
        Dim s As String
        Dim n As String
        For Each item As String() In list

            if item(4) = bibnumber.toString then
               s += "<tr>"
                 '   s += "<td>" & i+1 & "</td>"
                    s += "<td class='bib" & item(5) & "'>(" & item(4) & ")" & item(2) & ", " & item(3) & "</td>"
                   ' s += "<td>" & sqlDtSet.Tables("Results").Rows(i)("firstname") & "</td>"
                  '  s += "<td class='bibnumber'>" & item(4) & "</td>"
                 '   s += "<td>" & sqlDtSet.Tables("Results").Rows(i)("class") & "</td>"
                    s += "<td class='club'>" & fnGetFlag( item(7) ) & " " &item(7) & "</td>"
                    s += "<td class='misses'>" & fnParseShoot( item(8) ) & "</td>"
                    s += "<td class='misses'>" & fnParseShoot( item(9) ) & "</td>"
                    s += "<td class='time'>" & fnParseLap( item(12) ) & "</td>"
                    s += "<td class='time'>" & fnParseLap( item(13) ) & "</td>"
                    s += "<td class='time'>" & fnParseLap( item(14) ) & "</td>"
                 '   s += "<td>" & sqlDtSet.Tables("Results").Rows(i)("runtime") & "</td>"
                    s += "<td class='time'>" & item(18) & "</td>"
                    s+= "</tr>"
            End If
        Next

    Return s
    End Function

    ' Same function but for public start list side
    Public Function fnGetRelayTeamStart( list As ArrayList, bibnumber As Integer )
        Dim s As String
        Dim n As String
        For Each item As String() In list

            if item(4) = bibnumber.toString then
               s += "<tr>"
                    s += "<td>" & item(2) & ", " & item(3) & "</td>"
                    s += "<td class='club bib" & item(5) & "'>" & item(4) & "</td>"
                    s += "<td class='club'>" & item(7) & "</td>"
                    s += "<td class='club'>" & fnParseClass( item(6) ) & "</td>"
                    s += "<td class='club'>" & item(21) & "</td>"
                    s+= "</tr>"
            End If
        Next

    Return s
    End Function

    ' Return mass start public final results page
    ' PDF will be safer for the moment
    Public Function fnGetMassStartFinal( cid As Integer )
        return "<h2>Aucun résultat pour le moment | No results for the moment</h2>"
    End Function

    ' Return relay public final results page
    ' PDF will be safer for the moment
    Public Function fnGetRelayFinal( cid As Integer )
        return "<h2>Aucun résultat pour le moment | No results for the moment</h2>"
    End Function

    ' Return relay public final results page
    ' PDF will be safer for the moment
    Public Function fnGetPursuitFinal( cid As Integer )
        return "<h2>Aucun résultat pour le moment | No results for the moment</h2>"
    End Function

    ' Return relay public final results page
    ' PDF will be safer for the moment
    Public Function fnGetPatrolFinal( cid As Integer )
        return "<h2>Aucun résultat pour le moment | No results for the moment</h2>"
    End Function

End Class


