package com.project.hot.common.converter;

import org.springframework.core.convert.converter.Converter;
import org.springframework.stereotype.Component;

@Component
public class StringToIntConverter implements Converter<String, Integer> {

	@Override
	public Integer convert(String source) {
		return (source == null || source.trim().isEmpty()) ? null : Integer.parseInt(source);
	}

}
