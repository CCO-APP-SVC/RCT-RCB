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
        

            <!-- =============================== -->
            <!-- ===== TABLEAU DES RÉGIONS ===== -->

            <table border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td colspan="9" class="LineHorizo1PX"></td>
                <tr>
                    <td height="30" class="LineVertico1PX"></td>
                    <td width="10" align="center" valign="middle" bgcolor="#c0c0c0"></td>
                    <td class="LineVertico1PX"></td>
                    <td width="501" align="left" valign="middle" bgcolor="#c0c0c0">&nbsp;<b>Régions</b></td>
                    <td class="LineVertico1PX"></td>
                    <td width="171" align="center" valign="middle">

                        <%
                            Dim sEventTypeSelected As String = Request.QueryString("etid")
                            Dim strEventTypeAllSelected As String = ""
                            Dim sSql As String = "Select * From tblRegions JOIN tblEventsTypes ON tblRegions.fkEventTypeId=tblEventsTypes.eventTypeId Order By regionNameFr"

                            If String.IsNullOrEmpty(sEventTypeSelected) Then
                                sEventTypeSelected = "0"
                            End If
                            
                            If sEventTypeSelected = "0" Then
                                strEventTypeAllSelected = "selected='selected'"
                            End If

                            If sEventTypeSelected <> 0 Then
                                sSql = "Select * From tblRegions JOIN tblEventsTypes ON tblRegions.fkEventTypeId=tblEventsTypes.eventTypeId Where fkEventTypeId = " & sEventTypeSelected & " Order By regionNameFr"
                            End If

                            Dim sqlDtSet As System.Data.DataSet = fnGetDataSetInDB(sSql, "Regions")
                                                        
                            sSql = "Select * From tblEventsTypes"
                            sqlDtSet.Tables.Add("EventsTypes").Merge(fnGetDataTableInDB(sSql))

                            Dim i As Integer
                            Dim sSelected As String
                        %>

                        <form name="frmSelectEventType" id="frmSelectEventType" method="post" action="functions.aspx?fn=RegionsEventTypeSelect">
                        <select name="slEventType" id="slEventType" onchange="this.form.submit();" class="FormTextBox" style="width: 160px">
                            <option value="0" <% Response.Write(strEventTypeAllSelected) %>>Tous</option>
                            <%
                                For i = 0 To sqlDtSet.Tables("EventsTypes").Rows.Count - 1
                                    If sqlDtSet.Tables("EventsTypes").Rows(i)("eventTypeId").ToString() = sEventTypeSelected Then
                                        sSelected = "Selected='selected'"
                                    Else
                                        sSelected = ""
                                    End If
                            %>
                            <option value="<% Response.Write(sqlDtSet.Tables("EventsTypes").Rows(i)("eventTypeId")) %>" <% Response.Write(sSelected) %>><% Response.Write(sqlDtSet.Tables("EventsTypes").Rows(i)("eventTypeNameFr")) %></option>
                            <% Next %>
                        </select>
                        </form>
                    </td>
                    <td class="LineVertico1PX"></td>
                    <td width="85" align="center" valign="middle"><img src="pics/add.png" border="0" width="25" height="25" title="Add Regions" onmouseover="this.style.cursor='pointer'" onclick="fnOnClick('admin_regions_add.aspx?etid=<% Response.Write(sEventTypeSelected) %>')" /></td>
                    <td class="LineVertico1PX"></td>
                <tr>
                    <td colspan="9" class="LineHorizo1PX"></td>
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
                    <td width="85" align="center" valign="middle" bgcolor="#c0c0c0"><b>Type</b></td>
                    <td class="LineVertico1PX"></td>
                <tr>
                    <td colspan="13" class="LineHorizo1PX"></td>
            <% For i = 0 To sqlDtSet.Tables("Regions").Rows.Count - 1 %>
                <tr onmouseover="fnOnMouseOver(this);" onmouseout="fnOnMouseOut(this);" onclick="fnOnClick('admin_regions_edit.aspx?rid=<% Response.Write(sqlDtSet.Tables("Regions").Rows(i)("regionId")) %>&etid=<% Response.Write(sEventTypeSelected) %>')">
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
                    <td align="center" valign="middle"><% Response.Write(sqlDtSet.Tables("Regions").Rows(i)("eventTypeNameFr"))%></td>
                    <td class="LineVertico1PX"></td>
                <tr>
                    <td colspan="13" class="LineHorizo1PX"></td>
            <% Next %>

            </table>
            <br />
            <!-- ===== TABLEAU DES RÉGIONS ===== -->
            <!-- =============================== -->

        <!-- ===== CONTENU DE LA PAGE ADMIN_REGIONS ===== -->
        <!-- ============================================ -->
        </td>
</table>

<!--#include file="inc_bottom.aspx"-->
