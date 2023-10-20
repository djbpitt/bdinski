function changeFont (fontName) {
    var ocs = document.getElementsByClassName('os');
    for (var i = 0; i < ocs.length; i++) {
        ocs[i].style.fontFamily = fontName;
    }
}