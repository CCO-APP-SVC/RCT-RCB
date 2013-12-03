<%@ Page Language="VB" AutoEventWireup="false" CodeFile="functions.aspx.vb" Inherits="functions" %>
<%

Dim sSql ="Select uid, username, passwd, admin, enabled From tblUsers where username='" & Request.Form("username") & "' And passwd='" & Request.Form("password") & "'"
Dim sqlDtSet As System.Data.DataSet = fnGetDataSetInDB(sSql, "Users")
            
If sqlDtSet.Tables("Users").Rows.Count = 1 Then
    Session("validuser") = "ok"
    Session("uid") = sqlDtSet.Tables("Users").Rows(0)("username")
    Session.Timeout = 7200
    Response.Write( Session("uid") )
Else
    Response.Write("")
  '  context.Response.StatusCode = 403
   ' context.Response.Write("Not authorized")
   ' context.ApplicationInstance.CompleteRequest()
   ' return
End If
%>
