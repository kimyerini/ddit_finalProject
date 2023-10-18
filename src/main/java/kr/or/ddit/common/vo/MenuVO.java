package kr.or.ddit.common.vo;


import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString

public class MenuVO {
	private String menuId;
	private String upperMenuId;
	private String menuSe;
	private int menuOrd;
	private String menuName;
	private String menuDscrp;
	private String menuUrl;
	private String useYn;
	private String authGrpCode;
	private String readYn;
	private String writeYn;
	private String switchYn;
}
