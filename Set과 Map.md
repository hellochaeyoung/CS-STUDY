### Set과 Map

오늘 문제를 풀면서 중복값 제거는 HashSet을 이용했고, for문으로 인한 시간초과는 HashMap으로 해결했다.

문제 풀 때 중복값 제거 용도로 Set을 쓸 수 있다는 사실을 다시 한 번 생각했다. 알고 있는 내용인데도 바로 떠오르지 않았던 건 아무래도 개념 정리가 좀 덜 되어 있는게 아닌가 싶어

Set과 Map의 각각의 특징과 차이점을 정리하고자 한다.

##### 1. Set

- 데이터의 집합을 의미한다.
- **중복값** 을 허용하지 않는다. -> 배열의 중복값 제거할 때 자주 사용된다!
- 자바에서는 HashSet, TreeSet, LinkedHashSet 이 존재한다.
- HashSet : 들어간 순서가 보장되지 않는다.
- TreeSet : Binary Search Tree 구조로, key값을 기준으로 오름차순 정렬된다.
- LinkedHashSet : 데이터 들어간 순서가 보장된다. 추가 및 삭제에는 시간이 좀 더 걸리지만 정렬 및 탐색에 굉장히 효율적이다.


##### 2. Map

- **[key - value] 쌍** 으로 이루어진 데이터의 집합을 의미한다.
- 대용량 데이터에서 key 값으로 빠르게 데이터 찾기에 유용해 속도 면에서 굉장히 우월하다.
- 중복된 key는 허용하지 않는다.
- Set 보다 속도가 빠르다.
- 자바에서는 HashMap, TreeMap, LinkedHashMap 이 존재한다.
- HashMap : 데이터 들어간 순서가 보장되지 않는다.
- TreeMap : Binary Search Tree 구조로 key 기준으로 오름차순 정렬된다.
- LinkedHashMap : 데이터 들어간 순서대로 저장된다. 
 
