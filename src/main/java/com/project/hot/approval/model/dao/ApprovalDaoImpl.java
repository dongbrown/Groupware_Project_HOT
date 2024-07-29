package com.project.hot.approval.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.project.hot.approval.model.dto.Approval;
import com.project.hot.approval.model.dto.RequestApproval;
import com.project.hot.employee.model.dto.Department;
import com.project.hot.employee.model.dto.Employee;

import lombok.RequiredArgsConstructor;

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
	public int insertApproval(SqlSession session, RequestApproval ra) {
		return 0;
	}



}