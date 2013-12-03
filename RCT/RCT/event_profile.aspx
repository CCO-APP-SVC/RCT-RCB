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
        <br />
        <!-- ================================================== -->
        <!-- ===== TABLEAU DE CONSULTATION D'UN ÉVÉNEMENT ===== -->
        <% 
            Dim sSql As String = "Select * From vwEventsEventsTypes Where eventId = " & Request.QueryString("eid")
            Dim sqlDtSet As System.Data.DataSet = fnGetDataSetInDB(sSql, "Events")
        %>
            <table border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td colspan="7" class="LineHorizo1PX"></td>
                <tr>
                    <td height="30" class="LineVertico1PX"></td>
                    <td width="10" align="center" valign="middle" bgcolor="#c0c0c0"></td>
                    <td class="LineVertico1PX"></td>
                    <td width="673" align="left" valign="middle" bgcolor="#c0c0c0">&nbsp;<b>Event Profile</b><br />&nbsp;<b>Profile d'&eacute;v&eacute;nement</b></td>
                    <td class="LineVertico1PX"></td>
                    <td width="85" align="center" valign="middle">
                        <a href="events.aspx"><img src="pics/undo.png" width="25" height="25" title="Undo" border="0" /></a>&nbsp;
                        <% If Session("userRule") = 1 Or Session("userRule") = 2 Then%>
                        <a href="event_edit.aspx?eid=<% Response.Write(Request.QueryString("eid")) %>"><img src="pics/edit.jpg" width="25" height="25" title="Edit Event" border="0" /></a>
                        <% End If %>
                    </td>
                    <td class="LineVertico1PX"></td>
                <tr>
                    <td colspan="7" class="LineHorizo1PX"></td>
            </table>

            <table border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td colspan="5" class="LineHorizo1PX"></td>
                <tr>
                    <td class="LineVertico1PX" height="14"></td>
                    <td width="569" class="FormTableTitle" align="left" valign="middle">&nbsp;Nom de l'&eacute;v&eacute;nement en FRAN&Ccedil;AIS</td>
                    <td class="LineVertico1PX"></td>
                    <td width="200" class="FormTableTitle" align="left" valign="middle">&nbsp;Date de d&eacute;but (AAAA/MM/JJ)</td>
                    <td class="LineVertico1PX"></td>
                <tr>
                    <td class="LineVertico1PX" height="30"></td>
                    <td align="left" valign="middle">&nbsp;<% Response.Write(sqlDtSet.Tables("Events").Rows(0)("eventNameFr")) %></td>
                    <td class="LineVertico1PX"></td>
                    <td align="center" valign="middle"><% Response.Write(sqlDtSet.Tables("Events").Rows(0)("StartDate")) %></td>
                    <td class="LineVertico1PX"></td>
                <tr>
                    <td colspan="5" class="LineHorizo1PX"></td>
            </table>
            <table border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td class="LineVertico1PX" height="14"></td>
                    <td width="569" class="FormTableTitle" align="left" valign="middle">&nbsp;Nom de l'&eacute;v&eacute;nement en ANGLAIS</td>
                    <td class="LineVertico1PX"></td>
                    <td width="200" class="FormTableTitle" align="left" valign="middle">&nbsp;Date de fin (AAAA/MM/JJ)</td>
                    <td class="LineVertico1PX"></td>
                <tr>
                    <td class="LineVertico1PX" height="30"></td>
                    <td align="left" valign="middle">&nbsp;<% Response.Write(sqlDtSet.Tables("Events").Rows(0)("eventNameEn")) %></td>
                    <td class="LineVertico1PX"></td>
                    <td align="center" valign="middle"><% Response.Write(sqlDtSet.Tables("Events").Rows(0)("EndDate")) %></td>
                    <td class="LineVertico1PX"></td>
                <tr>
                    <td colspan="5" class="LineHorizo1PX"></td>
            </table>
            <table border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td class="LineVertico1PX" height="14"></td>
                    <td width="569" class="FormTableTitle" align="left" valign="middle">&nbsp;Lieu de l'&eacute;v&eacute;nement</td>
                    <td class="LineVertico1PX"></td>
                    <td width="200" class="FormTableTitle" align="left" valign="middle">&nbsp; Type d'&eacute;v&eacute;nement</td>
                    <td class="LineVertico1PX"></td>
                <tr>
                    <td class="LineVertico1PX" height="30"></td>
                    <td align="left" valign="middle">&nbsp;<% Response.Write(sqlDtSet.Tables("Events").Rows(0)("eventLocation")) %></td>
                    <td class="LineVertico1PX"></td>
                    <td align="center" valign="middle"><% Response.Write(sqlDtSet.Tables("Events").Rows(0)("eventTypeNameFr")) %></td>
                    <td class="LineVertico1PX"></td>
                <tr>
                    <td colspan="5" class="LineHorizo1PX"></td>
            </table>

            <table border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td class="LineVertico1PX" height="14"></td>
                    <td width="368" class="FormTableTitle" align="left" valign="middle">&nbsp;</td>
                    <td class="LineVertico1PX"></td>
                    <td width="200" class="FormTableTitle" align="left" valign="middle">&nbsp;Finale</td>
                    <td class="LineVertico1PX"></td>
                    <td width="200" class="FormTableTitle" align="left" valign="middle">&nbsp;R&eacute;sultats Public Affich&eacute;s</td>
                    <td class="LineVertico1PX"></td>
                <tr>
                    <td class="LineVertico1PX" height="30"></td>
                    <td align="left" valign="middle">&nbsp;</td>
                    <td class="LineVertico1PX"></td>
                    <td align="center" valign="middle" <% If Session("userRule") = 1 Or Session("userRule") = 2 Then%>onmouseover="fnOnMouseOver(this);" onmouseout="fnOnMouseOut(this);" onclick="fnOnClick('event_finalists_selection.aspx?eid=<% Response.Write(Request.QueryString("eid")) %>');"<% End If %>>Finalists Selection<br />Sélection des finalistes</td>
                    <td class="LineVertico1PX"></td>
                    <td align="center" valign="middle" <% If Session("userRule") = 1 Or Session("userRule") = 2 Then%>onmouseover="fnOnMouseOver(this);" onmouseout="fnOnMouseOut(this);" onclick="fnOnClick('functions.aspx?fn=ShowPublicResults&spr=<% Response.Write(sqlDtSet.Tables("Events").Rows(0)("eventShowPublicResults")) %>&eid=<% Response.Write(Request.QueryString("eid")) %>');"<% End If %>><% Response.Write(sqlDtSet.Tables("Events").Rows(0)("eventShowPublicResults")) %></td>
                    <td class="LineVertico1PX"></td>
                <tr>
                    <td colspan="7" class="LineHorizo1PX"></td>
            </table>
        <!-- ===== TABLEAU DE CONSULTATION D'UN ÉVÉNEMENT ===== -->
        <!-- ================================================== -->

            <br />

        <!-- ================================================ -->
        <!-- ===== TABLEAU D'AFFICHAGE DES COMPÉTITIONS ===== -->

            <table border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td colspan="7" class="LineHorizo1PX"></td>
                <tr>
                    <td height="30" class="LineVertico1PX"></td>
                    <td width="10" align="center" valign="middle" bgcolor="#c0c0c0"><span id="spanPlusCompetitions" name="spanPlusCompetitions" onmouseover="this.style.cursor='pointer';" onclick="fnHideShowItem('tblCompetitions','spanPlusCompetitions');">-</span></td>
                    <td class="LineVertico1PX"></td>
                    <td width="673" align="left" valign="middle" bgcolor="#c0c0c0">&nbsp;<span onmouseover="this.style.cursor='pointer';" onclick="fnHideShowItem('tblCompetitions','spanPlusCompetitions');"><b>Compétitions de l'événement</b></span></td>
                    <td class="LineVertico1PX"></td>
                    <td width="85" align="center" valign="middle">
                        <% If Session("userRule") = 1 Or Session("userRule") = 2 Then%>
                        <img src="pics/add.png" border="0" width="25" height="25" title="Add Competition" onmouseover="this.style.cursor='pointer'" onclick="fnOnClick('event_competition_add.aspx?eid=<% Response.Write(Request.Querystring("eid")) %>')" />
                        <% End If%>
                    </td>
                    <td class="LineVertico1PX"></td>
                <tr>
                    <td colspan="7" class="LineHorizo1PX"></td>
            </table>

            <table border="0" cellpadding="0" cellspacing="0" id="tblCompetitions" name="tblCompetitions">
                <tr>
                    <td colspan="9" class="LineHorizo1PX"></td>
                <tr>
                    <td height="20" class="LineVertico1PX"></td>
                    <td width="10" bgcolor="#c0c0c0"></td>
                    <td class="LineVertico1PX"></td>
                    <td width="350" align="left" valign="middle" bgcolor="#c0c0c0">&nbsp;<b>Nom en français</b></td>
                    <td class="LineVertico1PX"></td>
                    <td width="350" align="left" valign="middle" bgcolor="#c0c0c0">&nbsp;<b>Nom en anglais</b></td>
                    <td class="LineVertico1PX"></td>
                    <td width="57" align="center" valign="middle" bgcolor="#c0c0c0"><b></b></td>
                    <td class="LineVertico1PX"></td>
                <tr>
                    <td colspan="9" class="LineHorizo1PX"></td>
            <%
                sSql = "Select * From tblCompetitions Where fkEventId = " & Request.QueryString("eid") & " Order By competitionNameFr"
                sqlDtSet.Tables.Add("Competitions").Merge(fnGetDataTableInDB(sSql))

                Dim i As Integer
                For i = 0 To sqlDtSet.Tables("Competitions").Rows.Count - 1
            %>

                <tr onmouseover="fnOnMouseOver(this);" onmouseout="fnOnMouseOut(this);" onclick="fnOnClick('event_competition_edit.aspx?eid=<% Response.Write(Request.QueryString("eid")) %>&cid=<% Response.Write(sqlDtSet.Tables("Competitions").Rows(i)("competitionId"))%>')">
                    <td height="25" class="LineVertico1PX"></td>
                    <td bgcolor="#c0c0c0"></td>
                    <td class="LineVertico1PX"></td>
                    <td align="left" valign="middle">&nbsp;<% Response.Write(sqlDtSet.Tables("Competitions").Rows(i)("competitionNameFr"))%></td>
                    <td class="LineVertico1PX"></td>
                    <td align="left" valign="middle">&nbsp;<% Response.Write(sqlDtSet.Tables("Competitions").Rows(i)("competitionNameEn"))%></td>
                    <td class="LineVertico1PX"></td>
                    <td align="center" valign="middle"></td>
                    <td class="LineVertico1PX"></td>
                <tr>
                    <td colspan="9" class="LineHorizo1PX"></td>
            <% Next %>

            </table>

        <!-- ===== TABLEAU D'AFFICHAGE DES COMPÉTITIONS ===== -->
        <!-- ================================================ -->
        <br />

        <!-- =========================================== -->
        <!-- ===== TABLEAU D'AFFICHAGE DES RÉGIONS ===== -->

            <table border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td colspan="7" class="LineHorizo1PX"></td>
                <tr>
                    <td height="30" class="LineVertico1PX"></td>
                    <td width="10" align="center" valign="middle" bgcolor="#c0c0c0"><span id="spanPlusRegions" name="spanPlusRegions" onmouseover="this.style.cursor='pointer';" onclick="fnHideShowItem('tblRegions','spanPlusRegions');">-</span></td>
                    <td class="LineVertico1PX"></td>
                    <td width="673" align="left" valign="middle" bgcolor="#c0c0c0">&nbsp;<span onmouseover="this.style.cursor='pointer';" onclick="fnHideShowItem('tblRegions','spanPlusRegions');"><b>Régions de l'événement</b></span></td>
                    <td class="LineVertico1PX"></td>
                    <td width="85" align="center" valign="middle">
                        <% If Session("userRule") = 1 Or Session("userRule") = 2 Then%>
                        <img src="pics/edit.jpg" border="0" width="25" height="25" title="Edit Regions" onmouseover="this.style.cursor='pointer'" onclick="fnOnClick('event_regions.aspx?eid=<% Response.Write(Request.Querystring("eid")) %>')" />
                        <% End If %>
                    </td>
                    <td class="LineVertico1PX"></td>
                <tr>
                    <td colspan="7" class="LineHorizo1PX"></td>
            </table>

            <table border="0" cellpadding="0" cellspacing="0" id="tblRegions" name="tblRegions">
                <tr>
                    <td colspan="13" class="LineHorizo1PX"></td>
                <tr>
                    <td height="20" class="LineVertico1PX"></td>
                    <td width="10" bgcolor="#c0c0c0"></td>
                    <td class="LineVertico1PX"></td>
                    <td width="250" align="left" valign="middle" bgcolor="#c0c0c0">&nbsp;<b>Région FR</b></td>
                    <td class="LineVertico1PX"></td>
                    <td width="250" align="left" valign="middle" bgcolor="#c0c0c0">&nbsp;<b>Région EN</b></td>
                    <td class="LineVertico1PX"></td>
                    <td width="85" align="center" valign="middle" bgcolor="#c0c0c0"><b>Lettres FR</b></td>
                    <td class="LineVertico1PX"></td>
                    <td width="85" align="center" valign="middle" bgcolor="#c0c0c0"><b>Lettres EN</b></td>
                    <td class="LineVertico1PX"></td>
                    <td width="85" align="center" valign="middle" bgcolor="#c0c0c0"><b></b></td>
                    <td class="LineVertico1PX"></td>
                <tr>
                    <td colspan="13" class="LineHorizo1PX"></td>
            <%
                sSql = "Select * From tblRegions JOIN tblRegionsEvents ON tblRegions.regionId=tblRegionsEvents.fkRegionId Where fkEventId =" & Request.QueryString("eid") & " Order By regionNameFr"
                sqlDtSet.Tables.Add("Regions").Merge(fnGetDataTableInDB(sSql))
                
                For i = 0 To sqlDtSet.Tables("Regions").Rows.Count - 1
            %>
                <tr onmouseover="fnOnMouseOver(this);" onmouseout="fnOnMouseOut(this);" onclick="fnOnClick('event_region_teams.aspx?eid=<% Response.Write(Request.QueryString("eid")) %>&rid=<% Response.Write(sqlDtSet.Tables("Regions").Rows(i)("regionId")) %>&reid=<% Response.Write(sqlDtSet.Tables("Regions").Rows(i)("regionEventId")) %>')">
                    <td height="25" class="LineVertico1PX"></td>
                    <td bgcolor="#c0c0c0"></td>
                    <td class="LineVertico1PX"></td>
                    <td align="left" valign="middle">&nbsp;<% Response.Write(sqlDtSet.Tables("Regions").Rows(i)("regionNameFr"))%></td>
                    <td class="LineVertico1PX"></td>
                    <td align="left" valign="middle">&nbsp;<% Response.Write(sqlDtSet.Tables("Regions").Rows(i)("regionNameEn"))%></td>
                    <td class="LineVertico1PX"></td>
                    <td align="center" valign="middle"><% Response.Write(sqlDtSet.Tables("Regions").Rows(i)("regionLetterFr"))%></td>
                    <td class="LineVertico1PX"></td>
                    <td align="center" valign="middle"><% Response.Write(sqlDtSet.Tables("Regions").Rows(i)("regionLetterEn"))%></td>
                    <td class="LineVertico1PX"></td>
                    <td align="center" valign="middle"></td>
                    <td class="LineVertico1PX"></td>
                <tr>
                    <td colspan="13" class="LineHorizo1PX"></td>
            <%
            Next
            %>

            </table>

        <!-- ===== TABLEAU D'AFFICHAGE DES RÉGIONS ===== -->
        <!-- =========================================== -->
        <br />

        </td>
</table>
<!--#include file="inc_bottom.aspx"-->
