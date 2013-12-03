<%@ Page Language="VB" AutoEventWireup="false" CodeFile="functions.aspx.vb" Inherits="functions" %>
<!--#include file="inc_top.aspx"-->

<table border="0" cellpadding="0" cellspacing="0" class="TXTNormal">
    <tr>
        <td width="170" height="<% Response.Write(fnGetParamNumeric("HeightTableMenuLeft")) %>" align="center" valign="top">
            <!-- ========================================== -->
            <!-- ===== MENU DE LA PAGE DES ÉVÉNEMENTS ===== -->
            
            <!-- #include file="inc_menu_events.aspx" -->

            <!-- ===== MENU DE LA PAGE DES ÉVÉNEMENTS ===== -->
            <!-- ========================================== -->
        </td>
        <td class="LineVertico1PX"></td>
        <td width="827" align="center" valign="top">
            <%
                Dim strMessageSelected As String = Request.QueryString("msg")
                Dim strMessageToShow As String = ""

                If String.IsNullOrEmpty(strMessageSelected) Then
                    strMessageSelected = "n"
                End If

                Select Case strMessageSelected

                Case "a"
                    strMessageToShow = "L'événement a été ajouté avec succès."
                Case "m"
                    strMessageToShow = "L'événement a été modifié avec succès."
                Case "d"
                    strMessageToShow = "L'événement a été supprimé avec succès."
                End Select

                If strMessageSelected <> "n" Then
            %>
            <br />
            <table border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td width="772" align="left" valign="middle" class="TXTNormalRed">&nbsp;<% Response.Write(strMessageToShow) %></td>
            </table>
            <% End If %>

            <!-- ================================ -->
            <!-- ===== LISTE DES ÉVÉNEMENTS ===== -->
            <br />
            <table border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td colspan="7" class="LineHorizo1PX"></td>
                <tr>
                    <td height="30" class="LineVertico1PX"></td>
                    <td width="10" align="center" valign="middle" bgcolor="#c0c0c0"></td>
                    <td class="LineVertico1PX"></td>
                    <td width="673" align="left" valign="middle" bgcolor="#c0c0c0">&nbsp;<b>Liste des événements</b></td>
                    <td class="LineVertico1PX"></td>
                    <td width="85" align="center" valign="middle">
                    <% If Session("userRule") = 1 Or Session("userRule") = 2 Then%>
                    <a href="event_add.aspx"><img src="pics/add.png" border="0" width="25" height="25" title="Add Event" /></a>
                    <% End If %>
                    </td>
                    <td class="LineVertico1PX"></td>
                <tr>
                    <td colspan="7" class="LineHorizo1PX"></td>
            </table>

            <table border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td colspan="13" class="LineHorizo1PX"></td>
                <tr>
                    <td height="20" class="LineVertico1PX"></td>
                    <td width="10" bgcolor="#c0c0c0"></td>
                    <td class="LineVertico1PX"></td>
                    <td width="300" align="left" valign="middle" bgcolor="#c0c0c0">&nbsp;<b>Nom de l'événement</b></td>
                    <td class="LineVertico1PX"></td>
                    <td width="200" align="left" valign="middle" bgcolor="#c0c0c0">&nbsp;<b>Lieu de l'événement</b></td>
                    <td class="LineVertico1PX"></td>
                    <td width="85" align="center" valign="middle" bgcolor="#c0c0c0"><b>Type</b></td>
                    <td class="LineVertico1PX"></td>
                    <td width="85" align="center" valign="middle" bgcolor="#c0c0c0"><b>Début</b></td>
                    <td class="LineVertico1PX"></td>
                    <td width="85" align="center" valign="middle" bgcolor="#c0c0c0"><b>Fin</b></td>
                    <td class="LineVertico1PX"></td>
                <tr>
                    <td colspan="13" class="LineHorizo1PX"></td>
                
                <%
                    Dim sSql As String
                    If Session("userEventRestricted") <> 0 Then
                        sSql = "Select * From vwEventsEventsTypes Where eventId = " & Session("userEventRestricted") & " Order By eventNameFr"
                    Else
                        sSql = "Select * From vwEventsEventsTypes Order By eventNameFr"
                    End If
                    
                    Dim sqlDtSet As System.Data.DataSet = fnGetDataSetInDB(sSql, "Events")

                    Dim strName, strLocation As String
                    Dim i As Integer

                    For i = 0 To sqlDtSet.Tables("Events").Rows.Count - 1

                        If sqlDtSet.Tables("Events").Rows(i)("eventNameFr").ToString().Length > 38 Then
                            strName = sqlDtSet.Tables("Events").Rows(i)("eventNameFr").ToString().Substring(0,38) & "..."
                        Else
                            strName = sqlDtSet.Tables("Events").Rows(i)("eventNameFr")
                        End If

                        If sqlDtSet.Tables("Events").Rows(i)("eventLocation").ToString().Length > 23 Then
                            strLocation = sqlDtSet.Tables("Events").Rows(i)("eventLocation").ToString().Substring(0,23) & "..."
                        Else
                            strLocation = sqlDtSet.Tables("Events").Rows(i)("eventLocation")
                        End If
                %>
                <tr onmouseover="fnOnMouseOver(this);" onmouseout="fnOnMouseOut(this);" onclick="fnOnClick('event_profile.aspx?eid=<% Response.Write(sqlDtSet.Tables("Events").Rows(i)("eventId")) %>')">
                    <td height="25" class="LineVertico1PX"></td>
                    <td bgcolor="#c0c0c0"></td>
                    <td class="LineVertico1PX"></td>
                    <td align="left" valign="middle">&nbsp;<% Response.Write(strName) %></td>
                    <td class="LineVertico1PX"></td>
                    <td align="left" valign="middle">&nbsp;<% Response.Write(strLocation) %></td>
                    <td class="LineVertico1PX"></td>
                    <td align="center" valign="middle"><% Response.Write(sqlDtSet.Tables("Events").Rows(i)("eventTypeNameFr")) %></td>
                    <td class="LineVertico1PX"></td>
                    <td align="center" valign="middle"><% Response.Write(sqlDtSet.Tables("Events").Rows(i)("StartDate"))%></td>
                    <td class="LineVertico1PX"></td>
                    <td align="center" valign="middle"><% Response.Write(sqlDtSet.Tables("Events").Rows(i)("EndDate")) %></td>
                    <td class="LineVertico1PX"></td>
                <tr>
                    <td colspan="13" class="LineHorizo1PX"></td>
            
            <%
            Next
            %>
            </table>
            <!-- ===== LISTE DES ÉVÉNEMENTS ===== -->
            <!-- ================================ -->

        </td>
</table>

<!--#include file="inc_bottom.aspx"-->
