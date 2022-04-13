## 시작하며

스프링 MVC의 기본 기능에 대해 알아보고자 한다. 

HTTP 요청, 응답 방법에 따라 어떤 기능들을 사용할 수 있는지, 내부에서는 어떻게 처리가 되는지, 하나의 기능도 여러 방법으로 사용할 수 있기 때문에 그 부분들에 대해 짚어보고
전반적인 정리를 해보고자 한다.


### 1. HTTP 요청 방식

**(1) GET 방식 - 쿼리 파라미터
(2) POST HTML Form 방식 - body에 담기지만 GET 방식의 쿼리 파라미터 형식과 동일하기 때문에 파라미터 방식으로 처리 가능하다.
(3) HTTP API(REST API) - TEXT,JSON


### 2. HTTP 응답 방식

**(1) 정적 리소스 - HTML, CSS, JS 등
(2) 동적 리소스 - JSP, Thymeleaf 등 서버 사이드 플랫폼
(3) HTTP API - TEXT, JSON 객체형


### 3. HTTP 요청 파라미터 및 어노테이션

* HttpServletRequest, HttpServletResponse
* @RequestMapping
  * @GetMapping
      @PathVariable : GET 메소드의 url에 표시된 파라미터 매핑 어노테이션
      
      @RequestParam : POST 메소드의 HTML 폼 방식으로 온 데이터 파라미터명으로 매핑해주는 어노테이션 
                      
                      String, int, Integer 등의 단순 타입이면 어노테이션 생략 가능하다 -> 이렇게 되면 내부에서 어노테이션 설정으로 'required=false'를 적용하게 되는데
                      이 때, int형은 원시 타입으로 null 값이 들어갈 수 없어 만약 요청 파라미터에 생략되었을 때 오류를 발생할 수 있다. -> 따라서 defaultValue 설정을 해주면 
                      이러한 오류를 방지할 수 있다.
      
      @ModelAttribute : 요청 파라미터마다 매핑하는 것이 아닌 아예 객체를 생성해 set해서 매핑해주는 어노테이션 + Model에 자동으로 attribute 설정해주는 기능도 갖고있다.
                        
                        생략해도 기능은 정상적으로 동작하지만 어떤 것을 사용했는지 파악하기에 헷갈릴 수 있으므로 생략 안하는 것이 더 좋다!
                        
                        (어노테이션이 생략됐을 경우 스프링이 우선순위로 String, int, Integer와 같은 단순 타입은 @RequestParam을, 그 외의 나머지 경우에는 @ModelAttribute라고 생각하기 때문에 정상 동작이 가능한 것!)
 
  * @PostMapping
      InputStream, OutputStream : HTTP 메시지의 바디에 담겨진 데이터를 바로 읽어와 매핑, 로직 처리 후 response에 write하고 뷰를 반환한다. -> 과거에 사용됐던 방법, 현재는 거의 사용하지 않음!
      
      HttpEntity : HTTP 메시지의 헤더와 바디 정보를 편리하게 조회 가능하다. 요청 파라미터 어노테이션들과는 전혀 관계가 없으며 동일하게 응답에도 사용할 수 있다.
      
      @RequestBody : HTTP API 방식으로 요청했을 시 HTTP 메시지 Body에 담긴 데이터를 객체로 매핑해주는 어노테이션
                      
                     가장 많이 사용되는 어노테이션이라 볼 수 있다!
                     
        => Body에 담긴 데이터를 종류(byte, text, json .. )에 맞게 객체 매핑해주기 위해서 HttpMessageConverter가 사용된다.
                     
        => [Json 요청 -> HTTP 메시지 컨버터 -> 객체]
                     
  
=> 이렇게 다양한 요청 파라미터를 처리하기 위해 Argument Resolver가 존재!



### 4. HTTP 응답 리턴형

* HttpServletResponse : response에 데이터를 세팅후 뷰 논리 이름을 반환하여 처리

* HttpEntity, ResponseEntity : 데이터 뿐만 아니라 HTTP 헤더 정보, Status도 함께 HTTP 응답 메시지 Body에 넣어서 반환 가능, Status를 경우에 따라 동적 처리할 때 사용한다.
* @ResponseBody : byte, 객체/Text, JSON 리턴, 응답 메시지 Body에 데이터를 넣어서 응답하는 방법

                  REST API 구현할 때 가장 많이 사용되는 방법으로 바디에 바로 담아서 보내기 때문에 view에 전달되지 않는다.
                  
  => HTTP 요청과 마찬가지로 데이터의 종류(byte, text, json ..)에 맞게 HTTP 메시지에 입력해야하기 때문에 ViewResolver가 아닌 HttpMessageConverter가 사용된다.
                  
  => [객체 -> HTTP 메시지 컨버터 -> Json 응답]

=> 이렇게 다양한 형태의 응답 처리를 위해 ReturnValueHandler가 존재!


### 5. HttpMessageConverter

위처럼 스프링 MVC는 다양한 종류의 요청 파라미터와 다양한 종류의 응답이 가능하다. 이렇게 다양한 종류를 처리할 수 있게된 것이 바로 Argument Resolver와 HttpMessageConverter가 
존재하여 각 종류에 맞게 처리해주는 역할을 담당하기 때문이다.

그 중 HttpMessageConverter는 HTTP 요청, 응답 둘 다에 쓰이는데, **HttpEntity/ResponseEntity나 @RequestBody, @ResponseBody**와 같이 **HTTP 메시지 바디 부분에 데이터가 담겨** 요청 및 응답할 때
데이터 종류를 파악해 그에 맞게 객체에 매핑해주는 역할을 담당한다.

![image](https://user-images.githubusercontent.com/55968079/163228743-a78c8888-c274-4ec8-9184-e42d143ed689.png)


* byte : ByteArrayHttpMessageConverter
* text : StringHttpMessageConverter
* json/객체 : MappingJackson2HttpMessageConverter

등 수 많은 HTTP 메시지 컨버터가 있지만 그 중에서도 위 세가지가 가장 대표적이라 볼 수 있다. 

또한 메시지 컨버터는 클래스 타입과 미디어 타입 두 개를 확인해 컨버터를 지정하는데 둘 중에 하나라도 맞지 않으면 다음으로 우선순위가 넘어가 버린다.

![image](https://user-images.githubusercontent.com/55968079/163229263-f31a77b7-ada6-4195-a1fd-59ba5e2094c8.png)



### 6. 핸들러 매핑 어댑터와 Argument Resolver, ReturnValue Handler, HttpMessage Converter

시스템 구조도로 확인했을 때 요청 및 응답을 맞게 처리하기 위해서 **핸들러 매핑 어댑터**가 메인 지시 역할을 한다.

![image](https://user-images.githubusercontent.com/55968079/163229871-07b15378-6ad5-49de-a2ba-61c3607ccc1d.png)

![image](https://user-images.githubusercontent.com/55968079/163229993-ef2434ce-3220-4a0b-8e94-cb0ba6253001.png)



## [마무리]

스프링 MVC에서 제공하는 HTTP 요청, 응답 메시지를 처리할 수 있는 많은 기능들을 살펴보았다. 개인 프로젝트를 하면서 왜 이런 경우에도 되고, 저런 경우에도 되는거지? 했던
의문을 상당히 많이 해결할 수 있었다. 

현재는 REST API 방식으로 가장 많이 백엔드를 설계하고 구현하기 때문에 이를 지원하는 기능을 잘 활용하는 것이 가장 중요하겠다. 하지만 이를 포함해 다른 방식들도 내부에 각 처리되는 과정이
전반적으로 그려져 앞으로 오류 처리나 개발할 때 많은 도움이 될 것 같다.
