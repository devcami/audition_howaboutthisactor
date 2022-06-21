<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/footer.css">
</div>
    
    
<footer>
<div id="totop" class="iconbutton">▲</div>



</footer>

 <script type="text/javascript">
    $(document).ready(function() {
        console.log($(this).scrollTop());
        if ($(this).scrollTop() == 0) {
            $(".iconbutton").hide();
        }

        $(document).scroll(function() {
            if ($(this).scrollTop() > 0) {
                $(".iconbutton").show();
            } else {
                $(".iconbutton").hide();
            }
        })

        $(".iconbutton").click(function() {
            //                            바디 스크롤 제일 상위로 이동
            $("html,body").animate({
                scrollTop: 0
            }, 150)
        })

    })
</script>

</body>
</html>