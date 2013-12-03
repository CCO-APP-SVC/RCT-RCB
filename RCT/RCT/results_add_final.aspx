<%@ Page Language="VB" AutoEventWireup="false" CodeFile="functions.aspx.vb" Inherits="functions" %>

<!--#include file="inc_top.aspx"-->
 
 <table border="0" cellpadding="0" cellspacing="0" class="TXTNormal">
    <tr>
        <td width="170" height="<% Response.Write(fnGetParamNumeric("HeightTableMenuLeft")) %>" align="center" valign="top">
            <!-- ====================================== -->
            <!-- ===== MENU DE LA SECTION RESULTS ===== -->
            
            <!-- #include file="inc_menu_results.aspx" -->

            <!-- ===== MENU DE LA SECTION RESULTS ===== -->
            <!-- ====================================== -->
        </td>
        <td class="LineVertico1PX"></td>
        <td width="827" align="center" valign="top">
        <br />

            <!-- ==================================================================== -->
            <!-- ===== TABLEAU DE SÉLECTION DE L'ÉVÉNEMENT ET DE LA COMPÉTITION ===== -->

            <% 
                
                Dim sSql As String
                    If Session("userEventRestricted") <> 0 Then
                        sSql = "Select * From vwEventsEventsTypes Where eventId = " & Session("userEventRestricted") & " Order By eventNameFr"
                    Else
                        sSql = "Select * From vwEventsEventsTypes Order By eventNameFr"
                    End If
                
                Dim sqlDtSet As System.Data.DataSet = fnGetDataSetInDB(sSql, "Events")

                Dim sEid, sCid, sMsg, sLines, sTnbr, sSerial, sSerialFinalist, sTargetSerial, sTargetSelected, sResult As String
                Dim sColorEid, sColorCid As String
                Dim sSelected As String
                Dim i As Integer

                sEid = Request.QueryString("eid")
                sCid = Request.QueryString("cid")
                sLines = Request.QueryString("lines")
                sTnbr = Request.QueryString("tnbr")

                sMsg = Request.QueryString("msg")
                
                If String.IsNullOrEmpty(sEid) Then
                    sEid = "0"
                End If
                If String.IsNullOrEmpty(sCid) Then
                    sCid = "0"
                End If
                If String.IsNullOrEmpty(sMsg) Then
                    sMsg = "0"
                End If
                If String.IsNullOrEmpty(sLines) Then
                    sLines = "0"
                End If
                If String.IsNullOrEmpty(sTnbr) Then
                    sTnbr = "1"
                End If

                If sEid = "0" Then
                    sColorEid = "#ffA0A0"
                Else
                    sColorEid = "#c0c0c0"
                End If

                if sCid = "0" Then
                    sColorCid = "#ffA0A0"
                Else
                    sColorCid = "#c0c0c0"
                End If


            %>
            <table border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td colspan="7" class="LineHorizo1PX"></td>
                <tr>
                    <td height="30" class="LineVertico1PX"></td>
                    <td width="10" align="center" valign="middle" bgcolor="#c0c0c0"></td>
                    <td class="LineVertico1PX"></td>
                    <td width="759" align="left" valign="middle" bgcolor="#c0c0c0">&nbsp;<b>Results entry : Final</b><br />&nbsp;<b>Saisie des r&eacute;sultats : Finale</b></td>
                    <td class="LineVertico1PX"></td>
                <tr>
                    <td colspan="7" class="LineHorizo1PX"></td>
            </table>
            <br />

            <table border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td colspan="7" class="LineHorizo1PX"></td>
                <tr>
                    <td height="30" class="LineVertico1PX"></td>
                    <td width="10" align="center" valign="middle" bgcolor="#c0c0c0"></td>
                    <td class="LineVertico1PX"></td>
                    <td width="373" align="left" valign="middle" bgcolor="<% Response.Write(sColorEid) %>">&nbsp;<b>Select an event</b><br />&nbsp;<b>S&eacute;lectionnez un &eacute;v&eacute;nement</b></td>
                    <td class="LineVertico1PX"></td>
                    <td width="385" align="center" valign="middle">
                        <select name="sEvents" id="sEvents" style="width: 365px" class="FormTextBox" onchange="fnResultsFinalAddEventSelect(this.value);">
                            <option value="0">Select an event - S&eacute;lectionnez un &eacute;v&eacute;nement</option>
                            <option disabled>--------------------</option>
                        <%
                            For i = 0 To sqlDtSet.Tables("Events").Rows.Count - 1
                                If sEid = sqlDtSet.Tables("Events").Rows(i)("eventId").ToString() Then
                                    sSelected = "selected='selected'"
                                Else
                                    sSelected = ""
                                End If
                        %>
                            <option value="<% Response.Write(sqlDtSet.Tables("Events").Rows(i)("eventId")) %>" <% Response.Write(sSelected) %>><% Response.Write(sqlDtSet.Tables("Events").Rows(i)("eventNameFr")) %></option>
                        <% Next %>
                        </select>
                    </td>
                    <td class="LineVertico1PX"></td>
                <tr>
                    <td colspan="7" class="LineHorizo1PX"></td>
            </table>
            <br />
            
            <% If sEid <> "0" Then%>

            <%
                sSql = "Select * From tblCompetitionsChapters Join tblCompetitions On tblCompetitionsChapters.fkCompetitionId=tblCompetitions.competitionId Where fkEventId = " & sEid
                sqlDtSet.Tables.Add("Competitions").Merge(fnGetDataTableInDB(sSql))
               
            %>
            <table border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td colspan="7" class="LineHorizo1PX"></td>
                <tr>
                    <td height="30" class="LineVertico1PX"></td>
                    <td width="10" align="center" valign="middle" bgcolor="#c0c0c0"></td>
                    <td class="LineVertico1PX"></td>
                    <td width="373" align="left" valign="middle" bgcolor="<% Response.Write(sColorCid) %>">&nbsp;<b>Select a competition</b><br />&nbsp;<b>S&eacute;lectionnez une comp&eacute;tition</b></td>
                    <td class="LineVertico1PX"></td>
                    <td width="385" align="center" valign="middle">
                        <select name="sCompetitions" id="sCompetitions" style="width: 365px" class="FormTextBox" onchange="fnResultsFinalAddCompetitionSelect(this.value,<% Response.Write(sEid) %>)">
                            <option value="0">Select a competition - S&eacute;lectionnez une comp&eacute;tition</option>
                            <option disabled>--------------------</option>
                            <% 
                                For i = 0 To sqlDtSet.Tables("Competitions").Rows.Count - 1
                                    If sCid = sqlDtSet.Tables("Competitions").Rows(i)("competitionChapterId").ToString() Then
                                        sSelected = "selected='selected'"
                                    Else
                                        sSelected = ""
                                    End If
                            %>
                            <option value="<% Response.Write(sqlDtSet.Tables("Competitions").Rows(i)("competitionChapterId")) %>" <% Response.Write(sSelected) %>><% Response.Write(sqlDtSet.Tables("Competitions").Rows(i)("competitionNameFr")) %> - <% Response.Write(sqlDtSet.Tables("Competitions").Rows(i)("competitionChapterNameFr")) %></option>
                            <% Next%>
                        </select>
                    </td>
                    <td class="LineVertico1PX"></td>
                <tr>
                    <td colspan="7" class="LineHorizo1PX"></td>
            </table>

            <% End If %>

            <!-- ===== TABLEAU DE SÉLECTION DE L'ÉVÉNEMENT ET DE LA COMPÉTITION ===== -->
            <!-- ==================================================================== -->

            
    <% If sCid <> "0" Then %>
    <!-- ===================================================== -->
    <!-- ===== TABLEAU D'ASSIGNATION DES COULOIRS DE TIR ===== -->

    <br />
    <%  
        sSql = "Select * From tblTeamsCompetitors Inner Join tblTeams On tblTeamsCompetitors.fkTeamId=tblTeams.teamId Inner Join tblRegionsEvents On tblTeams.fkRegionEventId=tblRegionsEvents.regionEventId Inner Join tblRegions On tblRegionsEvents.fkRegionId=tblRegions.regionId Where fkEventId = " & sEid & " And teamCompetitorFinalSelected = 1"
        sqlDtSet.Tables.Add("Finalists").Merge(fnGetDataTableInDb(sSql))
    
        sSql = "Select * From tblFinalsLines Where fkCompetitionChapterId = " & sCid
        sqlDtSet.Tables.Add("Lines").Merge(fnGetDataTableInDb(sSql))

        If sqlDtSet.Tables("Finalists").Rows.Count <> sqlDtSet.Tables("Lines").Rows.Count Then
    %>

    <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td colspan="3" class="LineHorizo1PXRed"></td>
        <tr>
            <td height="50" class="LineVertico1PXRed"></td>
            <td width="770" bgcolor="#ffA0A0" align="left" valign="middle">
                <br />
                &nbsp;<b>ATTENTION</b> :<br />
                <br />
                &nbsp;You must assign a shooting line for each shooter before begin with the result entries.<br />
                &nbsp;Vous devez assigner un couloir de tir pour chaque comp&eacute;titeurs avant de d&eacute;buter l'entr&eacute;e des r&eacute;sultats.<br />
                <br />
            </td>
            <td class="LineVertico1PXRed"></td>
        <tr>
            <td colspan="3" class="LineHorizo1PXRed"></td>
    </table>

    <% End If %>
    <% If (sqlDtSet.Tables("Finalists").Rows.Count <> sqlDtSet.Tables("Lines").Rows.Count) Or (sLines = "1") Then %>
    <br />
    <form name="frmLines" id="frmLines" method="post" enctype="multipart/form-data" action="functions.aspx?fn=ResultsFinalSaveLines">
        <input type="hidden" name="hEid" id="hEid" value="<% Response.Write(sEid) %>" />
        <input type="hidden" name="hCid" id="hCid" value="<% Response.Write(sCid) %>" />
        <input type="hidden" name="hNbr" id="hNbr" value="<% Response.Write(sqlDtSet.Tables("Finalists").Rows.Count) %>" />
    <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td colspan="7" class="LineHorizo1PX"></td>
        <tr>
            <td height="30" class="LineVertico1PX"></td>
            <td width="10" align="center" valign="middle" bgcolor="#c0c0c0"></td>
            <td class="LineVertico1PX"></td>
            <td width="673" align="left" valign="middle" bgcolor="#c0c0c0">&nbsp;<b>Shooting lines assignment</b><br />&nbsp;<b>Assignation des couloirs de tir</b></td>
            <td class="LineVertico1PX"></td>
            <td width="85" align="center" valign="middle" bgcolor="#ffffff">
                <input type="image" src="pics/save.png" name="bSave" id="bSave" width="25" height="25" title="Save" value="submit" />
            </td>
            <td class="LineVertico1PX"></td>
        <tr>
            <td colspan="7" class="LineHorizo1PX"></td>
    </table>

    <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td colspan="15" class="LineHorizo1PX"></td>
        <tr>
            <td height="30" class="LineVertico1PX"></td>
            <td width="10" bgcolor="#c0c0c0"></td>
            <td class="LineVertico1PX"></td>
            <td width="80" align="center" valign="middle" bgcolor="#c0c0c0"><b>Province</b></td>
            <td class="LineVertico1PX"></td>
            <td width="80" align="center" valign="middle" bgcolor="#c0c0c0"><b>Shooter</b><br /><b>Tireur</b></td>
            <td class="LineVertico1PX"></td>
            <td width="80" align="center" valign="middle" bgcolor="#c0c0c0"><b>Shooter</b><br /><b>Tireur</b></td>
            <td class="LineVertico1PX"></td>
            <td width="180" align="center" valign="middle" bgcolor="#c0c0c0"><b>LastName</b><br /><b>Nom</b></td>
            <td class="LineVertico1PX"></td>
            <td width="179" align="center" valign="middle" bgcolor="#c0c0c0"><b>FirstName</b><br /><b>Pr&eacute;nom</b></td>
            <td class="LineVertico1PX"></td>
            <td width="155" align="center" valign="middle" bgcolor="#c0c0c0"><b>Line</b><br /><b>Couloir</b></td>
            <td class="LineVertico1PX"></td>
        <tr>
            <td colspan="15" class="LineHorizo1PX"></td>

    <%
        sLines = 1
        For i = 0 To sqlDtSet.Tables("Finalists").Rows.Count - 1
        
            sSerial = sqlDtSet.Tables("Finalists").Rows(i)("teamCompetitorSerial").ToString()
            sSerialFinalist = sSerial.SubString(sSerial.Length-1, 1) 
            Select Case sSerialFinalist
                Case "1"
                    sSerialFinalist = "A"

                Case "2"
                    sSerialFinalist = "B"

                Case "3"
                    sSerialFinalist = "C"

                Case "4"
                    sSerialFinalist = "D"

                Case "5"
                    sSerialFinalist = "E"
            End Select
            sSerial = sSerial.SubString(0, sSerial.Length-1) & "-" & sSerialFinalist

    %>
        <input type="hidden" name="hTcid_<% Response.Write(i) %>" id="hTcid_<% Response.Write(i) %>" value="<% Response.Write(sqlDtSet.Tables("Finalists").Rows(i)("teamCompetitorId")) %>" />
        <tr>
            <td height="25" class="LineVertico1PX"></td>
            <td bgcolor="#c0c0c0"></td>
            <td class="LineVertico1PX"></td>
            <td align="center" valign="middle" bgcolor="#ffffff"><% Response.Write(sqlDtSet.Tables("Finalists").Rows(i)("regionLetterEn")) %></td>
            <td class="LineVertico1PX"></td>
            <td align="center" valign="middle" bgcolor="#ffffff"><% Response.Write(sqlDtSet.Tables("Finalists").Rows(i)("teamCompetitorSerial")) %></td>
            <td class="LineVertico1PX"></td>
            <td align="center" valign="middle" bgcolor="#ffffff"><% Response.Write(sSerial) %></td>
            <td class="LineVertico1PX"></td>
            <td align="left" valign="middle" bgcolor="#ffffff">&nbsp;<% Response.Write(sqlDtSet.Tables("Finalists").Rows(i)("teamCompetitorLastName")) %></td>
            <td class="LineVertico1PX"></td>
            <td align="left" valign="middle" bgcolor="#ffffff">&nbsp;<% Response.Write(sqlDtSet.Tables("Finalists").Rows(i)("teamCompetitorFirstName")) %></td>
            <td class="LineVertico1PX"></td>
            <td align="center" valign="middle" bgcolor="#ffffff"><input type="text" name="txtLine_<% Response.Write(i) %>" id="txtLine_<% Response.Write(i) %>" autocomplete="off" style="width: 50px" class="FormTextBox" value="" /></td>
            <td class="LineVertico1PX"></td>
        <tr>
            <td colspan="15" class="LineHorizo1PX"></td>

    <% Next %>

    </table>
    </form>
    <br />

    <% End If %>

    <!-- ===== TABLEAU D'ASSIGNATION DES COULOIRS DE TIR ===== -->
    <!-- ===================================================== -->
    

    <!-- =========================================== -->
    <!-- ===== TABLEAU DE SAISIE DES RÉSULTATS ===== -->

    <% If sLines = 0 Then %>
    <%
        sSql = "Select competitionChapterNbrTargets From tblCompetitionsChapters Where competitionChapterId = " & sCid
        sqlDtSet.Tables.Add("NbrTargets").Merge(fnGetDataTableInDb(sSql))

        sSql = "Select * From tblTeamsCompetitors Inner Join tblFinalsLines On tblTeamsCompetitors.teamCompetitorId=tblFinalsLines.fkTeamCompetitorId Where fkCompetitionChapterId = " & sCid & " Order By finalLine"
        sqlDtSet.Tables.Remove("Finalists")
        sqlDtSet.Tables.Add("Finalists").Merge(fnGetDataTableInDb(sSql))

    %>

    <form name="frmResults" id="frmResults" method="post" enctype="multipart/form-data" action="functions.aspx?fn=ResultsFinalAdd">
        <input type="hidden" name="hReid" id="hReid" value="<% Response.Write(sEid) %>" />
        <input type="hidden" name="hRcid" id="hRcid" value="<% Response.Write(sCid) %>" />
        <input type="hidden" name="hTnbr" id="hTnbr" value="<% Response.Write(sTnbr) %>" />
        <input type="hidden" name="hNbrTargets" id="hNbrTargets" value="<% Response.Write(sqlDtSet.Tables("NbrTargets").Rows(0)("competitionChapterNbrTargets")) %>" />
        <input type="hidden" name="hRnbr" id="hRnbr" value="<% Response.Write(sqlDtSet.Tables("Finalists").Rows.Count) %>" />


    <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td colspan="9" class="LineHorizo1PX"></td>
        <tr>
            <td height="30" class="LineVertico1PX"></td>
            <td width="10" align="center" valign="middle" bgcolor="#c0c0c0"></td>
            <td class="LineVertico1PX"></td>
            <td width="587" align="left" valign="middle" bgcolor="#c0c0c0">&nbsp;<b>Final Result Entries</b><br />&nbsp;<b>Entr&eacute;es des r&eacute;sultats de la Finale</b></td>
            <td class="LineVertico1PX"></td>
            <td width="85" align="center" valign="middle" bgcolor="#ffffff">
                <input type="button" name="bLines" id="bLines" value="Lines" onclick="document.location='results_add_final.aspx?eid=<% Response.Write(sEid) %>&cid=<% Response.Write(sCid) %>&lines=1';" />
            </td>
            <td class="LineVertico1PX"></td>
            <td width="85" align="center" valign="middle" bgcolor="#ffffff">
                <input type="image" src="pics/save.png" name="bSaveR" id="bSaveR" width="25" height="25" title="Save" value="submit" />
            </td>
            <td class="LineVertico1PX"></td>
        <tr>
            <td colspan="9" class="LineHorizo1PX"></td>
    </table>

    <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td colspan="17" class="LineHorizo1PX"></td>
        <tr>
            <td height="30" class="LineVertico1PX"></td>
            <td width="10" bgcolor="#c0c0c0"></td>
            <td class="LineVertico1PX"></td>
            <td width="80" align="center" valign="middle" bgcolor="#c0c0c0"><b>Line</b><br /><b>Couloir</b></td>
            <td class="LineVertico1PX"></td>
            <td width="80" align="center" valign="middle" bgcolor="#c0c0c0"><b>Shooter</b><br /><b>Tireur</b></td>
            <td class="LineVertico1PX"></td>
            <td width="80" align="center" valign="middle" bgcolor="#c0c0c0"><b>Shooter</b><br /><b>Tireur</b></td>
            <td class="LineVertico1PX"></td>
            <td width="167" align="center" valign="middle" bgcolor="#c0c0c0"><b>LastName</b><br /><b>Nom</b></td>
            <td class="LineVertico1PX"></td>
            <td width="166" align="center" valign="middle" bgcolor="#c0c0c0"><b>FirstName</b><br /><b>Pr&eacute;nom</b></td>
            <td class="LineVertico1PX"></td>
            <td width="80" align="center" valign="middle" bgcolor="#c0c0c0">
                <select name="sTarget" id="sTarget" style="width: 70px" class="FormTextBox" onchange="document.location='results_add_final.aspx?eid=<% Response.Write(sEid) %>&cid=<% Response.Write(sCid) %>&tnbr='+this.value;">
                    <%
                        For i = 0 To sqlDtSet.Tables("NbrTargets").Rows(0)("competitionChapterNbrTargets") -1
                    
                        If sTnbr = (i+1) Then
                            sTargetSelected = "selected='selected' "
                        Else
                            sTargetSelected = ""
                        End If
                    %>
                    <option <% Response.Write(sTargetSelected) %>value="<% Response.Write(i+1) %>"><% Response.Write(i+1) %></option>
                    <% Next %>
                </select>
            </td>
            <td class="LineVertico1PX"></td>
            <td width="100" align="center" valign="middle" bgcolor="#c0c0c0"><b>Target #</b><br /><b># Cible</b></td>
            <td class="LineVertico1PX"></td>
        <tr>
            <td colspan="17" class="LineHorizo1PX"></td>

        <%
            For i = 0 To sqlDtSet.Tables("Finalists").Rows.Count - 1
            
            sSerial = sqlDtSet.Tables("Finalists").Rows(i)("teamCompetitorSerial").ToString()
            sSerialFinalist = sSerial.SubString(sSerial.Length-1, 1)
            Select Case sSerialFinalist
                Case "1"
                    sSerialFinalist = "A"

                Case "2"
                    sSerialFinalist = "B"

                Case "3"
                    sSerialFinalist = "C"

                Case "4"
                    sSerialFinalist = "D"

                Case "5"
                    sSerialFinalist = "E"
            End Select
            sSerial = sSerial.SubString(0, sSerial.Length-1) & "-" & sSerialFinalist

            If Convert.ToInt16(sqlDtSet.Tables("Finalists").Rows(i)("teamCompetitorSerial").ToString().SubString(0, sqlDtSet.Tables("Finalists").Rows(i)("teamCompetitorSerial").ToString().Length-1)) < 10 Then
                sTargetSerial = "0" & sqlDtSet.Tables("Finalists").Rows(i)("teamCompetitorSerial").ToString()
            Else
                sTargetSerial = sqlDtSet.Tables("Finalists").Rows(i)("teamCompetitorSerial").ToString()
            End If

            If Convert.ToInt16(sTnbr) < 10 Then
                sTargetSerial = sTargetSerial & "0" & sTnbr
            Else
                sTargetSerial = sTargetSerial & sTnbr
            End If

            sSql = "Select result From tblResults Where resultTargetSerial = '" & sTargetSerial & "' And fkCompetitionChapterId = " & sCid
            sqlDtSet.Tables.Add("Result_" & i).Merge(fnGetDataTableInDb(sSql))

            If sqlDtSet.Tables("Result_" & i).Rows.Count = 0 Then
                sResult = ""
            Else
                sResult = sqlDtSet.Tables("Result_" & i).Rows(0)(0).ToString()
            End If
            
        %>
        <input type="hidden" name="hTargetSerial_<% Response.Write(i) %>" id="<% Response.Write(i) %>" value="<% Response.Write(sTargetSerial) %>" />
        <input type="hidden" name="hRtcid_<% Response.Write(i) %>" id="hRtcid_<% Response.Write(i) %>" value="<% Response.Write(sqlDtSet.Tables("Finalists").Rows(i)("teamCompetitorId")) %>" />
        <tr>
            <td height="25" class="LineVertico1PX"></td>
            <td bgcolor="#c0c0c0"></td>
            <td class="LineVertico1PX"></td>
            <td align="center" valign="middle" bgcolor="#ffffff"><% Response.Write(sqlDtSet.Tables("Finalists").Rows(i)("finalLine")) %></td>
            <td class="LineVertico1PX"></td>
            <td align="center" valign="middle" bgcolor="#ffffff"><% Response.Write(sqlDtSet.Tables("Finalists").Rows(i)("teamCompetitorSerial")) %></td>
            <td class="LineVertico1PX"></td>
            <td align="center" valign="middle" bgcolor="#ffffff"><% Response.Write(sSerial) %></td>
            <td class="LineVertico1PX"></td>
            <td align="left" valign="middle" bgcolor="#ffffff">&nbsp;<% Response.Write(sqlDtSet.Tables("Finalists").Rows(i)("teamCompetitorLastName")) %></td>
            <td class="LineVertico1PX"></td>
            <td align="left" valign="middle" bgcolor="#ffffff">&nbsp;<% Response.Write(sqlDtSet.Tables("Finalists").Rows(i)("teamCompetitorFirstName")) %></td>
            <td class="LineVertico1PX"></td>
            <td align="center" valign="middle" bgcolor="#ffffff"><input type="text" name="txtScore_<% Response.Write(i) %>" id="txtScore_<% Response.Write(i) %>" autocomplete="off" style="width: 50px" class="FormTextBox" value="<% Response.Write(sResult) %>" /></td>
            <td class="LineVertico1PX"></td>
            <td align="center" valign="middle" bgcolor="#ffffff"><% Response.Write(sTargetSerial) %></td>
            <td class="LineVertico1PX"></td>
        <tr>
            <td colspan="17" class="LineHorizo1PX"></td>
        <% Next %>

    </table>
    </form>

    <% End If %>
    
    <!-- ===== TABLEAU DE SAISIE DES RÉSULTATS ===== -->
    <!-- =========================================== -->

    
    <% End If %>

        </td>
</table>

<!--#include file="inc_bottom.aspx"-->