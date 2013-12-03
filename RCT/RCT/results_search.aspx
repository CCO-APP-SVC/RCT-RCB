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

            <!-- ==================================================================== -->
            <!-- ===== TABLEAU DE SÉLECTION DE L'ÉVÉNEMENT ET DE LA COMPÉTITION ===== -->

            <% 
                
                Dim sSql As String
                    If Session("userEventRestricted") <> 0 Then
                        sSql = "Select * From vwEventsEventsTypes Where eventId = " & Session("userEventRestricted") & " Order By eventNameFr"
                    Else
                        sSql = "Select * From vwEventsEventsTypes Order By eventNameFr"
                    End If

                Dim sqlDtSet As System.Data.DataSet = fnGetDataSetInDB(sSql, "Events")

                Dim sEid, sCid, sMsg, sTs As String
                Dim sColorEid, sColorCid As String
                Dim sSelected As String
                Dim i As Integer

                sEid = Request.QueryString("eid")
                sCid = Request.QueryString("cid")
                sMsg = Request.QueryString("msg")
                sTs = Request.Form("txtResultTargetSerial")
                
                If String.IsNullOrEmpty(sEid) Then
                    sEid = "0"
                End If
                If String.IsNullOrEmpty(sCid) Then
                    sCid = "0"
                End If
                If String.IsNullOrEmpty(sMsg) Then
                    sMsg = "0"
                End If
                If String.IsNullOrEmpty(sTs) Then
                    sTs = Request.QueryString("sts")
                End If
                If String.IsNullOrEmpty(sTs) Then
                    sTs = "0"
                End If


                If sEid = "0" Then
                    sColorEid = "#ffA0A0"
                Else
                    sColorEid = "#c0c0c0"
                End If

                if sCid = "0" Then
                    sColorCid = "#ffA0A0"
                Else
                    sColorCid = "#c0c0c0"
                End If


            %>
            <table border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td colspan="7" class="LineHorizo1PX"></td>
                <tr>
                    <td height="30" class="LineVertico1PX"></td>
                    <td width="10" align="center" valign="middle" bgcolor="#c0c0c0"></td>
                    <td class="LineVertico1PX"></td>
                    <td width="759" align="left" valign="middle" bgcolor="#c0c0c0">&nbsp;<b>Search entry</b><br />&nbsp;<b>Recherhe d'un r&eacute;sultat</b></td>
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
                        <select name="sEvents" id="sEvents" style="width: 365px" class="FormTextBox" onchange="fnResultsSearchEventSelect(this.value);">
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
                            <option value="<% Response.Write(sqlDtSet.Tables("Events").Rows(i)("eventId")) %>" <% Response.Write(sSelected) %>><% Response.Write(sqlDtSet.Tables("Events").Rows(i)("eventNameFr")) %></option>
                        <% Next %>
                        </select>
                    </td>
                    <td class="LineVertico1PX"></td>
                <tr>
                    <td colspan="7" class="LineHorizo1PX"></td>
            </table>
            <br />
            
            <% If sEid <> "0" Then%>

            <%
                sSql = "Select * From tblCompetitionsChapters Join tblCompetitions On tblCompetitionsChapters.fkCompetitionId=tblCompetitions.competitionId Where fkEventId = " & sEid
                sqlDtSet.Tables.Add("Competitions").Merge(fnGetDataTableInDB(sSql))
               
            %>
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
                        <select name="sCompetitions" id="sCompetitions" style="width: 365px" class="FormTextBox" onchange="fnResultsSearchCompetitionSelect(this.value,<% Response.Write(sEid) %>)">
                            <option value="0">Select a competition - S&eacute;lectionnez une comp&eacute;tition</option>
                            <option disabled>--------------------</option>
                            <% 
                                For i = 0 To sqlDtSet.Tables("Competitions").Rows.Count - 1
                                    If sCid = sqlDtSet.Tables("Competitions").Rows(i)("competitionChapterId").ToString() Then
                                        sSelected = "selected='selected'"
                                    Else
                                        sSelected = ""
                                    End If
                            %>
                            <option value="<% Response.Write(sqlDtSet.Tables("Competitions").Rows(i)("competitionChapterId")) %>" <% Response.Write(sSelected) %>><% Response.Write(sqlDtSet.Tables("Competitions").Rows(i)("competitionNameFr")) %> - <% Response.Write(sqlDtSet.Tables("Competitions").Rows(i)("competitionChapterNameFr")) %></option>
                            <% Next%>
                        </select>
                    </td>
                    <td class="LineVertico1PX"></td>
                <tr>
                    <td colspan="7" class="LineHorizo1PX"></td>
            </table>

            <% End If %>

            <!-- ===== TABLEAU DE SÉLECTION DE L'ÉVÉNEMENT ET DE LA COMPÉTITION ===== -->
            <!-- ==================================================================== -->

            <br />

            <!-- =========================================== -->
            <!-- ===== TABLEAU DE SAISIE DES RÉSULTATS ===== -->

            <% If sCid <> 0 Then %>

            
            <form name="frmResultSearch" id="frmResultSearch" method="post" action="results_search.aspx?eid=<% Response.Write(sEid) %>&cid=<% Response.Write(sCid) %>">

            <table border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td colspan="5" class="LineHorizo1PX"></td>
                <tr>
                    <td height="30" class="LineVertico1PX"></td>
                    <td width="10" align="center" valign="middle" bgcolor="#c0c0c0"></td>
                    <td class="LineVertico1PX"></td>
                    <td width="759" align="left" valign="middle" bgcolor="#ffA0A0">&nbsp;<b>Target search</b><br />&nbsp;<b>Recherche d'une cible</b></td>
                    <td class="LineVertico1PX"></td>
                <tr>
                    <td colspan="5" class="LineHorizo1PX"></td>
            </table>

            <table border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td colspan="7" class="LineHorizo1PX"></td>
                <tr>
                    <td class="LineVertico1PX" height="14"></td>
                    <td width="335" class="FormTableTitle" align="left" valign="middle">&nbsp;Target number - Num&eacute;ro de cible</td>
                    <td class="LineVertico1PX"></td>
                    <td width="335" class="FormTableTitle" align="left" valign="middle"></td>
                    <td class="LineVertico1PX"></td>
                    <td width="98" rowspan="2" align="center" valign="middle">
                        <img name="bSave" id="bSave" width="35" height="35" src="pics/search.jpg" title="Search" onmouseover="this.style.cursor='pointer';" onclick="fnResultSearch();" />
                    </td>
                    <td class="LineVertico1PX"></td>
                <tr>
                    <td class="LineVertico1PX" height="45"></td>
                    <td align="center" valign="middle"><input type="text" name="txtResultTargetSerial" id="txtResultTargetSerial" autocomplete="off" maxlength="5" autofocus="autofocus" onfocus="this.select();" onkeyup="" class="FormTextBoxResultsAdd" style="text-align: center; width: 180px;" value="<% Response.Write(sTs) %>" /></td>
                    <td class="LineVertico1PX"></td>
                    <td align="center" valign="middle"></td>
                    <td class="LineVertico1PX"></td>
                    <td class="LineVertico1PX"></td>
                <tr>
                    <td colspan="7" class="LineHorizo1PX"></td>
            </table>
            </form>
            <% End If %>
            <!-- ===== TABLEAU DE SAISIE DES RÉSULTATS ===== -->
            <!-- =========================================== -->

            <br />

            <!-- ============================================================= -->
            <!-- ===== AFFICHAGE DES RÉSULTATS SAISIS POUR LA COMPÉTITION===== -->

            <% If sCid <> 0 And sTs <> 0 Then %>
            <table border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td colspan="5" class="LineHorizo1PX"></td>
                <tr>
                    <td height="30" class="LineVertico1PX"></td>
                    <td width="10" align="center" valign="middle" bgcolor="#c0c0c0"></td>
                    <td class="LineVertico1PX"></td>
                    <td width="759" align="left" valign="middle" bgcolor="#c0c0c0">&nbsp;<b>Display of results seized</b><br />&nbsp;<b>Affichage des r&eacute;sultats saisis</b></td>
                    <td class="LineVertico1PX"></td>
                <tr>
                    <td colspan="5" class="LineHorizo1PX"></td>
            </table>

            <% 
                sSql = "Select * From vwResultsUsersPageResultsAdd Where fkCompetitionChapterId = " & sCid & " AND resultTargetSerial = " & sTs
                sqlDtSet = fnGetDataSetInDB(sSql, "Results")
            %>
            <table border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td colspan="13" class="LineHorizo1PX"></td>
                <tr>
                    <td height="30" class="LineVertico1PX"></td>
                    <td width="10" bgcolor="#c0c0c0"></td>
                    <td class="LineVertico1PX"></td>
                    <td width="100" align="center" valign="middle" bgcolor="#c0c0c0"><b>Target</b><br /><b>Cible</b></td>
                    <td class="LineVertico1PX"></td>
                    <td width="100" align="center" valign="middle" bgcolor="#c0c0c0"><b>Result</b><br /><b>R&eacute;sultat</b></td>
                    <td class="LineVertico1PX"></td>
                    <td width="200" align="center" valign="middle" bgcolor="#c0c0c0"><b>Entry Date</b><br /><b>Date Saisie</b></td>
                    <td class="LineVertico1PX"></td>
                    <td width="200" align="center" valign="middle" bgcolor="#c0c0c0"><b>User</b><br /><b>Usager</b></td>
                    <td class="LineVertico1PX"></td>
                    <td width="155" align="center" valign="middle" bgcolor="#c0c0c0"></td>
                    <td class="LineVertico1PX"></td>
                <tr>
                    <td colspan="13" class="LineHorizo1PX"></td>
                <% For i = 0 To sqlDtSet.Tables("Results").Rows.Count - 1 %>
                <tr onmouseover="fnOnMouseOver(this);" onmouseout="fnOnMouseOut(this);" onclick="fnOnClick('result_edit.aspx?eid=<% Response.Write(sEid) %>&cid=<% Response.Write(sCid) %>&tid=<% Response.Write(sqlDtSet.Tables("Results").Rows(i)("resultId")) %>')">
                    <td height="25" class="LineVertico1PX"></td>
                    <td bgcolor="#c0c0c0"></td>
                    <td class="LineVertico1PX"></td>
                    <td align="center" valign="middle"><% Response.Write(sqlDtSet.Tables("Results").Rows(i)("resultTargetSerial")) %></td>
                    <td class="LineVertico1PX"></td>
                    <td align="center" valign="middle"><% Response.Write(sqlDtSet.Tables("Results").Rows(i)("result")) %></td>
                    <td class="LineVertico1PX"></td>
                    <td align="center" valign="middle"><% Response.Write(sqlDtSet.Tables("Results").Rows(i)("DateInsert")) %></td>
                    <td class="LineVertico1PX"></td>
                    <td align="left" valign="middle">&nbsp;<% Response.Write(sqlDtSet.Tables("Results").Rows(i)("userLogin")) %></td>
                    <td class="LineVertico1PX"></td>
                    <td align="center" valign="middle"></td>
                    <td class="LineVertico1PX"></td>
                <tr>
                    <td colspan="13" class="LineHorizo1PX"></td>

                <% Next %>
            </table>
            <br />

            <% End If %>
            <!-- ===== AFFICHAGE DES RÉSULTATS SAISIS POUR LA COMPÉTITION===== -->
            <!-- ============================================================= -->

        </td>
</table>

<!--#include file="inc_bottom.aspx"-->