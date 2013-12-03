<%@ Page Language="VB" AutoEventWireup="false" CodeFile="functions.aspx.vb" Inherits="functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
    Session.Abandon()
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link href="rct.css" rel="Stylesheet" type="text/css" />
    <title>R&eacutesultats Championnat de Tir / Marksmanship Results</title>
</head>
<body>
<center>

    <table border="0" cellpadding="0" cellspacing="0" width="1000">
    <tr>
        <td colspan="5" height="75"></td>
    <tr>
        <td width="299" height="1"></td>
        <td width="1" height="1" bgcolor="#000000"></td>
        <td width="400" height="1" bgcolor="#000000"></td>
        <td width="1" height="1" bgcolor="#000000"></td>
        <td width="299" height="1"></td>
    <tr>
        <td width="299" height="200"></td>
        <td width="1" height="200" bgcolor="#000000"></td>
        <td width="400" height="200" bgcolor="#ffffff" valign="top">
            
            <!-- ===== BEGIN -- AUTHENTICATION FORM ===== -->
            <table border="0" cellpadding="0" cellspacing="0" width="400">
            <tr>
                <td width="400" height="40" align="left" valign="middle" class="TXTTitreLogin">
                    &nbsp;VEUILLEZ VOUS IDENTIFIER POUR ACC&Eacute;DER AU SITE.<br>
                    &nbsp;PLEASE IDENTIFY TO ACCESS THE SITE.
                </td>
            <tr>
                <td width="400" height="1" bgcolor="#000000"></td>
            <tr>
                <td width="400" height="118">
                <!-- ===== BEGIN -- LOGIN FORM ===== -->
                    <form name="frmLogin" id="frmLogin" action="functions.aspx?fn=logincheck" method="post">
                    <table border="0" cellpadding="0" cellspacing="0" width="400">
                    <tr>
                        <td width="165" height="30" class="TXTLogin" align="right">Login</td>
                        <td width="10" height="30"></td>
                        <td width="185" height="30"><input type="text" name="txtLogin" id="txtLogin" AutoComplete=off autofocus="autofocus" maxlength="10" class="TXTBoxes" style="width: 120px" /></td>
                        <td width="40" height="30"></td>
                    <tr>
                        <td width="165" height="30" class="TXTLogin" align="right">Password</td>
                        <td width="10" height="30"></td>
                        <td width="185" height="30"><input type="password" name="txtPword" id="txtPword" AutoComplete=off maxlength="10" class="TXTBoxes" style="width: 120px" /></td>
                        <td width="40" height="30"></td>
                    <tr>
                        <td colspan="2"></td>
                        <td width="185" height="30"><input type="submit" name="cmdSend" id="cmdSend" value="Login" class="CMDForm" style="width: 70px" onmouseover="this.style.cursor='pointer'" /></td>
                        <td width="40" height="30"></td>
                    </table>
                    </form>
                <!-- ===== END -- LOGIN FORM ===== -->
                </td>
             <tr>
                <td width="400" height="1" bgcolor="#000000"></td>
            <tr>
                <td width="400" height="40" align="left" valign="middle" class="TXTLoginMsg">
                <!-- ===== BEGIN -- ERROR MESSAGE ===== -->
                    &nbsp;
                    <%
                        If Request.QueryString("msg") = "invalid" Then
                            Response.Write("Login or Password invalid")
                        ElseIf Request.QueryString("msg") = "disable" Then
                            Response.Write("Login disable")
                        End If
                    %>
                <!-- ===== END -- ERROR MESSAGE ===== -->
                </td>
            </table>
            <!-- ===== END -- AUTHENTICATION FORM ===== -->

        </td>
        <td width="1" height="200" bgcolor="#000000"></td>
        <td width="299" height="200"></td>
    <tr>
        <td width="299" height="1"></td>
        <td width="1" height="1" bgcolor="#000000"></td>
        <td width="400" height="1" bgcolor="#000000"></td>
        <td width="1" height="1" bgcolor="#000000"></td>
        <td width="299" height="1"></td>
    </table>

</center>
</body>
</html>
