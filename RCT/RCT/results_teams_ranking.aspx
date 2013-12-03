<%@ Page Language="VB" AutoEventWireup="false" CodeFile="functions.aspx.vb" Inherits="functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
    Dim dCcValue, dCdValue As Decimal
    Dim i, ii, iCcid, iCdid, iTtid As Integer
    Dim sLineColor As String = ""
    Dim sLineBold As String = "style='font-weight: bold;'"
    
    Dim sSql As String = "Select * From tblCompetitionsChapters Where fkCompetitionId = " & Request.QueryString("cid")
    Dim sqlDtSet As System.Data.DataSet = fnGetDataSetInDB(sSql, "Chapters")
    
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
    
    iTtid = Request.QueryString("ttid")
    If String.IsNullOrEmpty(iTtid) Then
        iTtid = "0"
    End If
    
    sSql = "Select * From tblTeamsTypes Where teamTypeId = " & iTtid
    sqlDtSet.Tables.Add("TeamType").Merge(fnGetDataTableInDB(sSql))
    
    sSql = "Select COUNT(teamId) From tblTeams Inner Join tblRegionsEvents on tblTeams.fkRegionEventId=tblRegionsEvents.regionEventId Where fkTeamTypeId = " & iTtid & " And fkEventId = " & Request.QueryString("eid")
    sqlDtSet.Tables.Add("TeamsQty").Merge(fnGetDataTableInDB(sSql))
    
    Dim aTeamsRanking() As cTeamResults = fnTeamsRanking(Request.QueryString("eid"), iTtid, iCcid, iCdid, dCcValue, dCdValue)
    
    Dim sPublicTemplateMain As String = fnGetTextInTemplate("template_results_teams_ranking.html")
    Dim sPublicTemplateLine As String = fnGetTextInTemplate("template_results_teams_ranking_line.html")
    Dim sPublicTemplateSpacing As String = fnGetTextInTemplate("template_results_teams_ranking_spacing.html")
    Dim sPublicHtmlText As String = ""
    Dim sPublicHtmlTextLines As String = ""
    
    sPublicHtmlText = sPublicTemplateMain.Replace("#TeamTypeEn#", sqlDtSet.Tables("TeamType").Rows(0)("teamTypeNameEn"))
    sPublicHtmlText = sPublicHtmlText.Replace("#TeamTypeFr#", Server.HtmlEncode(sqlDtSet.Tables("TeamType").Rows(0)("teamTypeNameFr")))
    sPublicHtmlText = sPublicHtmlText.Replace("#ProneAv#", (dCcValue * 100).ToString(0))
    sPublicHtmlText = sPublicHtmlText.Replace("#StandingAv#", (dCdValue * 100).ToString(0))
    
    Dim sRegionName As String = ""
    
    sSql = "Select paramValue From tblParamsNumeric Where paramName = 'AutoRefreshTime'"
    sqlDtSet.Tables.Add("AutoRefreshTime").Merge(fnGetDataTableInDB(sSql))
    
    sSql = "Select paramValue From tblParamsNumeric Where paramName = 'PublicAutoRefreshTime'"
    sqlDtSet.Tables.Add("PublicAutoRefreshTime").Merge(fnGetDataTableInDB(sSql))
    
    'sPublicHtmlText = sPublicHtmlText.Replace("#AutoRefreshTime#", sqlDtSet.Tables("PublicAutoRefreshTime").Rows(0)(0).ToString())
    
    sSql = "Select eventShowPublicResults From tblEvents Where eventId = " & Request.QueryString("eid")
    sqlDtSet.Tables.Add("ShowPublicResults").Merge(fnGetDataTableInDB(sSql))
    Dim bShowPublicResults As Boolean = sqlDtSet.Tables("ShowPublicResults").Rows(0)(0)
    
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="refresh" content="<% Response.Write(sqlDtSet.Tables("AutoRefreshTime").Rows(0)(0)) %>" />
    <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
    <META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">

    <link href="rct.css" rel="Stylesheet" type="text/css" />
    <link href="datepickercontrol.css" rel="Stylesheet" type="text/css" />
    <script type="text/javascript" language="JavaScript" src="rct.js"></script>
    <script type="text/javascript" language="JavaScript" src="datepickercontrol.js"></script>
    <title>Teams Ranking / Classement des &eacute;quipes</title>
</head>
<body>
<center>
<br />
        <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td colspan="4"></td>
            <td colspan="17" class="LineHorizo2PX"></td>
        <tr>
            <td height="25" colspan="4"></td>
            <td class="LineVertico2PX"></td>
            <td colspan="11" class="TXTResultsBlack" style="font-weight:bold;" bgcolor="#ffffff"><% Response.Write(sqlDtSet.Tables("TeamType").Rows(0)("teamTypeNameEn"))%>&nbsp;Teams&nbsp;/&nbsp;&Eacute;quipes&nbsp;<% Response.Write(sqlDtSet.Tables("TeamType").Rows(0)("teamTypeNameFr"))%></td>
            <td class="LineVertico2PX"></td>
            <td rowspan="3" colspan="3" class="TXTResultsGreen" style="font-weight:bold;" bgcolor="#ffffff">Cumulative<br />Cumulatif</td>
            <td class="LineVertico2PX"></td>
        <tr>
            <td colspan="4"></td>
            <td colspan="13" class="LineHorizo1PX"></td>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="25" colspan="4"></td>
            <td class="LineVertico2PX"></td>
            <td colspan="11" class="TXTResultsBlack" style="font-weight:bold;" bgcolor="#ffffff">Teams ranking / Classement des &eacute;quipes</td>
            <td class="LineVertico2PX"></td>
            <td class="LineVertico2PX"></td>
        <tr>
            <td colspan="4"></td>
            <td colspan="17" class="LineHorizo1PX"></td>
        <tr>
            <td height="40" colspan="4"></td>
            <td class="LineVertico2PX"></td>
            <td class="TXTResultsRed" bgcolor="#ffffff">Prone<br />Couch&eacute;</td>
            <td bgcolor="#000000"></td>
            <td class="TXTResultsRed" bgcolor="#ffffff">100%</td>
            <td bgcolor="#000000"></td>
            <td class="TXTResultsRed" bgcolor="#ffffff"><% Response.Write((dCcValue * 100).ToString(0))%>%</td>
            <td bgcolor="#000000"></td>
            <td class="TXTResultsBlue" bgcolor="#ffffff">Standing<br />Debout</td>
            <td bgcolor="#000000"></td>
            <td class="TXTResultsBlue" bgcolor="#ffffff">100%</td>
            <td bgcolor="#000000"></td>
            <td class="TXTResultsBlue" bgcolor="#ffffff"><% Response.Write((dCdValue * 100).ToString(0))%>%</td>
            <td bgcolor="#000000"></td>
            <td class="TXTResultsGreen" bgcolor="#ffffff">100%<br />(<% Response.Write((dCcValue * 100).ToString(0))%>+<% Response.Write((dCdValue * 100).ToString(0))%>)</td>
            <td bgcolor="#000000"></td>
            <td class="TXTResultsGreen" bgcolor="#ffffff">Rank<br />Position</td>
            <td class="LineVertico2PX"></td>

        <tr>
            <td colspan="21" class="LineHorizo2PX"></td>
        
        <%
            For i = 0 To aTeamsRanking.Length - 1
                
                Select Case i
                    
                    Case 0
                        sLineColor = "yellow"
                    Case 1
                        sLineColor = "silver"
                    Case 2
                        sLineColor = "#cc9900"
                    Case Else
                        sLineColor = "#ffffff"
                        sLineBold = ""
                        
                End Select
                
                If aTeamsRanking(aTeamsRanking.Length - 1 - i).TeamRegionNameEn = aTeamsRanking(aTeamsRanking.Length - 1 - i).TeamRegionNameFr Then
                    sRegionName = aTeamsRanking(aTeamsRanking.Length - 1 - i).TeamRegionNameEn
                Else
                    sRegionName = aTeamsRanking(aTeamsRanking.Length - 1 - i).TeamRegionNameEn & "<br>" & Server.HtmlEncode(aTeamsRanking(aTeamsRanking.Length - 1 - i).TeamRegionNameFr)
                End If
                
                sPublicHtmlTextLines = sPublicHtmlTextLines & sPublicTemplateLine
                sPublicHtmlTextLines = sPublicHtmlTextLines.Replace("#LineColor#", sLineColor)
                sPublicHtmlTextLines = sPublicHtmlTextLines.Replace("#LineBold#", sLineBold)
                sPublicHtmlTextLines = sPublicHtmlTextLines.Replace("#RegionName#", sRegionName)
                sPublicHtmlTextLines = sPublicHtmlTextLines.Replace("#TeamName#", aTeamsRanking(aTeamsRanking.Length - 1 - i).TeamNameEn)
                sPublicHtmlTextLines = sPublicHtmlTextLines.Replace("#ProneScore#", aTeamsRanking(aTeamsRanking.Length - 1 - i).PointageCoucher)
                sPublicHtmlTextLines = sPublicHtmlTextLines.Replace("#PronePc#", aTeamsRanking(aTeamsRanking.Length - 1 - i).MoyenneCoucher.ToString("F"))
                sPublicHtmlTextLines = sPublicHtmlTextLines.Replace("#ProneAv#", aTeamsRanking(aTeamsRanking.Length - 1 - i).MoyenneCoucherTotal.ToString("F"))
                sPublicHtmlTextLines = sPublicHtmlTextLines.Replace("#StandingScore#", aTeamsRanking(aTeamsRanking.Length - 1 - i).PointageDebout)
                sPublicHtmlTextLines = sPublicHtmlTextLines.Replace("#StandingPc#", aTeamsRanking(aTeamsRanking.Length - 1 - i).MoyenneDebout.ToString("F"))
                sPublicHtmlTextLines = sPublicHtmlTextLines.Replace("#StandingAv#", aTeamsRanking(aTeamsRanking.Length - 1 - i).MoyenneDeboutTotal.ToString("F"))
                sPublicHtmlTextLines = sPublicHtmlTextLines.Replace("#Ranking#", i + 1)
                sPublicHtmlTextLines = sPublicHtmlTextLines.Replace("#TotalAv#", aTeamsRanking(aTeamsRanking.Length - 1 - i).MoyenneTotale.ToString("F"))
                
        %>
        <tr bgcolor="<% Response.Write(sLineColor) %>">
            <td class="LineVertico2PX"></td>
            <td width="80" height="40" class="TXTResultsBlack" <% Response.Write(sLineBold) %>><img src="pics/flags/<% Response.Write(aTeamsRanking(aTeamsRanking.Length - 1 - i).TeamRegionFlag) %>" height="36" alt="<% Response.Write(aTeamsRanking(aTeamsRanking.Length - 1 - i).TeamRegionNameEn) %>" /></td>
            <td class="LineVertico1PX"></td>
            <td width="100" class="TXTResultsBlack" <% Response.Write(sLineBold) %>><% Response.Write(aTeamsRanking(aTeamsRanking.Length - 1 - i).TeamNameEn)%></td>
            <td class="LineVertico2PX"></td>
            <td width="80" class="TXTResultsRed" <% Response.Write(sLineBold) %>><% Response.Write(aTeamsRanking(aTeamsRanking.Length - 1 - i).PointageCoucher)%></td>
            <td class="LineVertico1PX"></td>
            <td width="80" class="TXTResultsRed" <% Response.Write(sLineBold) %>><% Response.Write(aTeamsRanking(aTeamsRanking.Length - 1 - i).MoyenneCoucher.ToString("F"))%></td>
            <td class="LineVertico1PX"></td>
            <td width="80" class="TXTResultsRed" <% Response.Write(sLineBold) %>><% Response.Write(aTeamsRanking(aTeamsRanking.Length - 1 - i).MoyenneCoucherTotal.ToString("F"))%></td>
            <td class="LineVertico2PX"></td>
            <td width="80" class="TXTResultsBlue" <% Response.Write(sLineBold) %>><% Response.Write(aTeamsRanking(aTeamsRanking.Length - 1 - i).PointageDebout)%></td>
            <td class="LineVertico1PX"></td>
            <td width="80" class="TXTResultsBlue" <% Response.Write(sLineBold) %>><% Response.Write(aTeamsRanking(aTeamsRanking.Length - 1 - i).MoyenneDebout.ToString("F"))%></td>
            <td class="LineVertico1PX"></td>
            <td width="80" class="TXTResultsBlue" <% Response.Write(sLineBold) %>><% Response.Write(aTeamsRanking(aTeamsRanking.Length - 1 - i).MoyenneDeboutTotal.ToString("F"))%></td>
            <td class="LineVertico2PX"></td>
            <td width="80" class="TXTResultsGreen" <% Response.Write(sLineBold) %>><% Response.Write(aTeamsRanking(aTeamsRanking.Length - 1 - i).MoyenneTotale.ToString("F"))%><br /></td>
            <td class="LineVertico1PX"></td>
            <td width="80" class="TXTResultsGreen" <% Response.Write(sLineBold) %>><% Response.Write(i + 1)%></td>
            <td class="LineVertico2PX"></td>
        <% If i = aTeamsRanking.Length - 1 Then%>
        <tr>
            <td colspan="21" class="LineHorizo2PX"></td>
        <% Else%>
        <tr>
            <td colspan="21" class="LineHorizo1PX"></td>
        <% sPublicHtmlTextLines = sPublicHtmlTextLines & sPublicTemplateSpacing%>
        <% End If%>
        
        <% Next%>

        </table>
        <%
            sPublicHtmlText = sPublicHtmlText.Replace("#Values#", sPublicHtmlTextLines)
            sPublicHtmlText = sPublicHtmlText.Replace("#UpdatedDate#", Date.UtcNow.ToString() & " (UTC/GMT)")
            'fnCreateTextFile(sPublicHtmlText, "public_results_eid-" & Request.QueryString("eid") & "_" & sqlDtSet.Tables("TeamType").Rows(0)("teamTypeNameEn").ToString().ToLower() & "_teams_ranking.html")
            
            If bShowPublicResults Then
                fnPutPublicHtmlTextInDb("eid-" & Request.QueryString("eid") & "_" & sqlDtSet.Tables("TeamType").Rows(0)("teamTypeNameEn").ToString().ToLower() & "_tr", sPublicHtmlText)
            End If
        %>

</center>
</body>
</html>
