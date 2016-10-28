$(document).ready(function(){
  toggleMenuItems();
})

function toggleMenuItems() {
  $(".click-to-expand").on("click", function(e){
    e.preventDefault
    $(this).siblings().toggle()
  })
}
