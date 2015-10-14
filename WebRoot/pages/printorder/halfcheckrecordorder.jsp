<%@ page language="java" import="java.util.*" pageEncoding="utf-8"
	contentType="text/html; charset=utf-8"%>
<%@page import="com.fuwei.entity.OrderDetail"%>
<%@page import="com.fuwei.entity.Order"%>
<%@page import="com.fuwei.entity.ordergrid.HalfCheckRecordOrder"%>
<%@page import="com.fuwei.entity.ordergrid.HalfCheckRecordOrderDetail2"%>
<%@page import="com.fuwei.entity.ordergrid.PlanOrderDetail"%>
<%@page import="com.fuwei.commons.SystemCache"%>
<%@page import="com.fuwei.util.SerializeTool"%>
<%@page import="com.fuwei.util.DateTool"%>
<%
	Order order = (Order) request.getAttribute("order");
	//半检记录单
	HalfCheckRecordOrder halfCheckRecordOrder = (HalfCheckRecordOrder) request
			.getAttribute("halfCheckRecordOrder");
	List<HalfCheckRecordOrderDetail2> halfCheckRecordOrderDetailList2 = halfCheckRecordOrder == null ? new ArrayList<HalfCheckRecordOrderDetail2>()
			: halfCheckRecordOrder.getDetail_2_list();
	List<PlanOrderDetail> carFixRecordOrderDetailList = halfCheckRecordOrder == null ? new ArrayList<PlanOrderDetail>()
			: halfCheckRecordOrder.getDetaillist();
	String productfactoryStr = (String)request.getAttribute("productfactoryStr");
%>
<!DOCTYPE html>
<html>
	<head>

		<title>半检记录单 -- 桐庐富伟针织厂</title>
		<meta charset="utf-8">
		<meta http-equiv="keywords" content="针织厂,针织,富伟,桐庐">
		<meta http-equiv="description" content="富伟桐庐针织厂">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<!-- 为了让IE浏览器运行最新的渲染模式 -->
	</head>
	<body class="">
		<div class="container-fluid gridTab auto_container">
			<div class="row">
				<div class="col-md-12 tablewidget">
					<table class="table noborder">
						<caption id="tablename">
							桐庐富伟针织厂半检记录单<div table_id="<%=order.getId() %>" class="id_barcode"></div>
						</caption>
						<tr><td colspan="3" class="pull-right">№：<%=order.getOrderNumber() %></td></tr>
					</table>

					<table id="orderTb" class="tableTb">
						<tbody>
							<tr>
								<td align="center" rowspan="8" width="50%">
									<img id="previewImg" alt="200 x 100%"
										src="/<%=order.getImg_s()%>">
								</td>
								<td width="20%">
									生产单位
								</td>
								<td class="orderproperty"><%=productfactoryStr %></td>
							</tr>

							<tr>
								<td colspan="2" class="center">
									订单信息
								</td>
							</tr>
							<tr>
								<td>
									公司
								</td>
								<td><%=SystemCache.getCompanyShortName(order.getCompanyId())%></td>
							</tr>
							<tr>
								<td>
									客户
								</td>
								<td><%=SystemCache.getCustomerName(order.getCustomerId())%></td>
							</tr>
							<tr>
								<td>
									货号
								</td>
								<td><%=order.getCompany_productNumber()%></td>
							</tr>
							<tr>
								<td>
									款名
								</td>
								<td><%=order.getName()%></td>
							</tr>
							<tr>
								<td>
									跟单
								</td>
								<td><%=SystemCache.getEmployeeName(order.getCharge_employee())%></td>
							</tr>
							<tr>
								<td>
									发货时间
								</td>
								<td><%=DateTool.formatDateYMD(order.getEnd_at())%></td>
							</tr>
						</tbody>
					</table>

					<table id="mainTb" class="noborder">
						<tr>
							<td>
								<table class="detailTb">
									<caption>
										颜色及数量
									</caption>
									<thead>
										<tr>
											<th width="15%">
												颜色
											</th>
											<th width="15%">
												克重(g)
											</th>
											<th width="15%">
												纱线种类
											</th>
											<th width="15%">
												尺寸
											</th>
											<th width="15%">
												生产数量
											</th>
										</tr>
									</thead>
									<tbody>
										<%
											for (PlanOrderDetail detail : carFixRecordOrderDetailList) {
										%>
										<tr class="tr">
											<td class="color"><%=detail.getColor()%>
											</td>
											<td class="weight"><%=detail.getWeight()%>
											</td>
											<td class="yarn_name"><%=SystemCache.getMaterialName(detail.getYarn()) %>
											</td>
											<td class="size"><%=detail.getSize()%>
											</td>
											<td class="quantity"><%=detail.getQuantity()%>
											</td>
										</tr>

										<%
											}
										%>

									</tbody>
								</table>
							</td>
						</tr>

						<tr>
							<td>
								<table class="detailTb">
									<caption>
										生产材料信息
									</caption>
									<thead>
										<tr>
											<th width="20%">
												材料
											</th>
											<th width="20%">
												色号
											</th>
											<th width="25%">
												标准色样
											</th>
										</tr>
									</thead>
									<tbody>
										<%
											for (HalfCheckRecordOrderDetail2 detail : halfCheckRecordOrderDetailList2) {
										%>
										<tr class="tr">
											<td class="material_name"><%=SystemCache.getMaterialName(detail.getMaterial()) %>
											</td>
											<td class="color"><%=detail.getColor()%>
											</td>
											<td class="colorsample"><%=detail.getColorsample()%>
											</td>
										</tr>

										<%
											}
										%>

									</tbody>
								</table>
							</td>
						</tr>

						<tr>
							<td>
								<table class="auto_height stickedTb">
									<caption>
										半检记录
									</caption>
									<thead>
										<tr>
											<th width="7%">
												时间
											</th>
											<th width="7%">
												加工人
											</th>
											<th width="10%">
												半检内容
											</th>
											<th width="15%">
												颜色
											</th>
											<th width="15%">
												合格数量
											</th>
											<th width="15%">
												退回数量
											</th>
											<th width="15%">
												主要问题
											</th>
											<th width="10%">
												签名
											</th>

										</tr>
									</thead>
									<tbody>
										<tr>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
										</tr>

									</tbody>

								</table>
							</td>
						</tr>
					</table>

					<p class="pull-right auto_bottom">
						<span id="created_user">制单人：<%=SystemCache.getUserName(halfCheckRecordOrder.getCreated_user()) %></span>
						<span id="date"> 日期：<%=DateTool.formatDateYMD(DateTool.getYanDate(halfCheckRecordOrder.getCreated_at())) %></span>
					</p>



				</div>

			</div>
		</div>
	</body>
	<script type="text/javascript">
		$(".id_barcode").each(function(){
			var id =$(this).attr("table_id");
			$(this).barcode(id, "code128",{barWidth:2, barHeight:30,showHRI:false});
		});		
	</script>
</html>