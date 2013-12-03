<%@ Page Language="VB" AutoEventWireup="false" CodeFile="functions.aspx.vb" Inherits="functions" %>
<%

' Validate session or get user profile
If Session("validuser") <> "ok" Then
    context.Response.StatusCode = 403
    context.Response.Write("Not authorized")
    context.ApplicationInstance.CompleteRequest()
    return
Else

    ' Validate action
    If Request.Params("action") = "delete" Then
       Dim bRes As Boolean = fnDeleteEvent( Request.Params("eid") )
       If bRes = True Then
           context.Response.Write("{success:true}")    
       End If
    Else If Request.Params("action") = "add" Then
       If Request.Params("form-action") <> "edit" Then
           Dim bRes As Boolean = fnAddEvent( Request.Params("name-fr"), Request.Params("name-en") )
       Else
           Dim bRes As Boolean = fnUpdateEvent( Request.Params("eid"), Request.Params("name-fr"), Request.Params("name-en") )
       End If
     '  If bRes = True Then
           context.Response.Write("{success:true}")    
     '  End If
    End If

End If

%>
