<%@ Page Language="VB" AutoEventWireup="false" CodeFile="functions.aspx.vb" Inherits="functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
    Dim sSql As String = "Select * From tblCompetitionsChapters Where fkCompetitionId = " & Request.QueryString("cid")
    Dim sqlDtSet As System.Data.DataSet = fnGetDataSetInDB(sSql, "Chapters")
    Dim i, ii, iCcid, iCdid As Integer
    Dim dCcValue, dCdValue As Decimal
    Dim sLineColor As String = ""
    Dim sLineBold As String = "style='font-weight: bold;'"
                    
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
    
    Dim aRegionsRanking() As cRegionRanking
    aRegionsRanking = fnRegionsRanking(Request.QueryString("eid"), iCcid, iCdid, dCcValue, dCdValue)
    
    Dim sPublicTemplateMain As String = fnGetTextInTemplate("template_results_regions_ranking.html")
    Dim sPublicTemplateLine As String = fnGetTextInTemplate("template_results_regions_ranking_line.html")
    Dim sPublicTemplateSpacing As String = fnGetTextInTemplate("template_results_regions_ranking_spacing.html")
    Dim sPublicHtmlText As String = ""
    Dim sPublicHtmlTextLines As String = ""
    
    Dim sRegionName As String = ""
    
    sSql = "Select paramValue From tblParamsNumeric Where paramName = 'AutoRefreshTime'"
    sqlDtSet.Tables.Add("AutoRefreshTime").Merge(fnGetDataTableInDB(sSql))
    
    sSql = "Select eventShowPublicResults From tblEvents Where eventId = " & Request.QueryString("eid")
    sqlDtSet.Tables.Add("ShowPublicResults").Merge(fnGetDataTableInDB(sSql))
    Dim bShowPublicResults As Boolean = sqlDtSet.Tables("ShowPublicResults").Rows(0)(0)
    
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="refresh" content="<% Response.Write(sqlDtSet.Tables("AutoRefreshTime").Rows(0)(0)) %>" />
    <link href="rct.css" rel="Stylesheet" type="text/css" />
    <link href="datepickercontrol.css" rel="Stylesheet" type="text/css" />
    <script type="text/javascript" language="JavaScript" src="rct.js"></script>
    <script type="text/javascript" language="JavaScript" src="datepickercontrol.js"></script>
    <title>Ranking / Classement</title>
</head>
<body>
<center>
<br />

        <table border="0" cellpadding="0" cellspacing="0" class="TXTResultsBlack">
        <tr>
            <td colspan="9" class="LineHorizo2PX"></td>
        <tr bgcolor="#ffffff" style="font-weight: bold;">
            <td height="40" class="LineVertico2PX"></td>
            <td colspan="3" align="center" valign="middle">Province</td>
            <td class="LineVertico1PX"></td>
            <td align="center" valign="middle">Score<br />Pointage</td>
            <td class="LineVertico1PX"></td>
            <td align="center" valign="middle">Rank<br />Position</td>
            <td class="LineVertico2PX"></td>
        <tr>
            <td colspan="9" class="LineHorizo2PX"></td>
        <% 
            For i = 0 To aRegionsRanking.GetLength(0) - 1
                
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
                
                If aRegionsRanking(aRegionsRanking.GetLength(0) - 1 - i).RegionNameEn = aRegionsRanking(aRegionsRanking.GetLength(0) - 1 - i).RegionNameFr Then
                    sRegionName = aRegionsRanking(aRegionsRanking.GetLength(0) - 1 - i).RegionNameEn
                Else
                    sRegionName = aRegionsRanking(aRegionsRanking.GetLength(0) - 1 - i).RegionNameEn & "<br>&nbsp;" & Server.HtmlEncode(aRegionsRanking(aRegionsRanking.GetLength(0) - 1 - i).RegionNameFr)
                End If
                
                sPublicHtmlTextLines = sPublicHtmlTextLines & sPublicTemplateLine
                sPublicHtmlTextLines = sPublicHtmlTextLines.Replace("#LineColor#", sLineColor)
                sPublicHtmlTextLines = sPublicHtmlTextLines.Replace("#LineBold#", sLineBold)
                sPublicHtmlTextLines = sPublicHtmlTextLines.Replace("#RegionName#", sRegionName)
                sPublicHtmlTextLines = sPublicHtmlTextLines.Replace("#RegionLetters#", aRegionsRanking(aRegionsRanking.GetLength(0) - 1 - i).RegionLetterEn)
                sPublicHtmlTextLines = sPublicHtmlTextLines.Replace("#RegionValue#", aRegionsRanking(aRegionsRanking.GetLength(0) - 1 - i).RegionValue.ToString("F"))
                sPublicHtmlTextLines = sPublicHtmlTextLines.Replace("#RegionRanking#", i + 1)
                
        %>
        
        <tr bgcolor="<% Response.Write(sLineColor) %>" <% Response.Write(sLineBold) %>>
            <td height="40" class="LineVertico2PX"></td>
            <td width="100" align="center" valign="middle"><img src="pics/flags/<% Response.Write(aRegionsRanking(aRegionsRanking.GetLength(0) - 1 - i).RegionFlag) %>" height="36" alt="<% Response.Write(aRegionsRanking(aRegionsRanking.GetLength(0) - 1 - i).RegionNameEn) %>" /></td>
            <td class="LineVertico1PX"></td>
            <td width="100" align="center" valign="middle"><% Response.Write(aRegionsRanking(aRegionsRanking.GetLength(0) - 1 - i).RegionLetterEn)%></td>
            <td class="LineVertico1PX"></td>
            <td width="100" align="center" valign="middle"><% Response.Write(aRegionsRanking(aRegionsRanking.GetLength(0) - 1 - i).RegionValue.ToString("F"))%></td>
            <td class="LineVertico1PX"></td>
            <td width="100" align="center" valign="middle"><% Response.Write(i + 1)%></td>
            <td class="LineVertico2PX"></td>
        
        <% If i = aRegionsRanking.GetLength(0) - 1 Then%>
        <tr>
            <td colspan="9" class="LineHorizo2PX"></td>
        <% Else%>
        <tr>
            <td colspan="9" class="LineHorizo1PX"></td>
        <% sPublicHtmlTextLines = sPublicHtmlTextLines & sPublicTemplateSpacing%>
        <% End If%>
        
        <% 
            Next
        %>

        </table>

        <%
            sPublicHtmlText = sPublicTemplateMain.Replace("#Values#", sPublicHtmlTextLines)
            sPublicHtmlText = sPublicHtmlText.Replace("#UpdatedDate#", Date.UtcNow.ToString() & " (UTC/GMT)")
            'sPublicHtmlText = sPublicHtmlText.Replace("#AutoRefreshTime#", sqlDtSet.Tables("AutoRefreshTime").Rows(0)(0).ToString())
            'fnCreateTextFile(sPublicHtmlText, "public_results_eid-" & Request.QueryString("eid") & "_regions_ranking.html")
            
            If bShowPublicResults Then
                fnPutPublicHtmlTextInDb("eid-" & Request.QueryString("eid") & "_rr", sPublicHtmlText)
            End If
            
        %>

</center>
</body>
</html>
