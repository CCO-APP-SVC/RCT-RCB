<%@ Page Language="VB" AutoEventWireup="false" CodeFile="functions.aspx.vb" Inherits="functions" %>

<%
    Dim sSql As String
    
    Select Case Request.QueryString("fn")
    
        Case "logincheck"
            sSql = "Select * From tblUsers where userLogin='" & Request.Form("txtLogin") & "' And userPword='" & Request.Form("txtPword") & "'"
            Dim sqlDtSet As System.Data.DataSet = fnGetDataSetInDB(sSql, "Users")
            
            If sqlDtSet.Tables("Users").Rows.Count = 1 Then
                
                If sqlDtSet.Tables("Users").Rows(0)("fkUserRuleId") <> 5 Then
                    
                    Session("validuser") = "ok"
                    Session("userIdLog") = sqlDtSet.Tables("Users").Rows(0)("userId")
                    Session("userRule") = sqlDtSet.Tables("Users").Rows(0)("fkUserRuleId")
                    Session("userEventRestricted") = sqlDtSet.Tables("Users").Rows(0)("fkEventIdRestricted")
                    Session.Timeout = 120
                    Response.Redirect("default.aspx")
                    
                Else
                    Response.Redirect("login.aspx?msg=disable")
                End If
                
            Else
                Response.Redirect("login.aspx?msg=invalid")
            End If
            
        Case "RegionsEventTypeSelect"
                'Response.Write(Request.Form("slEventType"))
                Response.Redirect("admin_regions.aspx?etid=" & Request.Form("slEventType"))
        
        Case "EventCompetitionAdd"
                sSql = "Insert Into tblCompetitions (competitionNameFr, competitionNameEn, fkEventId) Values ('" & fnReplaceApostrophes(Request.Form("txtCompNameFr")) & "','" & fnReplaceApostrophes(Request.Form("txtCompNameEn")) & "'," & Request.Form("hEid") & ")"
                Dim sqlConn As System.Data.SqlClient.SqlConnection = New System.Data.SqlClient.SqlConnection(ConfigurationManager.AppSettings("sConn"))
                Dim sqlCommand As System.Data.SqlClient.SqlCommand = New System.Data.SqlClient.SqlCommand(sSql, sqlConn)
                sqlConn.Open()
                sqlCommand.ExecuteNonQuery()
                sqlCommand.CommandText = "Select @@Identity"
                Dim iCompetitionId As Integer = sqlCommand.ExecuteScalar()
                sqlConn.Close()
            
                sSql = "Select paramValue From tblParamsTexts Where paramName = 'DefaultChapterNameFrProne'"
                Dim sqlDtSet As System.Data.DataSet = fnGetDataSetInDB(sSql, "DefaultChapterNameFrProne")
                sSql = "Select paramValue From tblParamsTexts Where paramName = 'DefaultChapterNameFrStanding'"
                sqlDtSet.Tables.Add("DefaultChapterNameFrStanding").Merge(fnGetDataTableInDB(sSql))
                sSql = "Select paramValue From tblParamsTexts Where paramName = 'DefaultChapterNameEnProne'"
                sqlDtSet.Tables.Add("DefaultChapterNameEnProne").Merge(fnGetDataTableInDB(sSql))
                sSql = "Select paramValue From tblParamsTexts Where paramName = 'DefaultChapterNameEnStanding'"
                sqlDtSet.Tables.Add("DefaultChapterNameEnStanding").Merge(fnGetDataTableInDB(sSql))
                sSql = "Select paramValue From tblParamsNumeric Where paramName = 'DefaultChapterProneValue'"
                sqlDtSet.Tables.Add("DefaultChapterProneValue").Merge(fnGetDataTableInDB(sSql))
                sSql = "Select paramValue From tblParamsNumeric Where paramName = 'DefaultChapterStandingValue'"
                sqlDtSet.Tables.Add("DefaultChapterStandingValue").Merge(fnGetDataTableInDB(sSql))
            
                fnExecuteNonQueryInDB("Insert Into tblCompetitionsChapters (competitionChapterNameFr, competitionChapterNameEn, competitionChapterValue, fkCompetitionTypeId, fkCompetitionId) Values ('" & fnReplaceApostrophes(sqlDtSet.Tables("DefaultChapterNameFrStanding").Rows(0)(0)) & "', '" & fnReplaceApostrophes(sqlDtSet.Tables("DefaultChapterNameEnStanding").Rows(0)(0)) & "', " & sqlDtSet.Tables("DefaultChapterStandingValue").Rows(0)(0).ToString().Replace(",", ".") & ", 1, " & iCompetitionId & ")")
                fnExecuteNonQueryInDB("Insert Into tblCompetitionsChapters (competitionChapterNameFr, competitionChapterNameEn, competitionChapterValue, fkCompetitionTypeId, fkCompetitionId) Values ('" & fnReplaceApostrophes(sqlDtSet.Tables("DefaultChapterNameFrProne").Rows(0)(0)) & "', '" & fnReplaceApostrophes(sqlDtSet.Tables("DefaultChapterNameEnProne").Rows(0)(0)) & "', " & sqlDtSet.Tables("DefaultChapterProneValue").Rows(0)(0).ToString().Replace(",", ".") & ", 2, " & iCompetitionId & ")")
           
                Response.Redirect("event_profile.aspx?eid=" & Request.Form("hEid"))
        
        Case "EventCompetitionEdit"
                sSql = "Update tblCompetitions Set competitionNameFr='" & fnReplaceApostrophes(Request.Form("txtCompNameFr")) & "', competitionNameEn='" & fnReplaceApostrophes(Request.Form("txtCompNameEn")) & "' Where competitionId =" & Request.Form("hCid")
                fnExecuteNonQueryInDB(sSql)
                Response.Redirect("event_profile.aspx?eid=" & Request.Form("hEid"))
            
        Case "EventCompetitionDel"
                sSql = "Delete From tblCompetitions Where competitionId=" & Request.QueryString("cid")
                fnExecuteNonQueryInDB(sSql)
                Response.Redirect("event_profile.aspx?eid=" & Request.QueryString("eid"))
        
        Case "EventAdd"
                sSql = "Insert Into tblEvents (eventNameFr, eventNameEn, eventStartDate, eventEndDate, eventLocation, fkEventTypeId) Values ('" & fnReplaceApostrophes(Request.Form("txtEventNameFr")) & "','" & fnReplaceApostrophes(Request.Form("txtEventNameEn")) & "', Convert(DateTime,'" & Request.Form("txtEventStartDate") & "',111), Convert(DateTime,'" & Request.Form("txtEventEndDate") & "',111),'" & fnReplaceApostrophes(Request.Form("txtEventLocation")) & "'," & Request.Form("slEventType") & ")"
                fnExecuteNonQueryInDB(sSql)
                Response.Redirect("events.aspx?msg=a")
            
        Case "EventEdit"
                sSql = "Update tblEvents Set eventNameFr='" & fnReplaceApostrophes(Request.Form("txtEventNameFr")) & "', eventNameEn='" & fnReplaceApostrophes(Request.Form("txtEventNameEn")) & "', eventStartDate=Convert(DateTime,'" & Request.Form("txtEventStartDate") & "',111), eventEndDate=Convert(DateTime,'" & Request.Form("txtEventEndDate") & "',111), eventLocation='" & fnReplaceApostrophes(Request.Form("txtEventLocation")) & "', fkEventTypeId=" & Request.Form("slEventType") & " Where eventId=" & Request.Form("hEid")
                fnExecuteNonQueryInDB(sSql)
                Response.Redirect("event_profile.aspx?eid=" & Request.Form("hEid"))
        
        Case "EventDel"
                sSql = "Delete From tblEvents Where eventId=" & Request.QueryString("eid")
                fnExecuteNonQueryInDB(sSql)
                Response.Redirect("events.aspx?msg=d")
            
        Case "EventRegionsEdit"

                Dim i As Integer
                Dim ii As Integer
                Dim strValues(Request.Form.Count - 2, 3) As String
                Dim strValuesBefore(Request.Form("hdValuesBefore").Substring(0, Request.Form("hdValuesBefore").Length - 1).Split(":").Length, 3) As String
            
                For i = 0 To Request.Form("hdValuesBefore").Substring(0, Request.Form("hdValuesBefore").Length - 1).Split(":").Length - 1
                    strValuesBefore(i, 0) = Request.Form("hdValuesBefore").Substring(0, Request.Form("hdValuesBefore").Length - 1).Split(":")(i).Split("_")(0)
                    strValuesBefore(i, 1) = Request.Form("hdValuesBefore").Substring(0, Request.Form("hdValuesBefore").Length - 1).Split(":")(i).Split("_")(1)
                    strValuesBefore(i, 2) = Request.Form("hdValuesBefore").Substring(0, Request.Form("hdValuesBefore").Length - 1).Split(":")(i).Split("_")(2)
                Next
            
                For i = 0 To Request.Form.Count - 1
                    If Request.Form(i).Substring(0, 2).ToString = "cb" Then
                        strValues(i, 0) = Request.Form(i).Split("_")(0)
                        strValues(i, 1) = Request.Form(i).Split("_")(1)
                        strValues(i, 2) = Request.Form(i).Split("_")(2)
                    End If
                Next
            
                'Association des régions
                For i = 0 To strValues.GetLength(0) - 1
                    For ii = 0 To strValuesBefore.GetLength(0) - 1
                        If strValues(i, 1) = strValuesBefore(ii, 1) Then
                            If strValuesBefore(ii, 2) = "NO" Then
                                fnAssociateRegionToEvent(Request.QueryString("eid"), strValues(i, 1))
                            End If
                        End If
                    Next
                Next
            
                'Dissocier des régions
                Dim blRemove As Boolean
                For i = 0 To strValuesBefore.GetLength(0) - 1
                    If strValuesBefore(i, 2) = "YES" Then
                        blRemove = True
                        For ii = 0 To strValues.GetLength(0) - 1
                            If strValuesBefore(i, 1) = strValues(ii, 1) Then
                                blRemove = False
                            End If
                        Next
                        If blRemove Then
                            fnDissociateRegionToEvent(Request.QueryString("eid"), strValuesBefore(i, 1))
                        End If
                    End If
                Next
            
                Response.Redirect("event_profile.aspx?eid=" & Request.QueryString("eid"))
        
        Case "Region_Add"
                sSql = "Insert Into tblRegions (regionNameFr, regionNameEn, regionLetterFr, regionLetterEn, regionFlagLogo, fkEventTypeId) Values ('" & fnReplaceApostrophes(Request.Form("txtRegionNameFr")) & "','" & fnReplaceApostrophes(Request.Form("txtRegionNameEn")) & "','" & fnReplaceApostrophes(Request.Form("txtLetterFr")) & "','" & fnReplaceApostrophes(Request.Form("txtLetterEn")) & "','" & fnReplaceApostrophes(Request.Form("txtFlagLogo")) & "'," & Request.Form("slEventType") & ")"
                fnExecuteNonQueryInDB(sSql)
                Response.Redirect("admin_regions.aspx?etid=" & Request.QueryString("etid"))
            
        Case "Region_Edit"
                sSql = "Update tblRegions Set regionNameFr='" & fnReplaceApostrophes(Request.Form("txtRegionNameFr")) & "', regionNameEn='" & fnReplaceApostrophes(Request.Form("txtRegionNameEn")) & "', regionLetterFr='" & fnReplaceApostrophes(Request.Form("txtLetterFr")) & "', regionLetterEn='" & fnReplaceApostrophes(Request.Form("txtLetterEn")) & "', regionFlagLogo='" & fnReplaceApostrophes(Request.Form("txtFlagLogo")) & "', fkEventTypeId=" & Request.Form("slEventType") & " Where regionId=" & Request.QueryString("rid")
                fnExecuteNonQueryInDB(sSql)
                Response.Redirect("admin_regions.aspx?etid=" & Request.QueryString("etid"))
        
        Case "Region_Delete"
                sSql = "Delete From tblRegions Where regionId=" & Request.QueryString("rid")
                fnExecuteNonQueryInDB(sSql)
                Response.Redirect("admin_regions.aspx?etid=" & Request.QueryString("etid"))
        
        Case "EventRegionTeamAdd"
            
                If fnEventRegionTeamValidSerial(Convert.ToInt16(Request.Form("txtTeamSerial")), Convert.ToInt16(Request.Form("hEid"))) Then
            
                    sSql = "Insert Into tblTeams (teamSerial, teamNameFr, teamNameEn, fkTeamTypeId, fkRegionEventId) Values (" & Request.Form("txtTeamSerial") & ",'" & fnReplaceApostrophes(Request.Form("txtTeamNameFr")) & "','" & fnReplaceApostrophes(Request.Form("txtTeamNameEn")) & "'," & Request.Form("sTeamTypeId") & "," & Request.Form("hReid") & ")"
                    Dim sqlConn As System.Data.SqlClient.SqlConnection = New System.Data.SqlClient.SqlConnection(ConfigurationManager.AppSettings("sConn"))
                    Dim sqlCommand As System.Data.SqlClient.SqlCommand = New System.Data.SqlClient.SqlCommand(sSql, sqlConn)
                    sqlConn.Open()
                    sqlCommand.ExecuteNonQuery()
                    sqlCommand.CommandText = "Select @@Identity"
                    Dim iTeamId As Integer = sqlCommand.ExecuteScalar()
                    sqlConn.Close()
                
                    'Création des 5 Compétiteurs de l'équipe
                    fnExecuteNonQueryInDB("Insert Into tblTeamsCompetitors (teamCompetitorSerial,fkTeamId) Values (" & Request.Form("txtTeamSerial") & "1," & iTeamId & ")")
                    fnExecuteNonQueryInDB("Insert Into tblTeamsCompetitors (teamCompetitorSerial,fkTeamId) Values (" & Request.Form("txtTeamSerial") & "2," & iTeamId & ")")
                    fnExecuteNonQueryInDB("Insert Into tblTeamsCompetitors (teamCompetitorSerial,fkTeamId) Values (" & Request.Form("txtTeamSerial") & "3," & iTeamId & ")")
                    fnExecuteNonQueryInDB("Insert Into tblTeamsCompetitors (teamCompetitorSerial,fkTeamId) Values (" & Request.Form("txtTeamSerial") & "4," & iTeamId & ")")
                    fnExecuteNonQueryInDB("Insert Into tblTeamsCompetitors (teamCompetitorSerial,fkTeamId) Values (" & Request.Form("txtTeamSerial") & "5," & iTeamId & ")")
                
                    Response.Redirect("event_region_team_edit.aspx?eid=" & Request.Form("hEid") & "&rid=" & Request.Form("hRid") & "&reid=" & Request.Form("hReid") & "&tid=" & iTeamId)
        
                Else
                
                    Response.Redirect("event_region_team_add.aspx?eid=" & Request.Form("hEid") & "&rid=" & Request.Form("hRid") & "&reid=" & Request.Form("hReid") & "&msg=1")
                
                End If
                
                
        Case "EventRegionTeamEdit"
            
                Dim bValidTeamSerial As Boolean
            
                If Convert.ToInt16(Request.Form("hOldTeamSerial")) = Convert.ToInt16(Request.Form("txtTeamSerial")) Then
                    bValidTeamSerial = True
                Else
                    bValidTeamSerial = fnEventRegionTeamValidSerial(Convert.ToInt16(Request.Form("txtTeamSerial")), Convert.ToInt16(Request.Form("hEid")))
                End If
            
                If bValidTeamSerial Then
                    sSql = "Update tblTeams Set teamNameFr='" & fnReplaceApostrophes(Request.Form("txtTeamNameFr")) & "', teamNameEn='" & fnReplaceApostrophes(Request.Form("txtTeamNameEn")) & "', teamSerial=" & fnReplaceApostrophes(Request.Form("txtTeamSerial")) & ", fkTeamTypeId=" & Request.Form("sTeamTypeId") & " Where teamId=" & Request.Form("hTid")
                    fnExecuteNonQueryInDB(sSql)
                
                    fnEventRegionTeamEditChangeTeamCompetitorsSerials(Convert.ToInt16(Request.Form("hTid")), Convert.ToInt16(Request.Form("txtTeamSerial")))
                
                    Response.Redirect("event_region_teams.aspx?eid=" & Request.Form("hEid") & "&rid=" & Request.Form("hRid") & "&reid=" & Request.Form("hReid"))
                Else
                    Response.Redirect("event_region_team_edit.aspx?eid=" & Request.Form("hEid") & "&rid=" & Request.Form("hRid") & "&reid=" & Request.Form("hReid") & "&tid=" & Request.Form("hTid") & "&msg=1")
                End If
            
        Case "EventRegionTeamDel"
                sSql = "Delete From tblTeams Where teamId=" & Request.QueryString("tid")
                fnExecuteNonQueryInDB(sSql)
                Response.Redirect("event_region_teams.aspx?eid=" & Request.QueryString("eid") & "&rid=" & Request.QueryString("rid") & "&reid=" & Request.QueryString("reid"))
        
        Case "EventRegionTeamCompetitorAdd"
                sSql = "Insert Into tblTeamsCompetitors (teamCompetitorSerial, teamCompetitorFirstName, teamCompetitorLastName, teamCompetitorUnit, teamCompetitorBirthDate, fkGenderId, fkCompetitorCategoryId, fkTeamId) Values (" & Request.Form("txtTeamCompetitorSerial") & ",'" & fnReplaceApostrophes(Request.Form("txtTeamCompetitorFirstName")) & "','" & fnReplaceApostrophes(Request.Form("txtTeamCompetitorLastName")) & "','" & fnReplaceApostrophes(Request.Form("txtTeamCompetitorUnit")) & "',Convert(DateTime,'" & Request.Form("txtTeamCompetitorBirthDate") & "',111)," & Request.Form("sGenderId") & "," & Request.Form("sCompetitorCategoryId") & "," & Request.Form("hTid") & ")"
                fnExecuteNonQueryInDB(sSql)
                Response.Redirect("event_region_team_edit.aspx?eid=" & Request.Form("hEid") & "&rid=" & Request.Form("hRid") & "&reid=" & Request.Form("hReid") & "&tid=" & Request.Form("hTid"))
        
        Case "EventRegionTeamCompetitorEdit"
                sSql = "Update tblTeamsCompetitors Set teamCompetitorFirstName='" & fnReplaceApostrophes(Request.Form("txtTeamCompetitorFirstName")) & "', teamCompetitorLastName='" & fnReplaceApostrophes(Request.Form("txtTeamCompetitorLastName")) & "', teamCompetitorBirthDate=Convert(DateTime,'" & Request.Form("txtTeamCompetitorBirthDate") & "',111), teamCompetitorUnit='" & fnReplaceApostrophes(Request.Form("txtTeamCompetitorUnit")) & "', teamCompetitorSerial=" & fnReplaceApostrophes(Request.Form("txtTeamCompetitorSerial")) & ", fkGenderId=" & Request.Form("sGenderId") & ", fkCompetitorCategoryId=" & Request.Form("sCompetitorCategoryId") & " Where teamCompetitorId=" & Request.Form("hTcid")
                fnExecuteNonQueryInDB(sSql)
                Response.Redirect("event_region_team_edit.aspx?eid=" & Request.Form("hEid") & "&rid=" & Request.Form("hRid") & "&reid=" & Request.Form("hReid") & "&tid=" & Request.Form("hTid"))
            
        Case "EventRegionTeamCompetitorDel"
                sSql = "Delete From tblTeamsCompetitors Where teamCompetitorId=" & Request.QueryString("tcid")
                fnExecuteNonQueryInDB(sSql)
                Response.Redirect("event_region_team_edit.aspx?eid=" & Request.QueryString("eid") & "&rid=" & Request.QueryString("rid") & "&reid=" & Request.QueryString("reid") & "&tid=" & Request.QueryString("tid"))
            
        Case "ResultsAdd"
            
                Dim iMsgNumber As Integer
                Dim strValues(3) As String

                strValues(0) = Request.Form("txtResultTargetSerial").Substring(0, 2)
                strValues(1) = Request.Form("txtResultTargetSerial").Substring(0, 3)
                strValues(2) = Request.Form("txtResultTargetSerial").Substring(3, 2)
            
                Dim iTeamId As Integer = fnResultsAddValidTeamSerial(Convert.ToInt16(strValues(0)), Request.Form("hEid"))
                Dim iTeamCompetitorId As Integer = fnResultsAddValidCompetitorSerial(Convert.ToInt16(strValues(1)), iTeamId)
                Dim bValidTargetNumer As Boolean = fnResultsAddValidTargetNumber(Convert.ToInt16(strValues(1)), Convert.ToInt16(strValues(2)), Request.Form("hCid"))
            
                If iTeamId <> 0 And iTeamCompetitorId <> 0 And Not bValidTargetNumer Then
            
                    sSql = "Insert Into tblResults (result, resultTargetSerial, resultDateTimeInsert, resultTargetNbr, resultTeamSerial, resultTeamCompetitorSerial, fkTeamCompetitorId, fkCompetitionChapterId, fkUserId) Values (" & Request.Form("txtResult") & ",'" & fnReplaceApostrophes(Request.Form("txtResultTargetSerial")) & "', GETDATE(), " & strValues(2) & ", " & strValues(0) & ", " & strValues(1) & ", " & iTeamCompetitorId & ", " & Request.Form("hCid") & ", " & Session("userIdLog") & ")"
                    fnExecuteNonQueryInDB(sSql)
                    Response.Redirect("results_add.aspx?eid=" & Request.Form("hEid") & "&cid=" & Request.Form("hCid"))
        
                ElseIf iTeamId = 0 Then
                    iMsgNumber = 1
                ElseIf iTeamCompetitorId = 0 Then
                    iMsgNumber = 2
                ElseIf bValidTargetNumer Then
                    iMsgNumber = 3
                Else
                    iMsgNumber = 4
                End If
            
                Response.Redirect("results_add.aspx?eid=" & Request.Form("hEid") & "&cid=" & Request.Form("hCid") & "&msg=" & iMsgNumber & "&ts=" & Request.Form("txtResultTargetSerial") & "&rs=" & Request.Form("txtResult"))
                
        Case "ResultEdit"
            
                sSql = "Update tblResults Set result=" & Request.Form("txtResult") & " Where resultId=" & Request.Form("hTid")
                fnExecuteNonQueryInDB(sSql)
                Response.Redirect("results_search.aspx?eid=" & Request.Form("hEid") & "&cid=" & Request.Form("hCid") & "&sts=" & Request.Form("hTs"))
            
        Case "ResultsImport"
        
                Dim iResponse As Integer = fnResultsImport(Request.Form("txtCSV"), Request.Form("hEid"), Request.Form("hCid"))
                Response.Redirect("results_import.aspx?eid=" & Request.Form("hEid") & "&cid=" & Request.Form("hCid") & "&msg=" & iResponse)

        Case "ShowPublicResults"
            
                If Request.QueryString("spr") = "False" Or Request.QueryString("spr") = "0" Then
                    sSql = "Update tblEvents Set eventShowPublicResults = 1 Where eventId = " & Request.QueryString("eid")
                Else
                    sSql = "Update tblEvents Set eventShowPublicResults = 0 Where eventId = " & Request.QueryString("eid")
                End If
            
                fnExecuteNonQueryInDB(sSql)
                Response.Redirect("event_profile.aspx?eid=" & Request.QueryString("eid"))
                
        
        Case "UserAdd"
            
            sSql = "Insert Into tblUsers (userFirstName, userLastName, userLogin, userPword, fkUserRuleId, fkEventIdRestricted) Values ('" & Request.Form("txtUserFirstName") & "', '" & Request.Form("txtUserLastName") & "', '" & Request.Form("txtUserLogin") & "', '" & Request.Form("txtUserPword") & "', " & Request.Form("sUserRule") & ", " & Request.Form("sUserRestriction") & ")"
            fnExecuteNonQueryInDB(sSql)
            Response.Redirect("admin_users.aspx")
        
        Case "UserEdit"
            
            sSql = "Update tblUsers Set userFirstName = '" & Request.Form("txtUserFirstName") & "', userLastName = '" & Request.Form("txtUserLastName") & "', userLogin = '" & Request.Form("txtUserLogin") & "', userPword = '" & Request.Form("txtUserPword") & "', fkUserRuleId = " & Request.Form("sUserRule") & ", fkEventIdRestricted = " & Request.Form("sUserRestriction") & " Where userId = " & Request.Form("hUid")
            fnExecuteNonQueryInDB(sSql)
            Response.Redirect("admin_users.aspx")
        
        Case "UserDel"
            
            sSql = "Delete From tblUsers Where userId=" & Request.QueryString("uid")
            fnExecuteNonQueryInDB(sSql)
            Response.Redirect("admin_users.aspx")
            
        Case "EventCompetitionChapterEdit"
            
            Dim sCompetitionChapterValue As String = Request.Form("txtCompetitionChapterValue").Replace(",", ".")
            sSql = "Update tblCompetitionsChapters Set competitionChapterNameFr = '" & Request.Form("txtCompetitionChapterNameFr") & "', competitionChapterNameEn = '" & Request.Form("txtCompetitionChapterNameEn") & "', competitionChapterValue = " & sCompetitionChapterValue & ", competitionChapterNbrTargets = " & Request.Form("txtCompetitionChapterNbrTargets") & ", fkCompetitionTypeId = " & Request.Form("sCompetitionType") & " Where competitionChapterId = " & Request.Form("hCHid")
            fnExecuteNonQueryInDB(sSql)
            Response.Redirect("event_competition_edit.aspx?eid=" & Request.Form("hEid") & "&cid=" & Request.Form("hCid"))
            
        Case "FinalistSelected"
            
            sSql = "Update tblTeamsCompetitors Set teamCompetitorFinalSelected = " & Request.QueryString("tcfs") & " Where teamCompetitorId = " & Request.QueryString("tcid")
            fnExecuteNonQueryInDB(sSql)
            Response.Redirect("event_finalists_selection.aspx?eid=" & Request.QueryString("eid") & "&cid=" & Request.QueryString("cid"))
            'Response.Write("event_finalists_selection.aspx?eid=" & Request.QueryString("eid") & "cid=" & Request.QueryString("cid"))
            
        Case "ResultsFinalSaveLines"
            
            sSql = "Delete From tblFinalsLines Where fkCompetitionChapterId = " & Request.Form("hCid")
            fnExecuteNonQueryInDB(sSql)
            
            Dim i As Integer
            Dim iFinalists As Integer = Convert.ToInt16(Request.Form("hNbr"))
            
            For i = 0 To iFinalists - 1
                sSql = "Insert Into tblFinalsLines (fkCompetitionChapterId, fkTeamCompetitorId, finalLine) Values (" & Request.Form("hCid") & ", " & Request.Form("hTcid_" & i) & ", " & Request.Form("txtLine_" & i) & ")"
                fnExecuteNonQueryInDB(sSql)
                'Response.Write(sSql & "<br>")
            Next
            
            Response.Redirect("results_add_final.aspx?eid=" & Request.Form("hEid") & "&cid=" & Request.Form("hCid"))
        
        Case "ResultsFinalAdd"
            
            Dim i As Integer
            Dim iFinalists As Integer = Convert.ToInt16(Request.Form("hRnbr"))
            Dim strValues(3) As String
            Dim iTeamId As Integer
            Dim iTeamCompetitorId As Integer
            Dim bValidTargetNumer As Boolean
            Dim sqlDtSet As System.Data.DataSet = New System.Data.DataSet
            
            For i = 0 To iFinalists - 1
                strValues(0) = Request.Form("hTargetSerial_" & i).Substring(0, 2)
                strValues(1) = Request.Form("hTargetSerial_" & i).Substring(0, 3)
                strValues(2) = Request.Form("hTargetSerial_" & i).Substring(3, 2)
                
                iTeamId = fnResultsAddValidTeamSerial(Convert.ToInt16(strValues(0)), Request.Form("hReid"))
                iTeamCompetitorId = fnResultsAddValidCompetitorSerial(Convert.ToInt16(strValues(1)), iTeamId)
                bValidTargetNumer = fnResultsAddValidTargetNumber(Convert.ToInt16(strValues(1)), Convert.ToInt16(strValues(2)), Request.Form("hRcid"))
                
                sSql = "Select * From tblResults Where fkCompetitionChapterId = " & Request.Form("hRcid") & " And resultTargetSerial = '" & Request.Form("hTargetSerial_" & i) & "'"
                sqlDtSet.Tables.Add("Result_" & i).Merge(fnGetDataTableInDB(sSql))
                
                If sqlDtSet.Tables("Result_" & i).Rows.Count = 0 Then
                    sSql = "Insert Into tblResults (result, resultTargetSerial, resultDateTimeInsert, resultTargetNbr, resultTeamSerial, resultTeamCompetitorSerial, fkTeamCompetitorId, fkCompetitionChapterId, fkUserId) Values (" & Request.Form("txtScore_" & i).ToString().Replace(",", ".") & ",'" & fnReplaceApostrophes(Request.Form("hTargetSerial_" & i)) & "', GETDATE(), " & strValues(2) & ", " & strValues(0) & ", " & strValues(1) & ", " & iTeamCompetitorId & ", " & Request.Form("hRcid") & ", " & Session("userIdLog") & ")"
                Else
                    sSql = "Update tblResults Set result = " & Request.Form("txtScore_" & i).ToString().Replace(",", ".") & " Where fkCompetitionChapterId = " & Request.Form("hRcid") & " And resultTargetSerial = '" & Request.Form("hTargetSerial_" & i) & "'"
                End If
                
                fnExecuteNonQueryInDB(sSql)
            Next
            
            If Convert.ToInt16(Request.Form("hTnbr")) = Convert.ToInt16(Request.Form("hNbrTargets")) Then
                Response.Redirect("results_add_final.aspx?eid=" & Request.Form("hReid") & "&cid=" & Request.Form("hRcid") & "&tnbr=1&msg=1")
            Else
                Response.Redirect("results_add_final.aspx?eid=" & Request.Form("hReid") & "&cid=" & Request.Form("hRcid") & "&tnbr=" & Convert.ToInt16(Request.Form("hTnbr")) + 1) 
            End If

        Case Else
            
            Response.Redirect("login.aspx")
             
    End Select
    
    
%>