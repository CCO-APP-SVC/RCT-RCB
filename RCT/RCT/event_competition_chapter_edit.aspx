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
                        <a href="event_competition_edit.aspx?eid=<% Response.Write(Request.QueryString("eid")) %>&cid=<% Response.Write(Request.QueryString("cid")) %>"><img src="pics/undo.png" width="25" height="25" title="Undo" border="0" /></a>
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
        <!-- ===== TABLEAU DE CONSULTATION D'UN ÉVÉNEMENT ===== -->
        <!-- ================================================== -->
            <br />
        <!-- =========================================== -->
        <!-- ===== TABLEAU D'ÉDITION D'UN CHAPITRE ===== -->

        <%
            sSql = "Select * From tblCompetitionsChapters Where competitionChapterId =" & Request.QueryString("chid")
            sqlDtSet.Tables.Add("Chapter").Merge(fnGetDataTableInDB(sSql))
            
            sSql = "Select * From tblCompetitionsTypes"
            sqlDtSet.Tables.Add("CompetitionsTypes").Merge(fnGetDataTableInDB(sSql))
            
            Dim i As Integer
            Dim sSelected As String
        %>
        <form name="frmModChapter" id="frmModChapter" method="post" action="functions.aspx?fn=EventCompetitionChapterEdit">
        <input type="hidden" name="hEid" id="hEid" value="<% Response.Write(Request.QueryString("eid")) %>" />
        <input type="hidden" name="hCid" id="hCid" value="<% Response.Write(Request.QueryString("cid")) %>" />
        <input type="hidden" name="hCHid" id="hCHid" value="<% Response.Write(Request.QueryString("chid")) %>" />

            <table border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td colspan="7" class="LineHorizo1PX"></td>
                <tr>
                    <td height="30" class="LineVertico1PX"></td>
                    <td width="10" align="center" valign="middle" bgcolor="#c0c0c0"></td>
                    <td class="LineVertico1PX"></td>
                    <td width="653" align="left" valign="middle" bgcolor="#c0c0c0">&nbsp;<b>Edit Chapter</b><br />&nbsp;<b>&Eacute;dition d'un chapitre</b></td>
                    <td class="LineVertico1PX"></td>
                    <td width="105" align="center" valign="middle">
                        <a href="event_competition_edit.aspx?eid=<% Response.Write(Request.QueryString("eid")) %>&cid=<% Response.Write(Request.QueryString("cid")) %>"><img src="pics/undo.png" width="25" height="25" title="Undo" border="0" /></a>&nbsp;
                        <% If Session("userRule") = 1 Or Session("userRule") = 2 Then%>    
                        <input type="image" name="bSave" id="bSave" width="25" height="25" src="pics/save.png" title="Save" />&nbsp;
                        <% End If%>
                    </td>
                    <td class="LineVertico1PX"></td>
                <tr>
                    <td colspan="7" class="LineHorizo1PX"></td>
            </table>

            <table border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td class="LineVertico1PX" height="14"></td>
                    <td width="770" class="FormTableTitle" align="left" valign="middle">&nbsp;English Chapter Name / Nom du Chapitre en Anglais</td>
                    <td class="LineVertico1PX"></td>
                <tr>
                    <td class="LineVertico1PX" height="30"></td>
                    <td align="center" valign="middle"><input type="text" name="txtCompetitionChapterNameEn" id="txtCompetitionChapterNameEn" autocomplete="off" style="width: 760px" class="FormTextBox" value="<% Response.Write(sqlDtSet.Tables("Chapter").Rows(0)("competitionChapterNameEn")) %>" /></td>
                    <td class="LineVertico1PX"></td>
                <tr>
                    <td colspan="5" class="LineHorizo1PX"></td>
            </table>

            <table border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td class="LineVertico1PX" height="14"></td>
                    <td width="770" class="FormTableTitle" align="left" valign="middle">&nbsp;French Chapter Name / Nom du Chapitre en Français</td>
                    <td class="LineVertico1PX"></td>
                <tr>
                    <td class="LineVertico1PX" height="30"></td>
                    <td align="center" valign="middle"><input type="text" name="txtCompetitionChapterNameFr" id="txtCompetitionChapterNameFr" autocomplete="off" style="width: 760px" class="FormTextBox" value="<% Response.Write(sqlDtSet.Tables("Chapter").Rows(0)("competitionChapterNameFr")) %>" /></td>
                    <td class="LineVertico1PX"></td>
                <tr>
                    <td colspan="3" class="LineHorizo1PX"></td>
            </table>

            <table border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td class="LineVertico1PX" height="14"></td>
                    <td width="256" class="FormTableTitle" align="left" valign="middle">&nbsp;Chapter Type / Type du Chapitre</td>
                    <td class="LineVertico1PX"></td>
                    <td width="256" class="FormTableTitle" align="left" valign="middle">&nbsp;Chapter Value / Valeur du Chapitre</td>
                    <td class="LineVertico1PX"></td>
                    <td width="256" class="FormTableTitle" align="left" valign="middle">&nbsp;Chapter Value / Valeur du Chapitre</td>
                    <td class="LineVertico1PX"></td>
                <tr>
                    <td class="LineVertico1PX" height="30"></td>
                    <td align="center" valign="middle">
                    <select name="sCompetitionType" id="sCompetitionType" style="width: 240px" class="FormTextBox">
                    <%
                        For i = 0 To sqlDtSet.Tables("CompetitionsTypes").Rows.Count - 1
                        
                            If sqlDtSet.Tables("CompetitionsTypes").Rows(i)("competitionTypeId") = sqlDtSet.Tables("Chapter").Rows(0)("fkCompetitionTypeId") Then
                                sSelected = "selected='selected' "
                            Else
                                sSelected = ""
                            End If
                    %>
                        <option <% Response.Write(sSelected) %>value="<% Response.Write(sqlDtSet.Tables("CompetitionsTypes").Rows(i)("competitionTypeId")) %>"><% Response.Write(sqlDtSet.Tables("CompetitionsTypes").Rows(i)("competitionTypeNameFr")) %></option>
                            
                    <% Next%>
                    </select>
                    </td>
                    <td class="LineVertico1PX"></td>
                    <td align="center" valign="middle"><input type="text" name="txtCompetitionChapterValue" id="txtCompetitionChapterValue" autocomplete="off" style="width: 240px" class="FormTextBox" value="<% Response.Write(sqlDtSet.Tables("Chapter").Rows(0)("competitionChapterValue")) %>" /></td>
                    <td class="LineVertico1PX"></td>
                    <td align="center" valign="middle"><input type="text" name="txtCompetitionChapterNbrTargets" id="txtCompetitionChapterNbrTargets" autocomplete="off" style="width: 240px" class="FormTextBox" value="<% Response.Write(sqlDtSet.Tables("Chapter").Rows(0)("competitionChapterNbrTargets")) %>" /></td>
                    <td class="LineVertico1PX"></td>
                <tr>
                    <td colspan="7" class="LineHorizo1PX"></td>
            </table>


        </form>

        <!-- ===== TABLEAU D'ÉDITION D'UN CHAPITRE ===== -->
        <!-- =========================================== -->

        <br />

       






        </td>
</table>
<!--#include file="inc_bottom.aspx"-->
