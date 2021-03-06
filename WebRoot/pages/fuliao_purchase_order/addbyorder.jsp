<%@ page language="java" import="java.util.*" pageEncoding="utf-8"
	contentType="text/html; charset=utf-8"%>
<%@page import="com.fuwei.commons.SystemCache"%>
<%@page import="com.fuwei.entity.Company"%>
<%@page import="com.fuwei.entity.Material"%>
<%@page import="com.fuwei.entity.Customer"%>
<%@page import="com.fuwei.entity.Order"%>
<%@page import="com.fuwei.entity.Factory"%>
<%@page import="com.fuwei.commons.SystemCache"%>
<%@page import="com.fuwei.util.SerializeTool"%>
<%@page import="com.fuwei.util.DateTool"%>
<%@page import="com.fuwei.entity.ordergrid.MaterialPurchaseOrderDetail"%>
<%@page import="com.fuwei.entity.FuliaoType"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	Order order = (Order) request.getAttribute("order");
	List<Factory> fuliao_factorylist = (List<Factory>)request.getAttribute("fuliao_factorylist");
%>
<!DOCTYPE html>
<html>
	<head>
		<base href="<%=basePath%>">
		<title>创建辅料采购单 -- 桐庐富伟针织厂</title>
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
		<script src="<%=basePath%>js/plugins/WdatePicker.js"
			type="text/javascript"></script>
		<script src="js/common/common.js" type="text/javascript"></script>
		<script src="js/plugins/jquery.jqGrid.min.js" type="text/javascript"></script>
		<link href="css/plugins/ui.jqgrid.css" rel="stylesheet"
			type="text/css" />

		<link href="css/order/bill.css" rel="stylesheet" type="text/css" />
		<script src="js/order/ordergrid.js" type="text/javascript"></script>
		<script src="js/fuliao_purchase_order/addbyorder.js" type="text/javascript"></script>

	</head>
	<body>
		<%@ include file="../common/head.jsp"%>
		<div id="Content">
			<div id="main">
				<div class="breadcrumbs" id="breadcrumbs">
					<ul class="breadcrumb">
						<li>
							<i class="fa fa-home"></i>
							<a href="user/index">首页</a>
						</li>
						<li>
							<a href="order/detail/<%=order.getId()%>">订单详情</a>
						</li>
						<li>
							<a href="order/tablelist?orderId=<%=order.getId()%>&tab=fuliaopurchaseorder">表格</a>
						</li>
						<li class="active">
							创建辅料采购单
						</li>
					</ul>
				</div>
				<div class="body">
					<div class="container-fluid fuliaoorderWidget">
						<div class="row">
							<form class="saveform">
								<input type="hidden" id="sampleId" name="sampleId"
									value="<%=order.getSampleId()%>" class="require" />
								<input type="hidden" id="orderId" name="orderId"
									value="<%=order.getId()%>" class="require" />
								<button type="submit"
									class="pull-right btn btn-danger saveTable"
									data-loading-text="正在保存...">
									创建辅料采购单
								</button>

								<div class="clear"></div>
								<div class="col-md-12 tablewidget">
									<table class="table">
										<caption id="tablename">
											桐庐富伟针织厂辅料采购单
										</caption>
									</table>
									<table class="tableTb noborder">
										<tbody>
											<tr>
												<td>
													<div class="form-group">
														供货单位：
														<select class="form-control require" name="factoryId"
															id="factoryId">
															<option value="">
																未选择
															</option>
															<%
																for (Factory factory : fuliao_factorylist) {
															%>
															<option value="<%=factory.getId()%>"><%=factory.getName()%></option>
															<%
																}
															%>
														</select>
													</div>
													<div class="form-group">
														业务员：
														<select disabled name="charge_employee" id="charge_employee"
															class="form-control">
															<option value="<%=order.getCharge_employee()%>" selected><%=SystemCache.getEmployeeName(order.getCharge_employee())%></option>
														</select>
													</div>

												</td>
												<td>
													<div class="form-group pull-right">
														№：<input class="form-control" disabled type="text" value="自动生成" />
													</div>
												</td>
											</tr>

											<tr>
												<td colspan="2">
													<table class="table table-responsive table-bordered">
														<tr>
															<td class="center" width="10%">
																公司
															</td>
															<td class="center" width="10%">
																订单号
															</td>
															<td class="center" width="15%">
																公司货号
															</td>
															<td class="center" width="10%">
																客户
															</td>
															<td class="center" width="15%">
																品名
															</td>
														</tr>
														<tr>
															<td class="center">
																<select disabled class="form-control require"
																	name="companyId" id="companyId" placeholder="公司">
																	<option value="">
																		未选择
																	</option>
																	<%
																		for (Company company : SystemCache.companylist) {
																			if (order.getCompanyId() != null
																					&& company.getId() == order.getCompanyId()) {
																	%>
																	<option value="<%=company.getId()%>" selected><%=company.getFullname()%></option>
																	<%
																		} else {
																	%>
																	<option value="<%=company.getId()%>"><%=company.getFullname()%></option>
																	<%
																		}
																		}
																	%>
																</select>
															</td>
															<td class="center">
																<input readonly type="text" name="orderNumber"
																	id="orderNumber" class="form-control"
																	value="<%=order.getOrderNumber() == null ? "" : order
					.getOrderNumber()%>" />

															</td>
															<td class="center">
																<input readonly type="text" name="company_productNumber"
																	id="company_productNumber" class="form-control"
																	value="<%=order.getCompany_productNumber() == null ? "" : order
					.getCompany_productNumber()%>" />

															</td>
															<td class="center">
																<select class="form-control" name="customerId"
																	id="customerId" disabled formele=true>
																	<option value="">
																		未选择
																	</option>
																	<%
																		for (Customer customer : SystemCache.customerlist) {
																			if (order.getCustomerId() != null
																					&& order.getCustomerId() == customer.getId()) {
																	%>
																	<option value="<%=customer.getId()%>" selected><%=customer.getName()%></option>
																	<%
																		} else {
																	%>
																	<option value="<%=customer.getId()%>"><%=customer.getName()%></option>
																	<%
																		}
																		}
																	%>
																</select>
															</td>
															<td class="center">
																<input readonly type="text" name="name" id="name"
																	class="form-control"
																	value="<%=order.getName() == null ? "" : order.getName()%>" />
															</td>
														</tr>
													</table>
												</td>
											</tr>

										</tbody>
									</table>

									<table id="mainTb"
										class="table table-responsive table-bordered detailTb">
										<caption>
											<button type="button"
												class="btn btn-primary addRow pull-left">
												添加一行
											</button>
											材料列表
										</caption>
										<thead>
											<tr>
												<th width="15%">
													材料品种
												</th>
												<th width="15%">
													数量(kg)
												</th>
												<th width="15%">
													库位容量
												</th>
												<th width="30%">
													备注
												</th>
												<th width="15%">
													操作
												</th>
											</tr>
										</thead>
										<tbody>

										</tbody>

									</table>

									<div id="tip" class="auto_bottom">
										<div>
											说明：1.此单说明了本次采购的相关内容，请充分阅读并理解，如有疑问及时联系我方
										</div>
										<div class="tip_line">
											2.材料品质及颜色要确保准确，颜色色牢度须达到4级以上。
										</div>
										<div class="tip_line">
											3.不得含有偶氮、PCP、甲醛、APEO。不得有特殊气味，无致敏致癌物质。
										</div>
										<div class="tip_line">
											4.贵单位须妥善保管此单据，结账时须提供此单据
										</div>

									</div>

									<p class="pull-right auto_bottom">
										<span id="created_user">制单人：<%=SystemCache.getUserName(SystemContextUtils
							.getCurrentUser(session).getLoginedUser().getId())%></span>
										<span id="receiver_user">收货人：</span>
										<span id="date"> 日期：<%=DateTool.formatDateYMD(DateTool.now())%></span>
									</p>

									</table>

								</div>
							</form>
						</div>
					</div>
					
<!--
						 添加编辑辅料采购单对话框 -->
					<div class="modal fade tableRowDialog" id="fuliaopurchaseDialog">
						<div class="modal-dialog">
							<div class="modal-content">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal">
										<span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
									</button>
									<h4 class="modal-title">
										添加一行
									</h4>
								</div>
								<div class="modal-body">
									<form class="form-horizontal rowform" role="form">
										<div class="form-group col-md-12">
											<label for="style" class="col-sm-3 control-label">
												辅料类型
											</label>
											<div class="col-sm-8">
												<select name="style" id="style" class="form-control require">
													<option value="">
														未选择
													</option>
													<%
														for (FuliaoType fuliaoType : SystemCache.fuliaotypelist) {
													%>
													<option value="<%=fuliaoType.getId()%>"><%=fuliaoType.getName()%></option>
													<%
														}
													%>
												</select>
											</div>
											<div class="col-sm-1"></div>
										</div>
										<div class="form-group col-md-12">
											<label for="quantity" class="col-sm-3 control-label">
												数量(kg)
											</label>
											<div class="col-sm-8">
												<input type="text" name="quantity" id="quantity"
													class="form-control double require" />
											</div>
											<div class="col-sm-1"></div>
										</div>
										<div class="form-group col-md-12">
											<label for="location_size" class="col-sm-3 control-label">
												库位容量
											</label>
											<div class="col-sm-8">
														<input type="radio" name="location_size" id="location_size_3" value="3"/><span class="location_size">大</span>
														<input type="radio" name="location_size" id="location_size_2" value="2"/><span class="location_size">中</span>
														<input type="radio" name="location_size" id="location_size_1" value="1" checked/><span class="location_size">小</span>
													</div>
											<div class="col-sm-1"></div>
										</div>
										<div class="form-group col-md-12">
											<label for="memo" class="col-sm-3 control-label">
												备注
											</label>
											<div class="col-sm-8">
												<input type="text" name="memo" id="memo"
													class="form-control" />
											</div>
											<div class="col-sm-1"></div>
										</div>

										<div class="modal-footer">
											<button type="submit" class="btn btn-primary"
												data-loading-text="正在保存...">
												保存
											</button>
											<button type="button" class="btn btn-default"
												data-dismiss="modal">
												关闭
											</button>
										</div>
									</form>
								</div>

							</div>
						</div>
					</div>
					<!-- 添加编辑辅料采购单对话框 -->

				</div>
			</div>
		</div>
	</body>
</html>