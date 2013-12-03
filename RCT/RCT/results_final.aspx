<%@ Page Language="VB" AutoEventWireup="false" CodeFile="functions.aspx.vb" Inherits="functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
    
    'iQPCid = Integer Qualification Prone Competition ID
    'iQSCid = Integer Qualification Standing Competition ID
    'iFPCid = Integer Final Prone Competition ID
    'iFSCid = Integer Final Standing Competition ID
    
    'iQPTTQ = Integer Qualification Prone Targets Total Quantity
    'iQSTTQ = Integer Qualification Standing Targets Total Quantity
    'iFPTTQ = Integer Final Prone Targets Total Quantity
    'iFSTTQ = Integer Final Standing Targets Total Quantity
    
    'dQPCValue = Decimal Qualification Prone Competition Value
    'dQSCValue = Decimal Qualification Standing Competition Value
    'dFPCValue = Decimal Final Prone Competition Value
    'dFSCValue = Decimal Final Standing Competition Value
    
    Dim i, ii, iJunior, iQPCid, iQSCid, iFPCid, iFSCid, iQSTTQ, iQPTTQ, iFSTTQ, iFPTTQ, iColSpan As Integer
    Dim dQPCValue, dQSCValue, dFPCValue, dFSCValue As Decimal
    Dim sLineColor As String = "#ffffff"
    Dim sTemplateProneTargets As String = fnGetTextInTemplate("template_results_final_tenpronetargets.html")
    Dim sTemplateStandingTargets As String = fnGetTextInTemplate("template_results_final_tenstandingtargets.html")
    Dim sFPTargets, sFSTargets As String
    
    'Récupération des données sur la Finale
    Dim sSql As String = "Select * From tblCompetitionsChapters Where fkCompetitionId = " & Request.QueryString("cid")
    Dim sqlDtSet As System.Data.DataSet = fnGetDataSetInDB(sSql, "ChapterFinal")
    For i = 0 To sqlDtSet.Tables("ChapterFinal").Rows.Count - 1
        
        If sqlDtSet.Tables("ChapterFinal").Rows(i)("fkCompetitionTypeId") = 1 Then
            iFSCid = sqlDtSet.Tables("ChapterFinal").Rows(i)("competitionChapterId")
            dFSCValue = sqlDtSet.Tables("ChapterFinal").Rows(i)("competitionChapterValue")
            iFSTTQ = sqlDtSet.Tables("ChapterFinal").Rows(i)("competitionChapterNbrTargets")
        ElseIf sqlDtSet.Tables("ChapterFinal").Rows(i)("fkCompetitionTypeId") = 2 Then
            iFPCid = sqlDtSet.Tables("ChapterFinal").Rows(i)("competitionChapterId")
            dFPCValue = sqlDtSet.Tables("ChapterFinal").Rows(i)("competitionChapterValue")
            iFPTTQ = sqlDtSet.Tables("ChapterFinal").Rows(i)("competitionChapterNbrTargets")
        Else
            iFPCid = 0
            iFSCid = 0
            dFPCValue = 0
            dFSCValue = 0
            iFPTTQ = 0
            iFSTTQ = 0
        End If
        
    Next
    
    'Récupération des données sur la Qualification
    sSql = "Select * From tblCompetitionsChapters Inner Join tblCompetitions On tblCompetitionsChapters.fkCompetitionId=tblCompetitions.competitionId Where fkEventId = " & Request.QueryString("eid") & " And competitionId <> " & Request.QueryString("cid")
    sqlDtSet.Tables.Add("ChapterQualification").Merge(fnGetDataTableInDB(sSql))
    For i = 0 To sqlDtSet.Tables("ChapterQualification").Rows.Count - 1
        
        If sqlDtSet.Tables("ChapterQualification").Rows(i)("fkCompetitionTypeId") = 1 Then
            iQSCid = sqlDtSet.Tables("ChapterQualification").Rows(i)("competitionChapterId")
            dQSCValue = sqlDtSet.Tables("ChapterQualification").Rows(i)("competitionChapterValue")
            iQSTTQ = sqlDtSet.Tables("ChapterQualification").Rows(i)("competitionChapterNbrTargets")
        ElseIf sqlDtSet.Tables("ChapterQualification").Rows(i)("fkCompetitionTypeId") = 2 Then
            iQPCid = sqlDtSet.Tables("ChapterQualification").Rows(i)("competitionChapterId")
            dQPCValue = sqlDtSet.Tables("ChapterQualification").Rows(i)("competitionChapterValue")
            iQPTTQ = sqlDtSet.Tables("ChapterQualification").Rows(i)("competitionChapterNbrTargets")
        Else
            iQPCid = 0
            iQSCid = 0
            dQPCValue = 0
            dQSCValue = 0
            iQPTTQ = 0
            iQSTTQ = 0
        End If
        
    Next
    
    'Assigantion du ColSpan selon le nombre de cibles
    iColSpan = 25 + (((iFPTTQ / 2) - 1) * 2) + (((iFSTTQ / 2) - 1) * 2)
    
    'Récupération des compétiteurs qualifiés pour la finale
    sSql = "Select * From tblTeamsCompetitors Inner Join tblTeams On tblTeamsCompetitors.fkTeamId=tblTeams.teamId Inner Join tblRegionsEvents On tblTeams.fkRegionEventId=tblRegionsEvents.regionEventId Inner Join tblRegions On tblRegionsEvents.fkRegionId=tblRegions.regionId Where teamCompetitorFinalSelected = 1 And fkEventId = " & Request.QueryString("eid")
    sqlDtSet.Tables.Add("Competitors").Merge(fnGetDataTableInDB(sSql))
    
    'Récupération des résultats des compétiteurs
    Dim oIndividualFinalResults() As cIndividualFinalResults = fnGetIndividualFinalResults(sqlDtSet.Tables("Competitors"), iQPCid, iQSCid, iFPCid, iFSCid, dQPCValue, dQSCValue, dFPCValue, dFSCValue, iFPTTQ, iFSTTQ)
    
    iJunior = 0
    
    'Affichage pour le côté public
    sSql = "Select eventShowPublicResults From tblEvents Where eventId = " & Request.QueryString("eid")
    sqlDtSet.Tables.Add("ShowPublicResults").Merge(fnGetDataTableInDB(sSql))
    Dim bShowPublicResults As Boolean = sqlDtSet.Tables("ShowPublicResults").Rows(0)(0)
    
    'Valeur d'autorefresh
    sSql = "Select paramValue From tblParamsNumeric Where paramName = 'AutoRefreshTime'"
    sqlDtSet.Tables.Add("AutoRefreshTime").Merge(fnGetDataTableInDB(sSql))
    
    Dim sPublicHtml As String = fnGetTextInTemplate("template_results_public_final.html")
    Dim sTemplateHtmlCompetitors As String = fnGetTextInTemplate("template_results_public_final_competitor.html")
    Dim sTemplateHtmlLine As String = fnGetTextInTemplate("template_results_public_final_line1px.html")
    Dim sPublicHtmlCompetitors As String = ""
    
    sPublicHtml = sPublicHtml.Replace("#CcValue#", (dFPCValue * 100).ToString("0"))
    sPublicHtml = sPublicHtml.Replace("#CdValue#", (dFSCValue * 100).ToString("0"))
    
    
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

    <title>Final / Finale</title>
</head>
<body>
<center>
<br />
<table border="0" cellpadding="0" cellspacing="0" style="background-color: #ffffff;">
    
    <tr>
        <td colspan="<% Response.Write(iColSpan) %>" class="LineHorizo2PX"></td>
    <tr>
        <td height="30" class="LineVertico2PX"></td>
        <td colspan="5" align="center" valign="middle" class="TXTResultsBlack"><b>Final<br />Finale</b></td>
        <td class="LineVertico2PX"></td>
        <td colspan="<% Response.Write((((iFPTTQ / 2) - 1) * 2)+5) %>" align="center" valign="middle" class="TXTResultsRed"><b>Prone position<br />Position couch&eacute;e</b></td>
        <td class="LineVertico2PX"></td>
        <td colspan="<% Response.Write((((iFSTTQ / 2) - 1) * 2)+5) %>" align="center" valign="middle" class="TXTResultsBlue"><b>Standing position<br />Position debout</b></td>
        <td class="LineVertico2PX"></td>
        <td colspan="5" align="center" valign="middle" class="TXTResultsBlack"><b>Cumulative<br />Cumulatif</b></td>
        <td class="LineVertico2PX"></td>

    <tr>
        <td colspan="<% Response.Write(iColSpan) %>" class="LineHorizo2PX"></td>
    <tr>
        <td height="31" class="LineVertico2PX"></td>
        <td width="82" class="TXTResultsBlack">Provinces</td>
        <td class="LineVertico1PX"></td>
        <td width="110" class="TXTResultsBlack">Competitors<br />Comp&eacute;titeurs</td>
        <td class="LineVertico1PX"></td>
        <td width="50" class="TXTResultsGreen">Qualif.</td>
        <td class="LineVertico2PX"></td>

        <% For i = 0 To (iFPTTQ / 2) - 1%>
        <td align="center" valign="middle">
            <table border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td width="22" height="15" class="TXTResultsRedTiny"><% Response.Write(i + 1)%></td>
            <tr>
                <td class="LineHorizo1PX"></td>
            <tr>
                <td height="15" class="TXTResultsRedTiny"><% Response.Write((iFPTTQ / 2) + (i + 1))%></td>
            </table>
        </td>
        <td class="LineVertico1PX"></td>
        
        <% Next%>

        <td width="50" class="TXTResultsRed">Score<br />Point.</td>
        <td class="LineVertico1PX"></td>
        <td width="50" class="TXTResultsRed"><% Response.Write((dFPCValue * 100).ToString("0"))%>%</td>
        <td class="LineVertico2PX"></td>

        <% For i = 0 To (iFSTTQ / 2) - 1%>
        <td align="center" valign="middle">
            <table border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td width="22" height="15" class="TXTResultsBlueTiny"><% Response.Write(i + 1)%></td>
            <tr>
                <td class="LineHorizo1PX"></td>
            <tr>
                <td height="15" class="TXTResultsBlueTiny"><% Response.Write((iFSTTQ / 2) + (i + 1))%></td>
            </table>
        </td>
        <td class="LineVertico1PX"></td>

        <% Next%>
        
        <td width="50" class="TXTResultsBlue">Score<br />Point.</td>
        <td class="LineVertico1PX"></td>
        <td width="50" class="TXTResultsBlue"><% Response.Write((dFSCValue * 100).ToString("0"))%>%</td>
        <td class="LineVertico2PX"></td>
        <td width="50" class="TXTResultsGreen">100%<br />(<% Response.Write((dFPCValue * 100).ToString("0"))%>+<% Response.Write((dFSCValue * 100).ToString("0"))%>)</td>
        <td class="LineVertico1PX"></td>
        <td width="47" class="TXTResultsBlack">Open<br />Ouvert</td>
        <td class="LineVertico1PX"></td>
        <td width="47" class="TXTResultsBlack">Junior</td>
        <td class="LineVertico2PX"></td>
    <tr>
        <td colspan="<% Response.Write(iColSpan) %>" class="LineHorizo2PX"></td>
    
    
    <% For i = 0 To oIndividualFinalResults.Length - 1%>
    <%
        If sLineColor = "#ededec" Then
            sLineColor = "#ffffff"
        Else
            sLineColor = "#ededec"
        End If
       
        sPublicHtmlCompetitors = sPublicHtmlCompetitors & sTemplateHtmlCompetitors
        sPublicHtmlCompetitors = sPublicHtmlCompetitors & sTemplateHtmlLine
        sPublicHtmlCompetitors = sPublicHtmlCompetitors.Replace("#Province#", oIndividualFinalResults(i).CompetitorRegionLetterEn)
        sPublicHtmlCompetitors = sPublicHtmlCompetitors.Replace("#LastName#", oIndividualFinalResults(i).CompetitorLastName)
        sPublicHtmlCompetitors = sPublicHtmlCompetitors.Replace("#FirstName#", oIndividualFinalResults(i).CompetitorFirstName)
        sPublicHtmlCompetitors = sPublicHtmlCompetitors.Replace("#Qualification#", oIndividualFinalResults(i).QAvegare.ToString("F"))
        sPublicHtmlCompetitors = sPublicHtmlCompetitors.Replace("#ProneScore#", oIndividualFinalResults(i).FProneScore.ToString("F1"))
        sPublicHtmlCompetitors = sPublicHtmlCompetitors.Replace("#StandingScore#", oIndividualFinalResults(i).FStandingScore.ToString("F1"))
        sPublicHtmlCompetitors = sPublicHtmlCompetitors.Replace("#ProneAverage#", oIndividualFinalResults(i).FProneAverage.ToString("F"))
        sPublicHtmlCompetitors = sPublicHtmlCompetitors.Replace("#StandingAverage#", oIndividualFinalResults(i).FStandingAverage.ToString("F"))
        
        sPublicHtmlCompetitors = sPublicHtmlCompetitors.Replace("#Average#", oIndividualFinalResults(i).FAverage.ToString("F"))
        sPublicHtmlCompetitors = sPublicHtmlCompetitors.Replace("#Open#", i + 1)
        
        
        
    %>
    <tr style="background-color:<% Response.Write(sLineColor) %>;">
        <td height="31" class="LineVertico2PX"></td>
        <td width="82" class="TXTResultsBlack" style="text-align:left;">&nbsp;<% Response.Write(oIndividualFinalResults(i).CompetitorRegionNameEn)%></td>
        <td class="LineVertico1PX"></td>
        <td width="110" class="TXTResultsBlack" style="text-align:left;">&nbsp;<% Response.Write(oIndividualFinalResults(i).CompetitorLastName)%><br />&nbsp;<% Response.Write(oIndividualFinalResults(i).CompetitorFirstName)%></td>
        <td class="LineVertico1PX"></td>
        <td width="50" class="TXTResultsGreen"><% Response.Write(oIndividualFinalResults(i).QAvegare.ToString("F"))%></td>
        <td class="LineVertico2PX"></td>
        
        <% 
            For ii = 0 To (iFPTTQ / 2) - 1
                
                If oIndividualFinalResults(i).FProneScores(ii) = 0 Then
                    sFPTargets = sTemplateProneTargets.Replace("#1r#", "")
                    sFPTargets = sFPTargets.Replace("#bgcolor1r#", "")
                    sPublicHtmlCompetitors = sPublicHtmlCompetitors.Replace("#p" & ii + 1 & "#", "")
                Else
                    sFPTargets = sTemplateProneTargets.Replace("#1r#", oIndividualFinalResults(i).FProneScores(ii).ToString("F1"))
                    sPublicHtmlCompetitors = sPublicHtmlCompetitors.Replace("#p" & ii + 1 & "#", oIndividualFinalResults(i).FProneScores(ii).ToString("F1"))
                    
                    If oIndividualFinalResults(i).FProneScores(ii) >= 10 Then
                        sFPTargets = sFPTargets.Replace("#bgcolor1r#", "bgcolor='#FFFF00'")
                        sPublicHtmlCompetitors = sPublicHtmlCompetitors.Replace("#bgcolorp" & ii + 1 & "#", "bgcolor='#FFFF00'")
                    Else
                        sFPTargets = sFPTargets.Replace("#bgcolor1r#", "")
                        sPublicHtmlCompetitors = sPublicHtmlCompetitors.Replace("#bgcolorp" & ii + 1 & "#", "")
                    End If
                    
                End If
                
                If oIndividualFinalResults(i).FProneScores((iFPTTQ / 2) + ii) = 0 Then
                    sFPTargets = sFPTargets.Replace("#2r#", "")
                    sFPTargets = sFPTargets.Replace("#bgcolor2r#", "")
                    sPublicHtmlCompetitors = sPublicHtmlCompetitors.Replace("#p" & (iFPTTQ / 2) + ii + 1 & "#", "")
                Else
                    sFPTargets = sFPTargets.Replace("#2r#", oIndividualFinalResults(i).FProneScores((iFPTTQ / 2) + ii).ToString("F1"))
                    sPublicHtmlCompetitors = sPublicHtmlCompetitors.Replace("#p" & (iFPTTQ / 2) + ii + 1 & "#", oIndividualFinalResults(i).FProneScores((iFPTTQ / 2) + ii).ToString("F1"))
                    
                    If oIndividualFinalResults(i).FProneScores((iFPTTQ / 2) + ii) >= 10 Then
                        sFPTargets = sFPTargets.Replace("#bgcolor2r#", "bgcolor='#FFFF00'")
                        sPublicHtmlCompetitors = sPublicHtmlCompetitors.Replace("#bgcolorp" & (iFPTTQ / 2) + ii + 1 & "#", "bgcolor='#FFFF00'")
                    Else
                        sFPTargets = sFPTargets.Replace("#bgcolor2r#", "")
                        sPublicHtmlCompetitors = sPublicHtmlCompetitors.Replace("#bgcolorp" & (iFPTTQ / 2) + ii + 1 & "#", "")
                    End If
                    
                End If
                
                Response.Write(sFPTargets)
                
            Next
        %>
        <td width="50" class="TXTResultsRed"><% Response.Write(oIndividualFinalResults(i).FProneScore.ToString("F1"))%></td>
        <td class="LineVertico1PX"></td>
        <td width="50" class="TXTResultsRed"><% Response.Write(oIndividualFinalResults(i).FProneAverage.ToString("F"))%></td>
        <td class="LineVertico2PX"></td>

        <% 
            For ii = 0 To (iFSTTQ / 2) - 1
                
                If oIndividualFinalResults(i).FStandingScores(ii) = 0 Then
                    sFSTargets = sTemplateStandingTargets.Replace("#1r#", "")
                    sFSTargets = sFSTargets.Replace("#bgcolor1r#", "")
                    sPublicHtmlCompetitors = sPublicHtmlCompetitors.Replace("#s" & ii + 1 & "#", "")
                Else
                    sFSTargets = sTemplateStandingTargets.Replace("#1r#", oIndividualFinalResults(i).FStandingScores(ii).ToString("F1"))
                    sPublicHtmlCompetitors = sPublicHtmlCompetitors.Replace("#s" & ii + 1 & "#", oIndividualFinalResults(i).FStandingScores(ii).ToString("F1"))
                    
                    If oIndividualFinalResults(i).FStandingScores(ii) >= 10 Then
                        sFSTargets = sFSTargets.Replace("#bgcolor1r#", "bgcolor='#FFFF00'")
                        sPublicHtmlCompetitors = sPublicHtmlCompetitors.Replace("#bgcolors" & ii + 1 & "#", "bgcolor='#FFFF00'")
                    Else
                        sFSTargets = sFSTargets.Replace("#bgcolor1r#", "")
                        sPublicHtmlCompetitors = sPublicHtmlCompetitors.Replace("#bgcolors" & ii + 1 & "#", "")
                    End If
                    
                End If
                
                If oIndividualFinalResults(i).FStandingScores((iFSTTQ / 2) + ii) = 0 Then
                    sFSTargets = sFSTargets.Replace("#2r#", "")
                    sFSTargets = sFSTargets.Replace("#bgcolor2r#", "")
                    sPublicHtmlCompetitors = sPublicHtmlCompetitors.Replace("#s" & (iFSTTQ / 2) + ii + 1 & "#", "")
                Else
                    sFSTargets = sFSTargets.Replace("#2r#", oIndividualFinalResults(i).FStandingScores((iFSTTQ / 2) + ii).ToString("F1"))
                    sPublicHtmlCompetitors = sPublicHtmlCompetitors.Replace("#s" & (iFSTTQ / 2) + ii + 1 & "#", oIndividualFinalResults(i).FStandingScores((iFSTTQ / 2) + ii).ToString("F1"))
                    
                    If oIndividualFinalResults(i).FStandingScores((iFSTTQ / 2) + ii) >= 10 Then
                        sFSTargets = sFSTargets.Replace("#bgcolor2r#", "bgcolor='#FFFF00'")
                        sPublicHtmlCompetitors = sPublicHtmlCompetitors.Replace("#bgcolors" & (iFSTTQ / 2) + ii + 1 & "#", "bgcolor='#FFFF00'")
                    Else
                        sFSTargets = sFSTargets.Replace("#bgcolor2r#", "")
                        sPublicHtmlCompetitors = sPublicHtmlCompetitors.Replace("#bgcolors" & (iFSTTQ / 2) + ii + 1 & "#", "")
                    End If
                    
                End If
                
                Response.Write(sFSTargets)
                
            Next
        %>
        <td width="50" class="TXTResultsBlue"><% Response.Write(oIndividualFinalResults(i).FStandingScore.ToString("F1"))%></td>
        <td class="LineVertico1PX"></td>
        <td width="50" class="TXTResultsBlue"><% Response.Write(oIndividualFinalResults(i).FStandingAverage.ToString("F"))%></td>
        <td class="LineVertico2PX"></td>
        <td width="50" class="TXTResultsGreen"><% Response.Write(oIndividualFinalResults(i).FAverage.ToString("F"))%></td>
        <td class="LineVertico1PX"></td>
        <td width="47" class="TXTResultsBlack"><% Response.Write(i + 1)%></td>
        <td class="LineVertico1PX"></td>
        <td width="47" class="TXTResultsBlack">
            <%
                If oIndividualFinalResults(i).CompetitorJunior Then
                    iJunior = iJunior + 1
                    Response.Write(iJunior)
                    sPublicHtmlCompetitors = sPublicHtmlCompetitors.Replace("#Junior#", iJunior)
                Else
                    sPublicHtmlCompetitors = sPublicHtmlCompetitors.Replace("#Junior#", "")
                End If
            %>
        </td>
        <td class="LineVertico2PX"></td>
    
    <% If i < sqlDtSet.Tables("Competitors").Rows.Count - 1 Then%>
    <tr>
        <td colspan="<% Response.Write(iColSpan) %>" class="LineHorizo1PX"></td>
    <% End If%>
    <% Next%>

    <tr>
        <td colspan="<% Response.Write(iColSpan) %>" class="LineHorizo2PX"></td>

    </table>



<%
    Dim sPublicHtmlTextName As String = "eid-" & Request.QueryString("eid") & "_fn"
    
    sPublicHtml = sPublicHtml.Replace("#Competitors#", sPublicHtmlCompetitors)
        
    If bShowPublicResults Then
        fnPutPublicHtmlTextInDb(sPublicHtmlTextName, sPublicHtml)
    End If
    
%>

</center>

</body>
</html>
