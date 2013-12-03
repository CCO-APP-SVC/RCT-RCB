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
        
        <!-- ================================================ -->
        <!-- ===== TABLEAU DE MODIFICATION D'UNE RÉGION ===== -->
        <% 
            Dim sSql As String = "Select * From tblRegions JOIN tblEventsTypes ON tblRegions.fkEventTypeId=tblEventsTypes.eventTypeId Where regionId = " & Request.QueryString("rid") & " Order By regionNameFr"
            Dim sqlDtSet As System.Data.DataSet = fnGetDataSetInDB(sSql, "Region")
            
            Dim sEventTypeSelected As String = Request.QueryString("etid")
            If String.IsNullOrEmpty(sEventTypeSelected) Then
                sEventTypeSelected = "0"
            End If
            
        %>


        <form name="frmEditRegion" id="frmEditRegion" method="post" action="functions.aspx?fn=Region_Edit&rid=<% Response.Write(Request.QueryString("rid")) %>&etid=<% Response.Write(sEventTypeSelected) %>">

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
                    <td align="center" valign="middle"><input type="text" name="txtRegionNameFr" id="txtRegionNameFr" autocomplete="off" style="width: 559px" class="FormTextBox" value="<% Response.Write(sqlDtSet.Tables("Region").Rows(0)("regionNameFr")) %>" /></td>
                    <td class="LineVertico1PX"></td>
                    <td align="center" valign="middle"><input type="text" name="txtLetterFr" id="txtLetterFr" autocomplete="off" style="width: 190px" class="FormTextBox" value="<% Response.Write(sqlDtSet.Tables("Region").Rows(0)("regionLetterFr")) %>" /></td>
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
                    <td align="center" valign="middle"><input type="text" name="txtRegionNameEn" id="txtRegionNameEn" autocomplete="off" style="width: 559px" class="FormTextBox" value="<% Response.Write(sqlDtSet.Tables("Region").Rows(0)("regionNameEn")) %>" /></td>
                    <td class="LineVertico1PX"></td>
                    <td align="center" valign="middle"><input type="text" name="txtLetterEn" id="txtLetterEn" autocomplete="off" style="width: 190px" class="FormTextBox" value="<% Response.Write(sqlDtSet.Tables("Region").Rows(0)("regionLetterEn")) %>" /></td>
                    <td class="LineVertico1PX"></td>
                <tr>
                    <td colspan="5" class="LineHorizo1PX"></td>
            </table>
            <table border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td class="LineVertico1PX" height="14"></td>
                    <td width="483" class="FormTableTitle" align="left" valign="middle">&nbsp;Drapeau / Logo (facultatif)</td>
                    <td class="LineVertico1PX"></td>
                    <td width="175" class="FormTableTitle" align="left" valign="middle">&nbsp;Type d'&eacute;v&eacute;nement</td>
                    <td class="LineVertico1PX"></td>
                    <td width="110" rowspan="2" align="center" valign="middle">
                    
                        <a href="admin_regions.aspx?etid=<% Response.Write(sEventTypeSelected) %>"><img src="pics/undo.png" width="25" height="25" title="Undo" border="0" /></a>
                        <input type="image" name="bSave" id="bSave" width="25" height="25" src="pics/save.png" title="Save" />
                        <img src="pics/delete.png" width="25" height="25" title="Delete" onmouseover="this.style.cursor='pointer';" onclick="fnConfirmDelRegion(<% Response.Write(Request.QueryString("rid")) %>, <% Response.Write(sEventTypeSelected) %>)" />
                    
                    </td>
                    <td class="LineVertico1PX"></td>
                <tr>
                    <td class="LineVertico1PX" height="30"></td>
                    <td align="center" valign="middle"><input type="text" name="txtFlagLogo" id="txtFlagLogo" autocomplete="off" style="width: 473px" class="FormTextBox" value="<% Response.Write(sqlDtSet.Tables("Region").Rows(0)("regionFlagLogo")) %>" /></td>
                    <td class="LineVertico1PX"></td>
                    <td align="center" valign="middle">
                    <%
                        sSql = "Select * From tblEventsTypes"
                        sqlDtSet.Tables.Add("EventsTypes").Merge(fnGetDataTableInDB(sSql))
                        
                        Dim i As Integer
                        Dim sSelected As String
                        'sqlDtSet.Tables("Region").Rows(0)("fkEventTypeId")
                    %>
                        <select name="slEventType" id="slEventType" class="FormTextBox" style="width: 165px">
                            <%
                                For i = 0 To sqlDtSet.Tables("EventsTypes").Rows.Count - 1
                                    If sqlDtSet.Tables("EventsTypes").Rows(i)("eventTypeId") = sqlDtSet.Tables("Region").Rows(0)("fkEventTypeId") Then
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
                    <td class="LineVertico1PX"></td>
                <tr>
                    <td colspan="7" class="LineHorizo1PX"></td>
            </table>

        </form>
        <!-- ===== TABLEAU DE MODIFICATION D'UNE RÉGION ===== -->
        <!-- ================================================ -->


        <!-- ===== CONTENU DE LA PAGE ADMIN_REGIONS ===== -->
        <!-- ============================================ -->
        </td>
</table>

<!--#include file="inc_bottom.aspx"-->