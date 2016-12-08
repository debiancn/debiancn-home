$(document).ready(function(){
    $(window).scroll(function(){
        if ($(window).scrollTop() > 63){
            $(".negbar").css({"position":"fixed","top":"0px"});
            $(".mainbox").css("margin-top","90px");
        }
        else{
            $(".negbar").css("position","static");
            $(".mainbox").css("margin-top","50px");
        }
    });
});
function toGrey(a){
        a.style.backgroundColor = "#E4E4E4";
}
function toWhite(a){
        a.style.backgroundColor = "#FFFFFF";
}
