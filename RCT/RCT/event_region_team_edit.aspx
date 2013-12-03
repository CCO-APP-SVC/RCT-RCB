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
            
            Dim sMsg As String = Request.QueryString("msg")
            If String.IsNullOrEmpty(sMsg) Then
                sMsg = "0"
            End If
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
                    <td width="85" align="center" valign="middle"><a href="event_region_teams.aspx?eid=<% Response.Write(Request.QueryString("eid")) %>&rid=<% Response.Write(Request.QueryString("rid")) %>&reid=<% Response.Write(Request.QueryString("reid")) %>"><img src="pics/undo.png" width="25" height="25" title="Undo" border="0" /></a></td>
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
        <!-- ================================================ -->
        <!-- ===== TABLEAU DE MODIFICATION D'UNE ÉQUIPE ===== -->

            <% If sMsg <> 0 Then %>
                
                <table border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td colspan="3" class="LineHorizo1PXRed"></td>
                <tr>
                    <td height="50" class="LineVertico1PXRed"></td>
                    <td width="770" bgcolor="#ffA0A0" align="left" valign="middle"><br />&nbsp; <b>ATTENTION</b> : 
                    UNE ERREUR EST SURVENUE. LA MODIFICATION N'A PAS ÉTÉ ENREGISTRÉ.<br /><br />&nbsp;
                    Le <b>numéro de série</b> qui a été saisi existe déjà pour cet événement.<br />&nbsp;
                    Veuillez saisir correctement le numéro série.<br />&nbsp;
                    Si le problème persiste, veuillez communiquer avec l'administrateur du système.<br />
                    <br />
                    </td>
                    <td class="LineVertico1PXRed"></td>
                <tr>
                    <td colspan="3" class="LineHorizo1PXRed"></td>

                </table>
                <br />

            <% End If %>



        <form name="frmEditTeam" id="frmEditTeam" method="post" action="functions.aspx?fn=EventRegionTeamEdit">
        <input type="hidden" name="hEid" id="hEid" value="<% Response.Write(Request.Querystring("eid")) %>" />
        <input type="hidden" name="hRid" id="hRid" value="<% Response.Write(Request.Querystring("rid")) %>" />
        <input type="hidden" name="hReid" id="hReid" value="<% Response.Write(Request.Querystring("reid")) %>" />
        <input type="hidden" name="hTid" id="hTid" value="<% Response.Write(Request.Querystring("tid")) %>" />

        <% 
            sSql = "Select * From tblTeams JOIN tblTeamsTypes ON tblTeams.fkTeamTypeId=tblTeamsTypes.teamTypeId Where teamId = " & Request.QueryString("tid")
            sqlDtSet.Tables.Add("Team").Merge(fnGetDataTableInDB(sSql))
            
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
                    <td width="653" align="left" valign="middle" bgcolor="#c0c0c0">&nbsp;<b>Édition d'une équipe pour : <% Response.Write(sqlDtSet.Tables("Region").Rows(0)("regionNameFr"))%></b></td>
                    <td class="LineVertico1PX"></td>
                    <td width="105" align="center" valign="middle">
                        <a href="event_region_teams.aspx?eid=<% Response.Write(Request.QueryString("eid")) %>&rid=<% Response.Write(Request.QueryString("rid")) %>&reid=<% Response.Write(Request.QueryString("reid")) %>"><img src="pics/undo.png" width="25" height="25" title="Undo" border="0" /></a>&nbsp;
                        <% If Session("userRule") = 1 Or Session("userRule") = 2 Then%>
                        <img src="pics/save.png" name="bSave" id="bSave" width="25" height="25" title="Save" onclick="fnEventRegionTeamValidTeamSerial('txtTeamSerial','frmEditTeam');" onmouseover="this.style.cursor='pointer';" />&nbsp;
                        <img src="pics/delete.png" width="25" height="25" title="Delete" onmouseover="this.style.cursor='pointer';" onclick="fnConfirmDelTeam(<% Response.Write(Request.QueryString("eid")) %>,<% Response.Write(Request.QueryString("rid")) %>,<% Response.Write(Request.QueryString("reid")) %>,<% Response.Write(Request.QueryString("tid")) %>)" />
                        <% End If %>
                    </td>
                    <td class="LineVertico1PX"></td>
                <tr>
                    <td colspan="7" class="LineHorizo1PX"></td>
            </table>


        <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td colspan="5" class="LineHorizo1PX"></td>
        <tr>
            <td class="LineVertico1PX"></td>
            <td width="599" height="14" class="FormTableTitle">&nbsp;Nom de l'équipe en FRANÇAIS</td>
            <td class="LineVertico1PX"></td>
            <td width="170" align="left" valign="middle" class="FormTableTitle">&nbsp;Numéro de série</td>
            <td class="LineVertico1PX"></td>
        <tr>
            <td class="LineVertico1PX"></td>
            <td height="25" align="center" valign="middle"><input type="text" name="txtTeamNameFr" id="txtTeamNameFr" autocomplete="off" style="width : 589px;" class="FormTextBox" value="<% Response.Write(sqlDtSet.Tables("Team").Rows(0)("teamNameFr")) %>" /></td>
            <td class="LineVertico1PX"></td>
            <td align="center" valign="middle">
                <input type="text" name="txtTeamSerial" id="txtTeamSerial" autocomplete="off" maxlength="2" style="width : 160px;" class="FormTextBox" value="<% Response.Write(sqlDtSet.Tables("Team").Rows(0)("teamSerial")) %>" />
                <input type="hidden" name="hOldTeamSerial" id="hOldTeamSerial" value="<% Response.Write(sqlDtSet.Tables("Team").Rows(0)("teamSerial")) %>" />
                </td>
            <td class="LineVertico1PX"></td>
        <tr>
            <td colspan="5" class="LineHorizo1PX"></td>
        <tr>
            <td class="LineVertico1PX"></td>
            <td height="14" class="FormTableTitle">&nbsp;Nom de l'équipe en Anglais</td>
            <td class="LineVertico1PX"></td>
            <td height="14" class="FormTableTitle">&nbsp;Type d'équipe</td>
            <td class="LineVertico1PX"></td>
        <tr>
            <td class="LineVertico1PX"></td>
            <td height="25" align="center" valign="middle"><input type="text" name="txtTeamNameEn" id="txtTeamNameEn" autocomplete="off" style="width : 589px;" class="FormTextBox" value="<% Response.Write(sqlDtSet.Tables("Team").Rows(0)("teamNameEn")) %>" /></td>
            <td class="LineVertico1PX"></td>
            <td width="170" align="center" valign="middle">
            <%
                sSql = "Select * From tblTeamsTypes"
                sqlDtSet.Tables.Add("TeamsTypes").Merge(fnGetDataTableInDB(sSql))
                
                Dim i As Integer
                Dim sSelected As String
            %>
                    <select name="sTeamTypeId" id="sTeamTypeId" style="width: 160px" class="FormTextBox">
                        <%
                            For i = 0 To sqlDtSet.Tables("TeamsTypes").Rows.Count - 1
                                If sqlDtSet.Tables("TeamsTypes").Rows(i)("teamTypeId") = sqlDtSet.Tables("Team").Rows(0)("fkTeamTypeId") Then
                                    sSelected = "Selected='selected'"
                                Else
                                    sSelected = ""
                                End If
                        %>
                        <option value="<% Response.Write(sqlDtSet.Tables("TeamsTypes").Rows(i)("teamTypeId")) %>" <% Response.Write(sSelected) %>><% Response.Write(sqlDtSet.Tables("TeamsTypes").Rows(i)("teamTypeNameFr")) %></option>
                        <% Next%>
                    </select>
            </td>
            <td class="LineVertico1PX"></td>
        <tr>
            <td colspan="5" class="LineHorizo1PX"></td>
        </table>
        
        </form>

        <!-- ===== TABLEAU DE MODIFICATION D'UNE ÉQUIPE ===== -->
        <!-- ================================================ -->
        <br />
        <!-- ======================================================= -->
        <!-- ===== TABLEAU D'AFFICHAGE DES MEMBRES DE L'ÉQUIPE ===== -->

        <table border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td colspan="7" class="LineHorizo1PX"></td>
            <tr>
                <td height="30" class="LineVertico1PX"></td>
                <td width="10" align="center" valign="middle" bgcolor="#c0c0c0"></td>
                <td class="LineVertico1PX"></td>
                <td width="673" align="left" valign="middle" bgcolor="#c0c0c0">&nbsp;<b>Compétiteurs pour : <% Response.Write(sqlDtSet.Tables("Region").Rows(0)("regionNameFr"))%> &nbsp; <% Response.Write(sqlDtSet.Tables("Team").Rows(0)("teamTypeNameFr"))%> &nbsp; <% Response.Write(sqlDtSet.Tables("Team").Rows(0)("teamNameFr"))%></b></td>
                <td class="LineVertico1PX"></td>
                <td width="85" align="center" valign="middle">
                    <% If Session("userRule") = 1 Or Session("userRule") = 2 Then%>
                    <img src="pics/add.png" border="0" width="25" height="25" title="Add Competitor" onmouseover="this.style.cursor='pointer'" onclick="fnOnClick('event_region_team_competitor_add.aspx?eid=<% Response.Write(Request.QueryString("eid")) %>&rid=<% Response.Write(Request.QueryString("rid")) %>&reid=<% Response.Write(Request.QueryString("reid")) %>&tid=<% Response.Write(Request.QueryString("tid")) %>')" />
                    <% End If %>
                </td>
                <td class="LineVertico1PX"></td>
            <tr>
                <td colspan="7" class="LineHorizo1PX"></td>
        </table>
        
        <table border="0" cellpadding="0" cellspacing="0" id="tblCompetitions" name="tblCompetitions">
                <tr>
                    <td colspan="17" class="LineHorizo1PX"></td>
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
                    <td width="100" align="center" valign="middle" bgcolor="#c0c0c0"><b>DDN</b></td>
                    <td class="LineVertico1PX"></td>
                    <td width="100" align="center" valign="middle" bgcolor="#c0c0c0"><b>Catégorie</b></td>
                    <td class="LineVertico1PX"></td>
                <tr>
                    <td colspan="17" class="LineHorizo1PX"></td>
            <%
                sSql = "Select * From vwTeamsCompetitorsCompetitorsCategoriesGenders Where fkTeamId = " & Request.QueryString("tid") & " Order By teamCompetitorSerial"
                sqlDtSet.Tables.Add("TeamsCompetitors").Merge(fnGetDataTableInDB(sSql))
                
                For i = 0 To sqlDtSet.Tables("TeamsCompetitors").Rows.Count - 1
            %>
                <tr <% If Session("userRule") = 1 Or Session("userRule") = 2 Then%> onmouseover="fnOnMouseOver(this);" onmouseout="fnOnMouseOut(this);" onclick="fnOnClick('event_region_team_competitor_edit.aspx?eid=<% Response.Write(Request.QueryString("eid")) %>&rid=<% Response.Write(Request.QueryString("rid")) %>&reid=<% Response.Write(Request.QueryString("reid")) %>&tid=<% Response.Write(Request.QueryString("tid")) %>&tcid=<% Response.Write(sqlDtSet.Tables("TeamsCompetitors").Rows(i)("teamCompetitorId")) %>')" <% End If %>>
                    <td height="20" class="LineVertico1PX"></td>
                    <td bgcolor="#c0c0c0"></td>
                    <td class="LineVertico1PX"></td>
                    <td align="center" valign="middle"><% Response.Write(sqlDtSet.Tables("TeamsCompetitors").Rows(i)("teamCompetitorSerial"))%></td>
                    <td class="LineVertico1PX"></td>
                    <td align="center" valign="middle"><% Response.Write(sqlDtSet.Tables("TeamsCompetitors").Rows(i)("teamCompetitorUnit"))%></td>
                    <td class="LineVertico1PX"></td>
                    <td align="left" valign="middle">&nbsp;<% Response.Write(sqlDtSet.Tables("TeamsCompetitors").Rows(i)("teamCompetitorLastName"))%></td>
                    <td class="LineVertico1PX"></td>
                    <td align="left" valign="middle">&nbsp;<% Response.Write(sqlDtSet.Tables("TeamsCompetitors").Rows(i)("teamCompetitorFirstName"))%></td>
                    <td class="LineVertico1PX"></td>
                    <td align="center" valign="middle">&nbsp;<% Response.Write(sqlDtSet.Tables("TeamsCompetitors").Rows(i)("genderLetter"))%></td>
                    <td class="LineVertico1PX"></td>
                    <td align="center" valign="middle">&nbsp;<% Response.Write(sqlDtSet.Tables("TeamsCompetitors").Rows(i)("DDN"))%></td>
                    <td class="LineVertico1PX"></td>
                    <td align="center" valign="middle">&nbsp;<% Response.Write(sqlDtSet.Tables("TeamsCompetitors").Rows(i)("competitorCategoryNameFr"))%></td>
                    <td class="LineVertico1PX"></td>
                <tr>
                    <td colspan="17" class="LineHorizo1PX"></td>

            <%  Next %>

            </table>

        <!-- ===== TABLEAU D'AFFICHAGE DES MEMBRES DE L'ÉQUIPE ===== -->
        <!-- ======================================================= -->

        <br />

        </td>
</table>
<!--#include file="inc_bottom.aspx"-->
