package com.happy.prj.common;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class AccessLogFilter implements Filter{

	private Logger logger = LoggerFactory.getLogger(AccessLogFilter.class);
	
	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		
		HttpServletRequest req = (HttpServletRequest)request;
		
		String remoteAddr = StringUtils.defaultString(req.getRemoteAddr(), "-");
		String url = StringUtils.defaultString(req.getRequestURL().toString(), "-");
		String queryString = StringUtils.defaultString(req.getQueryString(), "-");
		String userAgent = StringUtils.defaultString(req.getHeader("User-Agent"));
		
		StringBuffer sb = new StringBuffer();
		sb.append(url).append("?").append(queryString).append("♥♥").append(remoteAddr).append("♥♥").append(userAgent);
		
		logger.info("[Access-Logger] "+sb.toString());
		
		chain.doFilter(request, response);
	}

	@Override
	public void destroy() {

	}

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		
	}
}
