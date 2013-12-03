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
        <!-- ============================================== -->
        <!-- ===== CONTENU DE LA PAGE ADMIN_USER_EDIT ===== -->
        
        <%
            Dim sSql As String = "Select * From tblUsers Where userId = " & Request.QueryString("uid")
            Dim sqlDtSet As System.Data.DataSet = fnGetDataSetInDB(sSql, "User")
            Dim i as Integer
            Dim sSelected as String = ""
            
            sSql = "Select * From tblUsersRules Order By userRuleName"
            sqlDtSet.Tables.Add("UsersRules").Merge(fnGetDataTableInDB(sSql))
            
            sSql = "Select * From tblEvents Order By eventNameFr"
            sqlDtSet.Tables.Add("Events").Merge(fnGetDataTableInDB(sSql))

        %>
        
        <br />
        <form name="frmModUser" id="frmModUser" method="post" action="functions.aspx?fn=UserEdit">
        <input type="hidden" name="hUid" id="hUid" value="<% Response.Write(Request.QueryString("uid")) %>" />
        <table border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td colspan="7" class="LineHorizo1PX"></td>
            <tr>
                <td height="30" class="LineVertico1PX"></td>
                <td width="10" align="center" valign="middle" bgcolor="#c0c0c0"></td>
                <td class="LineVertico1PX"></td>
                <td width="653" align="left" valign="middle" bgcolor="#c0c0c0">&nbsp;<b>Edit User<br />&nbsp;Modifier un usager</b></td>
                <td class="LineVertico1PX"></td>
                <td width="105" align="center" valign="middle">

                    <a href="admin_users.aspx"><img src="pics/undo.png" width="25" height="25" title="Undo" border="0" /></a>&nbsp;
                    <input type="image" name="bSave" id="bSave" width="25" height="25" src="pics/save.png" title="Save" />&nbsp;
                    <img src="pics/delete.png" width="25" height="25" title="Delete" onmouseover="this.style.cursor='pointer';" onclick="fnConfirmUserDel(<% Response.Write(Request.QueryString("uid")) %>)" />

                </td>
                <td class="LineVertico1PX"></td>
            <tr>
                <td colspan="7" class="LineHorizo1PX"></td>
        </table>

            <table border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td class="LineVertico1PX" height="14"></td>
                    <td width="469" class="FormTableTitle" align="left" valign="middle">&nbsp;LastName / Nom</td>
                    <td class="LineVertico1PX"></td>
                    <td width="300" class="FormTableTitle" align="left" valign="middle">&nbsp;Login / Code Usager</td>
                    <td class="LineVertico1PX"></td>
                <tr>
                    <td class="LineVertico1PX" height="30"></td>
                    <td align="center" valign="middle"><input type="text" name="txtUserLastName" id="txtUserLastName" autocomplete="off" style="width: 459px" class="FormTextBox" value="<% Response.Write(sqlDtSet.Tables("User").Rows(0)("userLastName")) %>" /></td>
                    <td class="LineVertico1PX"></td>
                    <td align="center" valign="middle"><input type="text" name="txtUserLogin" id="txtUserLogin" autocomplete="off" style="width: 290px" class="FormTextBox" value="<% Response.Write(sqlDtSet.Tables("User").Rows(0)("userLogin")) %>" /></td>
                    <td class="LineVertico1PX"></td>
                <tr>
                    <td colspan="5" class="LineHorizo1PX"></td>
            </table>

            <table border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td class="LineVertico1PX" height="14"></td>
                    <td width="469" class="FormTableTitle" align="left" valign="middle">&nbsp;FirstName / Pr&eacute;nom</td>
                    <td class="LineVertico1PX"></td>
                    <td width="300" class="FormTableTitle" align="left" valign="middle">&nbsp;Password / Mot de passe</td>
                    <td class="LineVertico1PX"></td>
                <tr>
                    <td class="LineVertico1PX" height="30"></td>
                    <td align="center" valign="middle"><input type="text" name="txtUserFirstName" id="txtUserFirstName" autocomplete="off" style="width: 459px" class="FormTextBox" value="<% Response.Write(sqlDtSet.Tables("User").Rows(0)("userFirstName")) %>" /></td>
                    <td class="LineVertico1PX"></td>
                    <td align="center" valign="middle"><input type="text" name="txtUserPword" id="txtUserPword" autocomplete="off" style="width: 290px" class="FormTextBox" value="<% Response.Write(sqlDtSet.Tables("User").Rows(0)("userPword")) %>" /></td>
                    <td class="LineVertico1PX"></td>
                <tr>
                    <td colspan="5" class="LineHorizo1PX"></td>
            </table>

            <table border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td class="LineVertico1PX" height="14"></td>
                    <td width="385" class="FormTableTitle" align="left" valign="middle">&nbsp;Rule / Autorit&eacute;</td>
                    <td class="LineVertico1PX"></td>
                    <td width="384" class="FormTableTitle" align="left" valign="middle">&nbsp;Restriction</td>
                    <td class="LineVertico1PX"></td>
                <tr>
                    <td class="LineVertico1PX" height="30"></td>
                    <td align="center" valign="middle">
                        <select name="sUserRule" id="sUserRule" class="FormTextBox" style="width: 370px">
                        <% 
                            For i = 0 To sqlDtSet.Tables("UsersRules").Rows.count - 1 
                        
                            If sqlDtSet.Tables("UsersRules").Rows(i)("userRuleId") = sqlDtSet.Tables("User").Rows(0)("fkUserRuleId") Then
                                sSelected = "selected='selected '"
                            Else
                                sSelected = ""
                            End If
                        
                        %>
                        <option <% Response.Write(sSelected) %>value="<% Response.Write(sqlDtSet.Tables("UsersRules").Rows(i)("userRuleId")) %>"><% Response.Write(sqlDtSet.Tables("UsersRules").Rows(i)("userRuleName")) %></option>
                        <% Next %>
                        </select>
                    </td>
                    <td class="LineVertico1PX"></td>
                    <td align="center" valign="middle">
                    
                        <select name="sUserRestriction" id="sUserRestriction" class="FormTextBox" style="width: 370px">
                        <option value="0">No Restriction / Sans Restriction</option>
                        <% 
                            For i = 0 To sqlDtSet.Tables("Events").Rows.count - 1 
                        
                            If sqlDtSet.Tables("Events").Rows(i)("eventId") = sqlDtSet.Tables("User").Rows(0)("fkEventIdRestricted") Then
                                sSelected = "selected='selected '"
                            Else
                                sSelected = ""
                            End If
                        
                        %>
                        <option <% Response.Write(sSelected) %>value="<% Response.Write(sqlDtSet.Tables("Events").Rows(i)("eventId")) %>"><% Response.Write(sqlDtSet.Tables("Events").Rows(i)("eventNameFr")) %></option>
                        <% Next %>
                        </select>

                    </td>
                    <td class="LineVertico1PX"></td>
                <tr>
                    <td colspan="5" class="LineHorizo1PX"></td>
            </table>

        </form>
        <!-- ===== CONTENU DE LA PAGE ADMIN_USER_EDIT ===== -->
        <!-- ============================================== -->
        </td>
</table>

<!--#include file="inc_bottom.aspx"-->
