<%@ Page Language="VB" AutoEventWireup="false" CodeFile="functions.aspx.vb" Inherits="functions" %>
<!--#include file="inc_top.aspx"-->

<table border="0" cellpadding="0" cellspacing="0" class="TXTNormal">
    <tr>
        <td width="170" height="<% Response.Write(fnGetParamNumeric("HeightTableMenuLeft")) %>" align="center" valign="top">
            <!-- ================================= -->
            <!-- ===== MENU DE LA PAGE ADMIN ===== -->
            
            <!-- #include file="inc_menu_admin.aspx" -->

            <!-- ===== MENU DE LA PAGE ADMIN ===== -->
            <!-- ================================= -->
        </td>
        <td class="LineVertico1PX"></td>
        <td width="827" align="center" valign="top">
        <!-- ============================================ -->
        <!-- ===== CONTENU DE LA PAGE ADMIN_REGIONS ===== -->
        <br />
        
        <!-- ======================================== -->
        <!-- ===== TABLEAU D'AJOUT D'UNE RÉGION ===== -->
        <%
            Dim sEventTypeSelected As String = Request.QueryString("etid")
            If String.IsNullOrEmpty(sEventTypeSelected) Then
                sEventTypeSelected = "0"
            End If
        %>

        <form name="frmAddRegion" id="frmAddRegion" method="post" action="functions.aspx?fn=Region_Add&etid=<% Response.Write(sEventTypeSelected) %>">

            <table border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td colspan="5" class="LineHorizo1PX"></td>
                <tr>
                    <td class="LineVertico1PX" height="14"></td>
                    <td width="569" class="FormTableTitle" align="left" valign="middle">&nbsp;Nom de la région en FRAN&Ccedil;AIS</td>
                    <td class="LineVertico1PX"></td>
                    <td width="200" class="FormTableTitle" align="left" valign="middle">&nbsp;Lettres en FRAN&Ccedil;AIS</td>
                    <td class="LineVertico1PX"></td>
                <tr>
                    <td class="LineVertico1PX" height="30"></td>
                    <td align="center" valign="middle"><input type="text" name="txtRegionNameFr" id="txtRegionNameFr" autocomplete="off" style="width: 559px" class="FormTextBox" /></td>
                    <td class="LineVertico1PX"></td>
                    <td align="center" valign="middle"><input type="text" name="txtLetterFr" id="txtLetterFr" autocomplete="off" style="width: 190px" class="FormTextBox" /></td>
                    <td class="LineVertico1PX"></td>
                <tr>
                    <td colspan="5" class="LineHorizo1PX"></td>
            </table>
            <table border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td class="LineVertico1PX" height="14"></td>
                    <td width="569" class="FormTableTitle" align="left" valign="middle">&nbsp;Nom de la région en ANGLAIS</td>
                    <td class="LineVertico1PX"></td>
                    <td width="200" class="FormTableTitle" align="left" valign="middle">&nbsp;Lettres en ANGLAIS</td>
                    <td class="LineVertico1PX"></td>
                <tr>
                    <td class="LineVertico1PX" height="30"></td>
                    <td align="center" valign="middle"><input type="text" name="txtRegionNameEn" id="txtRegionNameEn" autocomplete="off" style="width: 559px" class="FormTextBox" /></td>
                    <td class="LineVertico1PX"></td>
                    <td align="center" valign="middle"><input type="text" name="txtLetterEn" id="txtLetterEn" autocomplete="off" style="width: 190px" class="FormTextBox" /></td>
                    <td class="LineVertico1PX"></td>
                <tr>
                    <td colspan="5" class="LineHorizo1PX"></td>
            </table>
            <table border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td class="LineVertico1PX" height="14"></td>
                    <td width="483" class="FormTableTitle" align="left" valign="middle">&nbsp;Drapeau / Logo (facultatif)</td>
                    <td class="LineVertico1PX"></td>
                    <td width="200" class="FormTableTitle" align="left" valign="middle">&nbsp;Type d'&eacute;v&eacute;nement</td>
                    <td class="LineVertico1PX"></td>
                    <td width="85" rowspan="2" align="center" valign="middle"><input type="image" name="bSave" id="bSave" width="25" height="25" src="pics/save.png" title="Save" /></td>
                    <td class="LineVertico1PX"></td>
                <tr>
                    <td class="LineVertico1PX" height="30"></td>
                    <td align="center" valign="middle"><input type="text" name="txtFlagLogo" id="txtFlagLogo" autocomplete="off" style="width: 473px" class="FormTextBox" /></td>
                    <td class="LineVertico1PX"></td>
                    <td align="center" valign="middle">
                    <%
                        Dim sSQL As String = "Select * From tblEventsTypes"
                        Dim sqlDtSet As System.Data.DataSet = fnGetDataSetInDB(sSQL, "EventsTypes")
                                                
                        Dim i As Integer
                        Dim sSelected As String
                    %>
                        <select name="slEventType" id="slEventType" class="FormTextBox" style="width: 190px">
                            <%
                                For i = 0 To sqlDtSet.Tables("EventsTypes").Rows.Count - 1
                                    If sqlDtSet.Tables("EventsTypes").Rows(i)("eventTypeId") = sEventTypeSelected Then
                                        sSelected = "Selected='selected'"
                                    Else
                                        sSelected = ""
                                    End If
                            %>
                            <option value="<% Response.Write(sqlDtSet.Tables("EventsTypes").Rows(i)("eventTypeId")) %>" <% Response.Write(sSelected) %>><% Response.Write(sqlDtSet.Tables("EventsTypes").Rows(i)("eventTypeNameFr"))%></option>
                            <% Next%>

                        </select>
                    </td>
                    <td class="LineVertico1PX"></td>
                    <td class="LineVertico1PX"></td>
                <tr>
                    <td colspan="7" class="LineHorizo1PX"></td>
            </table>

        </form>
        <!-- ===== TABLEAU D'AJOUT D'UNE RÉGION ===== -->
        <!-- ======================================== -->
        
        <!-- ===== CONTENU DE LA PAGE ADMIN_REGIONS ===== -->
        <!-- ============================================ -->
        </td>
</table>

<!--#include file="inc_bottom.aspx"-->
