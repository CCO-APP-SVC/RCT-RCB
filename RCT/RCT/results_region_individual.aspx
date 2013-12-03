<%@ Page Language="VB" AutoEventWireup="false" CodeFile="functions.aspx.vb" Inherits="functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
    
    Dim sSql As String = "Select * From tblRegions Where regionId = " & Request.QueryString("rid")
    Dim sqlDtSet As System.Data.DataSet = fnGetDataSetInDB(sSql, "Region")
    Dim i, ii, iTid, iCcid, iCdid, iNbrProneTargetsTotal, iNbrStandingTargetsTotal As Integer
    Dim dCcValue, dCdValue As Decimal
    
    sSql = "Select * From tblCompetitionsChapters Where fkCompetitionId = " & Request.QueryString("cid")
    sqlDtSet.Tables.Add("Chapters").Merge(fnGetDataTableInDB(sSql))
                    
    For i = 0 To sqlDtSet.Tables("Chapters").Rows.Count - 1
        If sqlDtSet.Tables("Chapters").Rows(i)("fkCompetitionTypeId") = 1 Then
            iCdid = sqlDtSet.Tables("Chapters").Rows(i)("competitionChapterId")
            dCdValue = sqlDtSet.Tables("Chapters").Rows(i)("competitionChapterValue")
            iNbrStandingTargetsTotal = sqlDtSet.Tables("Chapters").Rows(i)("competitionChapterNbrTargets")
        ElseIf sqlDtSet.Tables("Chapters").Rows(i)("fkCompetitionTypeId") = 2 Then
            iCcid = sqlDtSet.Tables("Chapters").Rows(i)("competitionChapterId")
            dCcValue = sqlDtSet.Tables("Chapters").Rows(i)("competitionChapterValue")
            iNbrProneTargetsTotal = sqlDtSet.Tables("Chapters").Rows(i)("competitionChapterNbrTargets")
        Else
            iCcid = 0
            iCdid = 0
            dCcValue = 0
            dCdValue = 0
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
    
    Dim sPageTitle As String
    
    If sqlDtSet.Tables("Region").Rows(0)("regionNameFr") = sqlDtSet.Tables("Region").Rows(0)("regionNameEn") Then
        sPageTitle = sqlDtSet.Tables("Region").Rows(0)("regionNameEn")
    Else
        sPageTitle = sqlDtSet.Tables("Region").Rows(0)("regionNameEn") & " / " & sqlDtSet.Tables("Region").Rows(0)("regionNameFr")
    End If
    
    Dim sPublicTemplateMain As String = fnGetTextInTemplate("template_results_region_individual.html")
    Dim sPublicTemplateTeam As String = fnGetTextInTemplate("template_results_region_individual_team.html")
    Dim sPublicTemplateCompetitor As String = fnGetTextInTemplate("template_results_region_individual_team_line.html")
    Dim sPublicTemplateSpacing As String = fnGetTextInTemplate("template_results_region_individual_team_spacing.html")
    
    Dim sPublicHtml As String = ""
    Dim sPublicHtmlTeam As String = ""
    Dim sPublicHtmlTeams As String = ""
    Dim sPublicHtmlCompetitor As String = ""
    Dim sPublicHtmlCompetitors As String = ""
    
    sPublicHtml = sPublicTemplateMain.Replace("#Title#", Server.HtmlEncode(sPageTitle))
    sPublicHtml = sPublicHtml.Replace("#RegionNameEn#", Server.HtmlEncode(sqlDtSet.Tables("Region").Rows(0)("regionNameEn")))
    sPublicHtml = sPublicHtml.Replace("#RegionNameFr#", Server.HtmlEncode(sqlDtSet.Tables("Region").Rows(0)("regionNameFr")))
    
    sSql = "Select paramValue From tblParamsNumeric Where paramName = 'AutoRefreshTime'"
    sqlDtSet.Tables.Add("AutoRefreshTime").Merge(fnGetDataTableInDB(sSql))
    'sPublicHtml = sPublicHtml.Replace("#AutoRefreshTime#", sqlDtSet.Tables("AutoRefreshTime").Rows(0)(0).ToString())
    
    sSql = "Select eventShowPublicResults From tblEvents Where eventId = " & Request.QueryString("eid")
    sqlDtSet.Tables.Add("ShowPublicResults").Merge(fnGetDataTableInDB(sSql))
    Dim bShowPublicResults As Boolean = sqlDtSet.Tables("ShowPublicResults").Rows(0)(0)
    
    sSql = "Insert Into tblResultsIRBR (fkRegionEventId, resultIRBRSessionId) Values (" & Request.QueryString("reid") & ", '" & Session.SessionID & "')"
    fnExecuteNonQueryInDB(sSql)
    
    sSql = "Select * From tblRegionsEvents Where fkEventId = " & Request.QueryString("eid") & " Order By regionEventId"
    sqlDtSet.Tables.Add("RegionsEvent").Merge(fnGetDataTableInDB(sSql))
    
    sSql = "Select * From tblResultsIRBR Where resultIRBRSessionId = '" & Session.SessionID & "' Order By fkRegionEventId"
    sqlDtSet.Tables.Add("ResultsIRBR").Merge(fnGetDataTableInDB(sSql))
    
    Dim iRegionEventIdToShow, iRegionIdToShow As Integer
    Dim bAlreadyUsed As Boolean
    For i = 0 To sqlDtSet.Tables("RegionsEvent").Rows.Count - 1
    
        bAlreadyUsed = False

        If sqlDtSet.Tables("RegionsEvent").Rows(i)("regionEventId") <> Request.QueryString("reid") Then
            For ii = 0 To sqlDtSet.Tables("ResultsIRBR").Rows.Count - 1
                If sqlDtSet.Tables("RegionsEvent").Rows(i)("regionEventId") = sqlDtSet.Tables("ResultsIRBR").Rows(ii)("fkRegionEventId") Then
                    bAlreadyUsed = True
                End If
            Next
            If Not bAlreadyUsed Then
                iRegionEventIdToShow = sqlDtSet.Tables("RegionsEvent").Rows(i)("regionEventId")
                iRegionIdToShow = sqlDtSet.Tables("RegionsEvent").Rows(i)("fkRegionId")
                i = sqlDtSet.Tables("RegionsEvent").Rows.Count - 1
            End If
            
        End If
        
    Next
    
    If iRegionEventIdToShow = 0 Then
        iRegionEventIdToShow = sqlDtSet.Tables("RegionsEvent").Rows(0)("regionEventId")
        iRegionIdToShow = sqlDtSet.Tables("RegionsEvent").Rows(0)("fkRegionId")
        sSql = "Delete From tblResultsIRBR Where resultIRBRSessionId = '" & Session.SessionID & "'"
        fnExecuteNonQueryInDB(sSql)
    End If
    
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <!-- <meta http-equiv="refresh" content="<% Response.Write(sqlDtSet.Tables("AutoRefreshTime").Rows(0)(0)) %>" /> -->
    <link href="rct.css" rel="Stylesheet" type="text/css" />
    <link href="datepickercontrol.css" rel="Stylesheet" type="text/css" />
    <script type="text/javascript" language="JavaScript" src="rct.js"></script>
    <script type="text/javascript" language="JavaScript" src="datepickercontrol.js"></script>
    <title><% Response.Write(sPageTitle)%></title>
</head>
<body onload="fnReload();">

<script language="javascript" type="text/javascript">
    function fnReload() {
        setTimeout("document.location='results_region_individual.aspx?eid=<% Response.Write(Request.QueryString("eid")) %>&cid=<% Response.Write(Request.QueryString("cid")) %>&rid=<% Response.Write(iRegionIdToShow) %>&reid=<% Response.Write(iRegionEventIdToShow) %>'", <% Response.Write(sqlDtSet.Tables("AutoRefreshTime").Rows(0)(0)) %>000);
    }
</script>
<center>
        <br />
        <!-- ================================= -->
        <!-- ===== TABLEAU DES RÉSULTATS ===== -->

        <table border="0" cellpadding="0" cellspacing="0" bgcolor="#ffffff">
        <tr>
            <td colspan="5" class="LineHorizo2PX"></td>
        <tr>
            <td class="LineVertico2PX"></td>
            <td width="180" align="center" valign="middle"><img src="pics/flags/<% Response.Write(sqlDtSet.Tables("Region").Rows(0)("regionFlagLogo")) %>" height="75" alt="<% Response.Write(sqlDtSet.Tables("Region").Rows(0)("regionNameEn")) %>" /></td>
            <td class="LineVertico2PX"></td>
            <td>
                <table border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td colspan="29" height="30" class="TXTResultsTitles"><% Response.Write(sqlDtSet.Tables("Region").Rows(0)("regionNameEn"))%>&nbsp;Individual Results&nbsp;/&nbsp;R&eacute;sultats Individuels&nbsp;<% Response.Write(sqlDtSet.Tables("Region").Rows(0)("regionNameFr"))%></td>
                <tr>
                    <td colspan="29" class="LineHorizo1PX"></td>
                <tr>
                    <td colspan="11" height="30" bgcolor="#c8c8c8" class="TXTResultsRed"><b>Prone&nbsp;position&nbsp;/&nbsp;Position&nbsp;couch&eacute;</b></td>
                    <td class="LineVertico2PX"></td>
                    <td colspan="11" bgcolor="#c8c8c8" class="TXTResultsBlue"><b>Standing&nbsp;position&nbsp;/&nbsp;Position&nbsp;debout</b></td>
                    <td class="LineVertico2PX"></td>
                    <td colspan="5" bgcolor="#c8c8c8" class="TXTResultsGreen"><b>Cumulative&nbsp;/&nbsp;Cumulatif</b></td>
                <tr>
                    <td colspan="29" class="LineHorizo1PX"></td>
                <tr>
                    <%
                        Dim iNbrOpen As Integer = fnGetNbrCompetitors(Request.QueryString("eid"), False)
                        Dim iNbrJunior As Integer = fnGetNbrCompetitors(Request.QueryString("eid"), True)
                    %>
                    <td width="54" height="30" class="TXTResultsRed">Targets<br />Cibles</td>
                    <td class="LineVertico1PX"></td>
                    <td width="54" height="30" class="TXTResultsRed">Score</td>
                    <td class="LineVertico1PX"></td>
                    <td width="54" class="TXTResultsRed">%</td>
                    <td class="LineVertico1PX"></td>
                    <td width="54" class="TXTResultsRed">%<br>(<% Response.Write((dCcValue * 100).ToString(0))%>%)</td>
                    <td class="LineVertico1PX"></td>
                    <td width="52" class="TXTResultsRed">Open<br>/<% Response.Write(iNbrOpen)%></td>
                    <td class="LineVertico1PX"></td>
                    <td width="52" class="TXTResultsRed">Junior<br>/<% Response.Write(iNbrJunior)%></td>
                    <td class="LineVertico2PX"></td>
                    <td width="54" class="TXTResultsBlue">Targets<br />Cibles</td>
                    <td class="LineVertico1PX"></td>
                    <td width="54" class="TXTResultsBlue">Score</td>
                    <td class="LineVertico1PX"></td>
                    <td width="54" class="TXTResultsBlue">%</td>
                    <td class="LineVertico1PX"></td>
                    <td width="54" class="TXTResultsBlue">%<br>(<% Response.Write((dCdValue * 100).ToString(0))%>%)</td>
                    <td class="LineVertico1PX"></td>
                    <td width="52" class="TXTResultsBlue">Open<br>/<% Response.Write(iNbrOpen)%></td>
                    <td class="LineVertico1PX"></td>
                    <td width="52" class="TXTResultsBlue">Junior<br>/<% Response.Write(iNbrJunior)%></td>
                    <td class="LineVertico2PX"></td>
                    <td width="54" class="TXTResultsGreen">100 %<br />(<% Response.Write((dCcValue * 100).ToString(0))%>+<% Response.Write((dCdValue * 100).ToString(0))%>)</td>
                    <td class="LineVertico1PX"></td>
                    <td width="52" class="TXTResultsGreen">Open<br>/<% Response.Write(iNbrOpen)%></td>
                    <td class="LineVertico1PX"></td>
                    <td width="52" class="TXTResultsGreen">Junior<br>/<% Response.Write(iNbrJunior)%></td>
                </table>
            </td>
            <td class="LineVertico2PX"></td>
        <tr>
            <td colspan="5" class="LineHorizo2PX"></td>
        <tr>
            <td class="LineVertico2PX"></td>
            <td colspan="3">
                
                <%
                    sSql = "Select * From tblTeams JOIN tblTeamsTypes ON tblTeams.fkTeamTypeId=tblTeamsTypes.teamTypeId Where fkRegionEventId = " & Request.QueryString("reid")
                    sqlDtSet.Tables.Add("Teams").Merge(fnGetDataTableInDB(sSql))
                    
                    Dim oIndividualResults As cIndividualResults
                    Dim sCompetitorName As String
                    Dim sLineColor As String = "#ffffff"

                    For i = 0 To sqlDtSet.Tables("Teams").Rows.Count - 1
                        
                        sPublicHtmlTeam = sPublicTemplateTeam.Replace("#TeamNameEn#", Server.HtmlEncode(sqlDtSet.Tables("Teams").Rows(i)("teamNameEn")))
                        sPublicHtmlTeam = sPublicHtmlTeam.Replace("#CcValue#", (dCcValue * 100).ToString(0))
                        sPublicHtmlTeam = sPublicHtmlTeam.Replace("#CdValue#", (dCdValue * 100).ToString(0))
                        sPublicHtmlTeam = sPublicHtmlTeam.Replace("#NbrOpen#", iNbrOpen)
                        sPublicHtmlTeam = sPublicHtmlTeam.Replace("#NbrJunior#", iNbrJunior)
                        sPublicHtmlCompetitors = ""
                        
                        iTid = sqlDtSet.Tables("Teams").Rows(i)("teamId")
                        sSql = "Select * From vwTeamsCompetitorsCompetitorsCategoriesGenders Where fkTeamId = " & iTid & " Order By teamCompetitorSerial"
                        sqlDtSet.Tables.Add("TeamCompetitors_" & iTid).Merge(fnGetDataTableInDB(sSql))

                %>
                
                <table border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td width="60" rowspan="<% Response.Write(sqlDtSet.Tables("TeamCompetitors_" & iTid).Rows.Count) %>" class="TXTResultsBlack" align="center" valign="middle">
                        <% Response.Write(sqlDtSet.Tables("Teams").Rows(i)("teamSerial"))%><br />
                        <% Response.Write(sqlDtSet.Tables("Teams").Rows(i)("teamNameFr"))%>
                    </td>
                    <td class="LineVertico1PX" rowspan="<% Response.Write(sqlDtSet.Tables("TeamCompetitors_" & iTid).Rows.Count) %>"></td>
                    
                    <% For ii = 0 To sqlDtSet.Tables("TeamCompetitors_" & iTid).Rows.Count - 1%>
                    <%
                        oIndividualResults = fnResultsIndividual(sqlDtSet.Tables("TeamCompetitors_" & iTid).Rows(ii)("teamCompetitorId"), Request.QueryString("eid"), iCcid, iCdid, dCcValue, dCdValue, iACRPO, iACRPJ, iACRSO, iACRSJ, iACGRO, iACGRJ)
                        
                        If sLineColor = "#c8c8c8" Then
                            sLineColor = "#ffffff"
                        Else
                            sLineColor = "#c8c8c8"
                        End If
                        
                        sCompetitorName = sqlDtSet.Tables("TeamCompetitors_" & iTid).Rows(ii)("teamCompetitorLastName") & " " & sqlDtSet.Tables("TeamCompetitors_" & iTid).Rows(ii)("teamCompetitorFirstName")
                        If sCompetitorName.Length >= 16 Then
                            sCompetitorName = sCompetitorName.Substring(0,14) & "..."
                        End If
                        
                        sPublicHtmlCompetitor = sPublicTemplateCompetitor.Replace("#CompetitorLastName#", Server.HtmlEncode(sqlDtSet.Tables("TeamCompetitors_" & iTid).Rows(ii)("teamCompetitorLastName").ToString()))
                        sPublicHtmlCompetitor = sPublicHtmlCompetitor.Replace("#CompetitorFirstName#", Server.HtmlEncode(sqlDtSet.Tables("TeamCompetitors_" & iTid).Rows(ii)("teamCompetitorFirstName").ToString()))
                        sPublicHtmlCompetitor = sPublicHtmlCompetitor.Replace("#ProneTargets#", oIndividualResults.NbrCiblesCoucher)
                        sPublicHtmlCompetitor = sPublicHtmlCompetitor.Replace("#StandingTargets#", oIndividualResults.NbrCiblesDebout)
                        sPublicHtmlCompetitor = sPublicHtmlCompetitor.Replace("#ProneTargetsTotal#", iNbrProneTargetsTotal)
                        sPublicHtmlCompetitor = sPublicHtmlCompetitor.Replace("#StandingTargetsTotal#", iNbrStandingTargetsTotal)
                        sPublicHtmlCompetitor = sPublicHtmlCompetitor.Replace("#ProneScore#", oIndividualResults.PointageCoucher)
                        sPublicHtmlCompetitor = sPublicHtmlCompetitor.Replace("#StandingScore#", oIndividualResults.PointageDebout)
                        sPublicHtmlCompetitor = sPublicHtmlCompetitor.Replace("#TotalScore#", oIndividualResults.PointageCoucher + oIndividualResults.PointageDebout)
                        sPublicHtmlCompetitor = sPublicHtmlCompetitor.Replace("#PronePc#", oIndividualResults.MoyenneCoucher.ToString("F"))
                        sPublicHtmlCompetitor = sPublicHtmlCompetitor.Replace("#StandingPc#", oIndividualResults.MoyenneDebout.ToString("F"))
                        sPublicHtmlCompetitor = sPublicHtmlCompetitor.Replace("#TotalPc#", ((oIndividualResults.MoyenneCoucher + oIndividualResults.MoyenneDebout) / 2).ToString("F"))
                        sPublicHtmlCompetitor = sPublicHtmlCompetitor.Replace("#ProneAv#", oIndividualResults.MoyenneCoucherTotal.ToString("F"))
                        sPublicHtmlCompetitor = sPublicHtmlCompetitor.Replace("#StandingAv#", oIndividualResults.MoyenneDeboutTotal.ToString("F"))
                        sPublicHtmlCompetitor = sPublicHtmlCompetitor.Replace("#TotalAv#", oIndividualResults.MoyenneTotale.ToString("F"))
                        sPublicHtmlCompetitor = sPublicHtmlCompetitor.Replace("#OpenProneRank#", oIndividualResults.ClassementCoucherOuvert)
                        sPublicHtmlCompetitor = sPublicHtmlCompetitor.Replace("#OpenStandingRank#", oIndividualResults.ClassementDeboutOuvert)
                        sPublicHtmlCompetitor = sPublicHtmlCompetitor.Replace("#OpenRank#", oIndividualResults.ClassementOuvert)
                        
                        If Not (oIndividualResults.ClassementCoucherJunior = 0) Then
                            sPublicHtmlCompetitor = sPublicHtmlCompetitor.Replace("#JuniorProneRank#", oIndividualResults.ClassementCoucherJunior)
                        Else
                            sPublicHtmlCompetitor = sPublicHtmlCompetitor.Replace("#JuniorProneRank#", "")
                        End If
                        If Not (oIndividualResults.ClassementDeboutJunior = 0) Then
                            sPublicHtmlCompetitor = sPublicHtmlCompetitor.Replace("#JuniorStandingRank#", oIndividualResults.ClassementDeboutJunior)
                        Else
                            sPublicHtmlCompetitor = sPublicHtmlCompetitor.Replace("#JuniorStandingRank#", "")
                        End If
                        If Not (oIndividualResults.ClassementJunior = 0) Then
                            sPublicHtmlCompetitor = sPublicHtmlCompetitor.Replace("#JuniorRank#", oIndividualResults.ClassementJunior)
                        Else
                            sPublicHtmlCompetitor = sPublicHtmlCompetitor.Replace("#JuniorRank#", "")
                        End If
                        sPublicHtmlCompetitors = sPublicHtmlCompetitors & sPublicHtmlCompetitor
                        
                        If ii <> sqlDtSet.Tables("TeamCompetitors_" & iTid).Rows.Count - 1 Then
                            sPublicHtmlCompetitors = sPublicHtmlCompetitors & sPublicTemplateSpacing
                        End If
                    %>
                    
                    <td width="119" height="25" align="left" bgcolor="<% Response.Write(sLineColor) %>" class="TXTResultsBlack" style="text-align:left;">&nbsp;<% Response.Write(sCompetitorName)%></td>
                    <td class="LineVertico2PX"></td>
                    <td width="54" class="TXTResultsRed" bgcolor="<% Response.Write(sLineColor) %>"><% Response.Write(oIndividualResults.NbrCiblesCoucher)%>/<% Response.Write(iNbrProneTargetsTotal)%></td>
                    <td class="LineVertico1PX"></td>
                    <td width="54" class="TXTResultsRed" bgcolor="<% Response.Write(sLineColor) %>"><% Response.Write(oIndividualResults.PointageCoucher)%></td>
                    <td class="LineVertico1PX"></td>
                    <td width="54" class="TXTResultsRed" bgcolor="<% Response.Write(sLineColor) %>"><% Response.Write(oIndividualResults.MoyenneCoucher.ToString("F"))%></td>
                    <td class="LineVertico1PX"></td>
                    <td width="54" class="TXTResultsRed" bgcolor="<% Response.Write(sLineColor) %>"><% Response.Write(oIndividualResults.MoyenneCoucherTotal.ToString("F"))%></td>
                    <td class="LineVertico1PX"></td>
                    <td width="52" class="TXTResultsRed" bgcolor="<% Response.Write(sLineColor) %>"><% Response.Write(oIndividualResults.ClassementCoucherOuvert)%></td>
                    <td class="LineVertico1PX"></td>
                    <td width="52" class="TXTResultsRed" bgcolor="<% Response.Write(sLineColor) %>"><%
                                       If Not (oIndividualResults.ClassementCoucherJunior = 0) Then
                                           Response.Write(oIndividualResults.ClassementCoucherJunior)
                                       End If
                                   %></td>
                    <td class="LineVertico2PX"></td>
                    <td width="54" class="TXTResultsBlue" bgcolor="<% Response.Write(sLineColor) %>"><% Response.Write(oIndividualResults.NbrCiblesDebout)%>/<% Response.Write(iNbrStandingTargetsTotal)%></td>
                    <td class="LineVertico1PX"></td>
                    <td width="54" class="TXTResultsBlue" bgcolor="<% Response.Write(sLineColor) %>"><% Response.Write(oIndividualResults.PointageDebout)%></td>
                    <td class="LineVertico1PX"></td>
                    <td width="54" class="TXTResultsBlue" bgcolor="<% Response.Write(sLineColor) %>"><% Response.Write(oIndividualResults.MoyenneDebout.ToString("F"))%></td>
                    <td class="LineVertico1PX"></td>
                    <td width="54" class="TXTResultsBlue" bgcolor="<% Response.Write(sLineColor) %>"><% Response.Write(oIndividualResults.MoyenneDeboutTotal.ToString("F"))%></td>
                    <td class="LineVertico1PX"></td>
                    <td width="52" class="TXTResultsBlue" bgcolor="<% Response.Write(sLineColor) %>"><% Response.Write(oIndividualResults.ClassementDeboutOuvert)%></td>
                    <td class="LineVertico1PX"></td>
                    <td width="52" class="TXTResultsBlue" bgcolor="<% Response.Write(sLineColor) %>"><% 
                                       If Not (oIndividualResults.ClassementDeboutJunior = 0) Then
                                           Response.Write(oIndividualResults.ClassementDeboutJunior)
                                       End If
                                   %></td>
                    <td class="LineVertico2PX"></td>
                    <td width="54" class="TXTResultsGreen" bgcolor="<% Response.Write(sLineColor) %>"><% Response.Write(oIndividualResults.MoyenneTotale.ToString("F"))%></td>
                    <td class="LineVertico1PX"></td>
                    <td width="52" class="TXTResultsGreen" bgcolor="<% Response.Write(sLineColor) %>"><% Response.Write(oIndividualResults.ClassementOuvert)%></td>
                    <td class="LineVertico1PX"></td>
                    <td width="52" class="TXTResultsGreen" bgcolor="<% Response.Write(sLineColor) %>"><%
                                       If Not (oIndividualResults.ClassementJunior = 0) Then
                                           Response.Write(oIndividualResults.ClassementJunior)
                                       End If
                                   %></td>
                    <% If ii <> sqlDtSet.Tables("TeamCompetitors_" & iTid).Rows.Count - 1 Then%>
                <tr>
                    <% End If%>
                    <% Next%>
                    <%
                        sPublicHtmlTeam = sPublicHtmlTeam.Replace("#Competitors#", sPublicHtmlCompetitors)
                        sPublicHtmlTeams = sPublicHtmlTeams & sPublicHtmlTeam
                    %>
                <tr>
                    <td colspan="33" class="LineHorizo2PX"></td>
                </table>

                <% Next %>

                <%
                    sPublicHtml = sPublicHtml.Replace("#Teams#", sPublicHtmlTeams)
                    sPublicHtml = sPublicHtml.Replace("#UpdatedDate#", Date.UtcNow.ToString() & " (UTC/GMT)")
                    'fnCreateTextFile(sPublicHtml, "public_results_eid-" & Request.QueryString("eid") & "_region_" & sqlDtSet.Tables("Region").Rows(0)("regionNameEn").ToString().ToLower().Replace(" ", "") & "_individual.html")
                    
                    If bShowPublicResults Then
                        fnPutPublicHtmlTextInDb("eid-" & Request.QueryString("eid") & "_rid-" & sqlDtSet.Tables("Region").Rows(0)("regionId").ToString().ToLower().Replace(" ", "") & "_ri", sPublicHtml)
                    End If
                %>
            </td>
            <td class="LineHorizo2PX"></td>
        </table>

        <!-- ===== TABLEAU DES RÉSULTATS ===== -->
        <!-- ================================= -->

</center>

</body>
</html>
