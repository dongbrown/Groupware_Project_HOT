package com.project.hot.employee.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.project.hot.employee.model.dto.Commuting;
import com.project.hot.employee.model.dto.Department;
import com.project.hot.employee.model.dto.Employee;
import com.project.hot.employee.model.dto.RequestEmployee;

@Repository
public class EmployeeDaoImpl implements EmployeeDao {

	@Override
	public Employee selectEmployeeById(SqlSession session, String id) {
		return session.selectOne("employee.selectEmployeeById", id);
	}

	@Override
	public List<Employee> selectEmployeeList(SqlSession session, Map<String, Object> param) {
		return session.selectList("employee.selectEmployees", param,
				new RowBounds(((int)param.get("cPage")-1)*(int)param.get("numPerpage"), (int)param.get("numPerpage")));
	}

	@Override
	public int countEmployeeTotalData(SqlSession session, Map<String, Object> param) {
		return session.selectOne("employee.countEmployeeTotalData", param);
	}

	@Override
	public List<Department> selectDepartmentList(SqlSession session) {
		return session.selectList("employee.selectDepartmentList");
	}

	//테이블용 페이징 처리된 출퇴근 리스트
	@Override
	public List<Commuting> selectCommutingPagingList(SqlSession session, Map<String, Object> param) {
		return session.selectList("employee.selectCommutingPagingList", param,
				new RowBounds(((int)param.get("cPage")-1)*(int)param.get("numPerpage"), (int)param.get("numPerpage")));
	}

	@Override
	public int countCommutingTotalData(SqlSession session, Map<String, Object> param) {
		return session.selectOne("employee.countCommutingTotalData", param);
	}

	@Override
	public List<Commuting> selectCommutingList(SqlSession session, Map<String, Object> param) {
		return session.selectList("employee.selectCommutingList", param);
	}

	@Override
	public int updateEmployeePhoto(SqlSession session, Map<String, Object> param) {
		return session.update("employee.updateEmployeePhoto", param);
	}

	@Override
	public int updateEmployee(SqlSession session, RequestEmployee requestEmployee) {
		return session.update("employee.updateEmployee", requestEmployee);
	}

	@Override
	public int insertCommuting(SqlSession session, Map<String, Object> param) {
		return session.insert("employee.insertCommuting", param);
	}

	@Override
	public int updateCommuting(SqlSession session, Map<String, Object> param) {
		return session.update("employee.updateCommuting", param);
	}

	@Override
	public int insertCommutingNoAtt(SqlSession session) {
		return session.selectOne("employee.commutingProcedure");
	}

}
