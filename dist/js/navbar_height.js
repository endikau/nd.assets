function adjustNavbarPadding() {
  var navbarContainer = document.querySelector('#page-navbar-container');
  if (!!navbarContainer) {
  	document.body.style["padding-top"] = navbarContainer.scrollHeight + 'px';
  }
}

adjustNavbarPadding();
window.addEventListener('load', adjustNavbarPadding);
window.addEventListener('resize', adjustNavbarPadding);

/*
const navbarToggle = document.querySelector('#navbarSupportedContent') 
navbarToggle.addEventListener('shown.bs.collapse', adjustNavbarPadding) 
navbarToggle.addEventListener('hidden.bs.collapse', adjustNavbarPadding) 
*/
