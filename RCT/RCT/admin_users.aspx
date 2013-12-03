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
        <!-- ========================================== -->
        <!-- ===== CONTENU DE LA PAGE ADMIN_USERS ===== -->
        
        <%
            Dim sSql As String = "Select * From tblUsers Inner Join tblUsersRules On tblUsers.fkUserRuleId=tblUsersRules.userRuleId Order By userLastName, userFirstName"
            Dim sqlDtSet As System.Data.DataSet = fnGetDataSetInDB(sSql, "Users")
            Dim i As Integer
        %>
        
        <br />
        <table border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td colspan="7" class="LineHorizo1PX"></td>
            <tr>
                <td height="30" class="LineVertico1PX"></td>
                <td width="10" align="center" valign="middle" bgcolor="#c0c0c0"></td>
                <td class="LineVertico1PX"></td>
                <td width="673" align="left" valign="middle" bgcolor="#c0c0c0">&nbsp;<b>Users List<br />&nbsp;Liste des usagers</b></td>
                <td class="LineVertico1PX"></td>
                <td width="85" align="center" valign="middle">
                    <% If Session("userRule") = 1 Or Session("userRule") = 2 Then%>
                    <a href="admin_user_add.aspx"><img src="pics/add.png" border="0" width="25" height="25" title="Add Event" /></a>
                    <% End If %>
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
                <td width="153" align="center" valign="middle" bgcolor="#c0c0c0"><b>LastName</b> / <b>Nom</b></td>
                <td class="LineVertico1PX"></td>
                <td width="152" align="center" valign="middle" bgcolor="#c0c0c0"><b>FirstName</b> / <b>Pr&eacute;nom</b></td>
                <td class="LineVertico1PX"></td>
                <td width="150" align="center" valign="middle" bgcolor="#c0c0c0"><b>User</b> / <b>Usager</b></td>
                <td class="LineVertico1PX"></td>
                <td width="150" align="center" valign="middle" bgcolor="#c0c0c0"><b>Rule</b> / <b>Role</b></td>
                <td class="LineVertico1PX"></td>
                <td width="150" align="center" valign="middle" bgcolor="#c0c0c0"><b>Restriction</b></td>
                <td class="LineVertico1PX"></td>
            <tr>
                <td colspan="13" class="LineHorizo1PX"></td>
            <% For i = 0 to sqlDtSet.Tables("Users").Rows.count - 1 %>
            <tr onmouseover="fnOnMouseOver(this);" onmouseout="fnOnMouseOut(this);" onclick="fnOnClick('admin_user_edit.aspx?uid=<% Response.Write(sqlDtSet.Tables("Users").Rows(i)("userId")) %>')">
                <td height="20" class="LineVertico1PX"></td>
                <td bgcolor="#c0c0c0"></td>
                <td class="LineVertico1PX"></td>
                <td align="left" valign="middle">&nbsp;<% Response.Write(sqlDtSet.Tables("Users").Rows(i)("userLastName")) %></td>
                <td class="LineVertico1PX"></td>
                <td align="left" valign="middle">&nbsp;<% Response.Write(sqlDtSet.Tables("Users").Rows(i)("userFirstName")) %></td>
                <td class="LineVertico1PX"></td>
                <td align="left" valign="middle">&nbsp;<% Response.Write(sqlDtSet.Tables("Users").Rows(i)("userLogin")) %></td>
                <td class="LineVertico1PX"></td>
                <td align="left" valign="middle">&nbsp;<% Response.Write(sqlDtSet.Tables("Users").Rows(i)("userRuleName")) %></td>
                <td class="LineVertico1PX"></td>
                <td align="center" valign="middle"><% Response.Write(sqlDtSet.Tables("Users").Rows(i)("fkEventIdRestricted")) %></td>
                <td class="LineVertico1PX"></td>
            <tr>
                <td colspan="13" class="LineHorizo1PX"></td>
            <% Next %>

        </table>

        <!-- ===== CONTENU DE LA PAGE ADMIN_USERS ===== -->
        <!-- ========================================== -->
        </td>
</table>

<!--#include file="inc_bottom.aspx"-->
