<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<footer>
<div id="totop" class="iconbutton">▲</div>

    <div class ="foo_div">
        <img src="${pageContext.request.contextPath}/images/logoPink.png">
    </div>
    
    <div class="foo_div1">
        <a> 5GZO</a>
    </div>

    <div class="foo_div2">
      <a  href="https://www.youtube.com/watch?v=962tyDDSE8k" ><img src="${pageContext.request.contextPath}/images/youtube.png" alt="유투브" ></a>

      <a href="<%= request.getContextPath() %>"><img src="${pageContext.request.contextPath}/images/home.png" alt="홈"></a>
     
      <a href="https://github.com/devcami/semi_Project.git"><img src="${pageContext.request.contextPath}/images/gitP.png" alt="깃"></a>
    </div>    




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
