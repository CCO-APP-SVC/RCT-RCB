<%@ Page Language="VB" AutoEventWireup="false" CodeFile="functions.aspx.vb" Inherits="functions" %>
<%

' Validate session or get user profile
If Session("validuser") <> "ok" Then
    context.Response.StatusCode = 403
    context.Response.Write("Not authorized")
    context.ApplicationInstance.CompleteRequest()
    return
Else

    Dim csv As String = Request.Params("csv")
    Dim cid As Integer = Request.Params("cid")

    Dim S() as String = Split( csv, "#####", ,CompareMethod.Text)
    Dim list As New ArrayList
    For Each str As String In S
        ' Add player to list while stripping comma and double quotes
        Dim player() = str.replace( """", "").Split( ",")
        list.add(player)
    Next

     Dim bOldRes As Boolean
     bOldRes = fnDeleteResults( cid )

    'Prepare output
    'i is for number of players
    'j is for number of fields in CSV file 
    Dim i as Integer
    Dim bResTemp As Boolean
    For i = 0 To list.Count - 1
        bResTemp = fnAddResults( cid,list.Item(i) )
	Next i

    Dim bRes As Boolean = fnUpdateCompTime( cid, Request.Params("date") )

    Dim pubResTemp  As Boolean = fnUpdatePubRes( cid, "view-temp.aspx", "publicTemp" )
    Dim pubResStart As Boolean = fnUpdatePubRes( cid, "view-start.aspx", "publicStart" )
    Dim pubResFinal As Boolean = fnUpdatePubRes( cid, "view-final.aspx", "publicFinal" )

    context.Response.Write("{success:true}")    
End If

%>

