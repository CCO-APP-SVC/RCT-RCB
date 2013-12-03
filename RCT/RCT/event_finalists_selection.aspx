<%@ Page Language="VB" AutoEventWireup="false" CodeFile="functions.aspx.vb" Inherits="functions" %>
<!--#include file="inc_top.aspx"-->

<% 
    Dim i, iCcid, iCdid, iNbrProneTragetsTotal, iNbrStandingTargetsTotal, iSelected, iNbrSelected As Integer
    Dim sEid, sCid, sColorCid, sColorCompetitor, sColorCompetitors, sSelected, sTitleSelected As String
    Dim dCcValue, dCdValue As Decimal

    sEid = Request.QueryString("eid")
    sCid = Request.QueryString("cid")

    If String.IsNullOrEmpty(sEid) Then
        sEid = "0"
    End If
    If String.IsNullOrEmpty(sCid) Then
        sCid = "0"
    End If

    If sCid = "0" Then
        sColorCid = "#ffA0A0"
        sColorCompetitors = "#c0c0c0"
    Else
        sColorCid = "#c0c0c0"
        sColorCompetitors = "#ffA0A0"
    End If
    
%>

<table border="0" cellpadding="0" cellspacing="0" class="TXTNormal">
    <tr>
        <td width="170" height="<% Response.Write(fnGetParamNumeric("HeightTableMenuLeft")) %>" align="center" valign="top">
            <!-- ========================================== -->
            <!-- ===== MENU DE LA PAGE DES ÉVÉNEMENTS ===== -->
            
            <!-- #include file="inc_menu_events.aspx" -->

            <!-- ===== MENU DE LA PAGE DES ÉVÉNEMENTS ===== -->
            <!-- ========================================== -->
        </td>
        <td class="LineVertico1PX"></td>
        <td width="827" align="center" valign="top">
        <br />
        <!-- ================================================== -->
        <!-- ===== TABLEAU DE CONSULTATION D'UN ÉVÉNEMENT ===== -->
        <% 
            Dim sSql As String = "Select * From vwEventsEventsTypes Where eventId = " & Request.QueryString("eid")
            Dim sqlDtSet As System.Data.DataSet = fnGetDataSetInDB(sSql, "Events")
        %>
            <table border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td colspan="7" class="LineHorizo1PX"></td>
                <tr>
                    <td height="30" class="LineVertico1PX"></td>
                    <td width="10" align="center" valign="middle" bgcolor="#c0c0c0"></td>
                    <td class="LineVertico1PX"></td>
                    <td width="673" align="left" valign="middle" bgcolor="#c0c0c0">&nbsp;<b>Finalists selection for <% Response.Write(sqlDtSet.Tables("Events").Rows(0)("eventNameEn")) %></b><br />&nbsp;<b>S&eacute;lection des finalistes pour <% Response.Write(sqlDtSet.Tables("Events").Rows(0)("eventNameFr")) %></b></td>
                    <td class="LineVertico1PX"></td>
                    <td width="85" align="center" valign="middle">
                        <a href="event_profile.aspx?eid=<% Response.Write(Request.QueryString("eid")) %>"><img src="pics/undo.png" width="25" height="25" title="Undo" border="0" /></a>&nbsp;
                    </td>
                    <td class="LineVertico1PX"></td>
                <tr>
                    <td colspan="7" class="LineHorizo1PX"></td>
            </table>

        <!-- ===== TABLEAU DE CONSULTATION D'UN ÉVÉNEMENT ===== -->
        <!-- ================================================== -->
        
        <br />

        <!-- ====================================================================== -->
        <!-- ===== SÉLECTION DE LA COMPÉTITION D'OÙ PROVIENNENT LES RÉSULTATS ===== -->
            
            <%
                sSql = "Select * From tblCompetitions Where fkEventId = " & sEid
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
                        <select name="sCompetitions" id="sCompetitions" style="width: 365px" class="FormTextBox" onchange="fnFinalistsSelectionCompetitionSelect(this.value,<% Response.Write(sEid) %>)">
                            <option value="0">Select a competition - S&eacute;lectionnez une comp&eacute;tition</option>
                            <option disabled>--------------------</option>
                            <% 
                                For i = 0 To sqlDtSet.Tables("Competitions").Rows.Count - 1
                                    If sCid = sqlDtSet.Tables("Competitions").Rows(i)("competitionId").ToString() Then
                                        sSelected = "selected='selected'"
                                    Else
                                        sSelected = ""
                                    End If
                            %>
                            <option value="<% Response.Write(sqlDtSet.Tables("Competitions").Rows(i)("competitionId")) %>" <% Response.Write(sSelected) %>><% Response.Write(sqlDtSet.Tables("Competitions").Rows(i)("competitionNameFr"))%></option>
                            <% Next%>
                        </select>
                    </td>
                    <td class="LineVertico1PX"></td>
                <tr>
                    <td colspan="7" class="LineHorizo1PX"></td>
            </table>
        
        <!-- ===== SÉLECTION DE LA COMPÉTITION D'OÙ PROVIENNENT LES RÉSULTATS ===== -->
        <!-- ====================================================================== -->

        <br />


        <% If sCid <> "0" Then %>

        <!-- ===================================================== -->
        <!-- ===== SÉLECTION DES COMPÉTITEURS POUR LA FINALE ===== -->

        <% 

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
                oCompetitorsResults(i).CompetitorRegionLetterFr = sqlDtSet.Tables("Competitors").Rows(i)("regionLetterFr").ToString()
                oCompetitorsResults(i).CompetitorRegionLetterEn = sqlDtSet.Tables("Competitors").Rows(i)("regionLetterEn").ToString()
                oCompetitorsResults(i).CompetitorFlag = sqlDtSet.Tables("Competitors").Rows(i)("regionFlagLogo").ToString()
                oCompetitorsResults(i).CompetitorTeamNameEn = sqlDtSet.Tables("Competitors").Rows(i)("teamNameEn").ToString()
                oCompetitorsResults(i).CompetitorTeamNameFr = sqlDtSet.Tables("Competitors").Rows(i)("teamNameFr").ToString()
                If NOT IsDbNull(sqlDtSet.Tables("Competitors").Rows(i)("teamCompetitorFinalSelected")) AndAlso sqlDtSet.Tables("Competitors").Rows(i)("teamCompetitorFinalSelected") Then
                    oCompetitorsResults(i).CompetitorFinalSelected = "Selected"
                Else
                    oCompetitorsResults(i).CompetitorFinalSelected = ""
                End If
            Next

            Dim bEncore As Boolean = False
            Dim iTailleTableau As Integer = oCompetitorsResults.Length
            Dim oCompetitorsResultsInter As cIndividualResults = New cIndividualResults

            While Not bEncore
            bEncore = True
                For i = 0 To iTailleTableau - 2
                    If oCompetitorsResults(i).ClassementOuvert > oCompetitorsResults(i + 1).ClassementOuvert Then

                        oCompetitorsResultsInter = oCompetitorsResults(i)
                        oCompetitorsResults(i) = oCompetitorsResults(i + 1)
                        oCompetitorsResults(i + 1) = oCompetitorsResultsInter

                        bEncore = False

                    End If
                Next
                iTailleTableau = iTailleTableau - 1
            End While
        
            iNbrSelected = 0
            For i = 0 to oCompetitorsResults.Length - 1

                If oCompetitorsResults(i).CompetitorFinalSelected = "Selected" Then
                    iNbrSelected = iNbrSelected + 1
                End If

            Next

        %>

        <table border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td colspan="7" class="LineHorizo1PX"></td>
            <tr>
                <td height="30" class="LineVertico1PX"></td>
                <td width="10" align="center" valign="middle" bgcolor="#c0c0c0"></td>
                <td class="LineVertico1PX"></td>
                <td width="683" align="left" valign="middle" bgcolor="<% Response.Write(sColorCompetitors) %>">&nbsp;<b>Competitors selection</b><br />&nbsp;<b>S&eacute;lection des comp&eacute;titeurs</b></td>
                <td class="LineVertico1PX"></td>
                <td width="75" align="center" valign="middle" bgcolor="#9FC63A"><b><% Response.Write(iNbrSelected) %></b></td>
                <td class="LineVertico1PX"></td>
            <tr>
                <td colspan="7" class="LineHorizo1PX"></td>
        </table>

        <table border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td colspan="19" class="LineHorizo1PX"></td>
            <tr>
                <td height="30" class="LineVertico1PX"></td>
                <td width="10" bgcolor="#c0c0c0"></td>
                <td class="LineVertico1PX"></td>
                <td width="75" align="center" valign="middle" bgcolor="#c0c0c0"><b>Province</b></td>
                <td class="LineVertico1PX"></td>
                <td width="75" align="center" valign="middle" bgcolor="#c0c0c0"><b>Team</b><br /><b>&Eacute;quipe</b></td>
                <td class="LineVertico1PX"></td>
                <td width="151" align="center" valign="middle" bgcolor="#c0c0c0"><b>LastName</b><br /><b>Nom</b></td>
                <td class="LineVertico1PX"></td>
                <td width="151" align="center" valign="middle" bgcolor="#c0c0c0"><b>FirstName</b><br /><b>Pr&eacute;nom</b></td>
                <td class="LineVertico1PX"></td>
                <td width="75" align="center" valign="middle" bgcolor="#c0c0c0"><b>Score</b><br /><b>Pointage</b></td>
                <td class="LineVertico1PX"></td>
                <td width="75" align="center" valign="middle" bgcolor="#c0c0c0"><b>Open</b><br /><b>Ouvert</b></td>
                <td class="LineVertico1PX"></td>
                <td width="75" align="center" valign="middle" bgcolor="#c0c0c0"><b>Junior</b></td>
                <td class="LineVertico1PX"></td>
                <td width="75" align="center" valign="middle" bgcolor="#c0c0c0"><b>Selection</b><br /><b>S&eacute;lection</b></td>
                <td class="LineVertico1PX"></td>
            <tr>
                <td colspan="19" class="LineHorizo1PX"></td>
            <%
            
                For i = 0 To oCompetitorsResults.Length - 1
             
                    If oCompetitorsResults(i).CompetitorFinalSelected = "" Then
                        sTitleSelected = "Click to select"
                        iSelected = 1
                        sColorCompetitor = "#ffffff"
                    Else
                        sTitleSelected = "Click to unselect"
                        iSelected = 0
                        sColorCompetitor = "#9FC63A"
                    End If
            
            %>
            <tr>
                <td height="20" class="LineVertico1PX"></td>
                <td bgcolor="#c0c0c0"></td>
                <td class="LineVertico1PX"></td>
                <td align="center" valign="middle" bgcolor="<% Response.Write(sColorCompetitor) %>"><% Response.Write(oCompetitorsResults(i).CompetitorRegionLetterEn) %></td>
                <td class="LineVertico1PX"></td>
                <td align="center" valign="middle" bgcolor="<% Response.Write(sColorCompetitor) %>"><% Response.Write(oCompetitorsResults(i).CompetitorTeamNameEn) %></td>
                <td class="LineVertico1PX"></td>
                <td align="left" valign="middle" bgcolor="<% Response.Write(sColorCompetitor) %>">&nbsp;<% Response.Write(oCompetitorsResults(i).CompetitorLastName) %></td>
                <td class="LineVertico1PX"></td>
                <td align="left" valign="middle" bgcolor="<% Response.Write(sColorCompetitor) %>">&nbsp;<% Response.Write(oCompetitorsResults(i).CompetitorFirstName) %></td>
                <td class="LineVertico1PX"></td>
                <td align="center" valign="middle" bgcolor="<% Response.Write(sColorCompetitor) %>"><% Response.Write(oCompetitorsResults(i).MoyenneTotale) %></td>
                <td class="LineVertico1PX"></td>
                <td align="center" valign="middle" bgcolor="<% Response.Write(sColorCompetitor) %>"><% Response.Write(oCompetitorsResults(i).ClassementOuvert) %></td>
                <td class="LineVertico1PX"></td>
                <td align="center" valign="middle" bgcolor="<% Response.Write(sColorCompetitor) %>"><% Response.Write(oCompetitorsResults(i).ClassementJunior) %></td>
                <td class="LineVertico1PX"></td>
                <td align="center" valign="middle" bgcolor="#ffffff" title="<% Response.Write(sTitleSelected) %>" onmouseover="fnOnMouseOver(this);" onmouseout="fnOnMouseOut(this);" onclick="fnOnClick('functions.aspx?fn=FinalistSelected&eid=<% Response.Write(sEid) %>&cid=<% Response.Write(sCid) %>&tcid=<% Response.Write(oCompetitorsResults(i).CompetitorId) %>&tcfs=<% Response.Write(iSelected) %>');"><% Response.Write(oCompetitorsResults(i).CompetitorFinalSelected) %></td>
                <td class="LineVertico1PX"></td>
            <tr>
                <td colspan="19" class="LineHorizo1PX"></td>
            <% Next %>
                
        </table>

        <!-- ===== SÉLECTION DES COMPÉTITEURS POUR LA FINALE ===== -->
        <!-- ===================================================== -->

        <br />
        <% End If '==== End If of (sCid <> 0) ==== %>


        </td>
</table>
<!--#include file="inc_bottom.aspx"-->
