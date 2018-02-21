package com.sicc.console.enums;

public enum CommonEnums {
	DEFAULT_CREATE_DATA_USER 	("DEFAULT_CREATE_DATA_USER", 	"ADMIN"		),
	DEFAULT_UPDATE_DATA_USER 	("DEFAULT_UPDATE_DATA_USER", 	"ADMIN"		),
	DEFAULT_LENGTH_FOR_ZERO 	("DEFAULT_LENGTH_FOR_ZERO", 	"6"			),
	ONLY_YEAR_FORMAT 			("ONLY_YEAR_FORMAT", 			"YYYY"  	),
	SLASH_MARK 					("SLASH_MARK", 					"/"  		),
	DASH_MARK 					("DASH_MARK", 					"-"  		),
	CP_SCALE_CD 				("CP_SCALE_CD", 			"CP_SCALE_CD"  	),
	CONT_STAT_CD				("CONT_STAT_CD", 			"CONT_STAT_CD"  ),
	NETWORK_FG_CD				("NETWORK_FG_CD", 			"NETWORK_FG_CD" ),
	PASSWORD_LOD_CD				("PASSWORD_LOD_CD", 		"PASSWORD_LOD_CD"),
	RNWL_CYCL_CD				("RNWL_CYCL_CD", 			"RNWL_CYCL_CD"  ),
	CP_TYPE_CD 					("CP_TYPE_CD", 				"CP_TYPE_CD"  	),
	SERVICE_CD 					("SERVICE_CD", 				"SERVICE_CD"  	),
	LANG_CD 					("LANG_CD", 				"LANG_CD"  	),
	GMS_SYSTEM_CD 				("GMS_SYSTEM_CD", 			"GMS_SYSTEM_CD"  	),
	USE_CD 						("Y", 						"사용"  	),
	NUSE_CD 					("N", 						"미사용"  	);
	
	
	private String code; 
	private String value;
	 
	private CommonEnums (String code, String value) { 
		this.code = code;
		this.value = value;
	}

	public String getCode() {
		return code;
	}

	public String getValue() {
		return value;
	}
	
	
}
