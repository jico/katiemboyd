pathname = document.location.pathname
if pathname in [ '/process', '/work' ]
  $(".navigation a[href='#']").addClass('active')
else
  $(".navigation a[href='#{pathname}']").addClass('active')
