<%@ Page Language="VB" AutoEventWireup="false" CodeFile="functions.aspx.vb" Inherits="functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
    Dim sSql As String = "Select * From tblRegions Where regionId = " & Request.QueryString("rid")
    Dim sqlDtSet As System.Data.DataSet = fnGetDataSetInDB(sSql, "Region")
    Dim i, ii, iTid, iCcid, iCdid As Integer
    Dim dCcValue, dCdValue As Decimal
    
    sSql = "Select * From tblCompetitionsChapters Where fkCompetitionId = " & Request.QueryString("cid")
    sqlDtSet.Tables.Add("Chapters").Merge(fnGetDataTableInDB(sSql))
    
    sSql = "Select COUNT(fkRegionId) From tblRegionsEvents Where fkEventId = " & Request.QueryString("eid")
    sqlDtSet.Tables.Add("NbrRegionsEvent").Merge(fnGetDataTableInDB(sSql))
                    
    For i = 0 To sqlDtSet.Tables("Chapters").Rows.Count - 1
        If sqlDtSet.Tables("Chapters").Rows(i)("fkCompetitionTypeId") = 1 Then
            iCdid = sqlDtSet.Tables("Chapters").Rows(i)("competitionChapterId")
            dCdValue = sqlDtSet.Tables("Chapters").Rows(i)("competitionChapterValue")
        ElseIf sqlDtSet.Tables("Chapters").Rows(i)("fkCompetitionTypeId") = 2 Then
            iCcid = sqlDtSet.Tables("Chapters").Rows(i)("competitionChapterId")
            dCcValue = sqlDtSet.Tables("Chapters").Rows(i)("competitionChapterValue")
        Else
            iCcid = 0
            iCdid = 0
            dCcValue = 0
            dCdValue = 0
        End If
    Next
   
    Dim sPageTitle As String
    If sqlDtSet.Tables("Region").Rows(0)("regionNameFr") = sqlDtSet.Tables("Region").Rows(0)("regionNameEn") Then
        sPageTitle = sqlDtSet.Tables("Region").Rows(0)("regionNameEn")
    Else
        sPageTitle = sqlDtSet.Tables("Region").Rows(0)("regionNameEn") & " / " & sqlDtSet.Tables("Region").Rows(0)("regionNameFr")
    End If
    
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="refresh" content="10">
    <link href="rct.css" rel="Stylesheet" type="text/css" />
    <link href="datepickercontrol.css" rel="Stylesheet" type="text/css" />
    <script type="text/javascript" language="JavaScript" src="rct.js"></script>
    <script type="text/javascript" language="JavaScript" src="datepickercontrol.js"></script>
    <title><% Response.Write(sPageTitle)%></title>
</head>
<body>

<%
    Dim aRegionsRanking() As cRegionRanking
    Dim iRegionRanking As Integer = 0
    aRegionsRanking = fnRegionsRanking(Request.QueryString("eid"), iCcid, iCdid, dCcValue, dCdValue)
    
    For i = 0 To aRegionsRanking.Length - 1
        If Request.QueryString("rid") = aRegionsRanking(i).RegionId Then
            iRegionRanking = aRegionsRanking.Length - i
        End If
    Next
    
%>

<center>
        <br />
        <!-- ================================= -->
        <!-- ===== TABLEAU DES RÉSULTATS ===== -->

        <table border="0" cellpadding="0" cellspacing="0" bgcolor="#ffffff">
        <tr>
            <td colspan="5" class="LineHorizo2PX"></td>
        <tr>
            <td class="LineVertico2PX"></td>
            <td width="200" align="center" valign="middle"><img src="pics/flags/<% Response.Write(sqlDtSet.Tables("Region").Rows(0)("regionFlagLogo")) %>" height="75" alt="<% Response.Write(sqlDtSet.Tables("Region").Rows(0)("regionNameEn")) %>" /></td>
            <td class="LineVertico2PX"></td>
            <td>
                <table border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td colspan="19" height="30" class="TXTResultsTitles"><% Response.Write(sqlDtSet.Tables("Region").Rows(0)("regionNameEn"))%>&nbsp;Team Results&nbsp;/&nbsp;R&eacute;sultats en &eacute;quipe&nbsp;<% Response.Write(sqlDtSet.Tables("Region").Rows(0)("regionNameFr"))%></td>
                <tr>
                    <td colspan="19" class="LineHorizo1PX"></td>
                <tr>
                    <td colspan="11" height="30" bgcolor="#c8c8c8" class="TXTResultsBlack"><b>Team&nbsp;/&nbsp;&Eacute;quipe</b></td>
                    <td class="LineVertico2PX"></td>
                    <td colspan="3" bgcolor="#c8c8c8" class="TXTResultsGreen"><b>Cumulative<br />Cumulatif</b></td>
                    <td class="LineVertico2PX"></td>
                    <td colspan="3" bgcolor="#c8c8c8" class="TXTResultsBlack"><b>Ranking<br />Classement</b></td>
                <tr>
                    <td colspan="19" class="LineHorizo1PX"></td>
                <tr>
                    <%
                        Dim iNbrOpen As Integer = fnGetNbrCompetitors(Request.QueryString("eid"), False)
                        Dim iNbrJunior As Integer = fnGetNbrCompetitors(Request.QueryString("eid"), True)
                    %>
                    <td width="64" height="30" class="TXTResultsRed">Prone<br />Couch&eacute;</td>
                    <td class="LineVertico1PX"></td>
                    <td width="64" class="TXTResultsRed">%</td>
                    <td class="LineVertico1PX"></td>
                    <td width="64" class="TXTResultsRed">%<br />(<% Response.Write((dCcValue * 100).ToString(0))%>%)</td>
                    <td class="LineVertico1PX"></td>
                    <td width="64" class="TXTResultsBlue">Standing<br />Debout</td>
                    <td class="LineVertico1PX"></td>
                    <td width="64" class="TXTResultsBlue">%</td>
                    <td class="LineVertico1PX"></td>
                    <td width="64" class="TXTResultsBlue">%<br>(<% Response.Write((dCdValue * 100).ToString(0))%>%)</td>
                    <td class="LineVertico2PX"></td>
                    <td width="64" class="TXTResultsGreen">Score</td>
                    <td class="LineVertico1PX"></td>
                    <td width="64" class="TXTResultsGreen">%<br />(<% Response.Write((dCcValue * 100).ToString(0))%>+<% Response.Write((dCdValue * 100).ToString(0))%>)</td>
                    <td class="LineVertico2PX"></td>
                    <td width="64" class="TXTResultsBlack">%</td>
                    <td class="LineVertico1PX"></td>
                    <td width="64" class="TXTResultsBlack">/<% Response.Write(sqlDtSet.Tables("NbrRegionsEvent").Rows(0)(0))%></td>
                </table>
            </td>
            <td class="LineVertico2PX"></td>
        <tr>
            <td colspan="5" class="LineHorizo2PX"></td>
        <tr>
            <td class="LineVertico2PX"></td>
            <td colspan="3">
                <table border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td>

                <%
                    sSql = "Select * From tblTeams JOIN tblTeamsTypes ON tblTeams.fkTeamTypeId=tblTeamsTypes.teamTypeId Where fkRegionEventId = " & Request.QueryString("reid")
                    sqlDtSet.Tables.Add("Teams").Merge(fnGetDataTableInDB(sSql))
                    
                    Dim sCompetitorName As String
                    Dim iNbrTeams As String = sqlDtSet.Tables("Teams").Rows.Count
                    Dim iNbrCompetitorInTheTeam As Integer = 0
                    
                    Dim oResultsTeamRegion As cTeamResults = New cTeamResults
                    Dim dResultTotalRegion As Single = 0

                    For i = 0 To iNbrTeams - 1
                        
                        iTid = sqlDtSet.Tables("Teams").Rows(i)("teamId")
                        sSql = "Select * From vwTeamsCompetitorsCompetitorsCategoriesGenders Where fkTeamId = " & iTid & " Order By teamCompetitorSerial"
                        sqlDtSet.Tables.Add("TeamCompetitors_" & iTid).Merge(fnGetDataTableInDB(sSql))
                        iNbrCompetitorInTheTeam = sqlDtSet.Tables("TeamCompetitors_" & iTid).Rows.Count
                        
                        oResultsTeamRegion = fnResultsRegionTeam(iCcid, iCdid, dCcValue, dCdValue, sqlDtSet.Tables("TeamCompetitors_" & iTid))
                        dResultTotalRegion = dResultTotalRegion + oResultsTeamRegion.MoyenneTotale
                %>
                
                <table border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td width="80" rowspan="<% Response.Write(iNbrCompetitorInTheTeam) %>" class="TXTResultsBlack" align="center" valign="middle">
                        <% Response.Write(sqlDtSet.Tables("Teams").Rows(i)("teamSerial"))%><br />
                        <% Response.Write(sqlDtSet.Tables("Teams").Rows(i)("teamNameFr"))%>
                    </td>
                    <td class="LineVertico1PX" rowspan="<% Response.Write(iNbrCompetitorInTheTeam) %>"></td>
                    
                    <% For ii = 0 To iNbrCompetitorInTheTeam - 1%>
                    <%
                        
                        sCompetitorName = sqlDtSet.Tables("TeamCompetitors_" & iTid).Rows(ii)("teamCompetitorLastName") & " " & sqlDtSet.Tables("TeamCompetitors_" & iTid).Rows(ii)("teamCompetitorFirstName")
                        If sCompetitorName.Length >= 16 Then
                            sCompetitorName = sCompetitorName.Substring(0,14) & "..."
                        End If
                        
                    %>
                    
                    <td width="119" height="25" align="left" class="TXTResultsBlack" style="text-align:left;">&nbsp;<% Response.Write(sCompetitorName)%></td>
                    
                    <% If ii = 0 Then%>
                    <td class="LineVertico2PX" rowspan="<% Response.Write(iNbrCompetitorInTheTeam) %>"></td>
                    <td width="64" rowspan="<% Response.Write(iNbrCompetitorInTheTeam) %>" class="TXTResultsRed"><% Response.Write(oResultsTeamRegion.PointageCoucher)%></td>
                    <td class="LineVertico1PX" rowspan="<% Response.Write(iNbrCompetitorInTheTeam) %>"></td>
                    <td width="64" rowspan="<% Response.Write(iNbrCompetitorInTheTeam) %>" class="TXTResultsRed"><% Response.Write(oResultsTeamRegion.MoyenneCoucher.ToString("F"))%></td>
                    <td class="LineVertico1PX" rowspan="<% Response.Write(iNbrCompetitorInTheTeam) %>"></td>
                    <td width="64" rowspan="<% Response.Write(iNbrCompetitorInTheTeam) %>" class="TXTResultsRed"><% Response.Write(oResultsTeamRegion.MoyenneCoucherTotal.ToString("F"))%></td>
                    <td class="LineVertico1PX" rowspan="<% Response.Write(iNbrCompetitorInTheTeam) %>"></td>
                    <td width="64" rowspan="<% Response.Write(iNbrCompetitorInTheTeam) %>" class="TXTResultsBlue"><% Response.Write(oResultsTeamRegion.PointageDebout)%></td>
                    <td class="LineVertico1PX" rowspan="<% Response.Write(iNbrCompetitorInTheTeam) %>"></td>
                    <td width="64" rowspan="<% Response.Write(iNbrCompetitorInTheTeam) %>" class="TXTResultsBlue"><% Response.Write(oResultsTeamRegion.MoyenneDebout.ToString("F"))%></td>
                    <td class="LineVertico1PX" rowspan="<% Response.Write(iNbrCompetitorInTheTeam) %>"></td>
                    <td width="64" rowspan="<% Response.Write(iNbrCompetitorInTheTeam) %>" class="TXTResultsBlue"><% Response.Write(oResultsTeamRegion.MoyenneDeboutTotal.ToString("F"))%></td>
                    <td class="LineVertico2PX" rowspan="<% Response.Write(iNbrCompetitorInTheTeam) %>"></td>
                    <td width="64" rowspan="<% Response.Write(iNbrCompetitorInTheTeam) %>" class="TXTResultsGreen"><% Response.Write(oResultsTeamRegion.PointageTotal)%></td>
                    <td class="LineVertico1PX" rowspan="<% Response.Write(iNbrCompetitorInTheTeam) %>"></td>
                    <td width="64" rowspan="<% Response.Write(iNbrCompetitorInTheTeam) %>" class="TXTResultsGreen"><% Response.Write(oResultsTeamRegion.MoyenneTotale.ToString("F"))%></td>
                    <td class="LineVertico2PX" rowspan="<% Response.Write(iNbrCompetitorInTheTeam) %>"></td>
                    <% End If%>

                    <% If ii <> iNbrCompetitorInTheTeam - 1 Then%>
                <tr>
                    <% End If%>
                    <% Next%>
                    
                <tr>
                    <td colspan="20" class="LineHorizo2PX"></td>
                </table>

                <% Next %>

                </td>
                <td valign="top">

                    <table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="64" height="<% Response.Write((iNbrTeams*125)+(iNbrTeams*2)-2) %>" class="TXTResultsBlack"><% Response.Write((dResultTotalRegion / iNbrTeams).ToString("F"))%></td>
                        <td class="LineVertico1PX"></td>
                        <td width="64" class="TXTResultsTitles" style="font-size:20px;"><% Response.Write(iRegionRanking)%></td>
                    <tr>
                        <td colspan="3" class="LineHorizo2PX"></td>
                    </table>
                
                </td>
                </table>

            </td>

            <td class="LineVertico2PX"></td>
        </table>

        <!-- ===== TABLEAU DES RÉSULTATS ===== -->
        <!-- ================================= -->

</center>

</body>
</html>
