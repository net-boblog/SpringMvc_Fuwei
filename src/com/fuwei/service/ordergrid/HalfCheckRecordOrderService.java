package com.fuwei.service.ordergrid;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.fuwei.entity.ordergrid.HalfCheckRecordOrder;
//import com.fuwei.entity.ProducingOrderMaterialDetail;
import com.fuwei.service.BaseService;
import com.fuwei.util.SerializeTool;

@Component
public class HalfCheckRecordOrderService extends BaseService {
	private Logger log = org.apache.log4j.LogManager
			.getLogger(HalfCheckRecordOrderService.class);
	@Autowired
	JdbcTemplate jdbc;

	// 添加半检记录单
	@Transactional
	public int add(HalfCheckRecordOrder halfCheckRecordOrder) throws Exception {
		try {
			// if (halfCheckRecordOrder.getDetaillist() == null
			// || halfCheckRecordOrder.getDetaillist().size() <= 0) {
			// throw new Exception("半检记录单中至少得有一条颜色及数量详情记录");
			// } else {
			if (halfCheckRecordOrder.getDetail_2_list() == null
					|| halfCheckRecordOrder.getDetail_2_list().size() <= 0) {
				throw new Exception("半检记录单中至少得有一条生产材料信息记录");
			} else {
				halfCheckRecordOrder.setStatus(0);
				halfCheckRecordOrder.setState("新建");
				// halfCheckRecordOrder.setDetail_json(SerializeTool
				// .serialize(halfCheckRecordOrder.getDetaillist()));
				halfCheckRecordOrder.setDetail_2_json(SerializeTool
						.serialize(halfCheckRecordOrder.getDetail_2_list()));

				Integer tableOrderId = this.insert(halfCheckRecordOrder);

				halfCheckRecordOrder.setId(tableOrderId);

				return tableOrderId;
			}
			// }
		} catch (Exception e) {

			throw e;
		}
	}

	// 编辑半检记录单
	@Transactional
	public int update(HalfCheckRecordOrder halfCheckRecordOrder)
			throws Exception {
		try {
			// if (halfCheckRecordOrder.getDetaillist() == null
			// || halfCheckRecordOrder.getDetaillist().size() <= 0) {
			// throw new Exception("半检记录单中至少得有一条颜色及数量详情记录");
			// } else {
			if (halfCheckRecordOrder.getDetail_2_list() == null
					|| halfCheckRecordOrder.getDetail_2_list().size() <= 0) {
				throw new Exception("半检记录单中至少得有一条生产材料信息记录");
			} else {
				HalfCheckRecordOrder temp = this.get(halfCheckRecordOrder.getId());
				if (!temp.isEdit()) {
					throw new Exception("单据已执行完成，或已被取消，无法编辑 ");
				}
				// String details = SerializeTool.serialize(halfCheckRecordOrder
				// .getDetaillist());
				// halfCheckRecordOrder.setDetail_json(details);

				halfCheckRecordOrder.setDetail_2_json(SerializeTool
						.serialize(halfCheckRecordOrder.getDetail_2_list()));

				// 更新表
				this.update(halfCheckRecordOrder, "id",
						"created_user,created_at,orderId", true);

				return halfCheckRecordOrder.getId();
			}
			// }
		} catch (Exception e) {
			throw e;
		}

	}

	// 获取半检记录单
	public HalfCheckRecordOrder getByOrder(int orderId) throws Exception {
		try {
			HalfCheckRecordOrder order = dao.queryForBean(
					"select * from tb_halfcheckrecordorder where orderId = ?",
					HalfCheckRecordOrder.class, orderId);
			return order;
		} catch (Exception e) {
			throw e;
		}
	}

	// 获取半检记录单
	public HalfCheckRecordOrder get(int id) throws Exception {
		try {
			HalfCheckRecordOrder order = dao.queryForBean(
					"select * from tb_halfcheckrecordorder where id = ?",
					HalfCheckRecordOrder.class, id);
			return order;
		} catch (Exception e) {
			throw e;
		}
	}

	@Transactional
	public int completeByOrder(int orderId) throws Exception {
		try {
			return dao
					.update(
							"UPDATE tb_halfcheckrecordorder SET status=?,state=? WHERE orderId = ?",
							6, "执行完成", orderId);
		} catch (Exception e) {
			throw e;
		}
	}

	@Transactional
	public int updateStatus(int tableOrderId, int status, String state)
			throws Exception {
		try {
			return dao
					.update(
							"UPDATE tb_halfcheckrecordorder SET status=?,state=? WHERE id = ?",
							status, state, tableOrderId);
		} catch (Exception e) {
			throw e;
		}
	}

}
