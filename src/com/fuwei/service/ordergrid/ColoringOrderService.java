package com.fuwei.service.ordergrid;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.fuwei.commons.Pager;
import com.fuwei.commons.Sort;
import com.fuwei.entity.ordergrid.ColoringOrder;
import com.fuwei.service.BaseService;
import com.fuwei.util.DateTool;
import com.fuwei.util.SerializeTool;

@Component
public class ColoringOrderService extends BaseService {
	private Logger log = org.apache.log4j.LogManager
			.getLogger(ColoringOrderService.class);
	@Autowired
	JdbcTemplate jdbc;

	// 添加染色单
	@Transactional
	public int add(ColoringOrder tableOrder) throws Exception {
		try {
			if (tableOrder.getDetaillist() == null
					|| tableOrder.getDetaillist().size() <= 0) {
				throw new Exception("染色单中至少得有一条染色记录");
			} else {
				tableOrder.setDetail_json(SerializeTool
							.serialize(tableOrder.getDetaillist()));

					Integer tableOrderId = this.insert(tableOrder);

					tableOrder.setId(tableOrderId);

					return tableOrderId;
			}
		} catch (Exception e) {

			throw e;
		}
	}

	// 编辑染色单
	@Transactional
	public int update(ColoringOrder tableOrder) throws Exception {
		try {
			if (tableOrder.getDetaillist() == null
					|| tableOrder.getDetaillist().size() <= 0) {
				throw new Exception("染色单中至少得有一条染色记录");
			} else {
					String details = SerializeTool.serialize(tableOrder
							.getDetaillist());
					tableOrder.setDetail_json(details);

					// 更新表
					this.update(tableOrder, "id",
							"created_user,created_at,orderId", true);

					return tableOrder.getId();
			}
		} catch (Exception e) {
			throw e;
		}

	}

	// 获取染色单
	public List<ColoringOrder> getByOrder(int orderId) throws Exception {
		try {
			List<ColoringOrder> order = dao.queryForBeanList(
					"select * from tb_coloringorder where orderId = ?",
					ColoringOrder.class, orderId);
			return order;
		} catch (Exception e) {
			throw e;
		}
	}

	// 获取染色单
	public ColoringOrder get(int id) throws Exception {
		try {
			ColoringOrder order = dao.queryForBean(
					"select * from tb_coloringorder where id = ?",
					ColoringOrder.class, id);
			return order;
		} catch (Exception e) {
			throw e;
		}
	}
	
	// 获取染色单列表
	public Pager getList(Pager pager, Date start_time, Date end_time, 
			List<Sort> sortlist) throws Exception {
		try {
			StringBuffer sql = new StringBuffer();
			String seq = "WHERE ";
			
			sql.append("select * from tb_coloringorder ");

			if (start_time != null) {
				sql.append(seq + " created_at>='"
						+ DateTool.formateDate(start_time) + "'");
				seq = " AND ";
			}
			if (end_time != null) {
				sql.append(seq + " created_at<='"
						+ DateTool.formateDate(DateTool.addDay(end_time, 1))
						+ "'");
				seq = " AND ";
			}
			
			

			if (sortlist != null && sortlist.size() > 0) {

				for (int i = 0; i < sortlist.size(); ++i) {
					if (i == 0) {
						sql.append(" order by " + sortlist.get(i).getProperty()
								+ " " + sortlist.get(i).getDirection() + " ");
					} else {
						sql.append("," + sortlist.get(i).getProperty() + " "
								+ sortlist.get(i).getDirection() + " ");
					}

				}
			}
			return findPager_T(sql.toString(), ColoringOrder.class, pager);
		} catch (Exception e) {
			throw e;
		}
	}
	
	// 删除染色单
	public int remove(int id) throws Exception {
		try{
			return dao.update("delete from tb_coloringorder WHERE  id = ?", id);
		}catch(Exception e){
			SQLException sqlException = (java.sql.SQLException)e.getCause();
			if(sqlException!=null && sqlException.getErrorCode() == 1451){//外键约束
				log.error(e);
				throw new Exception("已被引用，无法删除，请先删除与染色单有关的引用");
			}
			throw e;
		}
	}


}
