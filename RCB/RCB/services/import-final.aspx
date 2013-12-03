<%@ Page Language="VB" AutoEventWireup="false" CodeFile="functions.aspx.vb" Inherits="functions" %>
<%

' Validate session or get user profile
If Session("validuser") <> "ok" Then
    context.Response.StatusCode = 403
    context.Response.Write("Not authorized")
    context.ApplicationInstance.CompleteRequest()
    return
Else

    Dim htmlFinal As String = Request.Params("finalHtml")
    Dim cid As Integer = Request.Params("cid")

    Dim pubResFinal As Boolean = fnUpdateFinalRes( cid, htmlFinal )

    context.Response.Write("{success:true}")    
End If

%>

