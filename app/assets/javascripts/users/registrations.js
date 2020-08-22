$(document).on('turbolinks:load', function() {
  $(function(){  
    $(".btn-app").hover(
      function(){
        $(this).css('opacity', '0.5');
      },
      function(){
        $(this).css('opacity', '');
      }
    );
  
    $(".btn-google").hover(
      function(){
        $(this).css('opacity', '0.5');
      },
      function(){
        $(this).css('opacity', '');
      }
    );
  
  
    function buildHTML(image){
      let html = `
                  <div class=".user-image-box">
                    <label for="image-edit-id">
                      <img src="${image}", class="user-image">
                    </label>
                  </div>
                  `
      console.log(html);
      return html;
    }
  
    $("#image-edit-id").on("change", function(){
      console.log("change");
      let file = this.files[0];
      // FileReader=>ユーザーのファイルをウェブアプリケーションから非同期的に読み込むことができるオブジェクト
      var reader = new FileReader();
      reader.readAsDataURL(file);
      reader.onload = function(){
      $(".user-image").remove();
        let image = this.result;
        var html = buildHTML(image);
        $(".user-image-box").append(html);
      }
    })

    $("#password-form-current, #password-form-new, #password-form-confirmation").on('keyup', function(){
      let pass_current = $("#password-form-current");
      let pass_new = $("#password-form-new");
      let pass_confirmation = $("#password-form-confirmation");
      console.log($("check"));
      if(pass_current.val() !== "" && pass_new.val() !== "" && pass_confirmation.val() !== "") {
        $(".password-submit").css('pointer-events', '');
        $(".password-submit").css('background-color', '#02a1fd');
      } else {
        $(".password-submit").css('pointer-events', 'none');
      }
    })
  });  
});
