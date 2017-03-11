$(document).ready(function(){
  $(".click-to-expand").siblings().hide()

  toggleMenuItems();
})

function toggleMenuItems() {
  $(".click-to-expand").on("click", function(e){
    e.preventDefault
    $(this).siblings().toggle()
  })
}
