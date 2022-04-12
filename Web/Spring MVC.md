## [시작하며]

Spring MVC를 잘 이해하기 위해 직접 MVC 프레임워크를 구현해보았다. 

구현한 프레임워크와 Spring MVC를 비교해보고 Spring MVC에 대해 더 자세하게 알아보려 한다.


### 1. 직접 구현한 MVC 프레임워크와 Spring MVC의 비교

* 직접 구현한 MVC 프레임워크

![image](https://user-images.githubusercontent.com/55968079/162963289-c13cb18b-dc41-494e-aac8-ea2b865e2f05.png)


* SpringMVC

![image](https://user-images.githubusercontent.com/55968079/162963987-5c8d6146-5626-404f-85a1-919e205ffe4d.png)



두 개의 구조는 거의 동일하다. 하지만 표시한 것과 같이 약간의 차이는 있다. 클래스 명이라던지 객체명이 조금씩 다르지만 각 역할은 동일하고 처리 구조 및 순서도 동일하다.

### 2. DispatcherServlet

스프링 MVC도 프론트 컨트롤러 패턴으로 구현되어 있으며, 스프링 MVC의 프론트 컨트롤러가 바로 DispatcherServlet이다.

DispatcherServlet이 **Spring MVC의 핵심**이다.

마찬가지로 소스를 까보면 타고 타고 올라가서 부모 클래스에서 HttpServlet을 상속 받아서 사용하며 이름 그대로 서블릿으로 동작한다.
  - DispatcherServlet -> FrameworkServlet -> HttpServletBean -> HttpServlet
  - 이렇게 인터페이스로 구현되어있기 때문에 기존 코드 변경 없이 원하는 기능을 변경하거나 확장에 용이하다!!
  
스프링 부트는 내장된 톰캣 서버를 실행함과 동시에 DispatcherServlet을 서블릿으로 자동등록하며 모든 경로("/")에 대해 매핑한다.
-> 더 자세한 경로가 우선 순위가 높기 때문에 매핑에 걱정할 일은 없다.


### 3. Handler Mapping과 Handler Adapter

클라이언트의 요청을 처리할 수 있는 컨트롤러가 맞게 호출되려면 핸들러 매핑과 핸들러 어댑터가 필요하다!!

스프링에는 이미 많은 핸들러 매핑과 핸들러 어댑터가 등록되어있다.
그 중에서도 어노테이션 기반 컨트롤러인 @RequestMapping에서 사용하는 다음 두 개의 핸들러 매핑과 핸들러 어댑터가 가장 많이 사용된다.
  - HandlerMapping : RequestMappingHandlerMapping
  - HandlerAdapter : RequestMappingHandlerAdapter


### 4. ViewResolver

뷰 리졸버는 핸들러 어댑터의 핸들러 호출 및 비즈니스 로직 처리 이후 결과로 받은 ModelAndView에 담긴 뷰의 논리 경로를 가지고 절대 경로로 바꿔 뷰 렌더링을 한다.

스프링 부트가 자동 등록해주는 많은 뷰 리졸버가 존재한다.
  - BeanNameViewResolver : 빈 이름으로 뷰를 찾아서 반환
  - InternalResourceViewResolver : JSP 같이 서버 내에서 처리하는 뷰를 반환

이 외에도 몇 개 더 존재한다.

### 4. Spring MVC

스프링은 어노테이션 기반으로 동작하는 컨트롤러를 제공하기 때문에 매우 유연하고 실용적이다.

MVC 부분에서 스프링이 정상을 차지하게 된 이 어노테이션들에 대해 알아보려 한다.

- **@Controller** : 스프링이 자동으로 스프링 빈으로 등록(내부에 @Component 있기 때문) -> 스프링 MVC에서 어노테이션 기반 컨트롤러로 인식한다.
- **@RequestMapping** : 요청 정보를 매핑, URL과 매핑되어 있어 메소드가 호출된다.
  * 여태까지는 이 @RequestMapping 마다, 즉 메소드마다 컨트롤러를 생성했지만 하나의 컨트롤러에 여러 기능을 담을 수 있다.
  * HTTP 메소드에 맞춰 더 세분화된 어노테이션을 더 많이 사용한다. 그리고 이걸 사용하는 게 바람직하다. -> @GetMapping, @PostMapping, @PutMapping ...
- **@RequestParam** : HttpServletRequest에 들어오는 요청의 핵심 데이터, 즉 HTTP 요청 파라미터를 request 객체에 직접 접근할 필요없이 @RequestParam이라는 어노테이션을 통해 이름으로 바로 접근하여 사용할 수 있다. (참고 : 예제에서는 form태그로 데이터를 전송하기 때문에 content type이 x-www-form-urlencoded여도 Get 메소드일 때의 쿼리 파라미터와 동일한 형태이기 때문에 @RequestParam으로 데이터를 꺼내올 수 있다.) 

또한 각 메소드들 마다 매개변수로 Model 객체를 전달받아 이 Model에 로직 처리 후 전달할 데이터들을 넣어주고 뷰의 논리 이름만 리턴해주는 이러한 간단한 방식으로 구현할 수 있게 되었다.


## [마무리]

Spring MVC에 대해 공부를 하니 최종적인 모습이 내가 올해 초부터 시작했던 개인 프로젝트 초창기 모습과 일치했다.

물론 지금은 REST API 방식으로 다 변경하였지만 맨 처음에는 서버 사이드 플랫폼인 Thymeleaf를 사용해서 구현하다 보니 Spring MVC를 사용할 수 밖에 없었고 
위와 같이 어노테이션 기반 컨트롤러에 url 매핑하여 모델에 데이터를 담아 뷰 논리명을 리턴하는 전형적인 방식으로 구현했다. 

직접 구현하는데 사용했던 방식이 어떻게 현재의 모습을 갖추게 됐는지 알게 되니 이미 해 본 경험이 있어서 그런가 더 명확하게 이해할 수 있어서 좋은 강의였다.


