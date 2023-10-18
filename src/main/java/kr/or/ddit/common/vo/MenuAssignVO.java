package kr.or.ddit.common.vo;


import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString

public class MenuAssignVO {
	private String authGrpCode;
	private String menuId;
	private String readYn;
	private String writeYn;
	private String deleteYn;
}
