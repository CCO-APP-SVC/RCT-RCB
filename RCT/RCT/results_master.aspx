<%@ Page Language="VB" AutoEventWireup="false" CodeFile="functions.aspx.vb" Inherits="functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
    Dim sSql As String = "Select paramValue From tblParamsNumeric Where paramName = 'AutoRefreshTime'"
    Dim sqlDtSet As System.Data.DataSet = fnGetDataSetInDB(sSql, "AutoRefreshTime")
    
    Dim i, ii, iii, iTid, iCcid, iCdid, iNbrCcTargets, iNbrCdTargets, iCcTotal, iCdTotal, iNbrTargetsShooted As Integer
    Dim dCcValue, dCdValue As Decimal
    Dim sTargetNumber As String = ""
    Dim sTargetValue As String = ""
    
    sSql = "Select * From tblCompetitionsChapters Where fkCompetitionId = " & Request.QueryString("cid")
    sqlDtSet.Tables.Add("Chapters").Merge(fnGetDataTableInDB(sSql))
                    
    For i = 0 To sqlDtSet.Tables("Chapters").Rows.Count - 1
        If sqlDtSet.Tables("Chapters").Rows(i)("fkCompetitionTypeId") = 1 Then
            iCdid = sqlDtSet.Tables("Chapters").Rows(i)("competitionChapterId")
            dCdValue = sqlDtSet.Tables("Chapters").Rows(i)("competitionChapterValue")
            iNbrCdTargets = sqlDtSet.Tables("Chapters").Rows(i)("competitionChapterNbrTargets")
        ElseIf sqlDtSet.Tables("Chapters").Rows(i)("fkCompetitionTypeId") = 2 Then
            iCcid = sqlDtSet.Tables("Chapters").Rows(i)("competitionChapterId")
            dCcValue = sqlDtSet.Tables("Chapters").Rows(i)("competitionChapterValue")
            iNbrCcTargets = sqlDtSet.Tables("Chapters").Rows(i)("competitionChapterNbrTargets")
        Else
            iCcid = 0
            iCdid = 0
            dCcValue = 0
            dCdValue = 0
            iNbrCcTargets = 0
            iNbrCdTargets = 0
        End If
    Next
    
    'ACRPO = All Competitors Results Prone Open
    'ACRPJ = All Competitors Results Prone Junior
    'ACRSO = All Competitors Results Standing Open
    'ACRSJ = All Competitors Results Standing Junior
    Dim iACRPO(,) As Single = fnGetAllCompetitorsResults(Request.QueryString("eid"), iCcid, False)
    Dim iACRPJ(,) As Single = fnGetAllCompetitorsResults(Request.QueryString("eid"), iCcid, True)
    Dim iACRSO(,) As Single = fnGetAllCompetitorsResults(Request.QueryString("eid"), iCdid, False)
    Dim iACRSJ(,) As Single = fnGetAllCompetitorsResults(Request.QueryString("eid"), iCdid, True)
    
    'ACGRO = All Competitors Global Results Open
    'ACGRJ = All Competitors Global Results Junior
    Dim iACGRO(,) As Single = fnGetAllCompetitorsGlobalsResults(Request.QueryString("eid"), iCcid, iCdid, dCcValue, dCdValue, False)
    Dim iACGRJ(,) As Single = fnGetAllCompetitorsGlobalsResults(Request.QueryString("eid"), iCcid, iCdid, dCcValue, dCdValue, True)
    
    Dim iColspan_1, iColspan_2, iColspan_3, iColspan_4 As Integer
    
    iColspan_1 = 25 + ((iNbrCcTargets + iNbrCdTargets) * 2)
    iColspan_2 = 5 + (iNbrCcTargets * 2)
    iColspan_3 = 5 + (iNbrCdTargets * 2)
    iColspan_4 = 29 + ((iNbrCcTargets + iNbrCdTargets) * 2)
    
    iCcTotal = iNbrCcTargets * 100
    iCdTotal = iNbrCdTargets * 100
    
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Results Master / R&eacute;sultats Maitre</title>
    <!-- <meta http-equiv="refresh" content="<% Response.Write(sqlDtSet.Tables("AutoRefreshTime").Rows(0)(0)) %>" /> -->
    <link href="rct.css" rel="Stylesheet" type="text/css" />
    <link href="datepickercontrol.css" rel="Stylesheet" type="text/css" />
    <script type="text/javascript" language="JavaScript" src="rct.js"></script>
    <script type="text/javascript" language="JavaScript" src="datepickercontrol.js"></script>
</head>
<body>
<center>
<br />

<table border="0" cellpadding="0" cellspacing="0">
    
    <tr>
        <td colspan="4"></td>
        <td colspan="<% Response.Write(iColspan_1) %>" class="LineHorizo2PX"></td>
    <tr>
        <td colspan="4" height="20" align="center" valign="bottom">
            <table border="0" cellpadding="0" cellspacing="0" width="100%">
            <tr><td width="100%" class="LineHorizo1PX"></td>
            </table>
        </td>
        <td class="LineVertico2PX"></td>
        <td colspan="<% Response.Write(iColspan_2) %>" class="TXTResultsRedT">Prone position / Position couch&eacute;e</td>
        <td class="LineVertico2PX"></td>
        <td colspan="<% Response.Write(iColspan_3) %>" class="TXTResultsBlueT">Standing position / Position debout</td>
        <td class="LineVertico2PX"></td>
        <td width="50" class="TXTResultsGreenT">Total</td>
        <td class="LineVertico2PX"></td>
        <td class="TXTResultsBlackT">Penalties<br />P&eacute;nalit&eacute;s</td>
        <td class="LineVertico1PX"></td>
        <td colspan="3" class="TXTResultsBlackT">Rank<br />Position</td>
        <td class="LineVertico2PX"></td>
        <td colspan="3" class="TXTResultsBlackT">Team<br />&Eacute;quipe</td>
        <td class="LineVertico2PX"></td>

    <tr>
        <td colspan="<% Response.Write(iColspan_4) %>" class="LineHorizo1PX"></td>
    
    <tr>
        <td height="30" class="LineVertico2PX"></td>
        <td width="45" class="TXTResultsBlackT">Team<br />&Eacute;quipe</td>
        <td class="LineVertico1PX"></td>
        <td width="35" class="TXTResultsBlackT">ID</td>
        <td class="LineVertico2PX"></td>
        
        <%
            For i = 0 To iNbrCcTargets - 1
                If (i + 1) < 10 Then
                    sTargetNumber = "0" & (i + 1).ToString()
                Else
                    sTargetNumber = (i + 1).ToString()
                End If
        %>
        <td width="35" class="TXTResultsRedT">P-<% Response.Write(sTargetNumber)%><br />/100</td>
        <td class="LineVertico1PX"></td>
        <% Next %>

        <td width="35" class="TXTResultsRedT">Total<br />/<% Response.Write(iCcTotal)%></td>
        <td class="LineVertico1PX"></td>
        <td width="40" class="TXTResultsRedT">%</td>
        <td class="LineVertico1PX"></td>
        <td width="40" class="TXTResultsRedT"><% Response.Write((dCcValue * 100).ToString("0"))%>%</td>
        <td class="LineVertico2PX"></td>

        <%
            For i = 0 To iNbrCdTargets - 1
                If (i + 1) < 10 Then
                    sTargetNumber = "0" & (i + 1).ToString()
                Else
                    sTargetNumber = (i + 1).ToString()
                End If
        %>
        <td width="35" class="TXTResultsBlueT">S-<% Response.Write(sTargetNumber)%><br />/100</td>
        <td class="LineVertico1PX"></td>
        <% Next %>

        <td width="35" class="TXTResultsBlueT">Total<br />/<% Response.Write(iCdTotal)%></td>
        <td class="LineVertico1PX"></td>
        <td width="40" class="TXTResultsBlueT">%</td>
        <td class="LineVertico1PX"></td>
        <td width="40" class="TXTResultsBlueT"><% Response.Write((dCdValue * 100).ToString("0"))%>%</td>
        <td class="LineVertico2PX"></td>
        <td width="50" class="TXTResultsGreenT">%<br />(<% Response.Write((dCcValue * 100).ToString("0"))%>+<% Response.Write((dCdValue * 100).ToString("0"))%>)</td>
        <td class="LineVertico2PX"></td>
        <td width="75" class="TXTResultsBlackT">Rules<br />R&egrave;gles</td>
        <td class="LineVertico1PX"></td>
        <td width="45" class="TXTResultsBlackT">Open<br />Ouvert</td>
        <td class="LineVertico1PX"></td>
        <td width="45" class="TXTResultsBlackT">Junior</td>
        <td class="LineVertico2PX"></td>
        <td width="40" class="TXTResultsBlackT">%</td>
        <td class="LineVertico1PX"></td>
        <td width="50" class="TXTResultsBlackT">Rank<br />Position</td>
        <td class="LineVertico2PX"></td>
    <tr>
        <td colspan="<% Response.Write(iColspan_4) %>" class="LineHorizo2PX"></td>

    <!-- COMPETITORS LINES BEGIN HERE -->

    <%
        sSql = "Select * From tblTeams JOIN tblTeamsTypes ON tblTeams.fkTeamTypeId=tblTeamsTypes.teamTypeId JOIN tblRegionsEvents ON tblTeams.fkRegionEventId=tblRegionsEvents.regionEventId Where fkEventId = " & Request.QueryString("eid") & " Order By teamSerial"
        sqlDtSet.Tables.Add("Teams").Merge(fnGetDataTableInDB(sSql))
        Dim oIndividualResults As cIndividualResults
        Dim sLineColor As String = "#d7d7d7"
        
        Dim aUnitTeamsRanking() As cTeamResults = fnTeamsRanking(Request.QueryString("eid"), 1, iCcid, iCdid, dCcValue, dCdValue)
        Dim aCompTeamsRanking() As cTeamResults = fnTeamsRanking(Request.QueryString("eid"), 2, iCcid, iCdid, dCcValue, dCdValue)
        Dim iTeamRanking As Integer = 0
        Dim dTeamResult As Decimal = 0
        
    %>

    <% For i = 0 To sqlDtSet.Tables("Teams").Rows.Count - 1%>
    
    <%
        iTid = sqlDtSet.Tables("Teams").Rows(i)("teamId")
        sSql = "Select * From vwTeamsCompetitorsCompetitorsCategoriesGenders Where fkTeamId = " & iTid & " Order By teamCompetitorSerial"
        sqlDtSet.Tables.Add("TeamCompetitors_" & iTid).Merge(fnGetDataTableInDB(sSql))
        
        iTeamRanking = 0
        For ii = 0 To aUnitTeamsRanking.Length - 1
            If aUnitTeamsRanking(ii).TeamNameEn = sqlDtSet.Tables("Teams").Rows(i)("teamNameEn") Then
                iTeamRanking = aUnitTeamsRanking.Length - ii
                dTeamResult = aUnitTeamsRanking(ii).MoyenneTotale
            End If
        Next
        
        For ii = 0 To aCompTeamsRanking.Length - 1
            If aCompTeamsRanking(ii).TeamNameEn = sqlDtSet.Tables("Teams").Rows(i)("teamNameEn") Then
                iTeamRanking = aCompTeamsRanking.Length - ii
                dTeamResult = aCompTeamsRanking(ii).MoyenneTotale
            End If
        Next
        
    %>
 
    <tr>
        <td rowspan="<% Response.Write(sqlDtSet.Tables("TeamCompetitors_" & iTid).Rows.Count) %>" class="LineVertico2PX"></td>
        <td rowspan="<% Response.Write(sqlDtSet.Tables("TeamCompetitors_" & iTid).Rows.Count) %>" bgcolor="#ffffff" class="TXTResultsBlack"><% Response.Write(sqlDtSet.Tables("Teams").Rows(i)("teamSerial"))%><br /><% Response.Write(sqlDtSet.Tables("Teams").Rows(i)("teamTypeLetterEn"))%></td>
        <td rowspan="<% Response.Write(sqlDtSet.Tables("TeamCompetitors_" & iTid).Rows.Count) %>" class="LineVertico1PX"></td>
        <% 
            For ii = 0 To sqlDtSet.Tables("TeamCompetitors_" & iTid).Rows.Count - 1
                
                If sLineColor = "#d7d7d7" Then
                    sLineColor = "#ffffff"
                Else
                    sLineColor = "#d7d7d7"
                End If
                
                oIndividualResults = fnResultsIndividual(sqlDtSet.Tables("TeamCompetitors_" & iTid).Rows(ii)("teamCompetitorId"), Request.QueryString("eid"), iCcid, iCdid, dCcValue, dCdValue, iACRPO, iACRPJ, iACRSO, iACRSJ, iACGRO, iACGRJ)
        
                sSql = "Select * From tblResults Where fkTeamCompetitorId = " & sqlDtSet.Tables("TeamCompetitors_" & iTid).Rows(ii)("teamCompetitorId") & " And fkCompetitionChapterId = " & iCcid & " Order By resultTargetNbr"
                sqlDtSet.Tables.Add("TargetsProne_" & sqlDtSet.Tables("TeamCompetitors_" & iTid).Rows(ii)("teamCompetitorId")).Merge(fnGetDataTableInDB(sSql))
                
                sSql = "Select * From tblResults Where fkTeamCompetitorId = " & sqlDtSet.Tables("TeamCompetitors_" & iTid).Rows(ii)("teamCompetitorId") & " And fkCompetitionChapterId = " & iCdid & " Order By resultTargetNbr"
                sqlDtSet.Tables.Add("TargetsStanding_" & sqlDtSet.Tables("TeamCompetitors_" & iTid).Rows(ii)("teamCompetitorId")).Merge(fnGetDataTableInDB(sSql))
        %>

        <td height="25" bgcolor="<% Response.Write(sLineColor) %>" class="TXTResultsBlack" onmouseover="this.style.cursor='pointer'" title="<% Response.Write(sqlDtSet.Tables("TeamCompetitors_" & iTid).Rows(ii)("teamCompetitorLastName") & " " & sqlDtSet.Tables("TeamCompetitors_" & iTid).Rows(ii)("teamCompetitorFirstName")) %>"><% Response.Write(sqlDtSet.Tables("TeamCompetitors_" & iTid).Rows(ii)("teamCompetitorSerial"))%></td>
        <td class="LineVertico2PX"></td>
        
        <%
            iNbrTargetsShooted = sqlDtSet.Tables("TargetsProne_" & sqlDtSet.Tables("TeamCompetitors_" & iTid).Rows(ii)("teamCompetitorId").ToString()).Rows.Count
            For iii = 0 To iNbrCcTargets - 1
                
                If iii < iNbrTargetsShooted Then
                    sTargetValue = sqlDtSet.Tables("TargetsProne_" & sqlDtSet.Tables("TeamCompetitors_" & iTid).Rows(ii)("teamCompetitorId").ToString()).Rows(iii)("result")
                Else
                    sTargetValue = ""
                End If
                
        %>
        <td bgcolor="<% Response.Write(sLineColor) %>" class="TXTResultsRed"><% Response.Write(sTargetValue)%></td>
        <td class="LineVertico1PX"></td>
        <% Next %>

        <td bgcolor="<% Response.Write(sLineColor) %>" class="TXTResultsRed"><% Response.Write(oIndividualResults.PointageCoucher)%></td>
        <td class="LineVertico1PX"></td>
        <td bgcolor="<% Response.Write(sLineColor) %>" class="TXTResultsRed"><% Response.Write(oIndividualResults.MoyenneCoucher.ToString("F"))%></td>
        <td class="LineVertico1PX"></td>
        <td bgcolor="<% Response.Write(sLineColor) %>" class="TXTResultsRed"><% Response.Write(oIndividualResults.MoyenneCoucherTotal.ToString("F"))%></td>
        <td class="LineVertico2PX"></td>

        <%
            iNbrTargetsShooted = sqlDtSet.Tables("TargetsStanding_" & sqlDtSet.Tables("TeamCompetitors_" & iTid).Rows(ii)("teamCompetitorId").ToString()).Rows.Count
            For iii = 0 To iNbrCdTargets - 1
                
                If iii < iNbrTargetsShooted Then
                    sTargetValue = sqlDtSet.Tables("TargetsStanding_" & sqlDtSet.Tables("TeamCompetitors_" & iTid).Rows(ii)("teamCompetitorId").ToString()).Rows(iii)("result")
                Else
                    sTargetValue = ""
                End If
                
        %>
        <td bgcolor="<% Response.Write(sLineColor) %>" class="TXTResultsBlue"><% Response.Write(sTargetValue)%></td>
        <td class="LineVertico1PX"></td>
        <% Next %>

        <td bgcolor="<% Response.Write(sLineColor) %>" class="TXTResultsBlue"><% Response.Write(oIndividualResults.PointageDebout)%></td>
        <td class="LineVertico1PX"></td>
        <td bgcolor="<% Response.Write(sLineColor) %>" class="TXTResultsBlue"><% Response.Write(oIndividualResults.MoyenneDebout.ToString("F"))%></td>
        <td class="LineVertico1PX"></td>
        <td bgcolor="<% Response.Write(sLineColor) %>" class="TXTResultsBlue"><% Response.Write(oIndividualResults.MoyenneDeboutTotal.ToString("F"))%></td>
        <td class="LineVertico2PX"></td>
        <td bgcolor="<% Response.Write(sLineColor) %>" class="TXTResultsGreen"><% Response.Write(oIndividualResults.MoyenneTotale.ToString("F"))%></td>
        <td class="LineVertico2PX"></td>
        <td bgcolor="<% Response.Write(sLineColor) %>" class="TXTResultsBlack"></td>
        <td class="LineVertico1PX"></td>
        <td bgcolor="<% Response.Write(sLineColor) %>" class="TXTResultsBlack"><% Response.Write(oIndividualResults.ClassementOuvert)%></td>
        <td class="LineVertico1PX"></td>
        <td bgcolor="<% Response.Write(sLineColor) %>" class="TXTResultsBlack"><%
                                                                                   If oIndividualResults.ClassementJunior = 0 Then
                                                                                       Response.Write("")
                                                                                   Else
                                                                                       Response.Write(oIndividualResults.ClassementJunior)
                                                                                   End If
                                                                                   
                                                                               %></td>
        <td class="LineVertico2PX"></td>
        <% If ii = 0 Then%>
        <td rowspan="<% Response.Write(sqlDtSet.Tables("TeamCompetitors_" & iTid).Rows.Count) %>" bgcolor="#ffffff" class="TXTResultsBlack"><% Response.Write(dTeamResult.ToString("F"))%></td>
        <td rowspan="<% Response.Write(sqlDtSet.Tables("TeamCompetitors_" & iTid).Rows.Count) %>" class="LineVertico1PX"></td>
        <td rowspan="<% Response.Write(sqlDtSet.Tables("TeamCompetitors_" & iTid).Rows.Count) %>" bgcolor="#ffffff" class="TXTResultsBlack"><% Response.Write(iTeamRanking)%><br /><% Response.Write(sqlDtSet.Tables("Teams").Rows(i)("teamTypeLetterEn"))%></td>
        <% End If%>
        <td class="LineVertico2PX"></td>
    <% If ii <> sqlDtSet.Tables("TeamCompetitors_" & iTid).Rows.Count - 1 Then%>
       <tr>
    <% End If%>

    <% 
    Next
    %>
    <tr>
        <td colspan="<% Response.Write(iColspan_4) %>" class="LineHorizo1PX"></td>
    <%
    Next
    %>


</table>

</center>
</body>
</html>
