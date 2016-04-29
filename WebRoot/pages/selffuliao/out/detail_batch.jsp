<%@ page language="java" import="java.util.*" pageEncoding="utf-8"
	contentType="text/html; charset=utf-8"%>
<%@page import="com.fuwei.entity.financial.Expense_income"%>
<%@page import="com.fuwei.entity.Salesman"%>
<%@page import="com.fuwei.entity.Company"%>
<%@page import="com.fuwei.entity.User"%>
<%@page import="com.fuwei.commons.Pager"%>
<%@page import="com.fuwei.util.DateTool"%>
<%@page import="com.fuwei.commons.SystemCache"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.fuwei.entity.Factory"%>
<%@page import="com.fuwei.entity.Employee"%>
<%@page import="com.fuwei.entity.producesystem.SelfFuliaoOut"%>
<%@page import="com.fuwei.entity.producesystem.SelfFuliaoOutDetail"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
	+ request.getServerName() + ":" + request.getServerPort()
	+ path + "/";
	List<SelfFuliaoOut> inOutlist = (List<SelfFuliaoOut>)request.getAttribute("result");
	String ids = (String)request.getAttribute("ids");
	if(inOutlist==null){
		inOutlist = new ArrayList<SelfFuliaoOut>();
	}
%>
<!DOCTYPE html>

<html>
	<head>
		<base href="<%=basePath%>">
		<title>清空生成的自购辅料出库单列表 -- 桐庐富伟针织厂</title>
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
		<link href="css/store_in_out/index.css" rel="stylesheet"
			type="text/css" />
		
	</head>
	<body>
		<%@ include file="../../common/head.jsp"%>
		<div id="Content">
			<div id="main">
				<div class="breadcrumbs" id="breadcrumbs">
					<ul class="breadcrumb">
						<li>
							<i class="fa fa-home"></i>
							<a href="user/index">首页</a>
						</li>
						<li>
							<a href="fuliao_workspace/workspace_purchase">自购辅料工作台</a>
						</li>
						<li class="active">
							清空库存生成的自购辅料出库单列表
						</li>
					</ul>
				</div>
				<div class="body">
					<div class="container-fluid">
						<div class="row">
							<div class="col-md-12 tablewidget">
								<a id="tabPrintBtn" target="_blank" class="btn btn-primary" href="selffuliaoout/print_batch/tag?ids=<%=ids %>" style="margin-bottom:5px;">批量打印辅料标签</a>
								<table class="table table-responsive table-bordered">
									<thead>
										<tr style="height:0;">
											<th style="width:20px"></th>
    										<th style="width:60px"></th>
    										<th style="width:60px"></th>
    										<th style="width:100px"></th>
											<th style="width:40px"></th>
    										<th style="width:55px"></th>
    										<th style="width:60px"></th>
    										<th style="width:50px"></th>
    										<th style="width:60px"></th>
    										<th style="width:60px"></th>
    										<th style="width:60px"></th>
    										<th style="width:30px"></th>
    										<th style="width:40px"></th>
  										</tr>
										<tr>
											<th rowspan="2"  width="20px" style="padding: 0;">
												No.
											</th>
											<th rowspan="2" width="60px">
												出库单号
											</th><th rowspan="2" width="60px">
												订单号
											</th><th rowspan="2" width="100px">
												款名
											</th>
											<th rowspan="2" width="40px">
												跟单人
											</th><th colspan="4" width="165px">自购辅料出库列表</th>
											<th rowspan="2" width="60px">
												出库时间
											</th>
											<th rowspan="2" width="60px">
												领取人
											</th>
											<th rowspan="2" width="30px">
												打印
											</th>
											<th rowspan="2" width="40px">
												操作
											</th>
										</tr><tr><th width="55px">
												类型
											</th><th  width="60px">
												数量(个)
											</th><th  width="50px">
												库位
											</th><th  width="60px">
												备注
											</th></tr>
									</thead>
									<tbody>
										<%
											int i = 0;
											for (SelfFuliaoOut item : inOutlist) {
												boolean even = i%2 == 0;
												String classname = even?"even":"odd";
												List<SelfFuliaoOutDetail> detailist = item.getDetaillist();
												if(detailist == null){detailist = new ArrayList<SelfFuliaoOutDetail>();}
												int detailsize = detailist.size();
										%>
										<tr itemId="<%=item.getId()%>" class="<%=classname%>">
											<td rowspan="<%=detailsize%>"><%=++i%></td>
											
											<td rowspan="<%=detailsize%>"><a target="_blank" href="selffuliaoout/detail/<%=item.getId()%>"><%=item.getNumber()%></a></td>
											<td rowspan="<%=detailsize%>"><a target="_blank" href="order/detail/<%=item.getOrderId()%>"><%=item.getOrderNumber()%></a></td>
											<td rowspan="<%=detailsize%>"><%=item.getName()%></td>
											<td rowspan="<%=detailsize%>"><%=SystemCache.getEmployeeName(item.getCharge_employee()) %></td>
											
											
											<td><%=SystemCache.getFuliaoTypeName(detailist.get(0).getStyle())%></td>
											<td><%=detailist.get(0).getQuantity()%></td>
											<td><%=SystemCache.getLocationNumber(detailist.get(0).getLocationId())%></td>
											<td><%=detailist.get(0).getMemo()==null?"":detailist.get(0).getMemo()%></td>

										
											<td rowspan="<%=detailsize%>"><%=DateTool.formatDateYMD(item.getCreated_at())%></td>	
											<td><%=SystemCache.getEmployeeName(item.getReceiver_employee())%></td>			
											<td rowspan="<%=detailsize%>"><%=item.printStr()%></td>	
											
											<td rowspan="<%=detailsize%>">
												<a target="_blank" href="fuliaoout/detail/<%=item.getId()%>">详情</a>
												
											</td>
										</tr>
										<%
											detailist.remove(0);
											for(SelfFuliaoOutDetail detail : detailist){
										%>
										<tr class="<%=classname %>">
											<td><%=SystemCache.getFuliaoTypeName(detail.getStyle())%></td>
											<td><%=detail.getQuantity()%></td>
											<td><%=SystemCache.getLocationNumber(detail.getLocationId())%></td>
											<td><%=detail.getMemo()==null?"":detail.getMemo()%></td>

										</tr>
										<%} %>
										<%
											}
										%>
										
									</tbody>
								</table>
							</div>
						</div>

					</div>
				</div>
			</div>
		</div>
	</body>
</html>