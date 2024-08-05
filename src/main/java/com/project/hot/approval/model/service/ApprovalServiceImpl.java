package com.project.hot.approval.model.service;

import java.io.File;
import java.text.SimpleDateFormat;
import java.time.Duration;
import java.time.LocalDateTime;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.project.hot.approval.model.dao.ApprovalDao;
import com.project.hot.approval.model.dto.Approval;
import com.project.hot.approval.model.dto.CommutingTimeForm;
import com.project.hot.approval.model.dto.OvertimeForm;
import com.project.hot.approval.model.dto.RequestApproval;
import com.project.hot.approval.model.dto.RequestBusinessTrip;
import com.project.hot.approval.model.dto.RequestExpenditure;
import com.project.hot.approval.model.dto.ResponseApprovalsCount;
import com.project.hot.approval.model.dto.ResponseSpecificApproval;
import com.project.hot.approval.model.dto.VacationForm;
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
		int approvalType = (Integer)(param.get("approvalType"));
		//각 결재문서 카운트
		ResponseApprovalsCount rac=new ResponseApprovalsCount();
		rac.setWaitCount(dao.selectApprovalWaitCount(session, (int)param.get("no")));
		rac.setProcessCount(dao.selectApprovalProcessCount(session, (int)param.get("no")));
		rac.setPendingCount(dao.selectApprovalPendingCount(session, (int)param.get("no")));
		rac.setCompleteCount(dao.selectApprovalCompleteCount(session, (int)param.get("no")));
		result.put("rac", rac);

		//결재 문서 리스트 가져오기
		switch(approvalType) {
			case 10:	// 전체 문서
				result.put("totalPage", Math.ceil((double)dao.selectApprovalAllCount(session, (int)param.get("no"))/5));
				result.put("approvals", dao.selectApprovalAllList(session, param));
			break;
			case 1:	// 대기 문서
				result.put("totalPage", Math.ceil((double)rac.getWaitCount()/5));
				result.put("approvals", dao.selectApprovalWaitList(session, param));
			break;
			case 3:	// 예정 문서
				result.put("totalPage", Math.ceil((double)rac.getProcessCount()/5));
				result.put("approvals", dao.selectApprovalPendingList(session, param));
			break;
			case 2:	// 진행 문서
				result.put("totalPage", Math.ceil((double)rac.getPendingCount()/5));
				result.put("approvals", dao.selectApprovalProcessList(session, param));
			break;
			case 4:	// 완료 문서
				result.put("totalPage", Math.ceil((double)rac.getCompleteCount()/5));
				result.put("approvals", dao.selectApprovalCompleteList(session, param));
			break;
		}


		return result;
	}


	@Transactional(rollbackFor = Exception.class)
	@Override
	public String insertApproval(Map<String, Object> param) {
		//결재문서 고유번호 생성
		RequestApproval ra=(RequestApproval)param.get("ra");
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MMdd");
		int type=((RequestApproval)param.get("ra")).getType();
		String appNo=type+"-"+sdf.format(ra.getApprovalDate())+"-"; // 1-yyyy-MMdd-
		ra.setApprovalNo(appNo);
		param.put("ra", ra);

		//참조자, 수신자 no 문자열로 변경
		if(ra.getRefererNo()!=null) {
			int[] referers=ra.getRefererNo();
			String strReferers=Arrays.stream(referers).mapToObj(String::valueOf).collect(Collectors.joining(","));
			param.put("refererNo", strReferers);
		}
		if(ra.getReceiverNo()!=null) {
			int[] receivers=ra.getReceiverNo();
			String strReceivers=Arrays.stream(receivers).mapToObj(String::valueOf).collect(Collectors.joining(","));
			param.put("receiverNo", strReceivers);
		}

		//첨부파일 저장
		String rename = "";
		String oriname = "";
		String path=(String)param.get("path"); //저장 경로
		if(!((MultipartFile[])param.get("upFile"))[0].getOriginalFilename().isEmpty()) {
			File dir=new File(path);
			if(!dir.exists()) dir.mkdirs(); //폴더 없으면 생성

			for(MultipartFile mf:(MultipartFile[])param.get("upFile")) {
				String oriFilename=mf.getOriginalFilename(); //원본 이름
				String ext=oriFilename.substring(oriFilename.lastIndexOf(".")); //확장자
				String reFilename=LocalDateTime.now().toLocalDate().toString()+"_"+(int)(Math.random()*10000000)+ext; // 변경 이름

				//파일 저장
				try {
					mf.transferTo(new File(path, reFilename));
					rename=rename.isEmpty()?reFilename:String.join(",", rename, reFilename);
					oriname=oriname.isEmpty()?oriFilename:String.join(",", oriname, oriFilename);
				}catch(Exception e) {
					//파일 저장 실패
					cleanUploadFile(rename, path);
					e.printStackTrace();
					return null;
				}
			}
		}
		param.put("rename", rename);
		param.put("oriname", oriname);
		param.put("newApprovalNo", "");

		//결재문서 결재자 참조, 수신처 저장
		String newApprovalNo=dao.insertApproval(session, param);
		if(newApprovalNo==null || newApprovalNo.isEmpty()) {
			cleanUploadFile(rename, path);
			throw new ApprovalException("결재문서 insert 실패");
		}

		return newApprovalNo;
	}

	public void cleanUploadFile(String rename, String path) {
		for(String s: rename.split(rename)) {
			File f=new File(path, s);
			f.delete();
		}
	}

	@Override
	public int insertVacation(VacationForm vf) {
		return dao.insertVacation(session, vf);
	}


	@Override
	public int insertCommuting(CommutingTimeForm ctf) {
		return dao.insertCommuting(session, ctf);
	}


	@Override
	public int insertOvertime(OvertimeForm of) {
		//몇시간 근무 했는지 계산
		if(of.getOvertimeStartTime()!=null && of.getOvertimeEndTime()!=null) {
			Duration d=Duration.between(of.getOvertimeStartTime(), of.getOvertimeEndTime());
			of.setOvertimeHours((int)d.toMinutes()/60);
		}
		return dao.insertOvertime(session, of);
	}

	@Transactional(rollbackFor = Exception.class)
	@Override
	public int insertBusinessTrip(RequestBusinessTrip rbt) {
		int result=dao.insertBusinessTrip(session, rbt);
		if(rbt.getPartnerNo()!=null) {
			return dao.insertBusinessPartner(session, rbt);
		}else {
			return result;
		}

	}

	@Transactional(rollbackFor = Exception.class)
	@Override
	public int insertExpenditure(RequestExpenditure re) {
		int result=dao.insertExpenditureForm(session, re);

		if(re.getItems().stream().anyMatch(e->e.isEmpty()==false)) {
			return dao.insertExpenditureItem(session, re);
		}else {
			return result;
		}
	}

	@Override
	public List<ResponseSpecificApproval> getSpecificApproval(String targetNo) {

		return dao.getSpecificApproval(session, targetNo);
	}


	@Transactional(rollbackFor = Exception.class)
	@Override
	public int updateApprovalStatus(Map<String, Object> param) {
		int status=Integer.valueOf((String)param.get("approverStatus"));
		int level=(int)param.get("level");
		if(status == 3 || (level == 2 && status == 1)) {
			//전결, 마지막 결재자의 승인 시 결재문서 상태 완료
			param.put("approvalStatus", 3);
		}else if(status == 2) {
			//반려면 결재문서 상태 반려
			param.put("approvalStatus", 4);
		}else {
			//결재문서 상태 진행
			param.put("approvalStatus", 2);
		}
		try {
			dao.updateApprover(session, param);
			dao.updateApprovalStatus(session, param);
			return 1;
		}catch(Exception e) {
			return 0;
		}
	}

	@Override
	public List<ResponseSpecificApproval> getMyApproval(int employeeNo) {
		return dao.getMyApproval(session, employeeNo);
	}


	@Override
	public List<ResponseSpecificApproval> getReceivedApproval(int employeeNo) {
		return dao.getReceivedApproval(session, employeeNo);
	}


	@Override
	public List<ResponseSpecificApproval> getReferenceDocuments(int employeeNo) {
		return dao.getReferenceDocuments(session, employeeNo);
	}


	@Override
	public List<ResponseSpecificApproval> getDocumentsByPosition(Map<String, Integer> param) {
		return dao.getDocumentsByPosition(session, param);
	}


	@Override
	public List<ResponseSpecificApproval> getTempDocuments(int employeeNo) {
		return dao.getTempDocuments(session, employeeNo);
	}


	@Override
	public int deleteApproval(String approvalNo) {
		Map<String, Object> param=new HashMap<>();
		param.put("approvalNo", approvalNo);
		param.put("result", 0);
		return dao.deleteApproval(session, param);
	}


}
