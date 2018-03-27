package com.sicc.console.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.sicc.console.common.ExportDataToFile;
import com.sicc.console.service.ContractService;
import com.sicc.console.service.FileDownService;

@Controller
public class FileController {

	@Autowired
	SqlSessionFactory sqlSessionFactory;
	
	@Autowired 
	FileDownService fileDownService;
	
	@Autowired 
	ContractService contractService;
	
	@GetMapping("/fileDownload")
    public String fildDownload(Model model) {

    	List<String> tenantList = fileDownService.selTenantList();
    	
    	model.addAttribute("tenantList",tenantList);

    	return "/file/fileDownload";
    }


    @PostMapping("/exportQuery")
    public String exportQuery (HttpServletRequest req, 
			HttpServletResponse res,
			@RequestParam("tenantId") String tenantId,
			Model model) {

    	Connection con = sqlSessionFactory.openSession().getConnection();
    	ExportDataToFile ef = new ExportDataToFile();
    	
    	String fileDir = "C:/exportTemp/";
    	String result = "";
    	
    	String selQuery[] = {
    	"SELECT cust.cust_id, cust.cust_nm, cust.rep_fax_no, cust.rep_tel_no, cust.corp_ad_no, cust.mgr_nm, cust.mgr_email_addr, cust.mgr_tel_no, cust.crt_id, cust.crt_ip, cust.ad_date, cust.udt_id, cust.udt_ip, cust.udt_date FROM con.concustcontm cont INNER JOIN con.concustm cust ON cont.cust_id = cust.cust_id WHERE cont.tenant_id = '"+tenantId+"';",
    	"SELECT tenant_id, cust_id, cont_nm, valid_start_dt, valid_end_dt, cont_stat_cd, network_fg_cd, password_lod_cd, password_min_len, password_rnwl_cycl_cd, password_use_lmt_yn, password_pose_yn, crt_id, crt_ip, ad_date, udt_id, udt_ip, udt_date  FROM con.concustcontm WHERE tenant_id = '"+tenantId+"';",
    	"SELECT tenant_id, cp_cd, cp_nm, cp_start_dt, cp_end_dt, cp_place_nm, cp_scale_cd, cp_type_cd, expect_user_num, crt_id, crt_ip, ad_date, udt_id, udt_ip, udt_date FROM con.concpm WHERE tenant_id = '"+tenantId+"';",
    	"SELECT tenant_id, cp_cd, img_fg_cd, img_seq, file_path_nm, img_file_nm, rep_img_yn, crt_id, crt_ip, ad_date, udt_id, udt_ip, udt_date, source_img_file_nm FROM con.concpimgm WHERE tenant_id = '"	+tenantId+ "';",	
    	"SELECT tenant_id, cp_cd, service_cd, service_start_dt, service_end_dt, service_url_addr, rep_color_value, fst_lang_cd, scnd_lang_cd, thrd_lang_cd, foth_lang_cd, fith_lang_cd, test_lab_use_yn, test_lab_remark_desc, test_event_add_yn, test_event_remark_desc, crt_id, crt_ip, ad_date, udt_id, udt_ip, udt_date FROM con.concpservicem WHERE tenant_id = '"+tenantId+"';",
    	"SELECT tenant_id, cp_cd, service_cd, system_cd, service_start_dt, service_end_dt, service_url_addr, crt_id, crt_ip, ad_date, udt_id, udt_ip, udt_date FROM con.concpserviced WHERE tenant_id = '"	+tenantId+ "';",
    	"SELECT tenant_id, montrn_fg_cd, montrn_url_addr, crt_id, crt_ip, ad_date, udt_id, udt_ip, udt_date FROM con.concustcontmontrnm WHERE tenant_id = '"	+tenantId+ "';",
    	"SELECT cd_group_id, cd_group_nm, use_yn, crt_id, crt_ip, ad_date, udt_id, udt_ip, udt_date FROM con.concdm; ",
    	"SELECT cd_group_id, cd_id, cd_nm, sort_ord, use_yn, crt_id, crt_ip, ad_date, udt_id, udt_ip, udt_date FROM con.concdd;",
    	"SELECT admin_id, admin_nm, admin_priv_cd, email_addr, password, crt_id, crt_ip, ad_date, udt_id, udt_ip, udt_date FROM con.conadminm WHERE admin_id='admin';"
    	};
    	
		String tables[] = {"concustm","concustcontm","concpm","concpimgm","concpservicem","concpserviced","concustcontmontrnm", "concdm", "concdd", "conadminm"};
		
		result = ef.getQueryDataString(con, selQuery, tables, tenantId, fileDir);
		
		model.addAttribute("fileDir", fileDir);
		model.addAttribute("result", result);
		
        return "jsonView";
    	
    }
    
    @ResponseBody
    @PostMapping("/executeQuery")
   // @Transactional(rollbackFor=Exception.class)
    public String executeQuery (@RequestPart MultipartFile scriptFile,
    		HttpServletRequest req, HttpServletResponse res) {
    	Connection con = null;
    	PreparedStatement ps = null;
    	ExportDataToFile ef = new ExportDataToFile();
    	String result = "";

		try {
			con = sqlSessionFactory.openSession().getConnection();
			List<String> insertQueryList = ef.fileReader(scriptFile.getInputStream());
			
			for(String query : insertQueryList) {
				ps = con.prepareStatement(query);
				System.out.println("query --->"+query);
				
				ps.executeUpdate();
			}
			
			result = "1";
			
		} catch (SQLException e) {
			result =e.getMessage();
			e.printStackTrace();
		} catch (IOException e) {
			result =e.getMessage();
			e.printStackTrace();
		} finally {
			System.out.println("result -->"+result);
	  		if(ps != null) try { ps.close();} catch(SQLException e) {}
	  		if(con != null) try { con.close();} catch(SQLException e) {}
		}
		
        return result;
    }

	
}
