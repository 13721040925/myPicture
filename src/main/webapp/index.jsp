<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!doctype html>
<html lang="en">
 <head>
  <meta charset="UTF-8">
  <meta name="Generator" content="EditPlus®">
  <meta name="Author" content="">
  <meta name="Keywords" content="">
  <meta name="Description" content="">
  <style>
	 *{margin:0;padding:0}
	  body{
		background:#222;
		overflow:hidden;
		user-select:none;  /*禁止选中*/
	  }
	.perspective{
		perspective:800px;  /*3d景深*/
	}
	.wrap{
		transform-style:preserve-3d;
		width:120px;
		height:180px;
		margin:100px auto;
		position:relative;
		transform:rotateX(-10deg) rotateY(0deg);
	}
	.wrap img{
		display:block;
		position:absolute;
		width:100%;
		height:100%;
		transform: rotateY(0deg) translateZ(0px);
		padding:10px;
		background:transparent;
		box-shadow: 0 0 4px #fff; /*水平位移 垂直位移 扩散程度 颜色*/
		border-radius:5px;        /*圆角*/
		-webkit-box-reflect:below 5px -webkit-linear-gradient(top,rgba(0,0,0,0) 40%, rgba(0,0,0,.5) 100%); /*倒影 倒影模式 直径*/
	}
	.wrap p{
		width:1200px;
		height:1200px;
		background:-webkit-radial-gradient(center center ,600px 600px, rgba(122,122,122,0.5),rgba(0,0,0,0));
		position:absolute;
		border-radius:50%;
		left:50%;
	    top:100%;
		margin-left:-600px;
		margin-top:-600px;
		transform:rotateX(90deg); /*沿着x轴方向摁倒*/
	}
  </style>
  	<link rel="icon" href="images/logo.jpg" type="image/x-icon"> 
	<link rel="shortcut icon" href="images/logo.jpg" type="image/x-icon">
  <title>我的相册</title>
    </head>
	<body>
	<div class='perspective'>
		<div class='wrap'>
			<img src='images/1.jpg' width='133' height='200' alt='#'>
			<img src='images/2.jpg' width='133' height='200' alt='#'>
			<img src='images/3.jpg' width='133' height='200' alt='#'>
			<img src='images/4.jpg' width='133' height='200' alt='#'>
			<img src='images/5.jpg' width='133' height='200' alt='#'>
			<img src='images/6.jpg' width='133' height='200' alt='#'>
			<img src='images/7.jpg' width='133' height='200' alt='#'>
			<img src='images/8.jpg' width='133' height='200' alt='#'>
			<img src='images/9.jpg' width='133' height='200' alt='#'>
			<img src='images/10.jpg' width='133' height='200' alt='#'>
			<img src='images/11.jpg' width='133' height='200' alt='#'>
			<p></p>
		</div>
	</div>
		<audio id="music" autoplay="autoplay" loop="loop" preload="auto">
		    <source src="mp3/背景音乐.mp3" type='audio/mpeg; codecs="mp3"'>
		</audio>
	<script>
			/*谁 触发了什么事件 谁做了什么*/
			window.onload=function(){  /*页面加载完成*/
			/*最新的原生获取元素方法querySelectorAll*/
				var oImg=document.querySelectorAll('img'); 
				var oWrap=document.querySelector('.wrap');
				var lastX,lastY,nowX,nowY,minusX,minusY,roY=0,roX=-10;
				var timer=null;
			/*计算每一个图片的角度 总角度(360) / 数量(11) = 单位角度*/
				var length=oImg.length;  /*获取img的数量 统称为长度*/
				var Deg=360/length;      /*单位角度*/
				for(var i=0;i<length;i++){
				   oImg[i].style.transform='rotateY('+ i*Deg +'deg) translateZ(350px)';
				   oImg[i].style.transition='transform 1s '+(length-1-i)*0.2+'s'
				}
				mTop();
				window.onresize=mTop;
				function mTop(){
					 /*获取浏览器窗口可视高度*/
					var wH=document.documentElement.clientHeight||document.body.clientHeight;
					oWrap.style.marginTop=(wH/2)-oWrap.offsetHeight+'px';
				}

			
				/*拖拽drag 按下 onmousedown 移动 onmousemove 抬起 onmouseup */
				document.onmousedown=function(event){ /*按下鼠标开始准备拖拽*/
					event=event||window.event;			/*处理兼容性*/
					lastX=event.clientX;				/*鼠标拖拽开始时的x坐标*/
					lastY=event.clientY;				/*鼠标拖拽开始时的Y坐标*/
					clearInterval(timer);
					document.onmousemove=function(event){
						event=event||window.event;	
						nowX=event.clientX;             /*鼠标移动时的x坐标*/
						nowY=event.clientY;				/*鼠标移动时的y坐标*/
						minusX=nowX-lastX;              /*获取鼠标移动距离*/
						minusY=nowY-lastY;				/*获取鼠标移动距离*/
						roY+=minusX*0.2;				/*通过移动量计算旋转角度*/
						roX-=minusY*0.1;				/*通过移动量计算旋转角度*/
						oWrap.style.transform='rotateX('+roX+'deg) rotateY('+roY+'deg)' 
						lastX=nowX;						/*更新初始位置保证 lastX 跟得上鼠标*/
						lastY=nowY;						/*更新初始位置保证 lastY  */
					}
					document.onmouseup=function(){
						document.onmousemove=null;
						timer=setInterval(function(){
							/*给一个摩擦系数,每一次定时器触发都慢一点点*/
							minusX*=0.9;                     
							minusY*=0.9;
							roY+=minusX*0.2;				/*通过移动量计算旋转角度*/
							roX-=minusY*0.1;				/*通过移动量计算旋转角度*/
							oWrap.style.transform='rotateX('+roX+'deg) rotateY('+roY+'deg)';
							if(Math.abs(minusX)<0.1&&Math.abs(minusY)<0.1){
								/*当移动向量过小的时候终止定时器停止惯性*/
								clearInterval(timer);    
							}
						},13);
					}
					return false;
				}
				
			
			}
	</script>
 </body>
</html>
