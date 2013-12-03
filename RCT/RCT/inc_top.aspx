
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
    If Session("validuser") <> "ok" Then
        Response.Redirect("login.aspx")
    End If
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <link href="rct.css" rel="Stylesheet" type="text/css" />
    <link href="datepickercontrol.css" rel="Stylesheet" type="text/css" />
    <script type="text/javascript" language="JavaScript" src="rct.js"></script>
    <script type="text/javascript" language="JavaScript" src="datepickercontrol.js"></script>
    <title>RCT</title>
</head>
<body>
<center>
    <table border="0" cellpadding="0" cellspacing="0">
    <tr>
        <td width="10" style="background-image: url('pics/leftcornertop.png');"></td>
        <td width="1002" height="10" style="background-image: url('pics/topside.png'); background-repeat: repeat-x;"></td>
        <td width="10" style="background-image: url('pics/rightcornertop.png');"></td>
    <tr>
        <td style="background-image: url('pics/leftside.png'); background-repeat: repeat-y;"></td>
        <td width="1002" height="35" style="background-image: url('pics/blue.png'); background-repeat: repeat-x;" class="TXTNormal">
            &nbsp;&nbsp;<span style="color: White;">RCT</span>
        </td>
        <td style="background-image: url('pics/rightside.png'); background-repeat: repeat-y;"></td>
    </table>
    
    <table border="0" cellpadding="0" cellspacing="0">
    <tr>
        <td width="10" style="background-image: url('pics/leftside.png'); background-repeat: repeat-y;"></td>
        <td>

    <table border="0" cellpadding="0" cellspacing="0">
    <tr>
        <td colspan="3" class="LineHorizo2PX"></td>
    <tr>
        <td height="25" class="LineVertico2PX"></td>
        <td width="998" height="30" bgcolor="#ffffff" align="left">
        
        <!-- ============================== -->
        <!-- ========== TOP MENU ========== -->
        
        <%
            Dim sColorUnselect As String = "#B7B7B7"
            Dim sMenuWidth As String = "100"
        %>
        <table border="0" cellpadding="0" cellspacing="0" class="TopMenuTexts">
        <tr>
            <td width="<% Response.Write(sMenuWidth) %>" height="30" name="mbHome" id="mbHome" bgcolor="<% Response.Write(sColorUnselect) %>" align="center" valign="middle" onmouseover="fnOnMouseOver(this)" onmouseout="fnOnMouseOut(this)" onclick="fnOnClick('default.aspx')">Home<br />Accueil</td>
            <td class="LineVertico1PX"></td>
            <td width="<% Response.Write(sMenuWidth) %>" name="mbAdmin" id="mbAdmin" bgcolor="<% Response.Write(sColorUnselect) %>" align="center" valign="middle" onmouseover="fnOnMouseOver(this)" onmouseout="fnOnMouseOut(this)" onclick="fnOnClick('admin.aspx')">Admin</td>
            <td class="LineVertico1PX"></td>
            <td width="<% Response.Write(sMenuWidth) %>" name="mbEvents" id="mbEvents" bgcolor="<% Response.Write(sColorUnselect) %>" align="center" valign="middle" onmouseover="fnOnMouseOver(this)" onmouseout="fnOnMouseOut(this)" onclick="fnOnClick('events.aspx')">Events<br />&Eacute;v&eacute;nements</td>
            <td class="LineVertico1PX"></td>
            <td width="<% Response.Write(sMenuWidth) %>" name="mbResults" id="mbResults" bgcolor="<% Response.Write(sColorUnselect) %>" align="center" valign="middle" onmouseover="fnOnMouseOver(this)" onmouseout="fnOnMouseOut(this)" onclick="fnOnClick('results.aspx')">Results<br />R&eacute;sultats</td>
            <td class="LineVertico1PX"></td>
        </table>

        <!-- ========== TOP MENU ========== -->
        <!-- ============================== -->

        </td>
        <td height="25" class="LineVertico2PX"></td>
    <tr>
        <td colspan="3" class="LineHorizo1PX"></td>
    <tr>
        <td height="500" class="LineVertico2PX"></td>
        <td width="998" bgcolor="#ffffff" valign="top">