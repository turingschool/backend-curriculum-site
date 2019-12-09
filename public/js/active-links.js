$('.nav-links a:not(.home-logo-link)').each(function(idx, link) {
  var currentPath = window.location.pathname;
  var linkPath = $(link).attr('href');

  if (currentPath.includes(linkPath)) {
    console.log(currentPath);
    $(link).toggleClass('active-link');
  }
});
