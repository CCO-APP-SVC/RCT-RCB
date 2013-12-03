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

                Dim sEid, sCid, sMsg, sTs, sRs As String
                Dim sColorEid, sColorCid As String
                Dim sSelected, sMessage As String
                Dim i As Integer

                sEid = Request.QueryString("eid")
                sCid = Request.QueryString("cid")
                sMsg = Request.QueryString("msg")
                sTs = Request.QueryString("ts")
                sRs = Request.QueryString("rs")
                
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
                    sTs = ""
                End If
                If String.IsNullOrEmpty(sRs) Then
                    sRs = ""
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

                sMessage = ""
                If sMsg = "1" Then
                    sMessage = "Successfully saved." & vbCrLf & "Enregistrement r&eacute;ussi."
                End If


            %>
            <table border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td colspan="7" class="LineHorizo1PX"></td>
                <tr>
                    <td height="30" class="LineVertico1PX"></td>
                    <td width="10" align="center" valign="middle" bgcolor="#c0c0c0"></td>
                    <td class="LineVertico1PX"></td>
                    <td width="759" align="left" valign="middle" bgcolor="#c0c0c0">&nbsp;<b>Import results from a CSV file</b><br />&nbsp;<b>Importer des r&eacute;sultats depuis un fichier CSV</b></td>
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
                        <select name="sEvents" id="sEvents" style="width: 365px" class="FormTextBox" onchange="fnResultsImportEventSelect(this.value);">
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
                        <select name="sCompetitions" id="sCompetitions" style="width: 365px" class="FormTextBox" onchange="fnResultsImportCompetitionSelect(this.value,<% Response.Write(sEid) %>)">
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

            <form name="frmResultsImport" id="frmResultsImport" method="post" action="functions.aspx?fn=ResultsImport">
            <input type="hidden" name="hEid" id="hEid" value="<% Response.Write(sEid) %>" />
            <input type="hidden" name="hCid" id="hCid" value="<% Response.Write(sCid) %>" />

            <table border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td colspan="5" class="LineHorizo1PX"></td>
                <tr>
                    <td height="30" class="LineVertico1PX"></td>
                    <td width="10" align="center" valign="middle" bgcolor="#c0c0c0"></td>
                    <td class="LineVertico1PX"></td>
                    <td width="759" align="left" valign="middle" bgcolor="#ffA0A0">&nbsp;<b>Results import</b><br />&nbsp;<b>Importer des r&eacute;sulats</b></td>
                    <td class="LineVertico1PX"></td>
                <tr>
                    <td colspan="5" class="LineHorizo1PX"></td>
            </table>

            <table border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td height="50" class="LineVertico1PX"></td>
                    <td style="font-weight:bold; font-size: large; text-align:center; vertical-align:middle;">1</td>
                    <td class="LineVertico1PX"></td>
                    <td colspan="3" style="text-align:center; vertical-align:middle;">
                        <input type="file" name="fCSV" id="fCSV" size="97" title="Select CSV File / Choisir le fichier CSV" />
                    </td>
                    <td class="LineVertico1PX"></td>
                <tr>
                    <td colspan="7" class="LineHorizo1PX"></td>
                <tr>
                    <td height="50" class="LineVertico1PX"></td>
                    <td width="50" style="font-weight:bold; font-size: large; text-align:center; vertical-align:middle;">2</td>
                    <td class="LineVertico1PX"></td>
                    <td width="518" class="TXTNormal">&nbsp;Press the button to load the CSV in the textbox below.<br />&nbsp;Appuyez sur le bouton pour charger le fichier CSV dans la boite ci-dessous.</td>
                    <td class="LineVertico1PX"></td>
                    <td width="200" style="text-align:center; vertical-align:middle;"><input type="button" name="cmdLoad" id="cmdLoad" onclick="fnLoadFileInTextArea(document.getElementById('fCSV'))" title="Load / Charger" value="Load / charger" style="width: 180px" /></td>
                    <td class="LineVertico1PX"></td>
                <tr>
                    <td colspan="7" class="LineHorizo1PX"></td>
                <tr>
                    <td height="300" class="LineVertico1PX"></td>
                    <td style="font-weight:bold; font-size: large; text-align:center; vertical-align:middle;">3</td>
                    <td class="LineVertico1PX"></td>
                    <td colspan="3" style="text-align:center; vertical-align:middle;">
                        <textarea readonly="readonly" rows="20" style="width: 700px; resize: none;" name="txtCSV" id="txtCSV" class="FormTextBox"><% Response.Write(sMessage) %></textarea>
                    </td>
                    <td class="LineVertico1PX"></td>
                <tr>
                    <td colspan="7" class="LineHorizo1PX"></td>
                <tr>
                    <td height="50" class="LineVertico1PX"></td>
                    <td style="font-weight:bold; font-size: large; text-align:center; vertical-align:middle;">4</td>
                    <td class="LineVertico1PX"></td>
                    <td class="TXTNormal">&nbsp;Press the button to save data in the database.<br />&nbsp;Appuyez sur le bouton pour enregistrer les donn&eacute;es dans la base de donn&eacute;es.</td>
                    <td class="LineVertico1PX"></td>
                    <td style="text-align:center; vertical-align:middle;"><input type="button" name="cmdSubmit" id="cmdSubmit" onclick="fnValidCSVBeforeSend()" title="Save / Enregistrer" value="Save / Enregistrer" style="width: 180px" /></td>
                    <td class="LineVertico1PX"></td>
                <tr>
                    <td colspan="7" class="LineHorizo1PX"></td>

            </table>


            </form>
            <% End If %>
            <!-- ===== TABLEAU DE SAISIE DES RÉSULTATS ===== -->
            <!-- =========================================== -->



            <br />

        

        </td>
</table>

<!--#include file="inc_bottom.aspx"-->
