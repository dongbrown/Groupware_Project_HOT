package com.project.hot.common.converter;

import org.springframework.core.convert.converter.Converter;
import org.springframework.stereotype.Component;

@Component
public class StringToIntegerConverter implements Converter<String, Integer> {

	@Override
	public Integer convert(String source) {
		if (source == null || source.trim().isEmpty()) {
			return null;
		}else {
			return Integer.parseInt(source);
		}
	}

}