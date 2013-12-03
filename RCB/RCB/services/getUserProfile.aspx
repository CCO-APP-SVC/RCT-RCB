<%@ Page Language="VB" AutoEventWireup="false" CodeFile="functions.aspx.vb" Inherits="functions" %>
<%

' Validate session or get user profile
If Session("validuser") <> "ok" Then
    context.Response.StatusCode = 403
    context.Response.Write("Not authorized")
    context.ApplicationInstance.CompleteRequest()
    return
Else
    ' Valid user is logged in
    context.Response.Write( "[{ uid:'" & Session("uid") & "', success: true}]" )
    context.ApplicationInstance.CompleteRequest()
    return
End If

%>
