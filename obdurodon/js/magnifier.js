/*
Author: Jacob Deitloff
Date: 2012-06-04
Copyright: Creative Commons BY-NC-SA 3.0 (http://creativecommons.org/licenses/by-nc-sa/3.0/)
Project home page: http://bdinski.obdurodon.org
Project director: David J. Birnbaum (djbpitt@gmail.com)
For working examples of the magnifier, see the individual folio pages on the project site.

Synopsis: Magnifying glass overlay for HTML images. Adapted from an unattributed application
and modified to work with CSS <div> pseudo-frames in a responsive (resizing) architecture.
The HTML document to which this code is attached must contain the following elements:

<div id="image">
<img id="smallImage" src="../images/jpg/bdinski001r.jpg" alt="Image of 001r" onload="setupMagnifier();"/>
<div id="largeImage" style="background-image:url(../images/jpg/bdinski001r.jpg);"/>
</div>

where the @src attribute for the smaller image and the background image for the larger one point to the
(same) actual image file.
*/

/*
Cookie management functions from http://www.quirksmode.org/js/cookies.html
*/

function createCookie(name, value, days) {
    if (days) {
        var date = new Date();
        date.setTime(date.getTime() +(days * 24 * 60 * 60 * 1000));
        var expires = "; expires=" + date.toGMTString();
    } else var expires = "";
    document.cookie = name + "=" + value + expires + "; path=/";
}

function readCookie(name) {
    var nameEQ = name + "=";
    var ca = document.cookie.split(';');
    for (var i = 0; i < ca.length; i++) {
        var c = ca[i];
        while (c.charAt(0) == ' ') c = c.substring(1, c.length);
        if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length, c.length);
    }
    return null;
}

/* Project-specific code begins here */

var dimension = 200;

var imageWidth;
var imageHeight;

document.onmousemove = function (e) {
    var x = e.pageX;
    var y = e.pageY;
    
    var currentElement = document.images.smallImage;
    while (currentElement != document.body) {
        x -= currentElement.offsetLeft;
        y -= currentElement.offsetTop;
        currentElement = currentElement.offsetParent;
    }
    
    if (x < 0 || y < 0 || x >= document.images.smallImage.clientWidth ||
    y >= document.images.smallImage.clientHeight) {
        return;
    }
    
    var largeImage = document.getElementById("largeImage");
    var smallImage = document.getElementById("smallImage");
    
    var imageRatioX = (imageWidth * 2) / smallImage.clientWidth;
    var imageRatioY = (imageHeight * 2) / smallImage.clientHeight;
    
    largeImage.style.left = (x - dimension / 2) + "px";
    largeImage.style.top = (y - dimension / 2) + "px";
    
    largeImage.style.backgroundPosition = -(x * imageRatioX - dimension / 2) + "px " + -(y * imageRatioY - dimension / 2) + "px";
}

function setupMagnifier() {
    var smallImage = document.getElementById("smallImage");
    var largeImage = document.getElementById("largeImage");
    
    var image = new Image();
    image.onload = function () {
        imageWidth = image.width;
        imageHeight = image.height;
        largeImage.style.backgroundSize = (imageWidth * 2) + "px " + (imageHeight * 2) + "px";
        /*        largeImage.style.display = "block";
        */
        if (readCookie("magnifier") === "visible") {
            largeImage.style.display = "block";
            document.getElementById("toggleMagnifier").setAttribute("checked","checked");
        } else {
            largeImage.style.display = "none";
            document.getElementById("toggleMagnifier").removeAttribute("checked");
        }
    };
    image.src = smallImage.src;
}

/*
Toggle magnifier and change text of toggle button
Toggle setting retained in cookie with name "magnifier" and value ("visible" | "hidden")
*/

function toggleMagnifier() { if (document.getElementById("largeImage").style.display === 'block') {
        document.getElementById("largeImage").style.display = 'none';
        document.getElementById("toggleMagnifier").removeAttribute("checked");
        createCookie("magnifier", "hidden", 7);
    } else {
        document.getElementById("largeImage").style.display = 'block';
        document.getElementById("toggleMagnifier").setAttribute("checked","checked");
        createCookie("magnifier", "visible", 7);
    }
}
