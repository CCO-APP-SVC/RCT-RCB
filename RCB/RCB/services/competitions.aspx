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
       Dim bRes As Boolean = fnDeleteComp( Request.Params("cid") )
       If bRes = True Then
           context.Response.Write("{success:true}")    
       End If
    Else If Request.Params("action") = "add" Then
        If Request.Params("form-action") <> "edit" Then
            Dim bRes As Boolean = fnAddComp( Request.Params("eid"), Request.Params("title-fr"), Request.Params("title-en"), Request.Params("type"), Request.Params("showFinal") )
        Else 
            Dim bRes As Boolean = fnUpdateComp( Request.Params("cid"), Request.Params("title-fr"), Request.Params("title-en"),  Request.Params("type"), Request.Params("showFinal") )
       End If

     ' If bRes = True Then
           context.Response.Write("{success:true}")    
      ' End If
    End If

End If

%>

