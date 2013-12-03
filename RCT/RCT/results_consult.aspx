<%@ Page Language="VB" AutoEventWireup="false" CodeFile="functions.aspx.vb" Inherits="functions" %>
<!--#include file="inc_top.aspx"-->
 
 <table border="0" cellpadding="0" cellspacing="0" class="TXTNormal">
    <tr>
        <td width="170" height="<% Response.Write(fnGetParamNumeric("HeightTableMenuLeft")) %>" align="center" valign="top">
            <!-- ====================================== -->
            <!-- ===== MENU DE LA SECTION RESULTS ===== -->
            
            <!-- #include file="inc_menu_results.aspx" -->

            <!-- ===== MENU DE LA SECTION RESULTS ===== -->
            <!-- ====================================== -->
        </td>
        <td class="LineVertico1PX"></td>
        <td width="827" align="center" valign="top">
        <br />
        <!-- ============================================== -->
        <!-- ===== CONTENU DE LA PAGE RESULTS_CONSULT ===== -->
        
            <!-- =============================================== -->
            <!-- ===== TABLEAU DE SÉLECTION D'UN ÉVÉNEMENT ===== -->

            <% 
                
                Dim sSql As String
                    If Session("userEventRestricted") <> 0 Then
                        sSql = "Select * From vwEventsEventsTypes Where eventId = " & Session("userEventRestricted") & " Order By eventNameFr"
                    Else
                        sSql = "Select * From vwEventsEventsTypes Order By eventNameFr"
                    End If
                
                Dim sqlDtSet As System.Data.DataSet = fnGetDataSetInDB(sSql, "Events")
                
                Dim sEid, sCid, sRaid As String
                Dim sColorEid, sColorCid, sColorRaid As String
                Dim sSelected As String
                Dim i As Integer

                sEid = Request.QueryString("eid")
                sCid = Request.QueryString("cid")
                sRaid = Request.QueryString("raid")
                
                If String.IsNullOrEmpty(sEid) Then
                    sEid = "0"
                End If
                If String.IsNullOrEmpty(sRaid) Then
                    sRaid = "0"
                End If
                If String.IsNullOrEmpty(sCid) Then
                    sCid = "0"
                End If

                If sEid = "0" Then
                    sColorEid = "#ffA0A0"
                Else
                    sColorEid = "#c0c0c0"
                End If

                If sCid = "0" Then
                    sColorCid = "#ffA0A0"
                Else
                    sColorCid = "#c0c0c0"
                End If

                if sRaid = "0" Then
                    sColorRaid = "#ffA0A0"
                Else
                    sColorRaid = "#c0c0c0"
                End If
                
            %>
            <table border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td colspan="7" class="LineHorizo1PX"></td>
                <tr>
                    <td height="30" class="LineVertico1PX"></td>
                    <td width="10" align="center" valign="middle" bgcolor="#c0c0c0"></td>
                    <td class="LineVertico1PX"></td>
                    <td width="759" align="left" valign="middle" bgcolor="#c0c0c0">&nbsp;<b>Consult results</b><br />&nbsp;<b>Consulter des résultats</b></td>
                    <td class="LineVertico1PX"></td>
                <tr>
                    <td colspan="7" class="LineHorizo1PX"></td>
            </table>
            <br />

            <table border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td colspan="7" class="LineHorizo1PX"></td>
            <tr>
                <td height="30" class="LineVertico1PX"></td>
                <td width="10" align="center" valign="middle" bgcolor="#c0c0c0"></td>
                <td class="LineVertico1PX"></td>
                <td width="373" align="left" valign="middle" bgcolor="<% Response.Write(sColorEid) %>">&nbsp;<b>Select an event</b><br />&nbsp;<b>S&eacute;lectionnez un &eacute;v&eacute;nement</b></td>
                <td class="LineVertico1PX"></td>
                <td width="385" align="center" valign="middle">
                    <select name="sEvents" id="sEvents" style="width: 365px" class="FormTextBox" onchange="document.location='results_consult.aspx?eid='+this.value;">
                        <option value="0">Select an event - S&eacute;lectionnez un &eacute;v&eacute;nement</option>
                        <option disabled>--------------------</option>
                        <%
                            For i = 0 To sqlDtSet.Tables("Events").Rows.Count - 1
                                If sEid = sqlDtSet.Tables("Events").Rows(i)("eventId").ToString() Then
                                    sSelected = "selected='selected'"
                                Else
                                    sSelected = ""
                                End If
                        %>
                        <option value="<% Response.Write(sqlDtSet.Tables("Events").Rows(i)("eventId")) %>"
                        <% Response.Write(sSelected) %>>
                        <% Response.Write(sqlDtSet.Tables("Events").Rows(i)("eventNameFr")) %></option>
                        <% Next %>
                    </select>
                </td>
                <td class="LineVertico1PX"></td>
            <tr>
                <td colspan="7" class="LineHorizo1PX"></td>
            </table>
            <br />
            <!-- ===== TABLEAU DE SÉLECTION D'UN ÉVÉNEMENT ===== -->
            <!-- =============================================== -->

            <% If sEid <> "0" Then %>
            <!-- ============================================================================ -->
            <!-- ===== TABLEAU DE SÉLECTION DE LA COMPÉTITION QUI COMPOSERA LE RAPPORT  ===== -->

            <table border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td colspan="7" class="LineHorizo1PX"></td>
                <tr>
                    <td height="30" class="LineVertico1PX"></td>
                    <td width="10" align="center" valign="middle" bgcolor="#c0c0c0"></td>
                    <td class="LineVertico1PX"></td>
                    <td width="373" align="left" valign="middle" bgcolor="<% Response.Write(sColorCid) %>">&nbsp;<b>Select a competition</b><br />&nbsp;<b>S&eacute;lectionnez une comp&eacute;tition</b></td>
                    <td class="LineVertico1PX"></td>
                    <td width="385" align="center" valign="middle">
                        <select name="sCompetitions" id="sCompetitions" style="width: 365px" class="FormTextBox" onchange="document.location='results_consult.aspx?eid=<% Response.Write(sEid) %>&cid='+this.value;">
                            <% 
                                sSql = "Select * From tblCompetitions Where fkEventId = " & sEid
                                sqlDtSet.Tables.Add("Competitions").Merge(fnGetDataTableInDB(sSql))
                            %>
                            <option value="0">Select a competition - S&eacute;lectionnez une comp&eacute;tition</option>
                            <option disabled>--------------------</option>
                            <%
                                For i = 0 To sqlDtSet.Tables("Competitions").Rows.Count - 1
                                    If sCid = sqlDtSet.Tables("Competitions").Rows(i)("competitionId").ToString() Then
                                        sSelected = "selected='selected'"
                                    Else
                                        sSelected = ""
                                    End If
                            %>
                            <option value="<% Response.Write(sqlDtSet.Tables("Competitions").Rows(i)("competitionId")) %>" <% Response.Write(sSelected) %>><% Response.Write(sqlDtSet.Tables("Competitions").Rows(i)("competitionNameFr")) %></option>
                            <% Next %>
                        </select>
                    </td>
                    <td class="LineVertico1PX"></td>
                <tr>
                    <td colspan="7" class="LineHorizo1PX"></td>
            </table>
            <br />

            <!-- ===== TABLEAU DE SÉLECTION DE LA COMPÉTITION QUI COMPOSERA LE RAPPORT  ===== -->
            <!-- ============================================================================ -->
            <% End If %>


            <% If sCid <> "0" Then%>
            <!-- =========================================== -->
            <!-- ===== TABLEAU DE SÉLECTION DU RAPPORT ===== -->

            <table border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td colspan="7" class="LineHorizo1PX"></td>
                <tr>
                    <td height="30" class="LineVertico1PX"></td>
                    <td width="10" align="center" valign="middle" bgcolor="#c0c0c0"></td>
                    <td class="LineVertico1PX"></td>
                    <td width="373" align="left" valign="middle" bgcolor="<% Response.Write(sColorRaid) %>">&nbsp;<b>Select a report</b><br />&nbsp;<b>S&eacute;lectionnez un rapport</b></td>
                    <td class="LineVertico1PX"></td>
                    <td width="385" align="center" valign="middle">
                        <select name="sReports" id="sReports" style="width: 365px" class="FormTextBox" onchange="document.location='results_consult.aspx?eid=<% Response.Write(sEid) %>&cid=<% Response.Write(sCid) %>&raid='+this.value;">
                            <% 
                                Dim sSelectReport1, sSelectReport2, sSelectReport3, sSelectReport4, sSelectReport5, sSelectReport6, sSelectReport7, sSelectReport8 As String
                                
                                Select Case sRaid
                                
                                Case "1"
                                    sSelectReport1 = "selected='selected'"

                                Case "2"
                                    sSelectReport2 = "selected='selected'"

                                Case "3"
                                    sSelectReport3 = "selected='selected'"

                                Case "4"
                                    sSelectReport4 = "selected='selected'"

                                Case "5"
                                    sSelectReport5 = "selected='selected'"

                                Case "6"
                                    sSelectReport6 = "selected='selected'"

                                Case "7"
                                    sSelectReport7 = "selected='selected'"

                                Case "8"
                                    sSelectReport8 = "selected='selected'"

                                End Select
                            %>
                            <option value="0">Select a report - S&eacute;lectionnez un rapport</option>
                            <option disabled="disabled">--------------------</option>
                            <option value="1" <% Response.Write(sSelectReport1) %>>R&eacute;sultats individuels par r&eacute;gion</option>
                            <option value="2" <% Response.Write(sSelectReport2) %>>R&eacute;sultats d'&eacute;quipe par r&eacute;gion</option>
                            <option value="3" <% Response.Write(sSelectReport3) %>>Classement des r&eacute;gions</option>
                            <option value="4" <% Response.Write(sSelectReport4) %>>Classement des &eacute;quipes compos&eacute;es</option>
                            <option value="5" <% Response.Write(sSelectReport5) %>>Classement des &eacute;quipes d'unit&eacute;</option>
                            <option value="6" <% Response.Write(sSelectReport6) %>>Classement des comp&eacute;titeurs</option>
                            <option disabled="disabled">--------------------</option>
                            <option value="7" <% Response.Write(sSelectReport7) %>>Master</option>
                            <option disabled="disabled">--------------------</option>
                            <option value="8" <% Response.Write(sSelectReport8) %>>Résultats de la finale</option>

                        </select>
                    </td>
                    <td class="LineVertico1PX"></td>
                <tr>
                    <td colspan="7" class="LineHorizo1PX"></td>
            </table>
            <br />
            <!-- ===== TABLEAU DE SÉLECTION DU RAPPORT ===== -->
            <!-- =========================================== -->
            <% End If %>


            <% If sRaid = "1" Then %>
            <!-- ======================================================================================== -->
            <!-- ===== TABLEAU DE SÉLECTION DE LA RÉGION POUR LES RÉSULTATS INDIVIDUELS PAR RÉGION  ===== -->

            <table border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td colspan="5" class="LineHorizo1PX"></td>
                <tr>
                    <td height="30" class="LineVertico1PX"></td>
                    <td width="10" align="center" valign="middle" bgcolor="#c0c0c0"></td>
                    <td class="LineVertico1PX"></td>
                    <td width="759" align="left" valign="middle" bgcolor="#ffA0A0">&nbsp;<b>Select a region</b><br />&nbsp;<b>S&eacute;lectionnez une r&eacute;gion</b></td>
                    <td class="LineVertico1PX"></td>
                <tr>
                    <td colspan="5" class="LineHorizo1PX"></td>
            </table>

            <% 
                sSql = "Select * From tblRegions JOIN tblRegionsEvents ON tblRegions.regionId=tblRegionsEvents.fkRegionId Where fkEventId = " & sEid & " Order By regionNameFr"
                sqlDtSet.Tables.Add("Regions").Merge(fnGetDataTableInDB(sSql))
            %>
            <table border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td colspan="9" class="LineHorizo1PX"></td>
                <tr>
                    <td height="20" class="LineVertico1PX"></td>
                    <td width="10" bgcolor="#c0c0c0"></td>
                    <td class="LineVertico1PX"></td>
                    <td width="325" align="center" valign="middle" bgcolor="#c0c0c0"><b>Région FR</b></td>
                    <td class="LineVertico1PX"></td>
                    <td width="325" align="center" valign="middle" bgcolor="#c0c0c0"><b>Region EN</b></td>
                    <td class="LineVertico1PX"></td>
                    <td width="107" align="center" valign="middle" bgcolor="#c0c0c0"><b></b></td>
                    <td class="LineVertico1PX"></td>
                <tr>
                    <td colspan="9" class="LineHorizo1PX"></td>
                <% For i = 0 To sqlDtSet.Tables("Regions").Rows.Count - 1 %>
                <tr onmouseover="fnOnMouseOver(this);" onmouseout="fnOnMouseOut(this);" onclick="window.open('results_region_individual.aspx?eid=<% Response.Write(sEid) %>&cid=<% Response.Write(sCid) %>&rid=<% Response.Write(sqlDtSet.Tables("Regions").Rows(i)("regionId")) %>&reid=<% Response.Write(sqlDtSet.Tables("Regions").Rows(i)("regionEventId")) %>');">
                    <td height="25" class="LineVertico1PX"></td>
                    <td bgcolor="#c0c0c0"></td>
                    <td class="LineVertico1PX"></td>
                    <td align="left" valign="middle">&nbsp;<% Response.Write(sqlDtSet.Tables("Regions").Rows(i)("regionNameFr")) %></td>
                    <td class="LineVertico1PX"></td>
                    <td align="left" valign="middle">&nbsp;<% Response.Write(sqlDtSet.Tables("Regions").Rows(i)("regionNameEn")) %></td>
                    <td class="LineVertico1PX"></td>
                    <td align="center" valign="middle"></td>
                    <td class="LineVertico1PX"></td>
                <tr>
                    <td colspan="9" class="LineHorizo1PX"></td>

                <% Next %>
            </table>
            <br />

            <!-- ===== TABLEAU DE SÉLECTION DE LA RÉGION POUR LES RÉSULTATS INDIVIDUELS PAR RÉGION  ===== -->
            <!-- ======================================================================================== -->

            <% End If %>


            <% If sRaid = "2" Then %>
            <!-- ====================================================================================== -->
            <!-- ===== TABLEAU DE SÉLECTION DE LA RÉGION POUR LES RÉSULTATS EN ÉQUIPE PAR RÉGION  ===== -->

            <table border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td colspan="5" class="LineHorizo1PX"></td>
                <tr>
                    <td height="30" class="LineVertico1PX"></td>
                    <td width="10" align="center" valign="middle" bgcolor="#c0c0c0"></td>
                    <td class="LineVertico1PX"></td>
                    <td width="759" align="left" valign="middle" bgcolor="#ffA0A0">&nbsp;<b>Select a region</b><br />&nbsp;<b>S&eacute;lectionnez une r&eacute;gion</b></td>
                    <td class="LineVertico1PX"></td>
                <tr>
                    <td colspan="5" class="LineHorizo1PX"></td>
            </table>

            <% 
                sSql = "Select * From tblRegions JOIN tblRegionsEvents ON tblRegions.regionId=tblRegionsEvents.fkRegionId Where fkEventId = " & sEid & " Order By regionNameFr"
                sqlDtSet.Tables.Add("Regions").Merge(fnGetDataTableInDB(sSql))
            %>
            <table border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td colspan="9" class="LineHorizo1PX"></td>
                <tr>
                    <td height="20" class="LineVertico1PX"></td>
                    <td width="10" bgcolor="#c0c0c0"></td>
                    <td class="LineVertico1PX"></td>
                    <td width="325" align="center" valign="middle" bgcolor="#c0c0c0"><b>Région FR</b></td>
                    <td class="LineVertico1PX"></td>
                    <td width="325" align="center" valign="middle" bgcolor="#c0c0c0"><b>Region EN</b></td>
                    <td class="LineVertico1PX"></td>
                    <td width="107" align="center" valign="middle" bgcolor="#c0c0c0"><b></b></td>
                    <td class="LineVertico1PX"></td>
                <tr>
                    <td colspan="9" class="LineHorizo1PX"></td>
                <% For i = 0 To sqlDtSet.Tables("Regions").Rows.Count - 1 %>
                <tr onmouseover="fnOnMouseOver(this);" onmouseout="fnOnMouseOut(this);" onclick="window.open('results_region_team.aspx?eid=<% Response.Write(sEid) %>&cid=<% Response.Write(sCid) %>&rid=<% Response.Write(sqlDtSet.Tables("Regions").Rows(i)("regionId")) %>&reid=<% Response.Write(sqlDtSet.Tables("Regions").Rows(i)("regionEventId")) %>');">
                    <td height="25" class="LineVertico1PX"></td>
                    <td bgcolor="#c0c0c0"></td>
                    <td class="LineVertico1PX"></td>
                    <td align="left" valign="middle">&nbsp;<% Response.Write(sqlDtSet.Tables("Regions").Rows(i)("regionNameFr")) %></td>
                    <td class="LineVertico1PX"></td>
                    <td align="left" valign="middle">&nbsp;<% Response.Write(sqlDtSet.Tables("Regions").Rows(i)("regionNameEn")) %></td>
                    <td class="LineVertico1PX"></td>
                    <td align="center" valign="middle"></td>
                    <td class="LineVertico1PX"></td>
                <tr>
                    <td colspan="9" class="LineHorizo1PX"></td>

                <% Next %>
            </table>
            <br />

            <!-- ===== TABLEAU DE SÉLECTION DE LA RÉGION POUR LES RÉSULTATS EN ÉQUIPE PAR RÉGION  ===== -->
            <!-- ====================================================================================== -->

            <% End If %>


            <% If sRaid = "3" Then %>
            <!-- ============================================ -->
            <!-- ===== TABLEAU DE LANCEMENT DU RAPPORT  ===== -->

            <table border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td colspan="7" class="LineHorizo1PX"></td>
                <tr>
                    <td height="30" class="LineVertico1PX"></td>
                    <td width="10" align="center" valign="middle" bgcolor="#c0c0c0"></td>
                    <td class="LineVertico1PX"></td>
                    <td width="558" align="left" valign="middle" bgcolor="#ffA0A0">&nbsp;<b>Click to the right to show the report</b><br />&nbsp;<b>Cliquez &agrave; droite pour afficher le rapport</b></td>
                    <td class="LineVertico1PX"></td>
                    <td width="200" align="center" valign="middle" onmouseover="fnOnMouseOver(this)" onmouseout="fnOnMouseOut(this)" onclick="window.open('results_regions_ranking.aspx?eid=<% Response.Write(Request.QueryString("eid")) %>&cid=<% Response.Write(Request.QueryString("cid")) %>')">&nbsp;<b>SHOW THE REPORT</b><br />&nbsp;<b>AFFICHER LE RAPPORT</b></td>
                    <td class="LineVertico1PX"></td>
                <tr>
                    <td colspan="7" class="LineHorizo1PX"></td>
            </table>

            <br />

            <!-- ===== TABLEAU DE LANCEMENT DU RAPPORT  ===== -->
            <!-- ============================================ -->

            <% End If %>

            <% If sRaid = "4" Then %>
            <!-- ============================================ -->
            <!-- ===== TABLEAU DE LANCEMENT DU RAPPORT  ===== -->

            <table border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td colspan="7" class="LineHorizo1PX"></td>
                <tr>
                    <td height="30" class="LineVertico1PX"></td>
                    <td width="10" align="center" valign="middle" bgcolor="#c0c0c0"></td>
                    <td class="LineVertico1PX"></td>
                    <td width="558" align="left" valign="middle" bgcolor="#ffA0A0">&nbsp;<b>Click to the right to show the report</b><br />&nbsp;<b>Cliquez &agrave; droite pour afficher le rapport</b></td>
                    <td class="LineVertico1PX"></td>
                    <td width="200" align="center" valign="middle" onmouseover="fnOnMouseOver(this)" onmouseout="fnOnMouseOut(this)" onclick="window.open('results_teams_ranking.aspx?eid=<% Response.Write(Request.QueryString("eid")) %>&cid=<% Response.Write(Request.QueryString("cid")) %>&ttid=2')">&nbsp;<b>SHOW THE REPORT</b><br />&nbsp;<b>AFFICHER LE RAPPORT</b></td>
                    <td class="LineVertico1PX"></td>
                <tr>
                    <td colspan="7" class="LineHorizo1PX"></td>
            </table>

            <br />

            <!-- ===== TABLEAU DE LANCEMENT DU RAPPORT  ===== -->
            <!-- ============================================ -->

            <% End If %>

            <% If sRaid = "5" Then %>
            <!-- ============================================ -->
            <!-- ===== TABLEAU DE LANCEMENT DU RAPPORT  ===== -->

            <table border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td colspan="7" class="LineHorizo1PX"></td>
                <tr>
                    <td height="30" class="LineVertico1PX"></td>
                    <td width="10" align="center" valign="middle" bgcolor="#c0c0c0"></td>
                    <td class="LineVertico1PX"></td>
                    <td width="558" align="left" valign="middle" bgcolor="#ffA0A0">&nbsp;<b>Click to the right to show the report</b><br />&nbsp;<b>Cliquez &agrave; droite pour afficher le rapport</b></td>
                    <td class="LineVertico1PX"></td>
                    <td width="200" align="center" valign="middle" onmouseover="fnOnMouseOver(this)" onmouseout="fnOnMouseOut(this)" onclick="window.open('results_teams_ranking.aspx?eid=<% Response.Write(Request.QueryString("eid")) %>&cid=<% Response.Write(Request.QueryString("cid")) %>&ttid=1')">&nbsp;<b>SHOW THE REPORT</b><br />&nbsp;<b>AFFICHER LE RAPPORT</b></td>
                    <td class="LineVertico1PX"></td>
                <tr>
                    <td colspan="7" class="LineHorizo1PX"></td>
            </table>

            <br />

            <!-- ===== TABLEAU DE LANCEMENT DU RAPPORT  ===== -->
            <!-- ============================================ -->

            <% End If %>

            <% If sRaid = "6" Then %>
            <!-- ============================================ -->
            <!-- ===== TABLEAU DE LANCEMENT DU RAPPORT  ===== -->

            <table border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td colspan="7" class="LineHorizo1PX"></td>
                <tr>
                    <td height="30" class="LineVertico1PX"></td>
                    <td width="10" align="center" valign="middle" bgcolor="#c0c0c0"></td>
                    <td class="LineVertico1PX"></td>
                    <td width="558" align="left" valign="middle" bgcolor="#ffA0A0">&nbsp;<b>Click to the right to show the report</b><br />&nbsp;<b>Cliquez &agrave; droite pour afficher le rapport</b></td>
                    <td class="LineVertico1PX"></td>
                    <td width="200" align="center" valign="middle" onmouseover="fnOnMouseOver(this)" onmouseout="fnOnMouseOut(this)" onclick="window.open('results_competitors_ranking.aspx?eid=<% Response.Write(Request.QueryString("eid")) %>&cid=<% Response.Write(Request.QueryString("cid")) %>')">&nbsp;<b>SHOW THE REPORT</b><br />&nbsp;<b>AFFICHER LE RAPPORT</b></td>
                    <td class="LineVertico1PX"></td>
                <tr>
                    <td colspan="7" class="LineHorizo1PX"></td>
            </table>

            <br />

            <!-- ===== TABLEAU DE LANCEMENT DU RAPPORT  ===== -->
            <!-- ============================================ -->

            <% End If %>

            <% If sRaid = "7" Then %>
            <!-- ============================================ -->
            <!-- ===== TABLEAU DE LANCEMENT DU RAPPORT  ===== -->

            <table border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td colspan="7" class="LineHorizo1PX"></td>
                <tr>
                    <td height="30" class="LineVertico1PX"></td>
                    <td width="10" align="center" valign="middle" bgcolor="#c0c0c0"></td>
                    <td class="LineVertico1PX"></td>
                    <td width="558" align="left" valign="middle" bgcolor="#ffA0A0">&nbsp;<b>Click to the right to show the report</b><br />&nbsp;<b>Cliquez &agrave; droite pour afficher le rapport</b></td>
                    <td class="LineVertico1PX"></td>
                    <td width="200" align="center" valign="middle" onmouseover="fnOnMouseOver(this)" onmouseout="fnOnMouseOut(this)" onclick="window.open('results_master.aspx?eid=<% Response.Write(Request.QueryString("eid")) %>&cid=<% Response.Write(Request.QueryString("cid")) %>')">&nbsp;<b>SHOW THE REPORT</b><br />&nbsp;<b>AFFICHER LE RAPPORT</b></td>
                    <td class="LineVertico1PX"></td>
                <tr>
                    <td colspan="7" class="LineHorizo1PX"></td>
            </table>

            <br />

            <!-- ===== TABLEAU DE LANCEMENT DU RAPPORT  ===== -->
            <!-- ============================================ -->

            <% End If %>

            <% If sRaid = "8" Then %>
            <!-- ============================================ -->
            <!-- ===== TABLEAU DE LANCEMENT DU RAPPORT  ===== -->

            <table border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td colspan="7" class="LineHorizo1PX"></td>
                <tr>
                    <td height="30" class="LineVertico1PX"></td>
                    <td width="10" align="center" valign="middle" bgcolor="#c0c0c0"></td>
                    <td class="LineVertico1PX"></td>
                    <td width="558" align="left" valign="middle" bgcolor="#ffA0A0">&nbsp;<b>Click to the right to show the report</b><br />&nbsp;<b>Cliquez &agrave; droite pour afficher le rapport</b></td>
                    <td class="LineVertico1PX"></td>
                    <td width="200" align="center" valign="middle" onmouseover="fnOnMouseOver(this)" onmouseout="fnOnMouseOut(this)" onclick="window.open('results_final.aspx?eid=<% Response.Write(Request.QueryString("eid")) %>&cid=<% Response.Write(Request.QueryString("cid")) %>')">&nbsp;<b>SHOW THE REPORT</b><br />&nbsp;<b>AFFICHER LE RAPPORT</b></td>
                    <td class="LineVertico1PX"></td>
                <tr>
                    <td colspan="7" class="LineHorizo1PX"></td>
            </table>

            <br />

            <!-- ===== TABLEAU DE LANCEMENT DU RAPPORT  ===== -->
            <!-- ============================================ -->

            <% End If %>


        <!-- ===== CONTENU DE LA PAGE RESULTS_CONSULT ===== -->
        <!-- ============================================== -->
        </td>
</table>

<!--#include file="inc_bottom.aspx"-->
