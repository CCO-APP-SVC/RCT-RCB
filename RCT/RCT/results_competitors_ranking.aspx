<%@ Page Language="VB" AutoEventWireup="false" CodeFile="functions.aspx.vb" Inherits="functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
    Dim i, iCcid, iCdid, iNbrProneTragetsTotal, iNbrStandingTargetsTotal As Integer
    Dim dCcValue, dCdValue As Decimal
    Dim sRegionName, sRegionNameHtml, sTeamName, sPublicHtmlTextName As String
    
    Dim sSql As String = "Select * From tblCompetitionsChapters Where fkCompetitionId = " & Request.QueryString("cid")
    Dim sqlDtSet As System.Data.DataSet = fnGetDataSetInDB(sSql, "Chapters")

    For i = 0 To sqlDtSet.Tables("Chapters").Rows.Count - 1
        If sqlDtSet.Tables("Chapters").Rows(i)("fkCompetitionTypeId") = 1 Then
            iCdid = sqlDtSet.Tables("Chapters").Rows(i)("competitionChapterId")
            dCdValue = sqlDtSet.Tables("Chapters").Rows(i)("competitionChapterValue")
            iNbrStandingTargetsTotal = sqlDtSet.Tables("Chapters").Rows(i)("competitionChapterNbrTargets")
        ElseIf sqlDtSet.Tables("Chapters").Rows(i)("fkCompetitionTypeId") = 2 Then
            iCcid = sqlDtSet.Tables("Chapters").Rows(i)("competitionChapterId")
            dCcValue = sqlDtSet.Tables("Chapters").Rows(i)("competitionChapterValue")
            iNbrProneTragetsTotal = sqlDtSet.Tables("Chapters").Rows(i)("competitionChapterNbrTargets")
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
    
    sSql = "Select * From tblTeamsCompetitors Inner Join tblTeams On tblTeamsCompetitors.fkTeamId=tblTeams.teamId Inner Join tblRegionsEvents On tblTeams.fkRegionEventId=tblRegionsEvents.regionEventId Inner Join tblRegions On tblRegionsEvents.fkRegionId=tblRegions.regionId Where fkEventId = " & Request.QueryString("eid")
    sqlDtSet.Tables.Add("Competitors").Merge(fnGetDataTableInDB(sSql))
    
    Dim oCompetitorsResults(sqlDtSet.Tables("Competitors").Rows.Count - 1) As cIndividualResults
    
    For i = 0 To sqlDtSet.Tables("Competitors").Rows.Count - 1
        oCompetitorsResults(i) = fnResultsIndividual(sqlDtSet.Tables("Competitors").Rows(i)("teamCompetitorId"), Request.QueryString("eid"), iCcid, iCdid, dCcValue, dCdValue, iACRPO, iACRPJ, iACRSO, iACRSJ, iACGRO, iACGRJ)
        oCompetitorsResults(i).CompetitorId = sqlDtSet.Tables("Competitors").Rows(i)("teamCompetitorId")
        oCompetitorsResults(i).CompetitorLastName = sqlDtSet.Tables("Competitors").Rows(i)("teamCompetitorLastName").ToString()
        oCompetitorsResults(i).CompetitorFirstName = sqlDtSet.Tables("Competitors").Rows(i)("teamCompetitorFirstName").ToString()
        oCompetitorsResults(i).CompetitorRegionNameFr = sqlDtSet.Tables("Competitors").Rows(i)("regionNameFr").ToString()
        oCompetitorsResults(i).CompetitorRegionNameEn = sqlDtSet.Tables("Competitors").Rows(i)("regionNameEn").ToString()
        oCompetitorsResults(i).CompetitorFlag = sqlDtSet.Tables("Competitors").Rows(i)("regionFlagLogo").ToString()
        oCompetitorsResults(i).CompetitorTeamNameEn = sqlDtSet.Tables("Competitors").Rows(i)("teamNameEn").ToString()
        oCompetitorsResults(i).CompetitorTeamNameFr = sqlDtSet.Tables("Competitors").Rows(i)("teamNameFr").ToString()
    Next
    
    Dim bEncore As Boolean = False
    Dim iTailleTableau As Integer = oCompetitorsResults.Length
    Dim oCompetitorsResultsInter As cIndividualResults = New cIndividualResults
    
    While Not bEncore
        bEncore = True
        For i = 0 To iTailleTableau - 2
            If oCompetitorsResults(i).MoyenneTotale > oCompetitorsResults(i + 1).MoyenneTotale Then

                oCompetitorsResultsInter = oCompetitorsResults(i)
                oCompetitorsResults(i) = oCompetitorsResults(i + 1)
                oCompetitorsResults(i + 1) = oCompetitorsResultsInter

                bEncore = False

            End If
        Next
        iTailleTableau = iTailleTableau - 1
    End While
    
    sSql = "Select paramValue From tblParamsNumeric Where paramName = 'AutoRefreshTime'"
    sqlDtSet.Tables.Add("AutoRefreshTime").Merge(fnGetDataTableInDB(sSql))
    
    sSql = "Select paramValue From tblParamsNumeric Where paramName = 'PublicAutoRefreshTime'"
    sqlDtSet.Tables.Add("PublicAutoRefreshTime").Merge(fnGetDataTableInDB(sSql))
    
    Dim sPublicTemplateMain As String = fnGetTextInTemplate("template_results_competitors_ranking.html")
    Dim sPublicTemplateLine As String = fnGetTextInTemplate("template_results_competitors_ranking_line.html")
    Dim sPublicTemplateSpacing As String = fnGetTextInTemplate("template_results_competitors_ranking_spacing.html")
    Dim sPublicHtml As String = ""
    Dim sPublicHtmlLine As String = ""
    Dim sPublicHtmlLines As String = ""
    
    sPublicHtml = sPublicTemplateMain.Replace("#dCcValue#", (dCcValue * 100).ToString("0"))
    sPublicHtml = sPublicHtml.Replace("#dCdValue#", (dCdValue * 100).ToString("0"))
    sPublicHtml = sPublicHtml.Replace("#NbrTargetsTotal#", iNbrProneTragetsTotal + iNbrStandingTargetsTotal)
    
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
    <title>Competitors Ranking / Classement des Comp&eacute;titeurs</title>
</head>
<body>
<center>
<br />
  
    <table border="0" cellpadding="0" cellspacing="0">
        
        <tr>
            <td colspan="4"></td>
            <td colspan="23" class="LineHorizo2PX"></td>

        <tr>
            <td colspan="4" height="30" class="TXTResultsBlack"></td>
            <td class="LineVertico2PX"></td>
            <td class="TXTResultsBlack" bgcolor="#ffffff" colspan="21" style="font-weight:bold;">Competitors ranking<br />Classement des comp&eacute;titeurs</td>
            <td class="LineVertico2PX"></td>
        
        
        <tr>
            <td colspan="4"></td>
            <td colspan="23" class="LineHorizo1PX"></td>

        <tr>
            <td colspan="4" height="30" class="TXTResultsBlack"></td>
            <td class="LineVertico2PX"></td>
            <td class="TXTResultsRed" bgcolor="#ffffff" colspan="7">Prone position<br />Position couch&eacute;e</td>
            <td class="LineVertico2PX"></td>
            <td class="TXTResultsBlue" bgcolor="#ffffff" colspan="7">Standing position<br />Position debout</td>
            <td class="LineVertico2PX"></td>
            <td class="TXTResultsGreen" bgcolor="#ffffff">Cumul.</td>
            <td class="LineVertico2PX"></td>
            <td class="TXTResultsGreen" bgcolor="#ffffff" colspan="3">Ranking<br />Classement</td>
            <td class="LineVertico2PX"></td>
        
        <tr>
            <td colspan="4"></td>
            <td colspan="23" class="LineHorizo1PX"></td>

        <tr>
            <td colspan="4" height="40" class="TXTResultsBlack"></td>
            <td class="LineVertico2PX"></td>
            <td class="TXTResultsRed" bgcolor="#ffffff">Targets<br />Cibles</td>
            <td class="LineVertico1PX"></td>
            <td class="TXTResultsRed" bgcolor="#ffffff">Score<br />Pointage</td>
            <td class="LineVertico1PX"></td>
            <td class="TXTResultsRed" bgcolor="#ffffff">%</td>
            <td class="LineVertico1PX"></td>
            <td class="TXTResultsRed" bgcolor="#ffffff">%<br />(<% Response.Write((dCcValue * 100).ToString("0"))%>%)</td>
            <td class="LineVertico2PX"></td>
            <td class="TXTResultsBlue" bgcolor="#ffffff">Targets<br />Cibles</td>
            <td class="LineVertico1PX"></td>
            <td class="TXTResultsBlue" bgcolor="#ffffff">Score<br />Pointage</td>
            <td class="LineVertico1PX"></td>
            <td class="TXTResultsBlue" bgcolor="#ffffff">%</td>
            <td class="LineVertico1PX"></td>
            <td class="TXTResultsBlue" bgcolor="#ffffff">%<br />(<% Response.Write((dCdValue * 100).ToString("0"))%>%)</td>
            <td class="LineVertico2PX"></td>
            <td class="TXTResultsGreen" bgcolor="#ffffff">%<br />(<% Response.Write((dCcValue * 100).ToString("0"))%>+<% Response.Write((dCdValue * 100).ToString("0"))%>)</td>
            <td class="LineVertico2PX"></td>
            <td class="TXTResultsGreen" bgcolor="#ffffff">Open<br />Ouvert</td>
            <td class="LineVertico1PX"></td>
            <td class="TXTResultsGreen" bgcolor="#ffffff">Junior</td>
            <td class="LineVertico2PX"></td>
        
        <tr>
            <td colspan="27" class="LineHorizo2PX"></td>

        <%
            For i = 0 To oCompetitorsResults.Length - 1
            
                If oCompetitorsResults(oCompetitorsResults.Length - 1 - i).CompetitorTeamNameEn = oCompetitorsResults(oCompetitorsResults.Length - 1 - i).CompetitorTeamNameFr Then
                    sRegionNameHtml = "&nbsp;" & oCompetitorsResults(oCompetitorsResults.Length - 1 - i).CompetitorTeamNameEn
                Else
                    sRegionNameHtml = "&nbsp;" & Server.HtmlEncode(oCompetitorsResults(oCompetitorsResults.Length - 1 - i).CompetitorTeamNameEn) & "<br>&nbsp;" & Server.HtmlEncode(oCompetitorsResults(oCompetitorsResults.Length - 1 - i).CompetitorTeamNameFr)
                End If
                
                sPublicHtmlLine = sPublicTemplateLine.Replace("#LastName#", Server.HtmlEncode(oCompetitorsResults(oCompetitorsResults.Length - 1 - i).CompetitorLastName))
                sPublicHtmlLine = sPublicHtmlLine.Replace("#FirstName#", Server.HtmlEncode(oCompetitorsResults(oCompetitorsResults.Length - 1 - i).CompetitorFirstName))
                sPublicHtmlLine = sPublicHtmlLine.Replace("#LastName#", Server.HtmlEncode(oCompetitorsResults(oCompetitorsResults.Length - 1 - i).CompetitorLastName))
                sPublicHtmlLine = sPublicHtmlLine.Replace("#TeamName#", sRegionNameHtml)
                sPublicHtmlLine = sPublicHtmlLine.Replace("#NbrTargets#", oCompetitorsResults(oCompetitorsResults.Length - 1 - i).NbrCiblesCoucher + oCompetitorsResults(oCompetitorsResults.Length - 1 - i).NbrCiblesDebout)
                sPublicHtmlLine = sPublicHtmlLine.Replace("#ProneAv#", oCompetitorsResults(oCompetitorsResults.Length - 1 - i).MoyenneCoucherTotal.ToString("F"))
                sPublicHtmlLine = sPublicHtmlLine.Replace("#StandingAv#", oCompetitorsResults(oCompetitorsResults.Length - 1 - i).MoyenneDeboutTotal.ToString("F"))
                sPublicHtmlLine = sPublicHtmlLine.Replace("#Cumulative#", oCompetitorsResults(oCompetitorsResults.Length - 1 - i).MoyenneTotale.ToString("F"))
                sPublicHtmlLine = sPublicHtmlLine.Replace("#OpenRanking#", oCompetitorsResults(oCompetitorsResults.Length - 1 - i).ClassementOuvert)
                
                If Not (oCompetitorsResults(oCompetitorsResults.Length - 1 - i).ClassementJunior = 0) Then
                    sPublicHtmlLine = sPublicHtmlLine.Replace("#JuniorRanking#", oCompetitorsResults(oCompetitorsResults.Length - 1 - i).ClassementJunior)
                Else
                    sPublicHtmlLine = sPublicHtmlLine.Replace("#JuniorRanking#", "")
                End If
                
                If i = oCompetitorsResults.Length - 1 Then
                    sPublicHtmlLines = sPublicHtmlLines & sPublicHtmlLine
                Else
                    sPublicHtmlLines = sPublicHtmlLines & sPublicHtmlLine & sPublicTemplateSpacing
                End If
                
            Next
        %>


        <% For i = 0 To 14%>

            <%
                If oCompetitorsResults(oCompetitorsResults.Length - 1 - i).CompetitorTeamNameEn = oCompetitorsResults(oCompetitorsResults.Length - 1 - i).CompetitorTeamNameFr Then
                    sTeamName = oCompetitorsResults(oCompetitorsResults.Length - 1 - i).CompetitorTeamNameEn
                Else
                    sTeamName = oCompetitorsResults(oCompetitorsResults.Length - 1 - i).CompetitorTeamNameEn & "<br>" & oCompetitorsResults(oCompetitorsResults.Length - 1 - i).CompetitorTeamNameFr
                End If
                
            %>
        <tr bgcolor="#ffffff">
            <td class="LineVertico2PX"></td>
            <td width="82" height="40" class="TXTResultsBlack"><img src="pics/flags/<% Response.Write(oCompetitorsResults(oCompetitorsResults.length - 1 - i).CompetitorFlag) %>" height="36" alt="<% Response.Write(sRegionName) %>" /></td>
            <td class="LineVertico1PX"></td>
            <td width="150" class="TXTResultsBlack" style="text-align:left;">&nbsp;<% Response.Write(oCompetitorsResults(oCompetitorsResults.Length - 1 - i).CompetitorLastName)%><br />&nbsp;<% Response.Write(oCompetitorsResults(oCompetitorsResults.Length - 1 - i).CompetitorFirstName)%></td>
            <td class="LineVertico2PX"></td>
            <td width="68" class="TXTResultsRed"><% Response.Write(oCompetitorsResults(oCompetitorsResults.Length - 1 - i).NbrCiblesCoucher)%>/<% Response.Write(iNbrProneTragetsTotal)%></td>
            <td class="LineVertico1PX"></td>
            <td width="68" class="TXTResultsRed"><% Response.Write(oCompetitorsResults(oCompetitorsResults.Length - 1 - i).PointageCoucher)%></td>
            <td class="LineVertico1PX"></td>
            <td width="68" class="TXTResultsRed"><% Response.Write(oCompetitorsResults(oCompetitorsResults.Length - 1 - i).MoyenneCoucher.ToString("F"))%></td>
            <td class="LineVertico1PX"></td>
            <td width="68" class="TXTResultsRed"><% Response.Write(oCompetitorsResults(oCompetitorsResults.Length - 1 - i).MoyenneCoucherTotal.ToString("F"))%></td>
            <td class="LineVertico2PX"></td>
            <td width="68" class="TXTResultsBlue"><% Response.Write(oCompetitorsResults(oCompetitorsResults.Length - 1 - i).NbrCiblesDebout)%>/<% Response.Write(iNbrStandingTargetsTotal)%></td>
            <td class="LineVertico1PX"></td>
            <td width="68" class="TXTResultsBlue"><% Response.Write(oCompetitorsResults(oCompetitorsResults.Length - 1 - i).PointageDebout)%></td>
            <td class="LineVertico1PX"></td>
            <td width="68" class="TXTResultsBlue"><% Response.Write(oCompetitorsResults(oCompetitorsResults.Length - 1 - i).MoyenneDebout.ToString("F"))%></td>
            <td class="LineVertico1PX"></td>
            <td width="68" class="TXTResultsBlue"><% Response.Write(oCompetitorsResults(oCompetitorsResults.Length - 1 - i).MoyenneDeboutTotal.ToString("F"))%></td>
            <td class="LineVertico2PX"></td>
            <td width="68" class="TXTResultsGreen"><% Response.Write(oCompetitorsResults(oCompetitorsResults.Length - 1 - i).MoyenneTotale.ToString("F"))%></td>
            <td class="LineVertico2PX"></td>
            <td width="68" class="TXTResultsGreen"><% Response.Write(oCompetitorsResults(oCompetitorsResults.Length - 1 - i).ClassementOuvert)%></td>
            <td class="LineVertico1PX"></td>
            <td width="68" class="TXTResultsGreen"><%  If Not (oCompetitorsResults(oCompetitorsResults.Length - 1 - i).ClassementJunior = 0) Then
                                                           Response.Write(oCompetitorsResults(oCompetitorsResults.Length - 1 - i).ClassementJunior)
                                                       End If%></td>
            <td class="LineVertico2PX"></td>
        
            <% If i = 14 Then%>
            <tr>
                <td colspan="27" class="LineHorizo2PX"></td>
            <% Else%>
            <tr>
                <td colspan="27" class="LineHorizo1PX"></td>
            <% End If%>

        <%
            Next
            
        sPublicHtml = sPublicHtml.Replace("#Values#", sPublicHtmlLines)
        sPublicHtml = sPublicHtml.Replace("#UpdatedDate#", Date.UtcNow.ToString() & " (UTC/GMT)")
        'sPublicHtml = sPublicHtml.Replace("#AutoRefreshTime#", sqlDtSet.Tables("PublicAutoRefreshTime").Rows(0)(0).ToString())
        
        'fnCreateTextFile(sPublicHtml, "public_results_eid-" & Request.QueryString("eid") & "_competitors_ranking.html")
        
        ' PublicHtmlTextName = "eid-##_cr"
        ' eid = Event ID
        ' cr = Competitors Ranking
        sPublicHtmlTextName = "eid-" & Request.QueryString("eid") & "_cr"
        
        If bShowPublicResults Then
            fnPutPublicHtmlTextInDb(sPublicHtmlTextName, sPublicHtml)
        End If
        
        %>
    
    
    
    </table>

</center>
</body>
</html>
