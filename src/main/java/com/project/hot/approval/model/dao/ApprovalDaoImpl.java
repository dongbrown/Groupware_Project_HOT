package com.project.hot.approval.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.project.hot.approval.model.dto.Approval;
import com.project.hot.approval.model.dto.CommutingTimeForm;
import com.project.hot.approval.model.dto.OvertimeForm;
import com.project.hot.approval.model.dto.RequestBusinessTrip;
import com.project.hot.approval.model.dto.RequestExpenditure;
import com.project.hot.approval.model.dto.ResponseSpecificApproval;
import com.project.hot.approval.model.dto.VacationForm;
import com.project.hot.employee.model.dto.Department;
import com.project.hot.employee.model.dto.Employee;

@Repository
public class ApprovalDaoImpl implements ApprovalDao {

    @Override
    public List<Approval> AllDocuments(SqlSession session) {
        return session.selectList("approval.approvalAll");
    }

    @Override
    public List<Employee> getEmployeesByDepartment(SqlSession session, String departmentCode) {
        return session.selectList("approval.getEmployeesByDepartment", departmentCode);
    }

    @Override
    public List<Department> selectDepartmentList(SqlSession session) {
        return session.selectList("approval.selectDepartmentList");
    }

	@Override
	public int selectApprovalWaitCount(SqlSession session, int no) {
		return session.selectOne("approval.selectApprovalWaitCount", no);
	}

	@Override
	public int selectApprovalProcessCount(SqlSession session, int no) {
		return session.selectOne("approval.selectApprovalProcessCount", no);
	}

	@Override
	public int selectApprovalPendingCount(SqlSession session, int no) {
		return session.selectOne("approval.selectApprovalPendingCount", no);
	}

	@Override
	public int selectApprovalCompleteCount(SqlSession session, int no) {
		return session.selectOne("approval.selectApprovalCompleteCount", no);
	}

	@Override
	public List<Approval> selectApprovalAllList(SqlSession session, Map<String, Object> param) {
		return session.selectList("approval.selectApprovalAllList", param,
				new RowBounds(((int)param.get("cPage")-1)*(int)param.get("numPerpage"), (int)param.get("numPerpage")));
	}

	@Override
	public int selectApprovalAllCount(SqlSession session, int no) {
		return session.selectOne("approval.selectApprovalAllCount", no);
	}

	@Override
	public String insertApproval(SqlSession session, Map<String, Object> param) {
		session.selectOne("approval.insertApprovalProcedure", param);
		return (String)param.get("newApprovalNo");
	}

	@Override
	public int insertVacation(SqlSession session, VacationForm vf) {
		return session.insert("approval.insertVacation", vf);
	}

	@Override
	public int insertCommuting(SqlSession session, CommutingTimeForm ctf) {
		return session.insert("approval.insertCommuting", ctf);
	}

	@Override
	public int insertOvertime(SqlSession session, OvertimeForm of) {
		return session.insert("approval.insertOvertime", of);
	}

	@Override
	public int insertBusinessTrip(SqlSession session, RequestBusinessTrip rbt) {
		return session.insert("approval.insertBusinessTrip", rbt);
	}

	@Override
	public int insertBusinessPartner(SqlSession session, RequestBusinessTrip rbt) {
		return session.insert("approval.insertBusinessPartner", rbt);
	}

	@Override
	public int insertExpenditureForm(SqlSession session, RequestExpenditure re) {
		return session.insert("approval.insertExpenditureForm", re);
	}

	@Override
	public int insertExpenditureItem(SqlSession session, RequestExpenditure re) {
		return session.insert("approval.insertExpenditureItem", re);
	}

	@Override
	public List<Approval> selectApprovalWaitList(SqlSession session, Map<String, Object> param) {
		return session.selectList("approval.selectApprovalWaitList", param,
				new RowBounds(((int)param.get("cPage")-1)*(int)param.get("numPerpage"), (int)param.get("numPerpage")));
	}

	@Override
	public List<Approval> selectApprovalCompleteList(SqlSession session, Map<String, Object> param) {
		return session.selectList("approval.selectApprovalCompleteList", param,
				new RowBounds(((int)param.get("cPage")-1)*(int)param.get("numPerpage"), (int)param.get("numPerpage")));
	}

	@Override
	public List<Approval> selectApprovalProcessList(SqlSession session, Map<String, Object> param) {
		return session.selectList("approval.selectApprovalProcessList", param,
				new RowBounds(((int)param.get("cPage")-1)*(int)param.get("numPerpage"), (int)param.get("numPerpage")));
	}

	@Override
	public List<Approval> selectApprovalPendingList(SqlSession session, Map<String, Object> param) {
		return session.selectList("approval.selectApprovalPendingList", param,
				new RowBounds(((int)param.get("cPage")-1)*(int)param.get("numPerpage"), (int)param.get("numPerpage")));
	}

	@Override
	public List<ResponseSpecificApproval> getSpecificApproval(SqlSession session, String targetNo) {
		String no = targetNo.substring(0, 1);
		Map<String, String> param = new HashMap<>();
		param.put("no", no);
		param.put("targetNo", targetNo);
		System.out.println("no : " + no);
		System.out.println("ㅋㅋ");
		List<ResponseSpecificApproval> result = session.selectList("approval.getSpecificApproval", param);
		return session.selectList("approval.getSpecificApproval", param);
	}

}