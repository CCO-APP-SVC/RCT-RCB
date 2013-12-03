
function fnOnMouseOver(xThis) {
    xThis.style.cursor = "pointer";
    xThis.style.backgroundImage = "url(pics/blue.png)";
    xThis.style.color = "White";
}

function fnOnMouseOut(xThis) {
    xThis.style.backgroundImage = "none";
    xThis.style.color = "Black";
}

function fnOnClick(xUrl) {
    window.location = xUrl;
}

function fnOnClickNewTab(xUrl) {
    window.open(xUrl);
}

function fnConfirmUserDel(xUid) {
    var strMessage = "!!! ATTENTION !!!\n";
    strMessage = strMessage + "Êtes-vous certain de vouloir supprimer cet usager?\n";
    strMessage = strMessage + "Cliquez sur OK pour supprimer.";

    if (confirm(strMessage))
        window.location = "functions.aspx?fn=UserDel&uid=" + xUid;
}

function fnConfirmEventDel(xEid) {
    var strMessage = "!!! ATTENTION !!!\n";
    strMessage = strMessage + "Êtes-vous certain de vouloir supprimer cet événement?\n";
    strMessage = strMessage + "La suppression de l'événement entraînera la suppression de toutes les données qui y sont liées.\n";
    strMessage = strMessage + "Cette action est irrévocable.\n";
    strMessage = strMessage + "Cliquez sur OK pour supprimer.";

    if (confirm(strMessage))
        window.location = "functions.aspx?fn=EventDel&eid=" + xEid;
}

function fnConfirmEventCompetitionDel(xEid, xCid) {
    var strMessage = "!!! ATTENTION !!!\n";
    strMessage = strMessage + "Êtes-vous certain de vouloir supprimer cette compétition?\n";
    strMessage = strMessage + "La suppression de la compétition entraînera la suppression de toutes les données qui y sont liées.\n";
    strMessage = strMessage + "Cette action est irrévocable.\n";
    strMessage = strMessage + "Cliquez sur OK pour supprimer.";

    if (confirm(strMessage))
        window.location = "functions.aspx?fn=EventCompetitionDel&eid=" + xEid + "&cid=" + xCid;
}

function fnConfirmEventRegionTeamCompetitorDel(xEid, xRid, xReid, xTid, xTcid) {
    var strMessage = "!!! ATTENTION !!!\n";
    strMessage = strMessage + "Êtes-vous certain de vouloir supprimer ce compétiteur?\n";
    strMessage = strMessage + "La suppression de ce compétiteur entraînera la suppression de toutes les données qui y sont liées.\n";
    strMessage = strMessage + "Cette action est irrévocable.\n";
    strMessage = strMessage + "Cliquez sur OK pour supprimer.";

    if (confirm(strMessage))
        window.location = "functions.aspx?fn=EventRegionTeamCompetitorDel&eid=" + xEid + "&rid=" + xRid + "&reid=" + xReid + "&tid=" + xTid + "&tcid=" + xTcid;
}

function fnConfirmDelRegion(xRid, xEtid) {
    var strMessage = "!!! ATTENTION !!!\n";
    strMessage = strMessage + "Êtes-vous certain de vouloir supprimer cette région?\n";
    strMessage = strMessage + "La suppression de la région entraînera la suppression de toutes les données qui y sont liées.\n";
    strMessage = strMessage + "Cette action est irrévocable.\n";
    strMessage = strMessage + "Cliquez sur OK pour supprimer.";

    if (confirm(strMessage))
        window.location = "functions.aspx?fn=Region_Delete&rid=" + xRid + "&etid=" + xEtid;
}

function fnConfirmDelTeam(xEid, xRid, xReid, xTid) {
    var strMessage = "!!! ATTENTION !!!\n";
    strMessage = strMessage + "Êtes-vous certain de vouloir supprimer cette équipe?\n";
    strMessage = strMessage + "La suppression de l'équipe entraînera la suppression de toutes les données qui y sont liées.\n";
    strMessage = strMessage + "Cette action est irrévocable.\n";
    strMessage = strMessage + "Cliquez sur OK pour supprimer.";

    if (confirm(strMessage))
        window.location = "functions.aspx?fn=EventRegionTeamDel&eid=" + xEid + "&rid=" + xRid + "&reid=" + xReid + "&tid=" + xTid;
}

function fnHideShowItem(xItem, xPlus) {
    
    if (document.getElementById(xItem).style.display == 'none') {
        document.getElementById(xItem).style.display = '';
        document.getElementById(xPlus).firstChild.nodeValue = "-"
    }
    else {
        document.getElementById(xItem).style.display = 'none';
        document.getElementById(xPlus).firstChild.nodeValue = "+";
    }

}

function fnHideShowItem2(xItem, xItem2, xPlus) {

    if (document.getElementById(xItem).style.display == 'none') {
        document.getElementById(xPlus).firstChild.nodeValue = "-"
        document.getElementById(xItem).style.display = '';
        document.getElementById(xItem2).style.display = '';
        
    }
    else {
        document.getElementById(xPlus).firstChild.nodeValue = "+";
        document.getElementById(xItem).style.display = 'none';
        document.getElementById(xItem2).style.display = 'none';
    }
}

function fnResultsAddEventSelect(xEid) {
    document.location = "results_add.aspx?eid=" + xEid;
}

function fnResultsFinalAddEventSelect(xEid) {
    document.location = "results_add_final.aspx?eid=" + xEid;
}

function fnResultsImportEventSelect(xEid) {
    document.location = "results_import.aspx?eid=" + xEid;
}

function fnResultsSearchEventSelect(xEid) {
    document.location = "results_search.aspx?eid=" + xEid;
}

function fnResultsAddCompetitionSelect(xCid, xEid) {
    document.location = "results_add.aspx?eid=" + xEid + "&cid=" + xCid;
}

function fnResultsFinalAddCompetitionSelect(xCid, xEid) {
    document.location = "results_add_final.aspx?eid=" + xEid + "&cid=" + xCid;
}

function fnResultsImportCompetitionSelect(xCid, xEid) {
    document.location = "results_import.aspx?eid=" + xEid + "&cid=" + xCid;
}

function fnResultsSearchCompetitionSelect(xCid, xEid) {
    document.location = "results_search.aspx?eid=" + xEid + "&cid=" + xCid;
}

function fnFinalistsSelectionCompetitionSelect(xCid, xEid) {
    document.location = "event_finalists_selection.aspx?eid=" + xEid + "&cid=" + xCid;
}

function fnResultsAddValidTargetSerial(xElement) {
    
    var sValue = document.getElementById(xElement).value;
    var sPattern = /[0-9][0-9][0-9][0-9][0-9]/;

    var sMsgError = "!!! ATTENTION !!!\n";
    sMsgError = sMsgError + "Le numéro de cible que vous avez saisie n'est pas conforme.\n";
    sMsgError = sMsgError + "Le numéro de cible doit être composé uniquement de chiffres.\n";
    sMsgError = sMsgError + "Le numéro de cible doit avoir 5 caractères.\n";
    sMsgError = sMsgError + "Exemple : 01101\n";

    if (!sValue.match(sPattern)) {
        alert(sMsgError);
        document.getElementById(xElement).focus();
        document.getElementById(xElement).select();
    }
}

function fnResultsAddOnChangeTargetSerial(xElement,xKeyCode) {

    if (xElement.value.length == 5 && xKeyCode != 13) {
        document.getElementById("txtResult").focus();
    }

}

function fnResultsAddValidResult(xElement) {

    var sValue = document.getElementById(xElement).value;
    var sPattern = /^[0-9]{1,3}$/;

    var sMsgError = "!!! ATTENTION !!!\n";
    sMsgError = sMsgError + "Le résultat que vous avez saisie n'est pas conforme.\n";
    sMsgError = sMsgError + "Le résultat doit être composé uniquement de chiffres.\n";
    sMsgError = sMsgError + "Le résultat doit avoir 1 à 3 caractères.\n";
    sMsgError = sMsgError + "Le résultat doit être de 0 à 100.\n";
    sMsgError = sMsgError + "Exemple : 4, 92 ou 100\n";

    if (!sValue.match(sPattern) || sValue > 100) {
        alert(sMsgError);
        document.getElementById(xElement).focus()
        document.getElementById(xElement).select()
    }
    else
        document.frmResultsAdd.submit();
}

function fnResultSearch() {
    document.frmResultSearch.submit();
}

function fnResultsAddPressEnter(xThis,xKeyCode) {

    if (xKeyCode == 13)
        fnResultsAddValidResult(xThis.id);

}

function fnEventRegionTeamValidTeamSerial(xElementToValid, xForm) {

    var sValue = document.getElementById(xElementToValid).value;
    var sPattern = /^[0-9]{1,2}$/;

    var sMsgError = "!!! ATTENTION !!!\n";
    sMsgError = sMsgError + "Le numéro de série que vous avez saisie n'est pas conforme.\n";
    sMsgError = sMsgError + "Le numéro de série doit être composé uniquement de chiffres.\n";
    sMsgError = sMsgError + "Le numéro de série doit avoir 2 caractères.\n";
    sMsgError = sMsgError + "Le numéro de série doit être de 0 à 99.\n";
    sMsgError = sMsgError + "Exemple : 03 ou 32\n";

    if (!sValue.match(sPattern)) {
        alert(sMsgError);
        document.getElementById(xElementToValid).focus()
        document.getElementById(xElementToValid).select()
    }
    else
        document.getElementById(xForm).submit();

}

function fnLoadFileInTextArea(fElement) {

    var f = fElement.files[0];

    if (f) {
        document.getElementById("txtCSV").style.color = "black";
        var reader = new FileReader();
        reader.onload = function (e) { document.getElementById("txtCSV").value = e.target.result }
        reader.readAsText(f, "UTF-8");
    }
    else {
        document.getElementById("txtCSV").style.color = "red";
        document.getElementById("txtCSV").value = "Unable to load the CSV file.\nImpossible de charger le fichier CSV."
    }
}

function fnValidCSVBeforeSend() {

    var sFirstValidString = document.getElementById("txtCSV").value.substr(0, 5).toLowerCase();

    if (sFirstValidString == "relay") {
        document.frmResultsImport.submit();
    }
    else {
        alert("The CSV file loaded is not valid. It is not accepted.\nPlease, choose a valid CSV file. If this problem persists,\nfeel free to contact the software admin.\n\nLe fichier CSV chargé n'est pas valide. Il n'est pas accepté.\nSVP, veuillez choisir un fichier CSV valide. Si le problème\npersiste, communiquez avec l'administrateur du logiciel.");
    }

}
