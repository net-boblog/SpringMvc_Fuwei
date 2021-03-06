<%@ page language="java" import="java.util.*" pageEncoding="utf-8"
	contentType="text/html; charset=utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	Boolean has_changelocation = SystemCache.hasAuthority(session,"selffuliaoinout/changelocation");
	Boolean has_cleaningstock = SystemCache.hasAuthority(session,"fuliao_workspace/cleaningstock");
%>
<!DOCTYPE html>
<html>
	<head>
		<base href="<%=basePath%>">
		<title>自购辅料工作台 -- 桐庐富伟针织厂</title>
		<meta charset="utf-8">
		<meta http-equiv="keywords" content="针织厂,针织,富伟,桐庐">
		<meta http-equiv="description" content="富伟桐庐针织厂">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<!-- 为了让IE浏览器运行最新的渲染模式 -->
		<link href="css/plugins/bootstrap.min.css" rel="stylesheet"
			type="text/css" />
		<link href="css/plugins/font-awesome.min.css" rel="stylesheet"
			type="text/css" />
		<link href="css/common/common.css" rel="stylesheet" type="text/css" />
		<script src="js/plugins/jquery-1.10.2.min.js"></script>
		<script src="js/plugins/bootstrap.min.js" type="text/javascript"></script>
		<script src="js/common/common.js" type="text/javascript"></script>
		<link href="css/store_in_out/index.css" rel="stylesheet" type="text/css" />
	</head>

	<body>
		<%@ include file="../common/head.jsp"%>
	
		<div id="Content" class="auto_container">
			<div id="main">
				<div class="breadcrumbs" id="breadcrumbs">
					<ul class="breadcrumb">
						<li>
							<i class="fa fa-home"></i>
							<a href="user/index">首页</a>
						</li>
						<li class="active">
							自购辅料工作台
						</li>
					</ul>
				</div>
				<div class="body">
					<div class="container-fluid">
						<div class="row">
							<div class="col-md-12 btnWidget">
								
								<a href="selffuliaoin/scan" type="button" class="btn btn-warning"><i class="fa fa-sign-in fa-lg"></i>入库</a>
								<a href="selffuliaoout/scan" type="button" class="btn btn-danger"><i class="fa fa-sign-out fa-lg"></i>出库</a>
							<!--	<a href="fuliaoreturn/scan" type="button" class="btn btn-danger"><i class="fa fa-sign-out fa-lg"></i>退货</a> -->
								<%if(has_changelocation){ %>
								<a target="_blank" href="fuliao_workspace/changelocation/scan_purchase" type="button" class="btn btn-primary"><i class=""></i>更改库位</a>
								<%} %>
								<%if(has_cleaningstock){ %>
								<a target="_blank" href="fuliao_workspace/cleaningstock_purchase" type="button" class="btn btn-danger pull-right"><i class=""></i>手动清库存</a>
								<%} %>
							</div>
						</div>


					</div>
					<div id="tab">

						<ul class="nav nav-tabs" role="tablist">
							<li class="active">
								<a href="#store_in" role="tab" data-toggle="tab">入库列表</a>
							</li>

							<li>
								<a href="#store_out" role="tab" data-toggle="tab">出库列表</a>
							</li>
							<!-- <li>
								<a href="#store_return" role="tab" data-toggle="tab">退货列表</a>
							</li> -->
							<li>
								<a href="#current_stock" role="tab" data-toggle="tab">库位库存报表</a>
							</li>
						</ul>


						<div class="tab-content auto_height">
							<div class="tab-pane active" id="store_in">
								<iframe id="store_inIframe" name="store_inIframe" border="0" furl="selffuliaoin/index" > </iframe>

							</div>
							<div class="tab-pane" id="store_out">
								<iframe id="store_outIframe" name="store_outIframe" border="0" furl="selffuliaoout/index" > </iframe>
							</div>
							<div class="tab-pane" id="store_return">
								<iframe id="store_returnIframe" name="store_returnIframe" border="0" furl="selffuliaoreturn/index" > </iframe>
							</div>
							<div class="tab-pane" id="current_stock">
								<iframe id="current_stockIframe" name="current_stockIframe" border="0" furl="fuliao_workspace/current_stock_purchase" > </iframe>
							</div>
						</div>
					</div>
					
				</div>

			</div>
		</div>
		</div>
	<script type="text/javascript">
			/*设置当前选中的页*/
			var $a = $("#left li a[href='fuliao_workspace/workspace_purchase']");
			setActiveLeft($a.parent("li"));
			$("#tab ul.nav>li").click(function(){
				var $a = $(this).find("a");
				var tab_name = $a.attr("href").substring(1);
				var $frame = $("#"+tab_name).find("iframe");
				var src = $frame.attr("src");
				if(src == undefined || src == ""){
					$frame.attr("src",$frame.attr("furl"));
				}
			});
			$("#tab ul.nav>li").first().click();
		</script>
	</body>
</html>
