window.addEventListener('scroll', () => {
    let nav = document.getElementsByClassName('nav')[0];
    const width = document.documentElement.clientWidth;
    if (window.pageYOffset > 90 && width > 1000)
    {
        nav.style.cssText =
            'position: fixed; \
            top: 0; \
            left: 0; \
            width: 77%; \
            height: 40px; \
            border-bottom: 5px solid #D24C72; \
            z-index: "2"; \
            background-color: #FFF; \
            padding: 5px 13% 0 10%;';
    } else {
        if (width > 1000)
            nav.style.cssText = "position: static;";
    }
});
window.addEventListener('resize', () => {
    const width = document.documentElement.clientWidth;
    let header = document.getElementById('header');
    let nav = document.getElementsByClassName('nav')[0];
    if (width > 1000)
    {
        console.log("resize")
        header.style.cssText = 'height: 140px !important;';
        nav.style.cssText = 'display: block !important';
    } else {
        header.style.cssText = 'height: 50px !important;';
        nav.style.cssText = 'display: none !important';

    }
});

window.onload = function() {
    document.getElementById('menu-button').addEventListener('click', () => {
        let nav = document.getElementsByClassName('nav')[0];
        let header = document.getElementById('header');
        if (nav.style.display == "" || nav.style.display == "none")
        {
            nav.style.cssText = 'display: block !important;';
            header.style.cssText = 'height: 300px;';
        } else {
            nav.style.cssText = 'display: none !important;';
            header.style.cssText = 'height: 50px;';
        }
    });
}
