package dao.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import logic.Item;

public interface ItemMapper {
	
	@Select("select nvl(max(itemid), 0) from item")
	int maxNo();

	@Insert("insert into item (itemid, itemname, price, description, itemimg, itemdate, itype, stock, shortdes, rcnum, userpick)"
			+ " values (#{itemid}, #{itemname}, #{price}, #{description}, #{itemimg}, sysdate, #{itype}, "
			+ " #{stock}, #{shortdes}, #{rcnum}, #{userpick})")
	void insert(Item item);

	@Select({"<script>",
		"select * from item ",
		"<trim prefix='where' prefixOverrides='AND || OR'>"
	 +"<if test='userpick != null'> and userpick=#{userpick}</if>"
	 +" <if test='itype != null'> and itype=#{itype}</if></trim> order by itemid desc",
		"</script>"})
	List<Item> select(Map<String, Object> param);

	@Select({"<script>",
	    "select * from item",
	   	"<if test='itemid != null'> where itemid=#{itemid}</if>", 
	   	" order by itemid",
	   	"</script>"})
	List<Item> selectOne(Map<String, Object> param);

	@Update("update item set itemname=#{itemname}, price=#{price}, description=#{description}, "
			   + "itemimg=#{itemimg}, itemdate=sysdate, itype=#{itype}, stock=#{stock}, "
			   + " shortdes=#{shortdes}, rcnum=#{rcnum}, userpick=#{userpick} where itemid=#{itemid}")
	void update(Item item);

	@Delete("delete from item where itemid=#{value}")
	void delete(String id);

	@Select("select stock from item where itemid=#{itemid}")
	Integer getStock(Map<String, Object> param);

	@Update("update item set stock=#{stock} where itemid=#{itemid}")
	void reStock(Map<String, Object> param);
}
