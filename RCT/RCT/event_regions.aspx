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
        <!-- ===== TABLEAU D'AFFICHAGE DES RÉGIONS ===== -->
            <form name="frmEditRegions" id="frmEditRegions" method="post" action="functions.aspx?fn=EventRegionsEdit&eid=<% Response.Write(Request.QueryString("eid")) %>">
            
            <table border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td colspan="7" class="LineHorizo1PX"></td>
                <tr>
                    <td height="30" class="LineVertico1PX"></td>
                    <td width="10" align="center" valign="middle" bgcolor="#c0c0c0"></td>
                    <td class="LineVertico1PX"></td>
                    <td width="673" align="left" valign="middle" bgcolor="#c0c0c0">&nbsp;<b>Sélectionner les régions</b></td>
                    <td class="LineVertico1PX"></td>
                    <td width="85" align="center" valign="middle">
                        <a href="event_profile.aspx?eid=<% Response.Write(Request.QueryString("eid")) %>"><img src="pics/undo.png" width="25" height="25" title="Undo" border="0" /></a>&nbsp;
                        <input type="image" name="bSave" id="bSave" width="25" height="25" src="pics/save.png" title="Save" />
                    </td>
                    <td class="LineVertico1PX"></td>
                <tr>
                    <td colspan="7" class="LineHorizo1PX"></td>
            </table>
            
            <table border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td colspan="13" class="LineHorizo1PX"></td>
                <tr>
                    <td height="20" class="LineVertico1PX"></td>
                    <td width="10" bgcolor="#c0c0c0"></td>
                    <td class="LineVertico1PX"></td>
                    <td width="250" align="left" valign="middle" bgcolor="#c0c0c0">&nbsp;<b>Région FR</b></td>
                    <td class="LineVertico1PX"></td>
                    <td width="250" align="left" valign="middle" bgcolor="#c0c0c0">&nbsp;<b>Région EN</b></td>
                    <td class="LineVertico1PX"></td>
                    <td width="85" align="center" valign="middle" bgcolor="#c0c0c0"><b>Lettres FR</b></td>
                    <td class="LineVertico1PX"></td>
                    <td width="85" align="center" valign="middle" bgcolor="#c0c0c0"><b>Lettres EN</b></td>
                    <td class="LineVertico1PX"></td>
                    <td width="85" align="center" valign="middle" bgcolor="#c0c0c0"><b>Selected</b></td>
                    <td class="LineVertico1PX"></td>
                <tr>
                    <td colspan="13" class="LineHorizo1PX"></td>
            <%
                sSql = "Select * From tblRegions Where fkEventTypeId = " & sqlDtSet.Tables("Events").Rows(0)("eventTypeId") & "  Order By regionNameFr"
                sqlDtSet.Tables.Add("Regions").Merge(fnGetDataTableInDB(sSql))
                
                Dim i As Integer
                Dim strCheckBox As String
                Dim strValuesBefore As String = ""
                
                For i = 0 To sqlDtSet.Tables("Regions").Rows.Count - 1

                    sSql = "Select * From tblRegionsEvents Where fkRegionId = " & sqlDtSet.Tables("Regions").Rows(i)("regionId") & " And fkEventId = " & Request.QueryString("eid")
                    sqlDtSet.Tables.Add("RegionEvent_" & sqlDtSet.Tables("Regions").Rows(i)("regionId") & "-" & Request.QueryString("eid")).Merge(fnGetDataTableInDB(sSql))

                    if sqlDtSet.Tables("RegionEvent_" & sqlDtSet.Tables("Regions").Rows(i)("regionId") & "-" & Request.QueryString("eid")).Rows.Count = 0 Then
                        strCheckBox = ""
                        strValuesBefore = strValuesBefore & "hdrid_" & sqlDtSet.Tables("Regions").Rows(i)("regionId") & "_NO:"
                    Else
                        strCheckBox = "checked='checked'"
                        strValuesBefore = strValuesBefore & "hdrid_" & sqlDtSet.Tables("Regions").Rows(i)("regionId") & "_YES:"
                    End If

            %>
                <tr>
                    <td height="25" class="LineVertico1PX"></td>
                    <td bgcolor="#c0c0c0"></td>
                    <td class="LineVertico1PX"></td>
                    <td align="left" valign="middle">&nbsp;<% Response.Write(sqlDtSet.Tables("Regions").Rows(i)("regionNameFr"))%></td>
                    <td class="LineVertico1PX"></td>
                    <td align="left" valign="middle">&nbsp;<% Response.Write(sqlDtSet.Tables("Regions").Rows(i)("regionNameEn"))%></td>
                    <td class="LineVertico1PX"></td>
                    <td align="center" valign="middle"><% Response.Write(sqlDtSet.Tables("Regions").Rows(i)("regionLetterFr"))%></td>
                    <td class="LineVertico1PX"></td>
                    <td align="center" valign="middle"><% Response.Write(sqlDtSet.Tables("Regions").Rows(i)("regionLetterEn"))%></td>
                    <td class="LineVertico1PX"></td>
                    <td align="center" valign="middle">
                        <input type="checkbox" name="CBRId_<% Response.Write(sqlDtSet.Tables("Regions").Rows(i)("regionId"))%>" id="CBRId_<% Response.Write(sqlDtSet.Tables("Regions").Rows(i)("regionId"))%>" <% Response.Write(strCheckBox) %> value="cbrid_<% Response.Write(sqlDtSet.Tables("Regions").Rows(i)("regionId")) %>_OK"/>

                    </td>
                    <td class="LineVertico1PX"></td>
                <tr>
                    <td colspan="13" class="LineHorizo1PX"></td>
            <%
            Next
            %>
            </table>
                <input type="hidden" name="hdValuesBefore" id="hdValuesBefore" value="<% Response.Write(strValuesBefore) %>" />
            </form>
            <br />
        <!-- ===== TABLEAU D'AFFICHAGE DES RÉGIONS ===== -->
        <!-- =========================================== -->

        </td>
</table>
<!--#include file="inc_bottom.aspx"-->
