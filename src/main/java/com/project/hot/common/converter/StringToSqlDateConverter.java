package com.project.hot.common.converter;

import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;

import org.springframework.core.convert.converter.Converter;

public class StringToSqlDateConverter implements Converter<String, Date> {

	private String sqlDateFormat = "yyyy-MM-dd";

	@Override
	public Date convert(String source) {


		if(source == null || source.trim().isEmpty()) {
			return null;
		}
		try {
			SimpleDateFormat dateFormat=new SimpleDateFormat(sqlDateFormat);
			java.util.Date utilDate = dateFormat.parse(source);
	        return new Date(utilDate.getTime());
		}catch(ParseException e) {
			throw new IllegalArgumentException("Invalid date format. Please use " + sqlDateFormat);
		}
	}

}
