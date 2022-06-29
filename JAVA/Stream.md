# JAVA Stream

## 1. 뜻, 정의

- 사전적 의미 : ‘흐르다’, ‘개울’
- **데이터의 흐름**
- **배열 또는 컬렉션 인스턴스를 함수형 인터페이스를 통해 간단하게 내부 데이터를 순회하여 처리할 수 있는 방법**
- 예시 설명
    - 물고기가 바닷속을 헤엄치는데 ⇒ Stream
    - 어부가 물고기 중 고등어를 그물로 잡고 ⇒ filter (중간 연산자)
    - 여러 마리를 일정한 기준(ex.7cm 이상)으로 모아서 상자에 넣고 ⇒ map (중간 연산자)
    - 이거를 하나도 모은 뒤 트럭에 실어서 시중까지 운반 ⇒ collect (최종 연산자)
- **수 많은 데이터의 흐름 속에서 각각의 원하는 값을 가공하여 최종 소비자에게 제공하는 것!**
    - 여러 개의 함수를 조합하여 원하는 결과를 도출
    - 또한 람다를 이용해서 코드의 양을 줄이고 간결하게 표현 가능 ⇒ 람다식과 스트림이 같이 많이 사용되는 이유!
    - 즉, 배열과 컬렉션을 함수형으로 처리 가능 ⇒ 이것으로 인해 간단하게 병렬 처리가 가능하다!!!!
     - 왜 병렬 처리가 가능한 지는 이따가 알아보기

- 스트림과 컬렉션 비교
    - 데이터를 **언제 계산**하느냐가 가장 큰 차이이자 관점!
     - 컬렉션 : 요소의 연산 완료 후 컬렉션에 추가됨.
     - 스트림 : 요청할 때만 요소를 연산 → 연산과 추가를 동시에 수행
            - 사용자가 데이터를 요청할 때만 연산
            - 컬렉션을 게으르게 만듦

## 2. 특징

- 데이터 소스를 추상화하고 데이터를 다루는 데 자주 사용되는 메소드들을 정의
    - **데이터 소스를 추상화**했다?
     - 데이터 소스가 무엇이던 간에 같은 방식으로 다룰 수 있게 되었다는 의미이므로 코드의 재사용성이 높아진다는 것을 의미
     - 인터페이스를 구현해놓고 여러 기술을 가지고 다양하게 구현한 구현체들을 편하게 바꿔 끼워가며 사용할 수 있는 것처럼, 스트림도 배열이든, 컬렉션이든, 파일이든 다른 자료형의 데이터들을 같은 방식으로 다룰 수 있게 해줌으로써 재사용성이 높아졌다는 것을 의미한다.
     - 이것에 대한 예시는 밑에서 확인
- 데이터 소스를 읽기만 하고 변경하지 않는다.
    - 읽어서 연산 후 새로운 스트림으로 리턴한다는 의미
    - 생성된 스트림에 요소 자체를 새로 추가하거나 삭제하는 것은 불가능
    - 필요에 따라 정렬된 결과를 컬렉션이나 배열로 반환할 수 있다.
- 일회용이다.
    - 한 번 사용하면 닫혀서 다시 사용할 수 없다.
    - 필요 시 다시 생성해야 한다.
- 간결하다.
    - 바로 **내부 반복** 때문..!!
     - 반복문을 메소드의 내부에 숨길 수 있다는 것을 의미
            - 외부 반복 : 개발자가 코드로 직접 컬렉션의 요소를 반복해서 가져오는 패턴
                - 기존의 for문, while문 등
            - 내부 반복 : 컬렉션 내부에서 요소들을 반복시키고, 개발자는 요소 당 처리해야 할 코드만 제공하는 패턴
     - 람다식을 매개변수로 넣어 데이터 소스의 모든 요소에 적용한다.
        
        ```java
        List<String> list = Arrays.asList("a", "b", "c");
        
        for(String s : list) {
        	System.out.println(s);
        }
        
        **list.stream().forEach(System.out::println);**
        
        // 더 간단하게
        list.forEach(System.out::println);
        ```
        
        ```
        void forEach(**Consumer<? super T> action**)
        {
            Objects.requireNonNull(action); // 매개변수의 널 체크
        
            for(T t : src) // 내부 반복
            {
                action.accept(T);
            }
        } 
        ```
        

 

- 여러 연산을 연속해서 사용할 수 있다.
    - 연산 : 스트림에 정의된 메소드 중에서 데이터 소스를 다루는 작업을 수행하는 것
    - 중간 연산과 최종 연산으로 분류
     - 중간 연산 : 리턴형이 스트림이기 때문에 중간 연산을 연속해서 연결하여 사용 가능
     - 최종 연산 : 스트림의 요소를 소모하면서 연산을 수행하기 때문에 단 한 번 만의 연산이 가능
- 지연된 연산이다. - lazy
    - 최종 연산이 수행되기 전까지는 중간 연산이 수행되지 않는다.
    - 중간 연산을 호출해도 즉각적으로 실행되는 것이 아니다.
     - 단지 **어떤 작업이 수행되어야 하는지를 지정** 해 주는 것
    - **최종 연산이 호출**되어야 스트림의 요소들이 중간 연산을 거쳐 최종 연산으로 한 번에 처리
- 기본형을 다루는 스트림이 존재한다.
    - int, double, long
    - 기본적으로 제네릭 타입을 사용하지만, 비효율적인 오토 박싱 & 언박싱의 비용을 줄이기 위해 데이터 소스의 요소를 기본형으로 다루는 스트림이 존재한다.
    - IntStream, LongStream, DoubleStream
- 병렬 처리, 병렬 스트림
    - 내부적으로 fork & join  프레임워크를 사용하여 자동적으로 연산을 병렬로 수행한다.
     - fork & join 프레임워크
     - fork : 갈라지다, 나뉘다
     - join : (하나가 되도록) 합쳐지다
     - 한 작업을 여러 개의 스레드가 나누어 처리하고 각 작업이 끝나면 하나의 작업으로 합치는 것..!
    - 내부 반복자는 요소들을 분배시켜 병렬 작업을 수행한다.
     - 이 때 람다식으로 요소 처리 내용만 전달하고 요소의 병렬 처리 및 반복 수행 자체는 컬렉션 내부에서 일어나므로 효율적인 병렬 처리가 가능하다.
        
        ![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/44521e44-224a-4af2-9f3a-639d9c2a714f/Untitled.png)
        
        ![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/46137ea0-7fc8-47ec-a1b8-9e065aafcdfd/Untitled.png)
        

## 3. 사용법

- 스트림을 사용하는 이유는?
    - 멀티 스레드 코드를 구현하지 않아도 데이터를 투명하게 병렬로 처리가 가능하다 ⇒ 성능이 향상!
    - 선언형으로 컬렉션 데이터를 처리할 수 있다.
     - 루프/if 등의 반복문, 조건문의 제어 블록을 사용해서 어떻게 동작을 구현할 지 지정할 필요가 없다 ⇒ 동작 수행을 지정할 수 있다!

- 생성하기 : 스트림 인스턴스를 생성한다.
- 가공하기 : 필터링(Filtering) 및 매핑(Mapping) 등을 통해 원하는 결과를 만들어 가는 중간 작업
- 결과 만들기

### 1) 스트림 생성하기

- 배열 이용

```java
String[] arr = new String[] {"a", "b", "c"};

// 배열을 이용하여 스트림 생성
Stream<String> stream = Arrays.stream(arr);

// 배열의 범위를 지정해 스트림 생성
Stream<String> streamOfArrayPart = Arrays.stream(arr, 1, 3);

System.out.println(Arrays.toString(stream.toArray()));
System.out.println(Arrays.toString(streamOfArrayPart.toArray()));
```

- 컬렉션 이용

```java
// 컬렉션을 이용한 스트림 생성
List<String> list = Arrays.asList("a", "b", "c");

list.forEach(System.out::println);

Stream<String> stream1 = list.stream();
Stream<String> parallelStream = list.parallelStream(); // 병렬 처리 스트림

//
Arrays.asList("a", "b", "c").forEach(System.out::println);
```

- 빌더 이용

```java
// Stream.builder() -> 빌더를 이용하면 스트림에 직접적으로 원하는 값을 넣을 수 있다.
Stream<String> builderStream = Stream.<String>builder()
        .add("Eric").add("Elena").add("Java")
        .build();
```

- generate() 이용

```java
Stream<String> generateStream = Stream.generate(() -> "gen").limit(5);

System.out.println(Arrays.toString(generateStream.toArray()));

=> 결과 : [gen, gen, gen, gen, gen]
```

- iterate() 이용

```java
// 초기값과 초기값을 이용하는 람다식을 이용해 스트림에 들어갈 요소를 만든다.
// 요소가 다음 요소의 인풋으로 들어간다.
Stream<Integer> iteratedStream = Stream.iterate(30, n -> n+2).limit(5);

=> 결과
30
32
34
36
38
```

- 기본 타입형 스트림 생성

```java
IntStream intStream = IntStream.range(1,5); // 종료 지점이 포함되지 않음

LongStream longStream = LongStream.rangeClosed(1,5); // 종료 지점이 포함됨

intStream = new Random().ints(3);
longStream = new Random().longs(5);
DoubleStream doubleStream = new Random().doubles(3);

checkString("sdkjflei45@#$%%");

.
.
.

static public void checkString(String str) {

        int count = (int) str.chars().filter(s -> (s < 97 || s > 122)).count();

        if(count > 0) System.out.println("incorrect input String. Please Check Again");
        else System.out.println("correct input!.");
    }
```

- 문자열 스트림 생성

```java
Stream<String> stringStream = Pattern.compile(", ").splitAsStream("Eric, Elena, Java");
System.out.println(Arrays.toString(stringStream.toArray()));

Stream<String> stringStream1 = Pattern.compile("/").splitAsStream("aaa/23/180.2/55/23/5.6");
System.out.println(Arrays.toString(stringStream1.toArray()));

=> 결과
[Eric, Elena, Java]
[aaa, 23, 180.2, 55, 23, 5.6]
```

- 파일 스트림 생성

```java
Stream<String> fileStream = Files.lines(Paths.get("C:\\Temp\\BaseballPlayer.txt"),
        StandardCharsets.UTF_8);

fileStream.forEach(System.out::println);

=> 결과
Pitcher/1/aaa/23/179.540/20/0.5
Batter/2/bbb/44/198.377/33/0.4
```

### 2) 가공하기 - 중간 연산

- filter
- map
- boxed
- distinct
- sorted
- . . .

- 스트림 연산 시 중간 연산이 여러 개 존재하면 서로 다른 연산이 한 과정으로 병합되어 수행된다.
    - 이것이 바로 loop fusion!

### [**Loop Fusion]**

- 서로 다른 연산이지만 실제로는 하나의 과정으로 병합되어 실행되는 것을 의미
- filter - map은 이렇게 병합되어 실행된다.

```java
package example.stream;

import java.sql.Array;
import java.util.ArrayList;
import java.util.List;

public class LoopFusionOfStreamEx {

    public static void main(String[] args) {

        List<String> list = new ArrayList<>();

        list.add("A");
        list.add("B");
        list.add("c");
        list.add("d");
        list.add("E");
        list.add("f");
        list.add("G");

        List<String> result = list.stream().filter(s -> {
            System.out.println("Filter : " + s);
            return s.charAt(0) >= 97;
        }).map(s -> {
            System.out.println("Map : " + s);
            return s;
        }).toList();

    }
}
```

```java
Filter : A
Filter : B
Filter : c
Map : c
Filter : d
Map : d
Filter : E
Filter : f
Map : f
Filter : G
```

- [참고]
    - filter - sort : [filter - map] 처럼 수행되지 않는다.
    - 정렬 연산을 매번 요소가 추가될 때마다 수행되는 것은 매우 비효율적!
    - 따라서 sort라는 연산의 특성을 고려하여 filter가 다 수행되고 sort가 수행된다.

### 3) 결과 만들기 - 종단 연산

- collect
- reduce
- findFirst
- findAny
- sum
- count
- 조건 체크
    - allMatch
    - anyMatch
    - noneMatch
- . . .

- findFirst와 findAny의 차이점
    - findFirst : 조건에 일치하는 요소들 중 스트림에서 가장 앞에 위치한 요소를 리턴
    - findAny : 스트림에서 가장 먼저 탐색되는 요소를 리턴
    - 단일, 직렬 수행으로 처리할 때는 둘 다 동일한 요소를 리턴하며 차이점은 없다
    - 병렬에서 차이점이 있다.
     - findFirst는 조건에 부합하는 요소를 찾아도 전체에서 다 찾고 순서가 제일 앞에 있는 요소로 리턴한다.
     - findAny는 멀티 스레드 환경에서 스트림을 처리할 때 조건에 부합하는 요소를 찾는 즉시 바로 리턴한다 → 따라서 뒤에 위치한 요소가 리턴될 수 있음!
     - 따라서 병렬 처리 시 findAny가 성능 면에서 더 효율적이다.
     - 여기서 나오는 개념이 Short Circuit!!!

### [**Short Circuit]**

- 데이터 끝에 도달하기 전 이미 결과가 확실하다면 나머지 연산을 수행할 필요가 없다.
- 예를 들어, or 연산일 때 앞이 true이면 뒤는 확인 안하는 것, and 연산에서 앞이 false이면 뒤를 확인 안하는 것과 같은 의미!
- 스트림은 전체가 아닌 부분적, 병렬적으로 처리하기 때문에 가능하다.
- 조건 체크 함수들인 allMatch, noneMatch, anyMatch 등을 수행할 때 해당된다.

```java
package example.stream;

import java.util.ArrayList;
import java.util.List;

public class ShortCircuitOfStreamEx {

    public static void main(String[] args) {

        List<int []> list = new ArrayList<>();

        list.add(new int[] {1,10000});
        list.add(new int[] {2,2000});
        list.add(new int[] {3,30000});
        list.add(new int[] {4,4000});
        list.add(new int[] {5,5000});
        list.add(new int[] {6,60000});

        boolean result = list.stream().allMatch(arr -> {
            System.out.println("run allMatch");
            return (arr[1] * 1000) == arr[0];
        });

        System.out.println("result = " + result);
        System.out.println();
        System.out.println();

				// limit을 적용하지 않았을 때
        list.stream().filter(arr -> (arr[1] % 1000 == 0)).forEach(arr -> System.out.println("[" + arr[0] + " " + arr[1] + "]"));
        System.out.println();

				// limit을 적용했을 때
        list.stream().limit(3).filter(arr -> (arr[1] % 1000 == 0)).forEach(arr -> System.out.println("[" + arr[0] + " " + arr[1] + "]"));
    }
}

```

```java
run allMatch
result = false

[1 10000]
[2 2000]
[3 30000]
[4 4000]
[5 5000]
[6 60000]

[1 10000]
[2 2000]
[3 30000]
```

## 4. 리팩토링 예제

- 자바-네트워크 과제였던 ‘채팅 프로그램 구현하기’를 람다 및 스트림 방식으로 리팩토링을 진행
- 메시지 전송을 위한 Socket 통신을 하기 위해 Exception 처리를 할 try-catch문이 필요
- 람다식은 함수형 인터페이스를 구현한 객체로 함수형 인터페이스에 선언된 추상 메소드 자체가 throws 처리가 되어있지 않다.
- 따라서 Exception 처리를 위해 추가적인 방법이 필요하다.
    1. 함수형 인터페이스를 상속받은 커스텀 인터페이스를 구현하여 사용하는 방법 
    2. Exception 처리가 필요한 부분을 따로 메소드로 뺀 후 람다식에 호출해서 사용하는 방법
    - 예외 발생 시 추가적인 처리가 필요할 경우에는 2번을 사용하는 것이 좋다 함.
    - 하지만 2번을 사용하면 람다식을 쓰는 의미도 없을 것 같고 채팅 프로그램에서 특별히 추가적인 예외 처리가 필요하지 않기에 1번으로 구현을 진행

- 두 개의 매개변수를 받아야 하기 때문에 BiConsumer 라는 함수형 인터페이스를 사용

```java
package impl;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.Socket;
import java.util.function.BiConsumer;

public class HandlerServerExceptionConsumer implements BiConsumer<Socket, String> {

	@Override
	public void accept(Socket t, String u) {
		
		try {

			PrintWriter writer = new PrintWriter(t.getOutputStream());
			writer.println(u);
			writer.flush();
			System.out.println("[HandlerServerExceptionConsumer]>>>>>" + u);
			
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
	}
}

```

- ServerThread에서 다음과 같이 생성하여 사용

```java
package threadex;

public class ServerThread extends Thread {

   Socket socket;
   List<Client> list; // 접속한 또 다른 클라이언트들의 목록
   Set<String> roomNameSet;

   **HandlerServerExceptionConsumer consumer = new HandlerServerExceptionConsumer();**

   @Override
   public void run(){
      super.run();

      try {

         while(true) {

            // 수신(receive)
            BufferedReader reader = new BufferedReader(new InputStreamReader(socket.getInputStream()));
            String str = reader.readLine();

            System.out.println("client로부터 받은 메시지 : " + str);

            // 송신(send)

            // 사용자 접속 리스트 처리
            if(str.startsWith("userInfo")) {
               String id = str.split("/")[1];

               // 2. 인터페이스 구현체 이용하여 람다식 try-catch 처리
               **list.forEach(c -> {
                  Socket s = c.getSocket();
                  if(s == socket) {
                     c.setId(id);
                  }

                  consumer.accept(s, str); ///////////////////////
               });**

         
            }
           
```

- 전체 코드 참고
    - Server : [https://github.com/hellochaeyoung/Bit-Education-academy/tree/master/TCPServer](https://github.com/hellochaeyoung/Bit-Education-academy/tree/master/TCPServer)
    - Client : [https://github.com/hellochaeyoung/Bit-Education-academy/tree/master/GUIClient](https://github.com/hellochaeyoung/Bit-Education-academy/tree/master/GUIClient)
    
- 참고 자료
    - [https://ict-nroo.tistory.com/43](https://ict-nroo.tistory.com/43)
    - [https://futurecreator.github.io/2018/08/26/java-8-streams/](https://futurecreator.github.io/2018/08/26/java-8-streams/)
    - [https://techvu.dev/140](https://techvu.dev/140)
    - [https://codechacha.com/ko/java8-stream-difference-findany-findfirst/](https://codechacha.com/ko/java8-stream-difference-findany-findfirst/)
    - [https://velog.io/@bosl95/자바의-함수형-인터페이스](https://velog.io/@bosl95/%EC%9E%90%EB%B0%94%EC%9D%98-%ED%95%A8%EC%88%98%ED%98%95-%EC%9D%B8%ED%84%B0%ED%8E%98%EC%9D%B4%EC%8A%A4)
    - [https://www.slipp.net/questions/572](https://www.slipp.net/questions/572)
    - [https://www.baeldung.com/java-lambda-exceptions](https://www.baeldung.com/java-lambda-exceptions)
