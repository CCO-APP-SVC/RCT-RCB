
Partial Class functions
    Inherits System.Web.UI.Page

    Public Function fnReplaceApostrophes(strOriginalText As String) As String
        Return strOriginalText.Replace("'", "''")
    End Function

    Public Sub fnPutPublicHtmlTextInDb(sPublicHtmlTextName As String, sPublicHtmlText As String)

        Dim sSql As String = "Select publicHtmlTextName From tblPublicHtmlTexts where publicHtmlTextName = '" & sPublicHtmlTextName & "'"
        Dim sqlDtSet As System.Data.DataSet = fnGetDataSetInDB(sSql, "PublicHtmlTextName")

        If sqlDtSet.Tables("PublicHtmlTextName").Rows.Count = 0 Then
            sSql = "Insert Into tblPublicHtmlTexts (publicHtmlTextName, publicHtmlText, publicHtmlTextDateTime) Values ('" & sPublicHtmlTextName & "','" & fnReplaceApostrophes(sPublicHtmlText) & "', GETDATE())"
        Else
            sSql = "Update tblPublicHtmlTexts Set publicHtmlText = '" & fnReplaceApostrophes(sPublicHtmlText) & "', publicHtmlTextDateTime = GETDATE() Where publicHtmlTextName = '" & sPublicHtmlTextName & "'"
        End If

        fnExecuteNonQueryInDB(sSql)

    End Sub


    Public Function fnGetTextInTemplate(sFileName As String) As String

        Dim sFullFileName As String = Server.MapPath("templates\" & sFileName)
        Dim oStreamReader As System.IO.StreamReader

        oStreamReader = System.IO.File.OpenText(sFullFileName)

        Dim sContent As String = oStreamReader.ReadToEnd()

        oStreamReader.Close()

        Return sContent

    End Function

    Public Sub fnCreateTextFile(sContent As String, sFileName As String)

        Dim oStreamWriter As System.IO.StreamWriter
        oStreamWriter = System.IO.File.CreateText(Server.MapPath("publictxtfiles\" & sFileName))
        oStreamWriter.WriteLine(sContent)
        oStreamWriter.Close()

    End Sub


    Public Function fnGetDataSetInDB(sSql As String, sDtSetName As String) As System.Data.DataSet

        Dim sqlDtSet As System.Data.DataSet = New System.Data.DataSet()
        Dim sqlConn As System.Data.SqlClient.SqlConnection = New System.Data.SqlClient.SqlConnection(ConfigurationManager.AppSettings("sConn"))
        Dim sqlDtAdapter As System.Data.SqlClient.SqlDataAdapter = New System.Data.SqlClient.SqlDataAdapter(sSql, sqlConn)
        sqlDtAdapter.Fill(sqlDtSet, sDtSetName)
        sqlConn.Close()
        Return sqlDtSet

    End Function

    Public Function fnGetDataTableInDB(sSql As String) As System.Data.DataTable

        Dim sqlDtSet As System.Data.DataSet = New System.Data.DataSet()
        Dim sqlConn As System.Data.SqlClient.SqlConnection = New System.Data.SqlClient.SqlConnection(ConfigurationManager.AppSettings("sConn"))
        Dim sqlDtAdapter As System.Data.SqlClient.SqlDataAdapter = New System.Data.SqlClient.SqlDataAdapter(sSql, sqlConn)
        sqlDtAdapter.Fill(sqlDtSet, "Table")
        sqlConn.Close()
        Return sqlDtSet.Tables("Table")

    End Function


    Public Function fnGetParamNumeric(sParamName As String) As Double
        Dim sqlDtSet As System.Data.DataSet = fnGetDataSetInDB("Select paramValue From tblParamsNumeric Where paramName = '" & sParamName & "'", "Param")
        Return sqlDtSet.Tables("Param").Rows(0)("paramValue")
    End Function


    Public Function fnGetText(sTextName As String) As String
        Dim sqlDtSet As System.Data.DataSet = fnGetDataSetInDB("Select text From tblTexts Where textName = '" & sTextName & "'", "Text")
        Return sqlDtSet.Tables("Text").Rows(0)("text")
    End Function


    Public Sub fnExecuteNonQueryInDB(sSql As String)

        Dim sqlConn As System.Data.SqlClient.SqlConnection = New System.Data.SqlClient.SqlConnection(ConfigurationManager.AppSettings("sConn"))
        Dim sqlCommand As System.Data.SqlClient.SqlCommand = New System.Data.SqlClient.SqlCommand(sSql, sqlConn)
        sqlConn.Open()
        sqlCommand.ExecuteNonQuery()
        sqlConn.Close()

    End Sub

    Public Function fnAssociateRegionToEvent(intEventId As Integer, intRegionId As Integer) As Boolean

        Dim sSQL As String = "Insert Into tblRegionsEvents (fkEventId, fkRegionId) Values (" & intEventId & "," & intRegionId & ")"
        fnExecuteNonQueryInDB(sSQL)
        Return True

    End Function

    Public Function fnDissociateRegionToEvent(intEventId As Integer, intRegionId As Integer) As Boolean

        Dim sSQL As String = "Delete From tblRegionsEvents Where fkEventId=" & intEventId & " And fkRegionId=" & intRegionId
        fnExecuteNonQueryInDB(sSQL)
        Return True

    End Function

    Public Function fnResultsAddValidTeamSerial(iTeamSerial As Integer, iEid As Integer) As Integer

        Dim sSql As String = "select * from tblTeams join tblRegionsEvents On tblTeams.fkRegionEventId=tblRegionsEvents.regionEventId Where teamSerial = " & iTeamSerial & " And fkEventId = " & iEid
        Dim sqlDtSet As System.Data.DataSet = fnGetDataSetInDB(sSql, "team")

        If sqlDtSet.Tables("team").Rows.Count <> 1 Then
            Return 0
        Else
            Return sqlDtSet.Tables("team").Rows(0)("teamId")
        End If

    End Function

    Public Function fnResultsAddValidCompetitorSerial(iTeamCompetitorSerial As Integer, iTeamId As Integer) As Integer

        Dim sSql As String = "select * from tblTeamsCompetitors Where teamCompetitorSerial = " & iTeamCompetitorSerial & " And fkTeamId = " & iTeamId
        Dim sqlDtSet As System.Data.DataSet = fnGetDataSetInDB(sSql, "TeamCompetitor")

        If sqlDtSet.Tables("TeamCompetitor").Rows.Count <> 1 Then
            Return 0
        Else
            Return sqlDtSet.Tables("TeamCompetitor").Rows(0)("teamCompetitorId")
        End If

    End Function

    Public Function fnResultsAddValidTargetNumber(iTeamCompetitorSerial As Integer, iTargetNumber As Integer, iCid As Integer) As Boolean

        Dim sSql As String = "select * from tblResults Where resultTeamCompetitorSerial = " & iTeamCompetitorSerial & " And fkCompetitionChapterId = " & iCid & " And resultTargetNbr = " & iTargetNumber
        Dim sqlDtSet As System.Data.DataSet = fnGetDataSetInDB(sSql, "Result")

        If sqlDtSet.Tables("Result").Rows.Count = 0 Then
            Return False
        Else
            Return True
        End If

    End Function

    Public Function fnEventRegionTeamValidSerial(iTeamSerial As Integer, iEid As Integer) As Boolean

        Dim sSql As String = "select * from tblTeams join tblRegionsEvents On tblTeams.fkRegionEventId=tblRegionsEvents.regionEventId Where teamSerial = " & iTeamSerial & " And fkEventId = " & iEid
        Dim sqlDtSet As System.Data.DataSet = fnGetDataSetInDB(sSql, "Team")

        If sqlDtSet.Tables("Team").Rows.Count = 0 Then
            Return True
        Else
            Return False
        End If

    End Function

    Public Sub fnEventRegionTeamEditChangeTeamCompetitorsSerials(iTid As Integer, iTeamSerial As Integer)

        Dim sSql As String = "Select teamCompetitorId From tblTeamsCompetitors Where fkTeamId = " & iTid & "Order By teamCompetitorSerial"
        Dim sqlDtSet As System.Data.DataSet = fnGetDataSetInDB(sSql, "CompetitorsId")

        Dim i As Integer
        For i = 0 To sqlDtSet.Tables("CompetitorsId").Rows.Count - 1
            sSql = "Update tblTeamsCompetitors Set teamCompetitorSerial=" & iTeamSerial & i + 1 & " Where teamCompetitorId = " & sqlDtSet.Tables("CompetitorsId").Rows(i)("teamCompetitorId")
            fnExecuteNonQueryInDB(sSql)
        Next

    End Sub


    Public Function fnTeamsRanking(iEid As Integer, iTtid As Integer, iCcid As Integer, iCdid As Integer, dCcValue As Decimal, dCdValue As Decimal) As cTeamResults()

        Dim sSql As String = "Select * From tblTeams Inner Join tblRegionsEvents on tblTeams.fkRegionEventId=tblRegionsEvents.regionEventId Inner Join tblRegions On tblRegionsEvents.fkRegionId=tblRegions.regionId Where fkTeamTypeId = " & iTtid & " And fkEventId = " & iEid
        Dim sqlDtSet As System.Data.DataSet = fnGetDataSetInDB(sSql, "Teams")
        Dim aTeamsRanking(sqlDtSet.Tables("Teams").Rows.Count - 1) As cTeamResults
        Dim i, ii As Integer

        For i = 0 To sqlDtSet.Tables("Teams").Rows.Count - 1

            sSql = "Select * From vwTeamsCompetitorsCompetitorsCategoriesGenders Where fkTeamId = " & sqlDtSet.Tables("Teams").Rows(i)("teamId") & " Order By teamCompetitorSerial"
            sqlDtSet.Tables.Add("TeamCompetitors_" & sqlDtSet.Tables("Teams").Rows(i)("teamId")).Merge(fnGetDataTableInDB(sSql))

            aTeamsRanking(i) = fnResultsTeam(iCcid, iCdid, dCcValue, dCdValue, sqlDtSet.Tables("TeamCompetitors_" & sqlDtSet.Tables("Teams").Rows(i)("teamId")))
            aTeamsRanking(i).TeamNameFr = sqlDtSet.Tables("Teams").Rows(i)("teamNameFr")
            aTeamsRanking(i).TeamNameEn = sqlDtSet.Tables("Teams").Rows(i)("teamNameEn")
            aTeamsRanking(i).TeamRegionNameFr = sqlDtSet.Tables("Teams").Rows(i)("regionNameFr")
            aTeamsRanking(i).TeamRegionNameEn = sqlDtSet.Tables("Teams").Rows(i)("regionNameEn")
            aTeamsRanking(i).TeamRegionFlag = sqlDtSet.Tables("Teams").Rows(i)("regionFlagLogo")

        Next

        Dim bEncore As Boolean = False
        Dim iTailleTableau As Integer = sqlDtSet.Tables("Teams").Rows.Count
        Dim oIntermediaire As cTeamResults = New cTeamResults

        While Not bEncore
            bEncore = True
            For i = 0 To iTailleTableau - 2
                If aTeamsRanking(i).MoyenneTotale > aTeamsRanking(i + 1).MoyenneTotale Then

                    oIntermediaire = aTeamsRanking(i)
                    aTeamsRanking(i) = aTeamsRanking(i + 1)
                    aTeamsRanking(i + 1) = oIntermediaire

                    bEncore = False

                End If
            Next
            iTailleTableau = iTailleTableau - 1
        End While


        Return aTeamsRanking

    End Function


    Public Function fnRegionsRanking(iEid As Integer, iCcid As Integer, iCdid As Integer, dCcValue As Decimal, dCdValue As Decimal) As cRegionRanking()

        Dim sSql As String = "Select * From tblRegionsEvents Inner Join tblRegions On tblRegionsEvents.fkRegionId=tblRegions.regionId Where fkEventId = " & iEid
        Dim sqlDtSet As System.Data.DataSet = fnGetDataSetInDB(sSql, "Regions")
        Dim aRegions(sqlDtSet.Tables("Regions").Rows.Count - 1) As cRegionRanking
        Dim i, ii, iCountTeamsResultsOk As Integer
        Dim oTeamResults As cTeamResults = New cTeamResults

        For i = 0 To sqlDtSet.Tables("Regions").Rows.Count - 1

            sSql = "Select * From tblTeams JOIN tblTeamsTypes ON tblTeams.fkTeamTypeId=tblTeamsTypes.teamTypeId Where fkRegionEventId = " & sqlDtSet.Tables("Regions").Rows(i)("regionEventId")
            sqlDtSet.Tables.Add("TeamsRegion_" & sqlDtSet.Tables("Regions").Rows(i)("regionEventId")).Merge(fnGetDataTableInDB(sSql))

            aRegions(i) = New cRegionRanking
            aRegions(i).RegionId = sqlDtSet.Tables("Regions").Rows(i)("fkRegionId")
            aRegions(i).RegionValue = 0
            aRegions(i).RegionNameFr = sqlDtSet.Tables("Regions").Rows(i)("regionNameFr")
            aRegions(i).RegionNameEn = sqlDtSet.Tables("Regions").Rows(i)("regionNameEn")
            aRegions(i).RegionLetterFr = sqlDtSet.Tables("Regions").Rows(i)("regionLetterFr")
            aRegions(i).RegionLetterEn = sqlDtSet.Tables("Regions").Rows(i)("regionLetterEn")
            aRegions(i).RegionFlag = sqlDtSet.Tables("Regions").Rows(i)("regionFlagLogo")
            aRegions(i).RegionWavingFlag = ""

            iCountTeamsResultsOk = 0

            For ii = 0 To sqlDtSet.Tables("TeamsRegion_" & sqlDtSet.Tables("Regions").Rows(i)("regionEventId")).Rows.Count - 1

                sSql = "Select * From vwTeamsCompetitorsCompetitorsCategoriesGenders Where fkTeamId = " & sqlDtSet.Tables("TeamsRegion_" & sqlDtSet.Tables("Regions").Rows(i)("regionEventId")).Rows(ii)("teamId") & " Order By teamCompetitorSerial"
                sqlDtSet.Tables.Add("TeamCompetitors_" & sqlDtSet.Tables("TeamsRegion_" & sqlDtSet.Tables("Regions").Rows(i)("regionEventId")).Rows(ii)("teamId")).Merge(fnGetDataTableInDB(sSql))

                oTeamResults = fnResultsRegionTeam(iCcid, iCdid, dCcValue, dCdValue, sqlDtSet.Tables("TeamCompetitors_" & sqlDtSet.Tables("TeamsRegion_" & sqlDtSet.Tables("Regions").Rows(i)("regionEventId")).Rows(ii)("teamId")))
                aRegions(i).RegionValue = aRegions(i).RegionValue + oTeamResults.MoyenneTotale

                If oTeamResults.MoyenneTotale > 0 Then
                    iCountTeamsResultsOk = iCountTeamsResultsOk + 1
                End If

            Next

            If iCountTeamsResultsOk = 0 Then
                iCountTeamsResultsOk = 1
            End If

            'aRegions(i).RegionValue = aRegions(i).RegionValue / sqlDtSet.Tables("TeamsRegion_" & sqlDtSet.Tables("Regions").Rows(i)("regionEventId")).Rows.Count
            aRegions(i).RegionValue = aRegions(i).RegionValue / iCountTeamsResultsOk


        Next

        Dim bEncore As Boolean = False
        Dim iTailleTableau As Integer = sqlDtSet.Tables("Regions").Rows.Count
        Dim oIntermediaire As cRegionRanking = New cRegionRanking

        While Not bEncore
            bEncore = True
            For i = 0 To iTailleTableau - 2
                If aRegions(i).RegionValue > aRegions(i + 1).RegionValue Then

                    oIntermediaire = aRegions(i)
                    aRegions(i) = aRegions(i + 1)
                    aRegions(i + 1) = oIntermediaire

                    bEncore = False

                End If
            Next
            iTailleTableau = iTailleTableau - 1
        End While

        Return aRegions

    End Function


    Public Function fnResultsTeam(iCcid As Integer, iCdid As Integer, dCcValue As Decimal, dCdValue As Decimal, sqlDtTableCompetitors As System.Data.DataTable) As cTeamResults

        Dim oTeamResults As cTeamResults = New cTeamResults
        Dim i, ii As Integer
        Dim sSql As String
        Dim sqlDtSet As System.Data.DataSet = New System.Data.DataSet

        Dim iTeamProneScore As Single = 0
        Dim iTeamStandingScore As Single = 0
        Dim iNbrProneTargets As Integer = 0
        Dim iNbrStandingTargets As Integer = 0

        Dim aResultsCompetitor(sqlDtTableCompetitors.Rows.Count - 1) As cIndividualResults
        Dim bEncore As Boolean = False
        Dim iTailleTableau As Integer = aResultsCompetitor.Length
        Dim oResultsCompInter As cIndividualResults = New cIndividualResults


        For i = 0 To sqlDtTableCompetitors.Rows.Count - 1

            sSql = "Select * From tblResults Where fkTeamCompetitorId = " & sqlDtTableCompetitors.Rows(i)("teamCompetitorId") & " And fkCompetitionChapterId = " & iCcid
            sqlDtSet.Tables.Add("tblResultsProneCompetitor_" & i).Merge(fnGetDataTableInDB(sSql))

            sSql = "Select * From tblResults Where fkTeamCompetitorId = " & sqlDtTableCompetitors.Rows(i)("teamCompetitorId") & " And fkCompetitionChapterId = " & iCdid
            sqlDtSet.Tables.Add("tblResultsStandingCompetitor_" & i).Merge(fnGetDataTableInDB(sSql))

            aResultsCompetitor(i) = New cIndividualResults

            iNbrProneTargets = 0
            For ii = 0 To sqlDtSet.Tables("tblResultsProneCompetitor_" & i).Rows.Count - 1
                aResultsCompetitor(i).PointageCoucher = aResultsCompetitor(i).PointageCoucher + sqlDtSet.Tables("tblResultsProneCompetitor_" & i).Rows(ii)("result")
                iNbrProneTargets = iNbrProneTargets + 1
            Next

            iNbrStandingTargets = 0
            For ii = 0 To sqlDtSet.Tables("tblResultsStandingCompetitor_" & i).Rows.Count - 1
                aResultsCompetitor(i).PointageDebout = aResultsCompetitor(i).PointageDebout + sqlDtSet.Tables("tblResultsStandingCompetitor_" & i).Rows(ii)("result")
                iNbrStandingTargets = iNbrStandingTargets + 1
            Next

            aResultsCompetitor(i).MoyenneCoucher = (aResultsCompetitor(i).PointageCoucher / (iNbrProneTargets * 100)) * 100
            aResultsCompetitor(i).MoyenneDebout = (aResultsCompetitor(i).PointageDebout / (iNbrProneTargets * 100)) * 100
            aResultsCompetitor(i).MoyenneCoucherTotal = (aResultsCompetitor(i).PointageCoucher / (iNbrProneTargets * 100)) * (dCcValue * 100)
            aResultsCompetitor(i).MoyenneDeboutTotal = (aResultsCompetitor(i).PointageDebout / (iNbrStandingTargets * 100)) * (dCdValue * 100)
            aResultsCompetitor(i).NbrCiblesCoucher = iNbrProneTargets
            aResultsCompetitor(i).NbrCiblesDebout = iNbrStandingTargets

            If Not (aResultsCompetitor(i).MoyenneCoucher >= 0 And aResultsCompetitor(i).MoyenneCoucher <= 100) Then
                aResultsCompetitor(i).MoyenneCoucher = 0
            End If
            If Not (aResultsCompetitor(i).MoyenneDebout >= 0 And aResultsCompetitor(i).MoyenneDebout <= 100) Then
                aResultsCompetitor(i).MoyenneDebout = 0
            End If
            If Not (aResultsCompetitor(i).MoyenneCoucherTotal >= 0 And aResultsCompetitor(i).MoyenneCoucherTotal <= (dCcValue * 100)) Then
                aResultsCompetitor(i).MoyenneCoucherTotal = 0
            End If
            If Not (aResultsCompetitor(i).MoyenneDeboutTotal >= 0 And aResultsCompetitor(i).MoyenneDeboutTotal <= (dCdValue * 100)) Then
                aResultsCompetitor(i).MoyenneDeboutTotal = 0
            End If

            aResultsCompetitor(i).MoyenneTotale = aResultsCompetitor(i).MoyenneCoucherTotal + aResultsCompetitor(i).MoyenneDeboutTotal

        Next

        While Not bEncore
            bEncore = True
            For i = 0 To iTailleTableau - 2
                If aResultsCompetitor(i).MoyenneTotale > aResultsCompetitor(i + 1).MoyenneTotale Then

                    oResultsCompInter = aResultsCompetitor(i)
                    aResultsCompetitor(i) = aResultsCompetitor(i + 1)
                    aResultsCompetitor(i + 1) = oResultsCompInter

                    bEncore = False

                End If
            Next
            iTailleTableau = iTailleTableau - 1
        End While

        Dim iNbrCompOk As Integer = 0

        If aResultsCompetitor.Length = 5 Then
            iNbrCompOk = 4
        Else
            iNbrCompOk = aResultsCompetitor.Length
        End If

        For i = 0 To iNbrCompOk - 1
            oTeamResults.PointageCoucher = oTeamResults.PointageCoucher + aResultsCompetitor(aResultsCompetitor.Length - 1 - i).PointageCoucher
            oTeamResults.NbrCiblesCoucher = oTeamResults.NbrCiblesCoucher + aResultsCompetitor(aResultsCompetitor.Length - 1 - i).NbrCiblesCoucher

            oTeamResults.PointageDebout = oTeamResults.PointageDebout + aResultsCompetitor(aResultsCompetitor.Length - 1 - i).PointageDebout
            oTeamResults.NbrCiblesDebout = oTeamResults.NbrCiblesDebout + aResultsCompetitor(aResultsCompetitor.Length - 1 - i).NbrCiblesDebout
        Next

        oTeamResults.MoyenneCoucher = (oTeamResults.PointageCoucher / (oTeamResults.NbrCiblesCoucher * 100)) * 100
        oTeamResults.MoyenneDebout = (oTeamResults.PointageDebout / (oTeamResults.NbrCiblesDebout * 100)) * 100
        oTeamResults.MoyenneCoucherTotal = (oTeamResults.PointageCoucher / (oTeamResults.NbrCiblesCoucher * 100)) * (dCcValue * 100)
        oTeamResults.MoyenneDeboutTotal = (oTeamResults.PointageDebout / (oTeamResults.NbrCiblesDebout * 100)) * (dCdValue * 100)

        If Not (oTeamResults.MoyenneCoucher >= 0 And oTeamResults.MoyenneCoucher <= 100) Then
            oTeamResults.MoyenneCoucher = 0
        End If
        If Not (oTeamResults.MoyenneDebout >= 0 And oTeamResults.MoyenneDebout <= 100) Then
            oTeamResults.MoyenneDebout = 0
        End If
        If Not (oTeamResults.MoyenneCoucherTotal >= 0 And oTeamResults.MoyenneCoucherTotal <= (dCcValue * 100)) Then
            oTeamResults.MoyenneCoucherTotal = 0
        End If
        If Not (oTeamResults.MoyenneDeboutTotal >= 0 And oTeamResults.MoyenneDeboutTotal <= (dCdValue * 100)) Then
            oTeamResults.MoyenneDeboutTotal = 0
        End If

        oTeamResults.MoyenneTotale = oTeamResults.MoyenneCoucherTotal + oTeamResults.MoyenneDeboutTotal
        oTeamResults.PointageTotal = oTeamResults.PointageCoucher + oTeamResults.PointageDebout

        Return oTeamResults

    End Function


    Public Function fnResultsRegionTeam(iCcid As Integer, iCdid As Integer, dCcValue As Decimal, dCdValue As Decimal, sqlDtTableCompetitors As System.Data.DataTable) As cTeamResults

        Dim oTeamResults As cTeamResults = New cTeamResults
        Dim i, ii As Integer
        Dim sSql As String
        Dim sqlDtSet As System.Data.DataSet = New System.Data.DataSet

        Dim iTeamProneScore As Single = 0
        Dim iTeamStandingScore As Single = 0
        Dim iNbrProneTargets As Integer = 0
        Dim iNbrStandingTargets As Integer = 0

        For i = 0 To sqlDtTableCompetitors.Rows.Count - 1

            sSql = "Select * From tblResults Where fkTeamCompetitorId = " & sqlDtTableCompetitors.Rows(i)("teamCompetitorId") & " And fkCompetitionChapterId = " & iCcid
            sqlDtSet.Tables.Add("tblResultsProneCompetitor_" & i).Merge(fnGetDataTableInDB(sSql))

            sSql = "Select * From tblResults Where fkTeamCompetitorId = " & sqlDtTableCompetitors.Rows(i)("teamCompetitorId") & " And fkCompetitionChapterId = " & iCdid
            sqlDtSet.Tables.Add("tblResultsStandingCompetitor_" & i).Merge(fnGetDataTableInDB(sSql))

            For ii = 0 To sqlDtSet.Tables("tblResultsProneCompetitor_" & i).Rows.Count - 1
                iTeamProneScore = iTeamProneScore + sqlDtSet.Tables("tblResultsProneCompetitor_" & i).Rows(ii)("result")
                iNbrProneTargets = iNbrProneTargets + 1
            Next

            For ii = 0 To sqlDtSet.Tables("tblResultsStandingCompetitor_" & i).Rows.Count - 1
                iTeamStandingScore = iTeamStandingScore + sqlDtSet.Tables("tblResultsStandingCompetitor_" & i).Rows(ii)("result")
                iNbrStandingTargets = iNbrStandingTargets + 1
            Next

        Next

        oTeamResults.PointageCoucher = iTeamProneScore
        oTeamResults.PointageDebout = iTeamStandingScore
        oTeamResults.MoyenneCoucher = (iTeamProneScore / (iNbrProneTargets * 100)) * 100
        oTeamResults.MoyenneDebout = (iTeamStandingScore / (iNbrStandingTargets * 100)) * 100

        If Not (oTeamResults.MoyenneCoucher >= 0 And oTeamResults.MoyenneCoucher <= 100) Then
            oTeamResults.MoyenneCoucher = 0
        End If
        If Not (oTeamResults.MoyenneDebout >= 0 And oTeamResults.MoyenneDebout <= 100) Then
            oTeamResults.MoyenneDebout = 0
        End If

        oTeamResults.MoyenneCoucherTotal = (iTeamProneScore / (iNbrProneTargets * 100)) * (dCcValue * 100)
        oTeamResults.MoyenneDeboutTotal = (iTeamStandingScore / (iNbrStandingTargets * 100)) * (dCdValue * 100)

        If Not (oTeamResults.MoyenneCoucherTotal >= 0 And oTeamResults.MoyenneCoucherTotal <= (dCcValue * 100)) Then
            oTeamResults.MoyenneCoucherTotal = 0
        End If
        If Not (oTeamResults.MoyenneDeboutTotal >= 0 And oTeamResults.MoyenneDeboutTotal <= (dCdValue * 100)) Then
            oTeamResults.MoyenneDeboutTotal = 0
        End If


        oTeamResults.PointageTotal = iTeamProneScore + iTeamStandingScore
        oTeamResults.MoyenneTotale = oTeamResults.MoyenneCoucherTotal + oTeamResults.MoyenneDeboutTotal

        Return oTeamResults

    End Function


    Public Function fnResultsIndividual(iTeamCompetitorId As Integer, iEid As Integer, iCcid As Integer, iCdid As Integer, dCcValue As Decimal, dCdValue As Decimal, iACRPO As Single(,), iACRPJ As Single(,), iACRSO As Single(,), iACRSJ As Single(,), iACGRO As Single(,), iACGRJ As Single(,)) As cIndividualResults

        Dim sSql As String = "Select * From tblResults Where fkTeamCompetitorId = " & iTeamCompetitorId & " And fkCompetitionChapterId = " & iCcid
        Dim sqlDtSet As System.Data.DataSet = fnGetDataSetInDB(sSql, "CompetitorResultsCoucher")

        sSql = "Select * From tblResults Where fkTeamCompetitorId = " & iTeamCompetitorId & " And fkCompetitionChapterId = " & iCdid
        sqlDtSet.Tables.Add("CompetitorResultsDebout").Merge(fnGetDataTableInDB(sSql))

        Dim oIndividualResults As cIndividualResults = New cIndividualResults
        Dim i As Integer

        For i = 0 To sqlDtSet.Tables("CompetitorResultsCoucher").Rows.Count - 1
            oIndividualResults.PointageCoucher = oIndividualResults.PointageCoucher + sqlDtSet.Tables("CompetitorResultsCoucher").Rows(i)("result")
        Next
        oIndividualResults.NbrCiblesCoucher = i
        oIndividualResults.MoyenneCoucher = (oIndividualResults.PointageCoucher / (i * 100)) * 100
        If Not (oIndividualResults.MoyenneCoucher >= 0 And oIndividualResults.MoyenneCoucher <= 100) Then
            oIndividualResults.MoyenneCoucher = 0
        End If

        oIndividualResults.MoyenneCoucherTotal = (oIndividualResults.PointageCoucher / (i * 100)) * (dCcValue * 100)
        If Not (oIndividualResults.MoyenneCoucherTotal >= 0 And oIndividualResults.MoyenneCoucherTotal <= (dCcValue * 100)) Then
            oIndividualResults.MoyenneCoucherTotal = 0
        End If

        For i = 0 To sqlDtSet.Tables("CompetitorResultsDebout").Rows.Count - 1
            oIndividualResults.PointageDebout = oIndividualResults.PointageDebout + sqlDtSet.Tables("CompetitorResultsDebout").Rows(i)("result")
        Next
        oIndividualResults.NbrCiblesDebout = i
        oIndividualResults.MoyenneDebout = (oIndividualResults.PointageDebout / (i * 100)) * 100
        If Not (oIndividualResults.MoyenneDebout >= 0 And oIndividualResults.MoyenneDebout <= 100) Then
            oIndividualResults.MoyenneDebout = 0
        End If

        oIndividualResults.MoyenneDeboutTotal = (oIndividualResults.PointageDebout / (i * 100)) * (dCdValue * 100)
        If Not (oIndividualResults.MoyenneDeboutTotal >= 0 And oIndividualResults.MoyenneDeboutTotal <= (dCdValue * 100)) Then
            oIndividualResults.MoyenneDeboutTotal = 0
        End If

        oIndividualResults.MoyenneTotale = oIndividualResults.MoyenneCoucherTotal + oIndividualResults.MoyenneDeboutTotal

        oIndividualResults.ClassementCoucherOuvert = fnGetRankCompetitor(iTeamCompetitorId, iACRPO)
        oIndividualResults.ClassementCoucherJunior = fnGetRankCompetitor(iTeamCompetitorId, iACRPJ)
        oIndividualResults.ClassementDeboutOuvert = fnGetRankCompetitor(iTeamCompetitorId, iACRSO)
        oIndividualResults.ClassementDeboutJunior = fnGetRankCompetitor(iTeamCompetitorId, iACRSJ)
        oIndividualResults.ClassementOuvert = fnGetRankCompetitor(iTeamCompetitorId, iACGRO)
        oIndividualResults.ClassementJunior = fnGetRankCompetitor(iTeamCompetitorId, iACGRJ)

        Return oIndividualResults

    End Function

    Public Function fnGetRankCompetitor(iTeamCompetitorId As Integer, iCompetitorsId As Single(,)) As Integer

        Dim i As Integer
        For i = 0 To iCompetitorsId.GetLength(0) - 1
            If iCompetitorsId(i, 0) = iTeamCompetitorId Then
                Return iCompetitorsId.GetLength(0) - i
            End If
        Next

        Return 0

    End Function


    Public Function fnGetAllCompetitorsGlobalsResults(iEid As Integer, iCcid As Integer, iCdid As Integer, dCcValue As Decimal, dCdValue As Decimal, bJunior As Boolean) As Single(,)

        Dim sSql As String = "Select teamCompetitorId From tblTeamsCompetitors JOIN tblTeams ON tblTeamsCompetitors.fkTeamId=tblTeams.teamId JOIN tblRegionsEvents ON tblTeams.fkRegionEventId=tblRegionsEvents.regionEventId WHERE fkEventId = " & iEid
        If bJunior Then
            sSql = sSql & " AND fkCompetitorCategoryId = 1"
        End If

        Dim sqlDtSet As System.Data.DataSet = fnGetDataSetInDB(sSql, "CompetitorsId")
        Dim iCompetitorsResults(sqlDtSet.Tables("CompetitorsId").Rows.Count - 1, 1) As Single
        Dim i, iic, iid As Integer
        Dim iPointageCoucher, iPointageDebout As Single
        Dim dProneAv As Single = 0
        Dim dStandingAv As Single = 0

        For i = 0 To sqlDtSet.Tables("CompetitorsId").Rows.Count - 1

            sSql = "Select * From tblResults Where fkCompetitionChapterId = " & iCcid & " AND fkTeamCompetitorID = " & sqlDtSet.Tables("CompetitorsId").Rows(i)("teamCompetitorId")
            sqlDtSet.Tables.Add("ResultsCompetitorCoucher_" & sqlDtSet.Tables("CompetitorsId").Rows(i)("teamCompetitorId")).Merge(fnGetDataTableInDB(sSql))
            iPointageCoucher = 0
            For iic = 0 To sqlDtSet.Tables("ResultsCompetitorCoucher_" & sqlDtSet.Tables("CompetitorsId").Rows(i)("teamCompetitorId")).Rows.Count - 1
                iPointageCoucher = iPointageCoucher + sqlDtSet.Tables("ResultsCompetitorCoucher_" & sqlDtSet.Tables("CompetitorsId").Rows(i)("teamCompetitorId")).Rows(iic)("result")
            Next

            sSql = "Select * From tblResults Where fkCompetitionChapterId = " & iCdid & " AND fkTeamCompetitorID = " & sqlDtSet.Tables("CompetitorsId").Rows(i)("teamCompetitorId")
            sqlDtSet.Tables.Add("ResultsCompetitorDebout_" & sqlDtSet.Tables("CompetitorsId").Rows(i)("teamCompetitorId")).Merge(fnGetDataTableInDB(sSql))
            iPointageDebout = 0
            For iid = 0 To sqlDtSet.Tables("ResultsCompetitorDebout_" & sqlDtSet.Tables("CompetitorsId").Rows(i)("teamCompetitorId")).Rows.Count - 1
                iPointageDebout = iPointageDebout + sqlDtSet.Tables("ResultsCompetitorDebout_" & sqlDtSet.Tables("CompetitorsId").Rows(i)("teamCompetitorId")).Rows(iid)("result")
            Next

            If iPointageCoucher = 0 Then
                dProneAv = 0
            Else
                dProneAv = ((iPointageCoucher / (iic * 100)) * (dCcValue * 100))
            End If

            If iPointageDebout = 0 Then
                dStandingAv = 0
            Else
                dStandingAv = ((iPointageDebout / (iid * 100)) * (dCdValue * 100))
            End If

            iCompetitorsResults(i, 0) = sqlDtSet.Tables("CompetitorsId").Rows(i)("teamCompetitorId")
            iCompetitorsResults(i, 1) = dProneAv + dStandingAv

            If Not (iCompetitorsResults(i, 1) >= 0 And iCompetitorsResults(i, 1) <= 100) Then
                iCompetitorsResults(i, 1) = 0
            End If
        Next

        Dim bEncore As Boolean = False
        Dim iTailleTableau As Integer = sqlDtSet.Tables("CompetitorsId").Rows.Count
        Dim iIntermediaire(0, 1) As Single

        While Not bEncore
            bEncore = True
            For i = 0 To iTailleTableau - 2
                If iCompetitorsResults(i, 1) > iCompetitorsResults(i + 1, 1) Then
                    iIntermediaire(0, 0) = iCompetitorsResults(i, 0)
                    iIntermediaire(0, 1) = iCompetitorsResults(i, 1)
                    iCompetitorsResults(i, 0) = iCompetitorsResults(i + 1, 0)
                    iCompetitorsResults(i, 1) = iCompetitorsResults(i + 1, 1)
                    iCompetitorsResults(i + 1, 0) = iIntermediaire(0, 0)
                    iCompetitorsResults(i + 1, 1) = iIntermediaire(0, 1)
                    bEncore = False
                End If
            Next
            iTailleTableau = iTailleTableau - 1
        End While

        Return iCompetitorsResults

    End Function


    Public Function fnGetAllCompetitorsResults(iEid As Integer, iCid As Integer, bJunior As Boolean) As Single(,)

        Dim sSql As String = "Select teamCompetitorId From tblTeamsCompetitors JOIN tblTeams ON tblTeamsCompetitors.fkTeamId=tblTeams.teamId JOIN tblRegionsEvents ON tblTeams.fkRegionEventId=tblRegionsEvents.regionEventId WHERE fkEventId = " & iEid
        If bJunior Then
            sSql = sSql & " AND fkCompetitorCategoryId = 1"
        End If

        Dim sqlDtSet As System.Data.DataSet = fnGetDataSetInDB(sSql, "CompetitorsId")
        Dim iCompetitorsResults(sqlDtSet.Tables("CompetitorsId").Rows.Count - 1, 1) As Single

        Dim i, ii As Integer
        Dim iPointage As Single

        For i = 0 To sqlDtSet.Tables("CompetitorsId").Rows.Count - 1
            sSql = "Select * From tblResults Where fkCompetitionChapterId = " & iCid & " AND fkTeamCompetitorID = " & sqlDtSet.Tables("CompetitorsId").Rows(i)("teamCompetitorId")
            sqlDtSet.Tables.Add("ResultsCompetitor_" & sqlDtSet.Tables("CompetitorsId").Rows(i)("teamCompetitorId")).Merge(fnGetDataTableInDB(sSql))
            iPointage = 0

            For ii = 0 To sqlDtSet.Tables("ResultsCompetitor_" & sqlDtSet.Tables("CompetitorsId").Rows(i)("teamCompetitorId")).Rows.Count - 1
                iPointage = iPointage + sqlDtSet.Tables("ResultsCompetitor_" & sqlDtSet.Tables("CompetitorsId").Rows(i)("teamCompetitorId")).Rows(ii)("result")
            Next

            iCompetitorsResults(i, 0) = sqlDtSet.Tables("CompetitorsId").Rows(i)("teamCompetitorId")
            iCompetitorsResults(i, 1) = (iPointage / (ii * 100)) * 100
            If Not (iCompetitorsResults(i, 1) >= 0 And iCompetitorsResults(i, 1) <= 100) Then
                iCompetitorsResults(i, 1) = 0
            End If
        Next

        Dim bEncore As Boolean = False
        Dim iTailleTableau As Integer = sqlDtSet.Tables("CompetitorsId").Rows.Count
        Dim iIntermediaire(0, 1) As Single

        While Not bEncore
            bEncore = True
            For i = 0 To iTailleTableau - 2
                If iCompetitorsResults(i, 1) > iCompetitorsResults(i + 1, 1) Then
                    iIntermediaire(0, 0) = iCompetitorsResults(i, 0)
                    iIntermediaire(0, 1) = iCompetitorsResults(i, 1)
                    iCompetitorsResults(i, 0) = iCompetitorsResults(i + 1, 0)
                    iCompetitorsResults(i, 1) = iCompetitorsResults(i + 1, 1)
                    iCompetitorsResults(i + 1, 0) = iIntermediaire(0, 0)
                    iCompetitorsResults(i + 1, 1) = iIntermediaire(0, 1)
                    bEncore = False
                End If
            Next
            iTailleTableau = iTailleTableau - 1
        End While

        Return iCompetitorsResults

    End Function


    Public Function fnGetNbrCompetitors(iEid As Integer, bJunior As Boolean) As Integer

        Dim sSql As String = "Select COUNT(teamCompetitorSerial) as 'NbrComp' From tblTeamsCompetitors JOIN tblTeams ON tblTeamsCompetitors.fkTeamId=tblTeams.teamId JOIN tblRegionsEvents ON tblTeams.fkRegionEventId=tblRegionsEvents.regionEventId WHERE fkEventId = " & iEid
        If bJunior Then
            sSql = sSql & " AND fkCompetitorCategoryId = 1"
        End If

        Dim sqlDtSet As System.Data.DataSet = fnGetDataSetInDB(sSql, "NbrCompetitors")

        Return sqlDtSet.Tables("NbrCompetitors").Rows(0)("NbrComp")

    End Function

    Public Function fnPutResultsImportInDb(iRecord() As Integer, iRelay As Integer, iEid As Integer, iCid As Integer) As Integer

        Dim i, iTeamSerial, iCompetitorSerial, iCompetitorId, iUserId, iTeamId As Integer
        Dim bValidTargetNumer As Boolean
        Dim sTargetSerial As String
        Dim sSql As String = "Select * From tblChaptersRelays Where fkCompetitionChapterId = " & iCid & " And chapterRelayNumber = " & iRelay
        Dim sqlDtSet As System.Data.DataSet = fnGetDataSetInDB(sSql, "RelayTargets")

        Dim sTargets() As String = sqlDtSet.Tables("RelayTargets").Rows(0)("chapterRelayTargetsNumbers").ToString().Split(";")

        iUserId = Convert.ToInt16(Session("userIdLog"))
        iCompetitorSerial = iRecord(0)
        iTeamSerial = Convert.ToInt16(iRecord(0).ToString().Substring(0, iRecord(0).ToString().Length - 1))

        iTeamId = fnResultsAddValidTeamSerial(iTeamSerial, iEid)
        iCompetitorId = fnResultsAddValidCompetitorSerial(iCompetitorSerial, iTeamId)

        For i = 1 To iRecord.Length - 1

            bValidTargetNumer = fnResultsAddValidTargetNumber(iCompetitorSerial, Convert.ToInt16(sTargets(i - 1)), iCid)

            If iCompetitorSerial < 100 Then
                sTargetSerial = "0" & iCompetitorSerial.ToString()
            Else
                sTargetSerial = iCompetitorSerial.ToString()
            End If

            If Convert.ToInt16(sTargets(i - 1)) < 10 Then
                sTargetSerial = sTargetSerial & "0" & sTargets(i - 1)
            Else
                sTargetSerial = sTargetSerial & sTargets(i - 1)
            End If

            If Not bValidTargetNumer Then
                sSql = "Insert Into tblResults (result, resultTargetSerial, resultDateTimeInsert, resultTargetNbr, resultTeamSerial, resultTeamCompetitorSerial, fkTeamCompetitorId, fkCompetitionChapterId, fkUserId) Values (" & iRecord(i) & ",'" & sTargetSerial & "', GETDATE(), " & sTargets(i - 1) & ", " & iTeamSerial & ", " & iCompetitorSerial & ", " & iCompetitorId & ", " & iCid & ", " & iUserId & ")"
            Else
                sSql = "Update tblResults Set result = " & iRecord(i) & ", resultDateTimeInsert = GETDATE() Where resultTargetSerial = '" & sTargetSerial & "'"
            End If
            fnExecuteNonQueryInDB(sSql)

        Next

        Return 1

    End Function


    Public Function fnResultsImport(sFileContent As String, iEid As Integer, iCid As Integer) As Integer

        Dim sRows() As String
        sRows = Split(sFileContent, vbCrLf)

        Dim i, ii, iii, iValue, iReturnCode, iRelay As Integer
        Dim sValues() As String
        Dim iRecord() As Integer

        iReturnCode = 1

        iRelay = Convert.ToInt16(sRows(0).Split(";")(0).ToString().Substring(6))

        For i = 0 To sRows.Length - 1

            sValues = sRows(i).Split(";")

            If Integer.TryParse(sValues(0), iValue) Then

                iii = 0
                For ii = 0 To sValues.Length - 1
                    If Integer.TryParse(sValues(ii), iValue) Then
                        iii = iii + 1
                    End If
                Next

                ReDim iRecord(iii - 1)

                For ii = 0 To iRecord.Length - 1
                    iRecord(ii) = sValues(ii)
                Next

                iReturnCode = fnPutResultsImportInDb(iRecord, iRelay, iEid, iCid)

                If iReturnCode <> 1 Then
                    Return iReturnCode
                End If

            End If

        Next

        Return iReturnCode

    End Function

    'Récupération des résultats individuels pour la finale
    Function fnGetIndividualFinalResults(sqlCompetitorsTable As System.Data.DataTable, iQPCid As Integer, iQSCid As Integer, iFPCid As Integer, iFSCid As Integer, dQPCValue As Decimal, dQSCValue As Decimal, dFPCValue As Decimal, dFSCValue As Decimal, iFPTTQ As Integer, iFSTTQ As Integer) As cIndividualFinalResults()

        'iQPCid = Integer Qualification Prone Competition ID
        'iQSCid = Integer Qualification Standing Competition ID
        'iFPCid = Integer Final Prone Competition ID
        'iFSCid = Integer Final Standing Competition ID

        'iFPTTQ = Integer Final Prone Targets Total Quantity
        'iFSTTQ = Integer Final Standing Targets Total Quantity

        'dQPCValue = Decimal Qualification Prone Competition Value
        'dQSCValue = Decimal Qualification Standing Competition Value
        'dFPCValue = Decimal Final Prone Competition Value
        'dFSCValue = Decimal Final Standing Competition Value

        'sQPScore = Single Qualification Prone Score
        'sQSScore = Single Qualification Standing Score
        'sFPScore = Single Final Prone Score
        'sFSScore = Single Final Standing Score

        'iQPTQ = Integer Qualification Prone Targets Quantity
        'iQSTQ = Integer Qualification Standing Targets Quantity
        'iFPTQ = Integer Final Prone Targets Quantity
        'iFSTQ = Integer Final Standing Targets Quantity

        Dim i, iQPTQ, iQSTQ, iFPTQ, iFSTQ As Integer
        Dim sQPScore, sQSScore, sFPScore, sFSScore As Single
        Dim sSql As String
        Dim sqlDtSet As System.Data.DataSet = New System.Data.DataSet
        Dim oIndividualFinalResults(sqlCompetitorsTable.Rows.Count - 1) As cIndividualFinalResults

        For i = 0 To oIndividualFinalResults.Length - 1

            oIndividualFinalResults(i) = New cIndividualFinalResults
            oIndividualFinalResults(i).CompetitorId = sqlCompetitorsTable.Rows(i)("teamCompetitorId")
            oIndividualFinalResults(i).CompetitorFirstName = sqlCompetitorsTable.Rows(i)("teamCompetitorFirstName").ToString()
            oIndividualFinalResults(i).CompetitorLastName = sqlCompetitorsTable.Rows(i)("teamCompetitorLastName").ToString()
            If sqlCompetitorsTable.Rows(i)("fkCompetitorCategoryId").ToString() = "1" Then
                oIndividualFinalResults(i).CompetitorJunior = True
            Else
                oIndividualFinalResults(i).CompetitorJunior = False
            End If
            oIndividualFinalResults(i).CompetitorRegionNameEn = sqlCompetitorsTable.Rows(i)("regionNameEn").ToString()
            oIndividualFinalResults(i).CompetitorRegionNameFr = sqlCompetitorsTable.Rows(i)("regionNameFr").ToString()
            oIndividualFinalResults(i).CompetitorRegionLetterEn = sqlCompetitorsTable.Rows(i)("regionLetterEn").ToString()
            oIndividualFinalResults(i).CompetitorRegionLetterFr = sqlCompetitorsTable.Rows(i)("regionLetterFr").ToString()

            'Récupération des résultats de la Qualification en position couchée
            sSql = "Select result From tblResults Where fkTeamCompetitorId = " & sqlCompetitorsTable.Rows(i)("teamCompetitorId") & " And fkCompetitionChapterId = " & iQPCid
            sqlDtSet.Tables.Add("QualificationProneResults_" & i).Merge(fnGetDataTableInDB(sSql))

            'Récupération des résultats de la Qualification en position debout
            sSql = "Select result From tblResults Where fkTeamCompetitorId = " & sqlCompetitorsTable.Rows(i)("teamCompetitorId") & " And fkCompetitionChapterId = " & iQSCid
            sqlDtSet.Tables.Add("QualificationStandingResults_" & i).Merge(fnGetDataTableInDB(sSql))

            'Récupération des résultats de la Finale en position couchée
            sSql = "Select result From tblResults Where fkTeamCompetitorId = " & sqlCompetitorsTable.Rows(i)("teamCompetitorId") & " And fkCompetitionChapterId = " & iFPCid & " Order By resultTargetNbr"
            sqlDtSet.Tables.Add("FinalProneResults_" & i).Merge(fnGetDataTableInDB(sSql))

            'Récupération des résultats de la Finale en position debout
            sSql = "Select result From tblResults Where fkTeamCompetitorId = " & sqlCompetitorsTable.Rows(i)("teamCompetitorId") & " And fkCompetitionChapterId = " & iFSCid & " Order By resultTargetNbr"
            sqlDtSet.Tables.Add("FinalStandingResults_" & i).Merge(fnGetDataTableInDB(sSql))

            'Calcul du pointage et de la moyenne de la Qualification en position couchée
            sQPScore = 0
            For iQPTQ = 0 To sqlDtSet.Tables("QualificationProneResults_" & i).Rows.Count - 1
                sQPScore = sQPScore + Convert.ToSingle(sqlDtSet.Tables("QualificationProneResults_" & i).Rows(iQPTQ)("result"))
            Next
            If sQPScore = 0 Then
                oIndividualFinalResults(i).QProneAverage = 0
            Else
                oIndividualFinalResults(i).QProneAverage = ((sQPScore / (iQPTQ * 100)) * (dQPCValue * 100))
            End If

            'Calcul du pointage et de la moyenne de la Qualification en position debout
            sQSScore = 0
            For iQSTQ = 0 To sqlDtSet.Tables("QualificationStandingResults_" & i).Rows.Count - 1
                sQSScore = sQSScore + Convert.ToSingle(sqlDtSet.Tables("QualificationStandingResults_" & i).Rows(iQSTQ)("result"))
            Next
            If sQSScore = 0 Then
                oIndividualFinalResults(i).QStandingAverage = 0
            Else
                oIndividualFinalResults(i).QStandingAverage = ((sQSScore / (iQSTQ * 100)) * (dQSCValue * 100))
            End If

            'Calcul du pointage et de la moyenne de la Finale en position couchée
            sFPScore = 0
            Dim sFPScores(iFPTTQ - 1) As Single
            For iFPTQ = 0 To sqlDtSet.Tables("FinalProneResults_" & i).Rows.Count - 1
                sFPScore = sFPScore + Convert.ToSingle(sqlDtSet.Tables("FinalProneResults_" & i).Rows(iFPTQ)("result"))
                sFPScores(iFPTQ) = Convert.ToSingle(sqlDtSet.Tables("FinalProneResults_" & i).Rows(iFPTQ)("result"))
            Next
            If sFPScore = 0 Then
                oIndividualFinalResults(i).FProneAverage = oIndividualFinalResults(i).QProneAverage
            Else
                oIndividualFinalResults(i).FProneAverage = (((sQPScore + sFPScore) / ((iQPTQ * 100) + (iFPTQ * 10.9))) * (dFPCValue * 100))
            End If

            'Calcul du pointage et de la moyenne de la Finale en position debout
            sFSScore = 0
            Dim sFSScores(iFSTTQ - 1) As Single
            For iFSTQ = 0 To sqlDtSet.Tables("FinalStandingResults_" & i).Rows.Count - 1
                sFSScore = sFSScore + Convert.ToSingle(sqlDtSet.Tables("FinalStandingResults_" & i).Rows(iFSTQ)("result"))
                sFSScores(iFSTQ) = Convert.ToSingle(sqlDtSet.Tables("FinalStandingResults_" & i).Rows(iFSTQ)("result"))
            Next
            If sFSScore = 0 Then
                oIndividualFinalResults(i).FStandingAverage = oIndividualFinalResults(i).QStandingAverage
            Else
                oIndividualFinalResults(i).FStandingAverage = (((sQSScore + sFSScore) / ((iQSTQ * 100) + (iFSTQ * 10.9))) * (dFSCValue * 100))
            End If

            oIndividualFinalResults(i).QProneScore = sQPScore
            oIndividualFinalResults(i).QStandingScore = sQSScore
            oIndividualFinalResults(i).FProneScore = sFPScore
            oIndividualFinalResults(i).FStandingScore = sFSScore

            oIndividualFinalResults(i).FProneScores = sFPScores
            oIndividualFinalResults(i).FStandingScores = sFSScores

            oIndividualFinalResults(i).QAvegare = oIndividualFinalResults(i).QProneAverage + oIndividualFinalResults(i).QStandingAverage
            oIndividualFinalResults(i).FAverage = oIndividualFinalResults(i).FProneAverage + oIndividualFinalResults(i).FStandingAverage

        Next

        'Trier oIndividualFinalResults par ordre décroissant
        Dim bEncore As Boolean = False
        Dim iTailleTableau As Integer = oIndividualFinalResults.Length
        Dim oIntermediaire As cIndividualFinalResults

        While Not bEncore
            bEncore = True
            For i = 0 To iTailleTableau - 2
                If oIndividualFinalResults(i).FAverage < oIndividualFinalResults(i + 1).FAverage Then
                    oIntermediaire = oIndividualFinalResults(i)
                    oIndividualFinalResults(i) = oIndividualFinalResults(i + 1)
                    oIndividualFinalResults(i + 1) = oIntermediaire
                    bEncore = False
                End If
            Next
            iTailleTableau = iTailleTableau - 1
        End While

        Return oIndividualFinalResults

    End Function


End Class


Public Class cIndividualFinalResults

    Public QProneScore As Single = 0 'Pointage total de toutes les cibles en position couchée lors de la qualification
    Public QProneAverage As Single = 0 'Note sur la valeur attibuée au tir couché (ex. note ramenée sur 89%) lors de la qualification
    Public FProneScores() As Single 'Pointages de chacun des diagrammes en position couchée lors de la finale
    Public FProneScore As Single = 0 'Pointage total des diagrammes en position couchées lors de la finale
    Public FProneAverage As Single = 0 'Note sur la valeur attibuée au tir couché (ex. note ramenée sur 89%) lors de la finale

    Public QStandingScore As Single = 0 'Pointage total de toutes les cibles en position debout lors de la qualification
    Public QStandingAverage As Single = 0 'Note sur la valeur attibuée au tir debout (ex. note ramenée sur 11%) lors de la qualification
    Public FStandingScores() As Single 'Pointages de chacun des diagrammes en position debout lors de la finale
    Public FStandingScore As Single 'Pointage total des diagrammes en position debout lors de la finale
    Public FStandingAverage As Single = 0 'Note sur la valeur attibuée au tir debout (ex. note ramenée sur 11%) lors de la finale

    Public QAvegare As Single = 0 'Note totale de la qualification
    Public FAverage As Single = 0 'Note totale de la finale

    Public CompetitorId As Integer = 0
    Public CompetitorLastName As String = ""
    Public CompetitorFirstName As String = ""
    Public CompetitorJunior As Boolean = False
    Public CompetitorRegionNameFr As String = ""
    Public CompetitorRegionNameEn As String = ""
    Public CompetitorRegionLetterFr As String = ""
    Public CompetitorRegionLetterEn As String = ""
    Public CompetitorFinalSelected As String = ""

End Class


Public Class cIndividualResults

    Public PointageCoucher As Single = 0
    Public MoyenneCoucher As Single = 0
    Public MoyenneCoucherTotal As Single = 0
    Public NbrCiblesCoucher As Integer = 0
    Public ClassementCoucherOuvert As Integer = 0
    Public ClassementCoucherJunior As Integer = 0

    Public PointageDebout As Single = 0
    Public MoyenneDebout As Single = 0
    Public MoyenneDeboutTotal As Single = 0
    Public NbrCiblesDebout As Integer = 0
    Public ClassementDeboutOuvert As Integer = 0
    Public ClassementDeboutJunior As Integer = 0

    Public MoyenneTotale As Single = 0
    Public ClassementOuvert As Integer = 0
    Public ClassementJunior As Integer = 0

    Public CompetitorId As Integer = 0
    Public CompetitorLastName As String = ""
    Public CompetitorFirstName As String = ""
    Public CompetitorRegionNameFr As String = ""
    Public CompetitorRegionNameEn As String = ""
    Public CompetitorRegionLetterFr As String = ""
    Public CompetitorRegionLetterEn As String = ""
    Public CompetitorFlag As String = ""
    Public CompetitorTeamNameFr As String = ""
    Public CompetitorTeamNameEn As String = ""
    Public CompetitorFinalSelected As String = ""

End Class

Public Class cTeamResults

    Public PointageCoucher As Single = 0
    Public MoyenneCoucher As Single = 0
    Public MoyenneCoucherTotal As Single = 0
    Public NbrCiblesCoucher As Integer = 0

    Public PointageDebout As Single = 0
    Public MoyenneDebout As Single = 0
    Public MoyenneDeboutTotal As Single = 0
    Public NbrCiblesDebout As Integer = 0

    Public PointageTotal As Single = 0
    Public MoyenneTotale As Single = 0

    Public TeamNameFr As String = ""
    Public TeamNameEn As String = ""
    Public TeamRegionNameFr As String = ""
    Public TeamRegionNameEn As String = ""
    Public TeamRegionFlag As String = ""

End Class

Public Class cRegionRanking

    Public RegionId As Integer = 0
    Public RegionValue As Single = 0
    Public RegionNameFr As String = ""
    Public RegionNameEn As String = ""
    Public RegionLetterFr As String = ""
    Public RegionLetterEn As String = ""
    Public RegionFlag As String = ""
    Public RegionWavingFlag As String = ""

End Class