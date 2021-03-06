### System.out.println vs StringBuilder


백준 2751번 정렬 문제를 풀다가 알게 된 내용이다.
그냥 System.out.println으로 하면 시간초과가 나고 StringBuilder로 모든 내용을 append하고 한번 println하면 시간 초과가 나지 않았다.
둘의 속도차이가 많이 나 왜그런지 알고 싶어서 이것저것 찾아봤다.


##### <System.out.println>

 일단 첫 번째, System.out.println을 실행 시 최상위 클래스인 Object 클래스의 toString() 메소드가 자동으로 호출된다.
따라서, 한 번의 출력마다 최상위 클래스에 접근한다는 의미이므로 출력 횟수가 많다면 이로 인한 오버헤드가 발생할 수 있을 거라고 생각했다.
 
 두 번째로, println 함수를 찾아보니 synchronized block으로 묶여있다. synchronized(동기화)는 같은 프로세스에 존재하는 스레드들끼리 데이터를 공유하는데
이 때 작업 중인 스레드가 있다면 이 작업이 다 끝날 때까지 공유 데이터에 접근하지 못하도록 막는 것이다. 따라서 이와 같은 대기시간에 오버헤드가 발생한다. 


##### <StringBuilder 사용>

반대로, StringBuilder는 String과 동일하지만 immutable 클래스인 String과 다르게 수정이 가능한 클래스이다. 따라서 append 함수로 출력할 내용을 이어붙이면
한 번의 출력만으로도 전체 내용을 출력할 수 있으며 출력으로 인한 오버헤드가 현저히 감소해 메모리 측면에서나 속도 측면에서 모두 우월하다 볼 수 있다.

이로써, StringBuilder는 출력 메소드 호출 빈도를 낮추는데 매우 효과적이다. 앞으로 반복적으로 출력할 경우에는 StringBuilder를 사용하는 것이 효율적이겠다.
  
  
  
  
  
  
  
  
  
  
  
