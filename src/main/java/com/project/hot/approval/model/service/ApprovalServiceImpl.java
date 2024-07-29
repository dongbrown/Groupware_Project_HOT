package com.project.hot.approval.model.service;

import java.io.File;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.project.hot.approval.model.dao.ApprovalDao;
import com.project.hot.approval.model.dto.Approval;
import com.project.hot.approval.model.dto.RequestApproval;
import com.project.hot.approval.model.dto.ResponseApprovalsCount;
import com.project.hot.common.exception.ApprovalException;
import com.project.hot.employee.model.dto.Department;
import com.project.hot.employee.model.dto.Employee;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ApprovalServiceImpl implements ApprovalService {


    private final ApprovalDao dao;
    private final SqlSession session;

    @Override
    public List<Approval> getAllDocuments() {
        return dao.AllDocuments(session);
    }


    @Override
    public List<Employee> getEmployeesByDepartment(String departmentCode) {
        return dao.getEmployeesByDepartment(session, departmentCode);
    }

    @Override
    public List<Department> selectDepartmentList() {
        return dao.selectDepartmentList(session);
    }


	@Override
	public Map<String, Object> getApprovalsCountAndList(Map<String, Object> param) {
		Map<String, Object> result=new HashMap<>();

		//각 결재문서 카운트
		ResponseApprovalsCount rac=new ResponseApprovalsCount();
		rac.setWaitCount(dao.selectApprovalWaitCount(session, (int)param.get("no")));
		rac.setProcessCount(dao.selectApprovalProcessCount(session, (int)param.get("no")));
		rac.setPendingCount(dao.selectApprovalPendingCount(session, (int)param.get("no")));
		rac.setCompleteCount(dao.selectApprovalCompleteCount(session, (int)param.get("no")));
		result.put("rac", rac);

		//결재 문서 리스트 가져오기
		result.put("totalPage", Math.ceil((double)dao.selectApprovalCompleteCount(session, (int)param.get("no"))/10));
		result.put("approvals", dao.selectApprovalAllList(session, param));
		return result;
	}


	@Transactional
	@Override
	public int insertVacation(Map<String, Object> param) {
		//결재문서 저장
		int resultA=dao.insertApproval(session, (RequestApproval)param.get("ra"));
		if(!(resultA>0)) {
			throw new ApprovalException("결재문서 insert 실패");
		}
		//결재자 저장
		
		//참조, 수신처 저장
		
		//휴가신청서 저장
		
		//첨부파일 저장
		MultipartFile[] upFile=(MultipartFile[])param.get("upFile");
		if(upFile.length>0) {
			String path=(String)param.get("path"); //저장 경로
			File dir=new File(path);
			if(!dir.exists()) dir.mkdirs(); //폴더 없으면 생성
			for(MultipartFile mf:upFile) {
				String oriname=mf.getOriginalFilename(); //원본 이름
				String ext=oriname.substring(oriname.lastIndexOf(".")); //확장자
				String rename=LocalDateTime.now().toLocalDate().toString()+"_"+(int)(Math.random()*10000000)+ext; // 변경 이름
				
				//파일 저장
				try {
					mf.transferTo(new File(path, rename));
					
				}catch(Exception e) {
					//파일 저장 실패
					e.printStackTrace();
					return 0;
				}
			}
		}
		return 0;
	}

}
