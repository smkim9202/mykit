package logic;

import java.util.ArrayList;
import java.util.List;

public class Cart {
	private List<ItemSet> itemSetList = new ArrayList<ItemSet>();
	
	public List<ItemSet> getItemSetList(){
		return itemSetList;
	}
	//장바구니추가
	public void push(ItemSet itemSet) {
		//itemSet: 장바구니에 추가할 상품 정보
		int count = itemSet.getQuantity();
		for(ItemSet old : itemSetList) {
			if(itemSet.getItem().getItemid() == old.getItem().getItemid()) {
				count = old.getQuantity() + itemSet.getQuantity();
				old.setQuantity(count);
				return;
			}
		}
		itemSetList.add(itemSet);
	}
	//총 금액
	public long getTotal() {
		long sum = 0;
		for(ItemSet is : itemSetList) {
			sum += is.getQuantity() * is.getItem().getPrice();
		}
		return sum;
	}
}
