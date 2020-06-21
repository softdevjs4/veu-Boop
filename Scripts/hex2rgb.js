/**
     {
         "api":1,
         "name":"HEX2RGB",
         "description":"Convert color in hexadecimal to RGB.",
         "author":"Venkat",
         "icon":"table",
         "tags":"flip"
     }
 **/

function main(input) {
    R = hexToR(input.text);
    G = hexToG(input.text);
    B = hexToB(input.text);

    input.text = R.toString().concat(',').
                   concat(G.toString()).concat(',').
                   concat(B.toString());
}

function hexToR(h) { return parseInt((cutHex(h)).substring(0,2),16) }
function hexToG(h) { return parseInt((cutHex(h)).substring(2,4),16) }
function hexToB(h) { return parseInt((cutHex(h)).substring(4,6),16) }
function cutHex(h) { return (h.charAt(0)=="#") ? h.substring(1,7) : h}