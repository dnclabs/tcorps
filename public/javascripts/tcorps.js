var GB_ANIMATION = true;

jQuery(document).ready(function(){    
  jQuery('div#signin_nav li a, div#signup_nav li a').click(function() {
    var name = jQuery(this).parent('li')[0].id.split('_')[1];
    var type = jQuery(this).parents('div.nav')[0].id.split('_')[0];
    return switch_nav(name, type);
  });
});

function switch_nav(name, type) {
  var nav_item = jQuery('li#nav_' + name);
  var other_navs = jQuery('div#' + type + '_nav li:not(#nav_' + name + ')');
  
  jQuery('div.' + type + '_option').hide();
  jQuery('div#' + type + '_' + name).show();
  other_navs.removeClass('active');
  nav_item.addClass('active');
  
  return false;
}

function setToNow(object, field) {
  var base = object + "_" + field;
  var now = new Date();
  var minutes = now.getMinutes();
  if (minutes < 10) minutes = "0" + minutes;
  
  jQuery("#" + base + "_1i").val(now.getYear() + 1900);
  jQuery("#" + base + "_2i").val(now.getMonth() + 1);
  jQuery("#" + base + "_3i").val(now.getDate());
  jQuery("#" + base + "_4i").val(now.getHours());
  jQuery("#" + base + "_5i").val(minutes);
}

// adapted from http://baxil.livejournal.com/266909.html
function mailtoLink(rhs, tld, lhs) {
  document.write("<a href=\"mailto");
  document.write(":" + lhs + "@" + rhs + "." + tld + "\">");
  document.write(lhs + "@" + rhs + "." + tld + "<\/a>");
}