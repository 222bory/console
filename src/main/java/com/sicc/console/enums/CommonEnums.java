package com.sicc.console.enums;

public enum CommonEnums {
	DEFAULT_CREATE_DATA_USER 	("DEFAULT_CREATE_DATA_USER", 	"ADMIN"		),
	DEFAULT_UPDATE_DATA_USER 	("DEFAULT_UPDATE_DATA_USER", 	"ADMIN"		),
	DEFAULT_LENGTH_FOR_ZERO 	("DEFAULT_LENGTH_FOR_ZERO", 	"6"			),
	ONLY_YEAR_FORMAT 			("ONLY_YEAR_FORMAT", 			"YYYY"  	),
	SLASH_MARK 					("SLASH_MARK", 					"/"  		),
	DASH_MARK 					("DASH_MARK", 					"-"  		),
	
	CP_SCALE_CD 				("CP_SCALE_CD", 			"CP_SCALE_CD"  	),
	CP_TYPE_CD 					("CP_TYPE_CD", 				"CP_TYPE_CD"  	),
	SERVICE_CD 					("SERVICE_CD", 				"SERVICE_CD"  	),
	LANG_CD 					("LANG_CD", 				"LANG_CD"  	);
	
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
