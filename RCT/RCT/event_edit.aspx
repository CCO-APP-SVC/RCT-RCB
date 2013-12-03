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
        <!-- ===== TABLEAU DE MODIFICATION D'UN ÉVÉNEMENT ===== -->
        <% 
            Dim sSql As String = "Select * From vwEventsEventsTypes Where eventId = " & Request.QueryString("eid")
            Dim sqlDtSet As System.Data.DataSet = fnGetDataSetInDB(sSql, "Events")
            
        %>
        <form name="frmModEvent" id="frmModEvent" method="post" action="functions.aspx?fn=EventEdit">
            <input type="hidden" name="hEid" id="hEid" value="<% Response.Write(Request.QueryString("eid")) %>" />
            <table border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td colspan="7" class="LineHorizo1PX"></td>
                <tr>
                    <td height="30" class="LineVertico1PX"></td>
                    <td width="10" align="center" valign="middle" bgcolor="#c0c0c0"></td>
                    <td class="LineVertico1PX"></td>
                    <td width="653" align="left" valign="middle" bgcolor="#c0c0c0">&nbsp;<b>Éditer un événement</b></td>
                    <td class="LineVertico1PX"></td>
                    <td width="105" align="center" valign="middle">
                        <a href="event_profile.aspx?eid=<% Response.Write(Request.QueryString("eid")) %>"><img src="pics/undo.png" width="25" height="25" title="Undo" border="0" /></a>&nbsp;
                        <input type="image" name="bSave" id="bSave" width="25" height="25" src="pics/save.png" title="Save" />&nbsp;
                        <img src="pics/delete.png" width="25" height="25" title="Delete" onmouseover="this.style.cursor='pointer';" onclick="fnConfirmEventDel(<% Response.Write(Request.QueryString("eid")) %>)" />
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
                    <td width="569" class="FormTableTitle" align="left" valign="middle">&nbsp;Nom de l'&eacute;v&eacute;nement en FRAN&Ccedil;AIS</td>
                    <td class="LineVertico1PX"></td>
                    <td width="200" class="FormTableTitle" align="left" valign="middle">&nbsp;Date de d&eacute;but (AAAA/MM/JJ)</td>
                    <td class="LineVertico1PX"></td>
                <tr>
                    <td class="LineVertico1PX" height="30"></td>
                    <td align="center" valign="middle"><input type="text" name="txtEventNameFr" id="txtEventNameFr" autocomplete="off" style="width: 559px" class="FormTextBox" value="<% Response.Write(sqlDtSet.Tables("Events").Rows(0)("eventNameFr")) %>" /></td>
                    <td class="LineVertico1PX"></td>
                    <td align="center" valign="middle"><input type="text" name="txtEventStartDate" id="txtEventStartDate" datepicker="true" class="FormTextBox" style="text-align: center" value="<% Response.Write(sqlDtSet.Tables("Events").Rows(0)("StartDate")) %>"></td>
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
                    <td align="center" valign="middle"><input type="text" name="txtEventNameEn" id="txtEventNameEn" autocomplete="off" style="width: 559px" class="FormTextBox" value="<% Response.Write(sqlDtSet.Tables("Events").Rows(0)("eventNameEn")) %>" /></td>
                    <td class="LineVertico1PX"></td>
                    <td align="center" valign="middle"><input type="text" name="txtEventEndDate" id="txtEventEndDate" datepicker="true" class="FormTextBox" style="text-align: center" value="<% Response.Write(sqlDtSet.Tables("Events").Rows(0)("EndDate")) %>"></td>
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
                    <td align="center" valign="middle"><input type="text" name="txtEventLocation" id="txtEventLocation" autocomplete="off" style="width: 559px" class="FormTextBox" value="<% Response.Write(sqlDtSet.Tables("Events").Rows(0)("eventLocation")) %>" /></td>
                    <td class="LineVertico1PX"></td>
                    <td align="center" valign="middle">
                    <%
                        sSql = "Select * From tblEventsTypes"
                        sqlDtSet.Tables.Add("EventsTypes").Merge(fnGetDataTableInDB(sSql))
                        
                        Dim i As Integer
                        Dim sSelected As String
                    %>
                        <select name="slEventType" id="slEventType" class="FormTextBox" style="width: 190px">
                            <%
                                For i = 0 To sqlDtSet.Tables("EventsTypes").Rows.Count - 1
                                    If sqlDtSet.Tables("EventsTypes").Rows(i)("eventTypeId") = sqlDtSet.Tables("Events").Rows(0)("fkEventTypeId") Then
                                        sSelected = "Selected='selected'"
                                    Else
                                        sSelected = ""
                                    End If
                            %>
                            <option value="<% Response.Write(sqlDtSet.Tables("EventsTypes").Rows(i)("eventTypeId")) %>" <% Response.Write(sSelected) %>><% Response.Write(sqlDtSet.Tables("EventsTypes").Rows(i)("eventTypeNameFr")) %></option>
                            <% Next%>
                        </select>
                    </td>
                    <td class="LineVertico1PX"></td>
                <tr>
                    <td colspan="5" class="LineHorizo1PX"></td>
            </table>

        </form>
        <!-- ===== TABLEAU DE MODIFICATION D'UN ÉVÉNEMENT ===== -->
        <!-- ================================================== -->

        </td>
</table>
<!--#include file="inc_bottom.aspx"-->
