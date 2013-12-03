<%@ Page Language="VB" AutoEventWireup="false" CodeFile="functions.aspx.vb" Inherits="functions" %>
<!--#include file="inc_top.aspx"-->

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
                    <td width="673" align="left" valign="middle" bgcolor="#c0c0c0">&nbsp;<b>Profile d'événement</b></td>
                    <td class="LineVertico1PX"></td>
                    <td width="85" align="center" valign="middle"><a href="event_profile.aspx?eid=<% Response.Write(Request.QueryString("eid")) %>"><img src="pics/undo.png" width="25" height="25" title="Undo" border="0" /></a></td>
                    <td class="LineVertico1PX"></td>
                <tr>
                    <td colspan="7" class="LineHorizo1PX"></td>
            </table>

            <table border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td colspan="5" class="LineHorizo1PX"></td>
                <tr>
                    <td class="LineVertico1PX" height="14"></td>
                    <td width="569" class="FormTableTitle" align="left" valign="middle">&nbsp;Nom de l'&eacute;v&eacute;nement en FRAN&Ccedil;AIS</td>
                    <td class="LineVertico1PX"></td>
                    <td width="200" class="FormTableTitle" align="left" valign="middle">&nbsp;Date de d&eacute;but (AAAA/MM/JJ)</td>
                    <td class="LineVertico1PX"></td>
                <tr>
                    <td class="LineVertico1PX" height="30"></td>
                    <td align="left" valign="middle">&nbsp;<% Response.Write(sqlDtSet.Tables("Events").Rows(0)("eventNameFr")) %></td>
                    <td class="LineVertico1PX"></td>
                    <td align="center" valign="middle"><% Response.Write(sqlDtSet.Tables("Events").Rows(0)("StartDate")) %></td>
                    <td class="LineVertico1PX"></td>
                <tr>
                    <td colspan="5" class="LineHorizo1PX"></td>
            </table>
            <table border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td class="LineVertico1PX" height="14"></td>
                    <td width="569" class="FormTableTitle" align="left" valign="middle">&nbsp;Nom de l'&eacute;v&eacute;nement en ANGLAIS</td>
                    <td class="LineVertico1PX"></td>
                    <td width="200" class="FormTableTitle" align="left" valign="middle">&nbsp;Date de fin (AAAA/MM/JJ)</td>
                    <td class="LineVertico1PX"></td>
                <tr>
                    <td class="LineVertico1PX" height="30"></td>
                    <td align="left" valign="middle">&nbsp;<% Response.Write(sqlDtSet.Tables("Events").Rows(0)("eventNameEn")) %></td>
                    <td class="LineVertico1PX"></td>
                    <td align="center" valign="middle"><% Response.Write(sqlDtSet.Tables("Events").Rows(0)("EndDate")) %></td>
                    <td class="LineVertico1PX"></td>
                <tr>
                    <td colspan="5" class="LineHorizo1PX"></td>
            </table>
            <table border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td class="LineVertico1PX" height="14"></td>
                    <td width="569" class="FormTableTitle" align="left" valign="middle">&nbsp;Lieu de l'&eacute;v&eacute;nement</td>
                    <td class="LineVertico1PX"></td>
                    <td width="200" class="FormTableTitle" align="left" valign="middle">&nbsp; Type d'&eacute;v&eacute;nement</td>
                    <td class="LineVertico1PX"></td>
                <tr>
                    <td class="LineVertico1PX" height="30"></td>
                    <td align="left" valign="middle">&nbsp;<% Response.Write(sqlDtSet.Tables("Events").Rows(0)("eventLocation")) %></td>
                    <td class="LineVertico1PX"></td>
                    <td align="center" valign="middle"><% Response.Write(sqlDtSet.Tables("Events").Rows(0)("eventTypeNameFr")) %></td>
                    <td class="LineVertico1PX"></td>
                <tr>
                    <td colspan="5" class="LineHorizo1PX"></td>
            </table>
        <!-- ===== TABLEAU DE CONSULTATION D'UN ÉVÉNEMENT ===== -->
        <!-- ================================================== -->

        <br />

        <!-- =========================================== -->
        <!-- ===== TABLEAU D'AFFICHAGE DES ÉQUIPES ===== -->

            <% 
                sSql = "Select * From tblRegions Where regionId = " & Request.QueryString("rid")
                sqlDtSet.Tables.Add("Region").Merge(fnGetDataTableInDB(sSql))
            %>

            <table border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td colspan="7" class="LineHorizo1PX"></td>
                <tr>
                    <td height="30" class="LineVertico1PX"></td>
                    <td width="10" align="center" valign="middle" bgcolor="#c0c0c0"></td>
                    <td class="LineVertico1PX"></td>
                    <td width="673" align="left" valign="middle" bgcolor="#c0c0c0">&nbsp;<b>Équipes pour : <% Response.Write(sqlDtSet.Tables("Region").Rows(0)("regionNameFr"))%></b></td>
                    <td class="LineVertico1PX"></td>
                    <td width="85" align="center" valign="middle">
                        <a href="event_profile.aspx?eid=<% Response.Write(Request.QueryString("eid")) %>"><img src="pics/undo.png" width="25" height="25" title="Undo" border="0" /></a>&nbsp;
                        <% If Session("userRule") = 1 Or Session("userRule") = 2 Then%>
                        <img src="pics/add.png" border="0" width="25" height="25" title="Add Team" onmouseover="this.style.cursor='pointer'" onclick="fnOnClick('event_region_team_add.aspx?eid=<% Response.Write(Request.QueryString("eid")) %>&rid=<% Response.Write(Request.QueryString("rid")) %>&reid=<% Response.Write(Request.QueryString("reid")) %>')" /></td>
                        <% End If%>
                    <td class="LineVertico1PX"></td>
                <tr>
                    <td colspan="7" class="LineHorizo1PX"></td>
            </table>

            <table border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td colspan="11" class="LineHorizo1PX"></td>
                <tr>
                    <td height="20" class="LineVertico1PX"></td>
                    <td width="10" bgcolor="#c0c0c0"></td>
                    <td class="LineVertico1PX"></td>
                    <td width="50" align="center" valign="middle" bgcolor="#c0c0c0"><b>#</b></td>
                    <td class="LineVertico1PX"></td>
                    <td width="278" align="center" valign="middle" bgcolor="#c0c0c0">&nbsp;<b>Nom Fr</b></td>
                    <td class="LineVertico1PX"></td>
                    <td width="278" align="center" valign="middle" bgcolor="#c0c0c0"><b>Nom En</b></td>
                    <td class="LineVertico1PX"></td>
                    <td width="150" align="center" valign="middle" bgcolor="#c0c0c0"><b>Type</b></td>
                    <td class="LineVertico1PX"></td>
                <tr>
                    <td colspan="11" class="LineHorizo1PX"></td>
                
            <%
                sSql = "Select * From tblTeams JOIN tblTeamsTypes ON tblTeams.fkTeamTypeId=tblTeamsTypes.teamTypeId Where fkRegionEventId = " & Request.QueryString("reid") & " Order By teamSerial"
                sqlDtSet.Tables.Add("Teams").Merge(fnGetDataTableInDB(sSql))
                
                Dim i As Integer
                For i = 0 To sqlDtSet.Tables("Teams").Rows.Count - 1
            %>
                <tr name="trToHide<% Response.Write(i) %>" id="trToHide<% Response.Write(i) %>" style="display:none">
                    <td colspan="11" class="LineHorizo1PX"></td>
                <tr onmouseover="fnOnMouseOver(this);" onmouseout="fnOnMouseOut(this);">
                    <td height="20" class="LineVertico1PX"></td>
                    <td width="10" align="center" valign="middle" bgcolor="#c0c0c0" onclick="fnHideShowItem2('tblCompetitors<% Response.Write(sqlDtSet.Tables("Teams").Rows(i)("teamId")) %>','trToHide<% Response.Write(i+1) %>','spanPlus<% Response.Write(sqlDtSet.Tables("Teams").Rows(i)("teamId")) %>')"><span name="spanPlus<% Response.Write(sqlDtSet.Tables("Teams").Rows(i)("teamId")) %>" id="spanPlus<% Response.Write(sqlDtSet.Tables("Teams").Rows(i)("teamId")) %>">+</span></td>
                    <td class="LineVertico1PX"></td>
                    <td width="50" align="center" valign="middle" onclick="fnOnClick('event_region_team_edit.aspx?eid=<% Response.Write(Request.QueryString("eid")) %>&rid=<% Response.Write(Request.QueryString("rid")) %>&reid=<% Response.Write(Request.QueryString("reid")) %>&tid=<% Response.Write(sqlDtSet.Tables("Teams").Rows(i)("teamId")) %>')"><% Response.Write(sqlDtSet.Tables("Teams").Rows(i)("teamSerial"))%></td>
                    <td class="LineVertico1PX"></td>
                    <td width="278" align="left" valign="middle" onclick="fnOnClick('event_region_team_edit.aspx?eid=<% Response.Write(Request.QueryString("eid")) %>&rid=<% Response.Write(Request.QueryString("rid")) %>&reid=<% Response.Write(Request.QueryString("reid")) %>&tid=<% Response.Write(sqlDtSet.Tables("Teams").Rows(i)("teamId")) %>')">&nbsp;<% Response.Write(sqlDtSet.Tables("Teams").Rows(i)("teamNameFr"))%></td>
                    <td class="LineVertico1PX"></td>
                    <td width="278" align="left" valign="middle" onclick="fnOnClick('event_region_team_edit.aspx?eid=<% Response.Write(Request.QueryString("eid")) %>&rid=<% Response.Write(Request.QueryString("rid")) %>&reid=<% Response.Write(Request.QueryString("reid")) %>&tid=<% Response.Write(sqlDtSet.Tables("Teams").Rows(i)("teamId")) %>')">&nbsp;<% Response.Write(sqlDtSet.Tables("Teams").Rows(i)("teamNameEn"))%></td>
                    <td class="LineVertico1PX"></td>
                    <td width="150" align="left" valign="middle" onclick="fnOnClick('event_region_team_edit.aspx?eid=<% Response.Write(Request.QueryString("eid")) %>&rid=<% Response.Write(Request.QueryString("rid")) %>&reid=<% Response.Write(Request.QueryString("reid")) %>&tid=<% Response.Write(sqlDtSet.Tables("Teams").Rows(i)("teamId")) %>')">&nbsp;<% Response.Write(sqlDtSet.Tables("Teams").Rows(i)("teamTypeNameFr"))%></td>
                    <td class="LineVertico1PX"></td>
                <tr>
                    <td colspan="11" class="LineHorizo1PX"></td>
                <tr name="tblCompetitors<% Response.Write(sqlDtSet.Tables("Teams").Rows(i)("teamId")) %>" id="tblCompetitors<% Response.Write(sqlDtSet.Tables("Teams").Rows(i)("teamId")) %>" style="display:none">
                    <td></td>
                    <td></td>
                    <td colspan="9">
                        <%
                            sSql = "Select * From vwTeamsCompetitorsCompetitorsCategoriesGenders Where fkTeamId = " & sqlDtSet.Tables("Teams").Rows(i)("teamId") & " Order By teamCompetitorSerial"
                            sqlDtSet.Tables.Add("TeamsCompetitors_" & i).Merge(fnGetDataTableInDB(sSql))
                                                        
                                If sqlDtSet.Tables("TeamsCompetitors_" & i).Rows.Count <> 0 Then
                                    Dim ii As Integer
                            %>
                        <table border="0" cellpadding="0" cellspacing="0">
                            <tr>
                                <td height="20" class="LineVertico1PX"></td>
                                <td width="10" bgcolor="#c0c0c0"></td>
                                <td class="LineVertico1PX"></td>
                                <td width="60" align="center" valign="middle" bgcolor="#c0c0c0"><b>#</b></td>
                                <td class="LineVertico1PX"></td>
                                <td width="60" align="center" valign="middle" bgcolor="#c0c0c0">&nbsp;<b>Unité</b></td>
                                <td class="LineVertico1PX"></td>
                                <td width="187" align="center" valign="middle" bgcolor="#c0c0c0"><b>Nom</b></td>
                                <td class="LineVertico1PX"></td>
                                <td width="186" align="center" valign="middle" bgcolor="#c0c0c0"><b>Prénom</b></td>
                                <td class="LineVertico1PX"></td>
                                <td width="60" align="center" valign="middle" bgcolor="#c0c0c0"><b>Gender</b></td>
                                <td class="LineVertico1PX"></td>
                                <td width="100" align="center" valign="middle" bgcolor="#c0c0c0"><b>Catégorie</b></td>
                                <td class="LineVertico1PX"></td>
                            <tr>
                                <td colspan="15" class="LineHorizo1PX"></td>
                            <% For ii = 0 To sqlDtSet.Tables("TeamsCompetitors_" & i).Rows.Count - 1%>
                            <tr>
                              
                                <td height="20" class="LineVertico1PX"></td>
                                <td bgcolor="#c0c0c0"></td>
                                <td class="LineVertico1PX"></td>
                                <td align="center" valign="middle"><% Response.Write(sqlDtSet.Tables("TeamsCompetitors_" & i).Rows(ii)("teamCompetitorSerial"))%></td>
                                <td class="LineVertico1PX"></td>
                                <td align="center" valign="middle"><% Response.Write(sqlDtSet.Tables("TeamsCompetitors_" & i).Rows(ii)("teamCompetitorUnit"))%></td>
                                <td class="LineVertico1PX"></td>
                                <td align="left" valign="middle">&nbsp;<% Response.Write(sqlDtSet.Tables("TeamsCompetitors_" & i).Rows(ii)("teamCompetitorLastName"))%></td>
                                <td class="LineVertico1PX"></td>
                                <td align="left" valign="middle">&nbsp;<% Response.Write(sqlDtSet.Tables("TeamsCompetitors_" & i).Rows(ii)("teamCompetitorFirstName"))%></td>
                                <td class="LineVertico1PX"></td>
                                <td align="center" valign="middle">&nbsp;<% Response.Write(sqlDtSet.Tables("TeamsCompetitors_" & i).Rows(ii)("genderLetter"))%></td>
                                <td class="LineVertico1PX"></td>
                                <td align="center" valign="middle">&nbsp;<% Response.Write(sqlDtSet.Tables("TeamsCompetitors_" & i).Rows(ii)("competitorCategoryNameFr"))%></td>
                                <td class="LineVertico1PX"></td>
                            <% If (i <> sqlDtSet.Tables("Teams").Rows.Count - 1 And ii <> sqlDtSet.Tables("TeamsCompetitors_" & i).Rows.Count - 1) Or i = sqlDtSet.Tables("Teams").Rows.Count - 1 Then%>
                            <tr>
                                <td colspan="15" class="LineHorizo1PX"></td>
                           
                            <% End If%>
                            
                        <% Next%>
                        </table>
                        <% End If %>
                    </td>

            <%  Next %>

            </table>

        <!-- ===== TABLEAU D'AFFICHAGE DES ÉQUIPES ===== -->
        <!-- =========================================== -->

        <br />

        </td>
</table>
<!--#include file="inc_bottom.aspx"-->
