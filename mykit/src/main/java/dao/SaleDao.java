package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import dao.mapper.SaleMapper;
import logic.Sale;

@Repository
public class SaleDao {
	@Autowired
	private SqlSessionTemplate template; //db연동을 위한 template
	private Map<String, Object> param = new HashMap<String, Object>();
	
	public int getMaxSaleId() {
		return template.getMapper(SaleMapper.class).maxsaleid();
	}
	
	public void insert(Sale sale) {
		template.getMapper(SaleMapper.class).insert(sale);
	}
	
	public List<Sale> list(String userid) {
		return template.getMapper(SaleMapper.class).select(userid);
	}

	public Integer getUserPoint(String userid) {
		return template.getMapper(SaleMapper.class).getUserPoint(userid);
	}

	public void updateUserPoint(String userid, int rpoint) {
		param.clear();
		param.put("userid", userid);
		param.put("rpoint", rpoint);
		template.getMapper(SaleMapper.class).updateUserPoint(param);
	}

	public void saleAmount(long total, int i) {
		param.clear();
		param.put("saleamount", total);
		param.put("saleid", i);
		template.getMapper(SaleMapper.class).saleAmount(param);
	}

	public void pointTouser(String getuserID) {
		template.getMapper(SaleMapper.class).pointTouser(getuserID);
	}

	//레시피보드 포인트 추가 2개.
	public int selectRpoint(String recipeuserid) {
		return template.getMapper(SaleMapper.class).selectRpoint(recipeuserid);
	}

	public void addRcpoint(int totalPoint, String recipeuserid) {
		param.clear();
		param.put("rpoint", totalPoint);
		param.put("userid", recipeuserid);
		template.getMapper(SaleMapper.class).addRcpoint(param);
	}
}
