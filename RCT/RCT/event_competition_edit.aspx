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
                        <a href="event_profile.aspx?eid=<% Response.Write(Request.QueryString("eid")) %>"><img src="pics/undo.png" width="25" height="25" title="Undo" border="0" /></a>
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
        <!-- =============================================== -->
        <!-- ===== TABLEAU D'ÉDITION D'UNE COMPÉTITION ===== -->

        <%
            sSql = "Select * From tblCompetitions Where competitionId =" & Request.QueryString("cid")
            sqlDtSet.Tables.Add("Competitions").Merge(fnGetDataTableInDB(sSql))
        %>
        <form name="frmModComp" id="frmModComp" method="post" action="functions.aspx?fn=EventCompetitionEdit">
        <input type="hidden" name="hEid" id="hEid" value="<% Response.Write(Request.QueryString("eid")) %>" />
        <input type="hidden" name="hCid" id="hCid" value="<% Response.Write(Request.QueryString("cid")) %>" />

            <table border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td colspan="7" class="LineHorizo1PX"></td>
                <tr>
                    <td height="30" class="LineVertico1PX"></td>
                    <td width="10" align="center" valign="middle" bgcolor="#c0c0c0"></td>
                    <td class="LineVertico1PX"></td>
                    <td width="653" align="left" valign="middle" bgcolor="#c0c0c0">&nbsp;<b>Édition d'une compétition</b></td>
                    <td class="LineVertico1PX"></td>
                    <td width="105" align="center" valign="middle">
                        <a href="event_profile.aspx?eid=<% Response.Write(Request.QueryString("eid")) %>"><img src="pics/undo.png" width="25" height="25" title="Undo" border="0" /></a>&nbsp;
                        <% If Session("userRule") = 1 Or Session("userRule") = 2 Then%>    
                        <input type="image" name="bSave" id="bSave" width="25" height="25" src="pics/save.png" title="Save" />&nbsp;
                        <img src="pics/delete.png" width="25" height="25" title="Delete" onmouseover="this.style.cursor='pointer';" onclick="fnConfirmEventCompetitionDel(<% Response.Write(Request.QueryString("eid")) %>, <% Response.Write(Request.QueryString("cid")) %>)" />
                        <% End If%>
                    </td>
                    <td class="LineVertico1PX"></td>
                <tr>
                    <td colspan="7" class="LineHorizo1PX"></td>
            </table>

        <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td colspan="3" class="LineHorizo1PX"></td>
        <tr>
            <td class="LineVertico1PX"></td>
            <td width="770" height="14" class="FormTableTitle">&nbsp;Nom de la comp&eacute;tition en FRANÇAIS</td>
            <td class="LineVertico1PX"></td>
        <tr>
            <td class="LineVertico1PX"></td>
            <td height="25" align="left" valign="middle">&nbsp;<input type="text" name="txtCompNameFr" id="txtCompNameFr" autocomplete="off" style="width : 760px;" class="FormTextBox" value="<% Response.Write(sqlDtSet.Tables("Competitions").Rows(0)("competitionNameFr")) %>" /></td>
            <td class="LineVertico1PX"></td>
        <tr>
            <td colspan="5" class="LineHorizo1PX"></td>
        <tr>
            <td class="LineHorizo1PX"></td>
            <td height="14" class="FormTableTitle">&nbsp;Nom de la comp&eacute;tition en Anglais</td>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td class="LineHorizo1PX"></td>
            <td height="25" align="left" valign="middle">&nbsp;<input type="text" name="txtCompNameEn" id="txtCompNameEn" autocomplete="off" style="width : 760px;" class="FormTextBox" value="<% Response.Write(sqlDtSet.Tables("Competitions").Rows(0)("competitionNameEn")) %>" /></td>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td colspan="5" class="LineHorizo1PX"></td>

        </table>
        </form>

        <!-- ===== TABLEAU D'ÉDITION D'UNE COMPÉTITION ===== -->
        <!-- =============================================== -->

        <br />

        <!-- =============================================================== -->
        <!-- ===== TABLEAU D'AFFICHAGE DES CHAPITRES DE LA COMPÉTITION ===== -->

        <table border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td colspan="7" class="LineHorizo1PX"></td>
            <tr>
                <td height="30" class="LineVertico1PX"></td>
                <td width="10" align="center" valign="middle" bgcolor="#c0c0c0"></td>
                <td class="LineVertico1PX"></td>
                <td width="673" align="left" valign="middle" bgcolor="#c0c0c0">&nbsp;<b>Chapitres pour : <% Response.Write(sqlDtSet.Tables("Competitions").Rows(0)("competitionNameFr")) %></b></td>
                <td class="LineVertico1PX"></td>
                <td width="85" align="center" valign="middle"></td>
                <td class="LineVertico1PX"></td>
            <tr>
                <td colspan="7" class="LineHorizo1PX"></td>
        </table>
        <table border="0" cellpadding="0" cellspacing="0" id="tblCompetitions" name="tblCompetitions">
            <tr>
                <td colspan="13" class="LineHorizo1PX"></td>
            <tr>
                <td height="20" class="LineVertico1PX"></td>
                <td width="10" bgcolor="#c0c0c0"></td>
                <td class="LineVertico1PX"></td>
                <td width="151" align="center" valign="middle" bgcolor="#c0c0c0">&nbsp;<b>Nom en français</b></td>
                <td class="LineVertico1PX"></td>
                <td width="151" align="center" valign="middle" bgcolor="#c0c0c0">&nbsp;<b>Nom en anglais</b></td>
                <td class="LineVertico1PX"></td>
                <td width="151" align="center" valign="middle" bgcolor="#c0c0c0"><b>Type</b></td>
                <td class="LineVertico1PX"></td>
                <td width="151" align="center" valign="middle" bgcolor="#c0c0c0"><b>Valeur(%)</b></td>
                <td class="LineVertico1PX"></td>
                <td width="151" align="center" valign="middle" bgcolor="#c0c0c0"><b>Targets</b></td>
                <td class="LineVertico1PX"></td>
            <tr>
                <td colspan="13" class="LineHorizo1PX"></td>
            <%
                sSql = "Select * From tblCompetitionsChapters Join tblCompetitionsTypes On tblCompetitionsChapters.fkCompetitionTypeId=tblCompetitionsTypes.competitionTypeId Where fkCompetitionId = " & Request.QueryString("cid") & " Order By competitionChapterNameFr"
                sqlDtSet.Tables.Add("Chapters").Merge(fnGetDataTableInDB(sSql))

                Dim i As Integer
                For i = 0 To sqlDtSet.Tables("Chapters").Rows.Count - 1
            %>

            <tr onmouseover="fnOnMouseOver(this);" onmouseout="fnOnMouseOut(this);" onclick="fnOnClick('event_competition_chapter_edit.aspx?eid=<% Response.Write(Request.QueryString("eid")) %>&cid=<% Response.Write(Request.QueryString("cid")) %>&chid=<% Response.Write(sqlDtSet.Tables("Chapters").Rows(i)("competitionChapterId")) %>')">
                <td height="25" class="LineVertico1PX"></td>
                <td bgcolor="#c0c0c0"></td>
                <td class="LineVertico1PX"></td>
                <td align="left" valign="middle">&nbsp;<% Response.Write(sqlDtSet.Tables("Chapters").Rows(i)("competitionChapterNameFr"))%></td>
                <td class="LineVertico1PX"></td>
                <td align="left" valign="middle">&nbsp;<% Response.Write(sqlDtSet.Tables("Chapters").Rows(i)("competitionChapterNameEn"))%></td>
                <td class="LineVertico1PX"></td>
                <td align="center" valign="middle"><% Response.Write(sqlDtSet.Tables("Chapters").Rows(i)("competitionTypeNameFr"))%> / <% Response.Write(sqlDtSet.Tables("Chapters").Rows(i)("competitionTypeNameEn"))%></td>
                <td class="LineVertico1PX"></td>
                <td align="center" valign="middle"><% Response.Write(sqlDtSet.Tables("Chapters").Rows(i)("competitionChapterValue") * 100)%> %</td>
                <td class="LineVertico1PX"></td>
                <td align="center" valign="middle"><% Response.Write(sqlDtSet.Tables("Chapters").Rows(i)("competitionChapterNbrTargets"))%></td>
                <td class="LineVertico1PX"></td>
            <tr>
                <td colspan="13" class="LineHorizo1PX"></td>
            <% Next %>

            </table>
        
        <!-- ===== TABLEAU D'AFFICHAGE DES CHAPITRES DE LA COMPÉTITION ===== -->
        <!-- =============================================================== -->

        </td>
</table>
<!--#include file="inc_bottom.aspx"-->
