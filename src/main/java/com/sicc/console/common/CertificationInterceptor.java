package com.sicc.console.common;

//@Component
//public class CertificationInterceptor implements HandlerInterceptor{
// 
//    @Override
//    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
//            throws Exception {
//    	Authentication auth = SecurityContextHolder.getContext().getAuthentication();
//    	String userId = auth.getName();
//    	
//        if("anonymousUser".equals(userId)){
//            response.sendRedirect("/login");
//            return false;
//        }else{
//           // session.setMaxInactiveInterval(30*60);
//            return true;
//        }
//        
//    }
// 
//    @Override
//    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
//            ModelAndView modelAndView) throws Exception {
//        // TODO Auto-generated method stub
//        
//    }
// 
//    @Override
//    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
//            throws Exception {
//        // TODO Auto-generated method stub
//        
//    }
// 
//}
