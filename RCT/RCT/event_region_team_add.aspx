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
        <!-- ======================================== -->
        <!-- ===== TABLEAU D'AJOUT D'UNE ÉQUIPE ===== -->
        <% 
            sSql = "Select * From tblRegions Where regionId = " & Request.QueryString("rid")
            sqlDtSet.Tables.Add("Region").Merge(fnGetDataTableInDB(sSql))
        %>

            <% If sMsg <> 0 Then %>
                
                <table border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td colspan="3" class="LineHorizo1PXRed"></td>
                <tr>
                    <td height="50" class="LineVertico1PXRed"></td>
                    <td width="770" bgcolor="#ffA0A0" align="left" valign="middle"><br />&nbsp; <b>ATTENTION</b> : 
                    UNE ERREUR EST SURVENUE. L'ÉQUIPE N'A PAS ÉTÉ ENREGISTRÉ.<br /><br />&nbsp;
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


        <form name="frmAddTeam" id="frmAddTeam" method="post" action="functions.aspx?fn=EventRegionTeamAdd">
        <input type="hidden" name="hEid" id="hEid" value="<% Response.Write(Request.Querystring("eid")) %>" />
        <input type="hidden" name="hRid" id="hRid" value="<% Response.Write(Request.Querystring("rid")) %>" />
        <input type="hidden" name="hReid" id="hReid" value="<% Response.Write(Request.Querystring("reid")) %>" />

        <table border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td colspan="7" class="LineHorizo1PX"></td>
            <tr>
                <td height="30" class="LineVertico1PX"></td>
                <td width="10" align="center" valign="middle" bgcolor="#c0c0c0"></td>
                <td class="LineVertico1PX"></td>
                <td width="673" align="left" valign="middle" bgcolor="#c0c0c0">&nbsp;<b>Créer une équipe pour : <% Response.Write(sqlDtSet.Tables("Region").Rows(0)("regionNameFr"))%></b></td>
                <td class="LineVertico1PX"></td>
                <td width="85" align="center" valign="middle">
                        <a href="event_region_teams.aspx?eid=<% Response.Write(Request.QueryString("eid")) %>&rid=<% Response.Write(Request.QueryString("rid")) %>&reid=<% Response.Write(Request.QueryString("reid")) %>"><img src="pics/undo.png" width="25" height="25" title="Undo" border="0" /></a>&nbsp;
                        <img src="pics/save.png" name="bSave" id="bSave" width="25" height="25" title="Save" onclick="fnEventRegionTeamValidTeamSerial('txtTeamSerial','frmAddTeam');" onmouseover="this.style.cursor='pointer';" />
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
            <td width="569" height="14" class="FormTableTitle">&nbsp;Nom de l'équipe en FRANÇAIS</td>
            <td class="LineVertico1PX"></td>
            <td width="200" align="left" valign="middle" class="FormTableTitle">&nbsp;Numéro de série</td>
            <td class="LineVertico1PX"></td>
        <tr>
            <td class="LineVertico1PX"></td>
            <td height="25" align="center" valign="middle"><input type="text" name="txtTeamNameFr" id="txtTeamNameFr" autocomplete="off" style="width : 559px;" class="FormTextBox" /></td>
            <td class="LineVertico1PX"></td>
            <td align="center" valign="middle"><input type="text" name="txtTeamSerial" id="txtTeamSerial" autocomplete="off" maxlength="2" style="width : 190px;" class="FormTextBox" /></td>
            <td class="LineVertico1PX"></td>
        <tr>
            <td class="LineHorizo1PX"></td>
            <td class="LineHorizo1PX"></td>
            <td class="LineHorizo1PX"></td>
            <td class="LineHorizo1PX"></td>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td class="LineHorizo1PX"></td>
            <td height="14" class="FormTableTitle">&nbsp;Nom de l'équipe en Anglais</td>
            <td class="LineHorizo1PX"></td>
            <td height="14" class="FormTableTitle">&nbsp;Type d'équipe</td>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td class="LineHorizo1PX"></td>
            <td height="25" align="center" valign="middle"><input type="text" name="txtTeamNameEn" id="txtTeamNameEn" autocomplete="off" style="width : 559px;" class="FormTextBox" /></td>
            <td class="LineHorizo1PX"></td>
            <td width="170" align="center" valign="middle">
            <%
                sSql = "Select * From tblTeamsTypes"
                sqlDtSet.Tables.Add("TeamsTypes").Merge(fnGetDataTableInDB(sSql))
                
                Dim i As Integer
            %>
                    <select name="sTeamTypeId" id="sTeamTypeId" style="width: 190px" class="FormTextBox">
                        <% For i = 0 To sqlDtSet.Tables("TeamsTypes").Rows.Count - 1%>
                        <option value="<% Response.Write(sqlDtSet.Tables("TeamsTypes").Rows(i)("teamTypeId")) %>"><% Response.Write(sqlDtSet.Tables("TeamsTypes").Rows(i)("teamTypeNameFr")) %></option>
                        <% Next%>
                    </select>
            </td>
            <td class="LineHorizo1PX"></td>    
        <tr>
            <td colspan="5" class="LineHorizo1PX"></td>

        </table>
        </form>
        <!-- ===== TABLEAU D'AJOUT D'UNE ÉQUIPE ===== -->
        <!-- ======================================== -->

        <br />

        </td>
</table>
<!--#include file="inc_bottom.aspx"-->

