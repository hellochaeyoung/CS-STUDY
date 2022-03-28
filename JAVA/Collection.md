##### JAVA의 Collection 종류

추상화된 Collections 인터페이스 아래, 특정한 기법으로 구현된 자료구조가 들어간다.


1. List
   배열과 비슷한 자바의 자료형으로 배열보다 편리한 기능을 많이 가지고 있다.
   - ArrayList : 자바의 Vector를 개선한 배열로 구현된 리스트, 배열과 같은 자료구조이기 때문에 연산 수행 시간 속도가 동일하다.
   - LinkedList : 다음 노드의 주소를 기억하고 있는 리스트로 삽입, 삭제 연산이 편리하다.
                  하지만, 탐색의 경우 맨 앞에서부터 탐색해 나가야하기 때문에 속도가 느리다.
                  
   - Array 와 ArrayList의 차이점
     Array : 크기 length 변수 사용, 크기가 고정, Primitive Type(int, char 등)과 Object 둘 다 사용 가능
     ArrayLsit : 크기 size() 메소드 사용, 크기가 동적, Object만 담을 수 있음
     
2. Map
   key - value 쌍으로 된 구조를 가진 자료형이다.
   - HashMap : 가장 일반적으로 많이 사용되는 Map, HashTable을 사용하여 key 값에 해시함수를 적용하여 나온 인덱스에 value를 저장하는 방식이다.
               key는 중복이 허용되지 않으며 데이터 입력 순서가 보장되지 않는다.
   - TreeMap : Red - Black Tree 자료구조를 이용한 Map, Tree 구조이기 때문에 어느 정도 순서를 보장한다.
   - LinkedHashMap : LinkedList로 구현된 HashMap, 데이터 입력 순서가 보장되지만 랜덤 접근에서는 속도가 느릴 수 있다.


3. Set
   배열처럼 value로만 이루어져 있지만 key와 value 값이 동일하다. 하지만 배열처럼 인덱스 접근이 불가능해 탐색 시 전체를 순회하여 탐색하는 것만이 가능하다.
   중복값을 허용하지 않기 때문에 중복값을 제거할 때 사용하기 좋다.
   - HashSet : 가장 일반적으로 많이 사용되는 Set, 순서가 유지되지 않는 특징을 갖고있다.
   - TreeSet : Red - Black Tree 자료구조를 이용한 Set, 어느 정도 순서를 보장한다.
   - LinkedHashSet : LinkedList로 구현된 Set, 데이터 입력 순서가 보장된다.


4. Stack & Queue
   데이터를 기록하는 자료구조이다.
   - Stack : 한 쪽에서만 데이터를 넣고 뺄 수 있는 LIFO(Last In First Out) 구조가 특징이다.
   - Queue : 한 쪽에서는 데이터를 넣고, 다른 한 쪽에서는 데이터가 나가는 FIFO(First In First Out) 구조가 특징이다.
   - Deque : 스택과 큐를 합친 형태이다.
