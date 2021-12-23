package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import dao.mapper.ItemMapper;
import logic.Item;

@Repository
public class ItemDao {
	@Autowired
	private SqlSessionTemplate template;
	private Map<String, Object> param = new HashMap<String, Object>();
	
	public int maxNo() {
		return template.getMapper(ItemMapper.class).maxNo();
	}

	public void insert(Item item) {
		template.getMapper(ItemMapper.class).insert(item);
	}

	public List<Item> list(String itype, String userpick) {
		param.clear();
		param.put("itype", itype);
		param.put("userpick", userpick);
		return template.getMapper(ItemMapper.class).select(param);
	}

	public Item selectOne(Integer itemid) {
		param.clear();
		param.put("itemid", itemid);
		return template.getMapper(ItemMapper.class).selectOne(param).get(0);
	}

	public void update(Item item) {
		template.getMapper(ItemMapper.class).update(item);
	}

	public void delete(String id) {
		template.getMapper(ItemMapper.class).delete(id);
	}

	public Integer getStock(Integer itemid) {
		param.clear();
		param.put("itemid", itemid);
		return template.getMapper(ItemMapper.class).getStock(param);
	}

	public void reStock(int itemid, int i) {
		param.clear();
		param.put("itemid", itemid);
		param.put("stock", i);
		template.getMapper(ItemMapper.class).reStock(param);
	}
}
