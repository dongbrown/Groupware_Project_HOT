package com.project.hot.config;

import java.io.PrintStream;

import org.springframework.boot.Banner;
import org.springframework.core.env.Environment;

public class HotBanner implements Banner {

	@Override
	public void printBanner(Environment environment, Class<?> sourceClass, PrintStream out) {
		out.println(" ___  ___                   ________                   _________                \r\n"
				+ "|\\  \\|\\  \\                 |\\   __  \\                 |\\___   ___\\              \r\n"
				+ "\\ \\  \\\\\\  \\                \\ \\  \\|\\  \\                \\|___ \\  \\_|              \r\n"
				+ " \\ \\   __  \\                \\ \\  \\\\\\  \\                    \\ \\  \\               \r\n"
				+ "  \\ \\  \\ \\  \\      ___       \\ \\  \\\\\\  \\      ___           \\ \\  \\          ___ \r\n"
				+ "   \\ \\__\\ \\__\\    |\\__\\       \\ \\_______\\    |\\__\\           \\ \\__\\        |\\__\\\r\n"
				+ "    \\|__|\\|__|    \\|__|        \\|_______|    \\|__|            \\|__|        \\|__|");
		out.println();
	}

}
