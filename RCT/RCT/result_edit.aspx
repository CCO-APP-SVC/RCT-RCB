<%@ Page Language="VB" AutoEventWireup="false" CodeFile="functions.aspx.vb" Inherits="functions" %>
<%

    Dim sStr As String = "Select * From vwResultsUsersPageResultsAdd Where resultId = " & Request.QueryString("tid")
    Dim sqlDtSet As System.Data.DataSet = fnGetDataSetInDB(sStr, "Result")
   
%>


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



        <!-- ================================================= -->
        <!-- ===== TABLEAU DE MODIFICATION D'UN RÉSULTAT ===== -->
        <form name="frmEditResult" id="frmEditResult" method="post" action="functions.aspx?fn=ResultEdit">
            <input type="hidden" name="hEid" title="hEid" value="<% Response.Write(Request.QueryString("eid")) %>" />
            <input type="hidden" name="hCid" title="hCid" value="<% Response.Write(Request.QueryString("cid")) %>" />
            <input type="hidden" name="hTid" title="hTid" value="<% Response.Write(Request.QueryString("tid")) %>" />
            <input type="hidden" name="hTs" title="hTs" value="<% Response.Write(sqlDtSet.Tables("Result").Rows(0)("resultTargetSerial")) %>" />

            <table border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td colspan="7" class="LineHorizo1PX"></td>
                <tr>
                    <td height="30" class="LineVertico1PX"></td>
                    <td width="10" align="center" valign="middle" bgcolor="#c0c0c0"></td>
                    <td class="LineVertico1PX"></td>
                    <td width="473" align="left" valign="middle" bgcolor="#c0c0c0">&nbsp;<b>Edit a target</b><br />&nbsp;<b>Modifier un r&eacute;sultat</b></td>
                    <td class="LineVertico1PX"></td>
                    <td width="85" align="center" valign="middle">
                        <a href="events.aspx"><img src="pics/undo.png" width="25" height="25" title="Undo" border="0" /></a>&nbsp;
                        <input type="image" name="bSave" id="bSave" width="25" height="25" src="pics/save.png" title="Save" />
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
                    <td width="285" class="FormTableTitle" align="left" valign="middle">&nbsp;Target Number / Num&eacute;ro de cible</td>
                    <td class="LineVertico1PX"></td>
                    <td width="284" class="FormTableTitle" align="left" valign="middle">&nbsp;Result / R&eacute;sultat</td>
                    <td class="LineVertico1PX"></td>
                <tr>
                    <td class="LineVertico1PX" height="45"></td>
                    <td align="center" valign="middle" style="font-size:16px;"><% Response.Write(sqlDtSet.Tables("Result").Rows(0)("resultTargetSerial")) %></td>
                    <td class="LineVertico1PX"></td>
                    <td align="center" valign="middle"><input type="text" name="txtResult" id="txtResult" class="FormTextBoxResultsAdd" style="text-align: center" value="<% Response.Write(sqlDtSet.Tables("Result").Rows(0)("result")) %>"></td>
                    <td class="LineVertico1PX"></td>
                <tr>
                    <td colspan="5" class="LineHorizo1PX"></td>
            </table>
            
            <table border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td colspan="5" class="LineHorizo1PX"></td>
                <tr>
                    <td class="LineVertico1PX" height="14"></td>
                    <td width="285" class="FormTableTitle" align="left" valign="middle">&nbsp;Date</td>
                    <td class="LineVertico1PX"></td>
                    <td width="284" class="FormTableTitle" align="left" valign="middle">&nbsp;User / Usager</td>
                    <td class="LineVertico1PX"></td>
                <tr>
                    <td class="LineVertico1PX" height="45"></td>
                    <td align="center" valign="middle"><% Response.Write(sqlDtSet.Tables("Result").Rows(0)("DateInsert")) %></td>
                    <td class="LineVertico1PX"></td>
                    <td align="center" valign="middle"><% Response.Write(sqlDtSet.Tables("Result").Rows(0)("userLogin")) %></td>
                    <td class="LineVertico1PX"></td>
                <tr>
                    <td colspan="5" class="LineHorizo1PX"></td>
            </table>

        </form>
        <!-- ===== TABLEAU DE MODIFICATION D'UN RÉSULTAT ===== -->
        <!-- ================================================= -->






        </td>
</table>

<!--#include file="inc_bottom.aspx"-->