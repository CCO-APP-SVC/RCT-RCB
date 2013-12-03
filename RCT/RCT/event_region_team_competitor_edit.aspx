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
                    <td width="85" align="center" valign="middle"><a href="event_region_team_edit.aspx?eid=<% Response.Write(Request.QueryString("eid")) %>&rid=<% Response.Write(Request.QueryString("rid")) %>&reid=<% Response.Write(Request.QueryString("reid")) %>&tid=<% Response.Write(Request.QueryString("tid")) %>"><img src="pics/undo.png" width="25" height="25" title="Undo" border="0" /></a></td>
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
        
        <!-- ================================================= -->
        <!-- ===== FORMULAIRE D'ÉDITION D'UN COMPÉTITEUR ===== -->
        <% 
            sSql = "Select teamNameFr, teamTypeNameFr From tblTeams JOIN tblTeamsTypes ON tblTeams.fkTeamTypeId=tblTeamsTypes.teamTypeId Where teamId = " & Request.QueryString("tid")
            sqlDtSet.Tables.Add("Team").Merge(fnGetDataTableInDB(sSql))
            
            sSql = "Select regionNameFr From tblRegions Where regionId = " & Request.QueryString("rid")
            sqlDtSet.Tables.Add("Region").Merge(fnGetDataTableInDB(sSql))
            
            sSql = "Select * From tblGenders"
            sqlDtSet.Tables.Add("Genders").Merge(fnGetDataTableInDB(sSql))
            
            sSql = "Select * From tblCompetitorsCategories"
            sqlDtSet.Tables.Add("CompetitorsCategories").Merge(fnGetDataTableInDB(sSql))
            
            sSql = "Select * From vwTeamsCompetitorsCompetitorsCategoriesGenders Where teamCompetitorId = " & Request.QueryString("tcid")
            sqlDtSet.Tables.Add("Competitor").Merge(fnGetDataTableInDB(sSql))
            
            Dim i As Integer
            Dim sSelected As String
        %>

            <form name="frmEventRegionTeamCompetitorEdit" id="frmEventRegionTeamCompetitorEdit" method="post" action="functions.aspx?fn=EventRegionTeamCompetitorEdit">
            <input type="hidden" name="hEid" id="hEid" value="<% Response.Write(Request.QueryString("eid")) %>" />
            <input type="hidden" name="hRid" id="hRid" value="<% Response.Write(Request.QueryString("rid")) %>" />
            <input type="hidden" name="hReid" id="hReid" value="<% Response.Write(Request.QueryString("reid")) %>" />
            <input type="hidden" name="hTid" id="hTid" value="<% Response.Write(Request.QueryString("tid")) %>" />
            <input type="hidden" name="hTcid" id="hTcid" value="<% Response.Write(sqlDtSet.Tables("Competitor").Rows(0)("teamCompetitorId")) %>" />

            <table border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td colspan="7" class="LineHorizo1PX"></td>
                <tr>
                    <td height="30" class="LineVertico1PX"></td>
                    <td width="10" align="center" valign="middle" bgcolor="#c0c0c0"></td>
                    <td class="LineVertico1PX"></td>
                    <td width="653" align="left" valign="middle" bgcolor="#c0c0c0">&nbsp;<b>Édition d'un compétiteur pour : <% Response.Write(sqlDtSet.Tables("Region").Rows(0)("regionNameFr"))%> &nbsp; <% Response.Write(sqlDtSet.Tables("Team").Rows(0)("teamTypeNameFr"))%> &nbsp; <% Response.Write(sqlDtSet.Tables("Team").Rows(0)("teamNameFr"))%></b></td>
                    <td class="LineVertico1PX"></td>
                    <td width="105" align="center" valign="middle">
                        <a href="event_region_team_edit.aspx?eid=<% Response.Write(Request.QueryString("eid")) %>&rid=<% Response.Write(Request.QueryString("rid")) %>&reid=<% Response.Write(Request.QueryString("reid")) %>&tid=<% Response.Write(Request.QueryString("tid")) %>"><img src="pics/undo.png" width="25" height="25" title="Undo" border="0" /></a>&nbsp;
                        
                        <input type="image" name="bSave" id="bSave" width="25" height="25" src="pics/save.png" title="Save" />&nbsp;
                        <img src="pics/delete.png" width="25" height="25" title="Delete" onmouseover="this.style.cursor='pointer';" onclick="fnConfirmEventRegionTeamCompetitorDel(<% Response.Write(Request.QueryString("eid")) %>, <% Response.Write(Request.QueryString("rid")) %>, <% Response.Write(Request.QueryString("reid")) %>, <% Response.Write(Request.QueryString("tid")) %>, <% Response.Write(sqlDtSet.Tables("Competitor").Rows(0)("teamCompetitorId")) %>)" />
                       
                    </td>
                    <td class="LineVertico1PX"></td>
                <tr>
                    <td colspan="7" class="LineHorizo1PX"></td>
            </table>

            <table border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td colspan="5" class="LineHorizo1PX"></td>
                <tr>
                    <td class="LineVertico1PX" height="14"></td>
                    <td width="569" class="FormTableTitle" align="left" valign="middle">&nbsp;Nom du compétiteur</td>
                    <td class="LineVertico1PX"></td>
                    <td width="200" class="FormTableTitle" align="left" valign="middle">&nbsp;Date de naissance (AAAA/MM/JJ)</td>
                    <td class="LineVertico1PX"></td>
                <tr>
                    <td class="LineVertico1PX" height="30"></td>
                    <td align="center" valign="middle"><input type="text" name="txtTeamCompetitorLastName" id="txtTeamCompetitorLastName" autocomplete="off" style="width : 559px;" class="FormTextBox" value="<% Response.Write(sqlDtSet.Tables("Competitor").Rows(0)("teamCompetitorLastName")) %>" /></td>
                    <td class="LineVertico1PX"></td>
                    <td align="center" valign="middle"><input type="text" name="txtTeamCompetitorBirthDate" id="txtTeamCompetitorBirthDate" datepicker="true" class="FormTextBox" style="text-align: center" value="<% Response.Write(sqlDtSet.Tables("Competitor").Rows(0)("DDN")) %>"></td>
                    <td class="LineVertico1PX"></td>
            </table>
            <table border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td colspan="5" class="LineHorizo1PX"></td>
                <tr>
                    <td class="LineVertico1PX" height="14"></td>
                    <td width="569" class="FormTableTitle" align="left" valign="middle">&nbsp;Prénom du compétiteur</td>
                    <td class="LineVertico1PX"></td>
                    <td width="200" class="FormTableTitle" align="left" valign="middle">&nbsp;Genre</td>
                    <td class="LineVertico1PX"></td>
                <tr>
                    <td class="LineVertico1PX" height="30"></td>
                    <td align="center" valign="middle"><input type="text" name="txtTeamCompetitorFirstName" id="txtTeamCompetitorFirstName" autocomplete="off" style="width : 559px;" class="FormTextBox" value="<% Response.Write(sqlDtSet.Tables("Competitor").Rows(0)("teamCompetitorFirstName")) %>" /></td>
                    <td class="LineVertico1PX"></td>
                    <td align="center" valign="middle">
                        <select name="sGenderId" id="sGenderId" style="width: 190px" class="FormTextBox">
                            <%
                                Dim iGender As Integer
                                For i = 0 To sqlDtSet.Tables("Genders").Rows.Count - 1
                                    
                                    If IsDBNull(sqlDtSet.Tables("Competitor").Rows(0)("fkGenderId")) Then
                                        iGender = 1
                                    Else
                                        iGender = sqlDtSet.Tables("Competitor").Rows(0)("fkGenderId")
                                    End If
                                    
                                    If sqlDtSet.Tables("Genders").Rows(i)("genderId") = iGender Then
                                        sSelected = "Selected='selected'"
                                    Else
                                        sSelected = ""
                                    End If
                            %>
                            <option value="<% Response.Write(sqlDtSet.Tables("Genders").Rows(i)("genderId")) %>" <% Response.Write(sSelected) %>><% Response.Write(sqlDtSet.Tables("Genders").Rows(i)("genderNameFr")) %></option>
                            <% Next%>
                        </select>
                    </td>
                    <td class="LineVertico1PX"></td>
            </table>
            <table border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td colspan="7" class="LineHorizo1PX"></td>
                <tr>
                    <td class="LineVertico1PX" height="14"></td>
                    <td width="200" class="FormTableTitle" align="left" valign="middle">&nbsp;# de série</td>
                    <td class="LineVertico1PX"></td>
                    <td width="200" class="FormTableTitle" align="left" valign="middle">&nbsp;Unité</td>
                    <td class="LineVertico1PX"></td>
                    <td width="368" class="FormTableTitle" align="left" valign="middle">&nbsp;Catégorie</td>
                    <td class="LineVertico1PX"></td>
                <tr>
                    <td class="LineVertico1PX" height="30"></td>
                    <td align="center" valign="middle"><input type="text" name="txtTeamCompetitorSerial" id="txtTeamCompetitorSerial" autocomplete="off" style="width : 190px;" class="FormTextBox" value="<% Response.Write(sqlDtSet.Tables("Competitor").Rows(0)("teamCompetitorSerial")) %>" /></td>
                    <td class="LineVertico1PX"></td>
                    <td align="center" valign="middle"><input type="text" name="txtTeamCompetitorUnit" id="txtTeamCompetitorUnit" autocomplete="off" style="width : 190px;" class="FormTextBox" value="<% Response.Write(sqlDtSet.Tables("Competitor").Rows(0)("teamCompetitorUnit")) %>" /></td>
                    <td class="LineVertico1PX"></td>
                    <td align="left" valign="middle">&nbsp;
                        <select name="sCompetitorCategoryId" id="sCompetitorCategoryId" style="width: 160px" class="FormTextBox">
                            <%
                                Dim iCompetitorCategory As Integer
                                For i = 0 To sqlDtSet.Tables("CompetitorsCategories").Rows.Count - 1
                                    
                                    If IsDBNull(sqlDtSet.Tables("Competitor").Rows(0)("fkCompetitorCategoryId")) Then
                                        iCompetitorCategory = 1
                                    Else
                                        iCompetitorCategory = sqlDtSet.Tables("Competitor").Rows(0)("fkCompetitorCategoryId")
                                    End If
                                    
                                    If sqlDtSet.Tables("CompetitorsCategories").Rows(i)("competitorCategoryId") = iCompetitorCategory Then
                                        sSelected = "Selected='selected'"
                                    Else
                                        sSelected = ""
                                    End If
                            %>
                            <option value="<% Response.Write(sqlDtSet.Tables("CompetitorsCategories").Rows(i)("competitorCategoryId")) %>" <% Response.Write(sSelected) %>><% Response.Write(sqlDtSet.Tables("CompetitorsCategories").Rows(i)("competitorCategoryNameFr")) %></option>
                            <% Next%>
                        </select>
                    </td>
                    <td class="LineVertico1PX"></td>
                <tr>
                    <td colspan="7" class="LineHorizo1PX"></td>
            </table>

            </form>

        <!-- ===== FORMULAIRE D'ÉDITION D'UN COMPÉTITEUR ===== -->
        <!-- ================================================= -->
        
        <br />

        </td>
</table>
<!--#include file="inc_bottom.aspx"-->
