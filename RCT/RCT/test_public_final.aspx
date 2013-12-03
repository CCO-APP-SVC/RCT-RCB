<%@ Page Language="VB" AutoEventWireup="false" CodeFile="functions.aspx.vb" Inherits="functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
</head>
<body>
<%
    Dim sSql As String = "Select * From tblPublicHtmlTexts Where publicHtmlTextName = 'eid-39_fn'"
    Dim sqlDtSet As System.Data.DataSet = fnGetDataSetInDB(sSql, "Html")
    Dim sHtml As String = sqlDtSet.Tables("Html").Rows(0)("publicHtmlText")
    Response.Write(sHtml)
%>



</body>
</html>
