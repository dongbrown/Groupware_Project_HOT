package com.project.hot.schedule.model.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Schedule {

    private int id;  // scheduleNo 대신
    private String title;  // scheduleTitle 대신
    private String description;  // scheduleContent 대신
    private String color;  // scheduleLabel 대신 (색상 코드로 사용)
    private String location;  // schedulePlace 대신
    private String type;  // scheduleType 대신
    private String start;  // scheduleStartDate 대신
    private String end;  // scheduleEndDate 대신
    private boolean allDay;  // 필요한 경우 추가
    //project_no 추가해야됨

}
