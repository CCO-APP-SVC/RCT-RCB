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
        <!-- ============================================= -->
        <!-- ===== TABLEAU D'AJOUT D'UNE COMPÉTITION ===== -->

        <form name="frmAddComp" id="frmAddComp" method="post" action="functions.aspx?fn=EventCompetitionAdd">
        <input type="hidden" name="hEid" id="hEid" value="<% Response.Write(Request.Querystring("eid")) %>" />

            <table border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td colspan="7" class="LineHorizo1PX"></td>
                <tr>
                    <td height="30" class="LineVertico1PX"></td>
                    <td width="10" align="center" valign="middle" bgcolor="#c0c0c0"></td>
                    <td class="LineVertico1PX"></td>
                    <td width="673" align="left" valign="middle" bgcolor="#c0c0c0">&nbsp;<b>Créer une compétition</b></td>
                    <td class="LineVertico1PX"></td>
                    <td width="85" align="center" valign="middle">
                        <a href="event_profile.aspx?eid=<% Response.Write(Request.Querystring("eid")) %>"><img src="pics/undo.png" width="25" height="25" title="Undo" border="0" /></a>&nbsp;
                        <input type="image" name="bSave" id="bSave" width="25" height="25" src="pics/save.png" title="Save" />
                    </td>
                    <td class="LineVertico1PX"></td>
                <tr>
                    <td colspan="7" class="LineHorizo1PX"></td>
            </table>

        <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td colspan="3" class="LineHorizo1PX"></td>
        <tr>
            <td class="LineVertico1PX"></td>
            <td width="770" height="14" class="FormTableTitle">&nbsp;Nom de la comp&eacute;tition en FRANÇAIS</td>
            <td class="LineVertico1PX"></td>
        <tr>
            <td class="LineVertico1PX"></td>
            <td height="25" align="left" valign="middle">&nbsp;<input type="text" name="txtCompNameFr" id="txtCompNameFr" autocomplete="off" style="width : 760px;" class="FormTextBox" /></td>
            <td class="LineVertico1PX"></td>
        <tr>
            <td colspan="3" class="LineHorizo1PX"></td>
        <tr>
            <td class="LineHorizo1PX"></td>
            <td height="14" class="FormTableTitle">&nbsp;Nom de la comp&eacute;tition en Anglais</td>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td class="LineHorizo1PX"></td>
            <td height="25" align="left" valign="middle">&nbsp;<input type="text" name="txtCompNameEn" id="txtCompNameEn" autocomplete="off" style="width : 760px;" class="FormTextBox" /></td>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td colspan="3" class="LineHorizo1PX"></td>
        </table>
        </form>
        <!-- ===== TABLEAU D'AJOUT D'UNE COMPÉTITION ===== -->
        <!-- ============================================= -->

        </td>
</table>
<!--#include file="inc_bottom.aspx"-->
