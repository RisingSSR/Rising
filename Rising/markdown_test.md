# iOS多线程

# 多线程方案以及相关特性

![image-20220412090359470](/Users/shizihan/Library/Application Support/typora-user-images/image-20220412090359470.png)

# GCD

### 使用GCD的好处

- GCD可用于多核的并行运算，它会自动利用更多的CPU内核
- GCD会自动管理线程的生命周期（创建、调度任务、销毁），程序员只需要告诉GCD想要执行什么任务，不需要编写线程管理代码

### 任何和队列

#### 任务

任务是执行操作（线程中执行的那段代码）即GCD中block中的内容。

任何执行方式分为同步执行和异步执行

- 同步执行(sync)：
  - 同步添加任务到指定队列中，在添加的任务执行结束前会一直等待，直到任务完成之后再继续执行
  - 只能在当前线程执行，不具备开启新线程的能力

- 异步执行(async)
  - 添加任务到指定队列之后，不会做任何等待就可以继续执行任务
  - 可以在新线程中执行任务，具有开启新线程的能力

#### 队列

执行任务的等待队列

- 串行队列

  只开启一个线程，每次只有一个任务被执行，当前任务被执行完再执行下一个任务

- 并行队列

  可以开启多个线程，让多个任务并发（同时）执行

<!--并发队列 的并发功能只有在异步（dispatch_async）方法下才有效-->

#### 任务与队列的不同组合情况

![image-20220412091050872](/Users/shizihan/Library/Application Support/typora-user-images/image-20220412091050872.png)

<!--注意：使用sync函数往当前串行队列中添加任务，会卡住当前的串行队列（产生死锁）-->

### GCD基本使用

#### 队列创建/获取步骤

##### 使用 `dispatch_queue_create` 方法创建队列

- 参数1: 队列唯一标识符，用于debug，可以为空
- 参数2:用来标识是串行队列还是并发队列
  - `DISPATCH_QUEUE_SERIAL` 表示串行队列
  - `DISPATCH_QUEUE_CONCURRENT` 表示并发队列

##### 对于并发队列，GCD 默认提供了 **全局并发队列（Global Dispatch Queue）**

可以使用 `dispatch_get_global_queue` 方法来获取全局并发队列。

传参：

- 第一个参数表示队列优先级，一般使用`DISPATCH_QUEUE_PRIORITY_DEFAULT`
- 第二个参数暂时没用，用 0 即可。

##### 对于串行队列，GCD 默认提供了：主队列（Main Dispatch Queue）

- 所有放在主队列中的任务，都会放到主线程中执行。
- 可使用 dispatch_get_main_queue() 方法获得主队列。

#### 任务创建

- 同步执行任务创建方法

  ```objc
  dispatch_sync(queue, ^{
      // 这里放同步执行任务代码
  });
  ```

-  异步执行任务创建方法

  ```objc
  dispatch_async(queue, ^{
      // 这里放异步执行任务代码
  });
  ```

### 栅栏函数 `dispatch_barrier_async`
第一组操作执行完之后，才能开始执行第二组操作。栅栏函数就在这中间作为两组的分割

### 延迟执行：dispatch_after。
dispatch_after 方法并不是在指定时间之后才开始执行处理，而是在指定时间之后将任务追加到主队列中

```objc
	dispatch_after(dispatch_time_t when, dispatch_queue_t queue, dispatch_block_t block);
	//when:时间参数
			dispatch_time_t t = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2* NSEC_PER_SEC));
				#define NSEC_PER_SEC 1000000000ull     多少纳秒 = 1秒            1秒 = 10亿纳秒              
				#define NSEC_PER_MSEC 1000000ull       多少纳秒 = 1毫秒          1毫秒 = 100万纳秒
				#define USEC_PER_SEC 1000000ull        多少微秒 = 1秒            1秒 = 100万微秒   
				#define NSEC_PER_USEC 1000ull          多少纳秒 = 1微秒           1微秒 = 1000 纳秒
	//	queue:就是一个队列，自己创建一个就行了
	// block:想执行的内容
```

### 只执行一次之的代码：dispatch_once
​	使用 dispatch_once 方法能保证某段代码在程序运行过程中只被执行 1 次，并且即使在多线程的环境下，dispatch_once 也可以保证线程安全。一般用于单例模式
​	

```objc
	@implementation AppManager

- (instancetype)sharedInstance{
static AppManager *manager = nil;
static dispatch_once_t appManagerTocken;
dispatch_once(&appManagerTocken, ^{
    manager = [[super allocWithZone:nil] init];
});
return manager;
}
@end
```

### 信号量

 Dispatch Semaphore，是持有计数的信号。类似于过高速路收费站的栏杆。可以通过时，打开栏杆，不可以通过时，关闭栏杆。在 Dispatch Semaphore 中，使用计数来完成这个功能，计数小于 0 时需要等待，不可通过。计数为 0 或大于 0 时，不用等待可通过。计数大于 0 且计数减 1 时不用等待，可通过

#### 主要使用的三种方法

- `dispatch_semaphore_create`：创建一个 Semaphore 并初始化信号的总量

- `dispatch_semaphore_signal`：发送一个信号，让信号总量加 1

- `dispatch_semaphore_wait`：可以使总信号量减 1，信号总量小于 0 时就会一直等待（阻塞所在线程），否则就可以正常执行。

#### 开发实际用处

- 保持线程同步，将异步执行任务转换为同步执行任务
- 保证线程安全，为线程加锁

<!--注意：信号量的使用前提是：想清楚你需要处理哪个线程等待（阻塞），又要哪个线程继续执行，然后使用信号量。-->

### 资源

参考文章发：[掘金](https://juejin.cn/post/6938442778221215757#comment)

demo：见旁边文件夹

# NSOperation

基于`GCD`更高一层的封装，完全面向对象。相对于GCD而言使用更加的简单、代码更具可读性

看资料：[NSOperation详解](https://juejin.cn/post/6844904097326465038#heading-16)

### 任务和队列

#### 任务

和GCD一样NSOperation同样有任务的概念。所谓任务就是在线程中执行的那段代码，在GCD中是放在block执行的，而在NSOperation中是在其子类 `NSInvocationOperation`、`NSBlockOperation`、`自定义子类`中执行的。和GCD不同的是NSOperation需要NSOperationQueue的配合来实现多线程，NSOperation 单独使用时是同步执行操作，配合 NSOperationQueue 才能实现异步执行。

#### 队列

# iOS中的锁

## 自旋锁

自旋锁：如果共享数据已经有其他线程加锁了，线程会以死循环的方式等待锁，一旦被访问的资源被解锁，则等待资源的线程会立即执行。因为忙等会消耗大量CPU资源,但是不涉及到操作系统上下文的切换，所以该锁适用于锁的持有者保存时间较短的情况，例如内存缓存的存取。

使用场景

- 预计线程等待锁的时间很短
- 加锁的代码（临界区）经常被调用，但竞争情况很少发生
- CPU资源不紧张
- 多核处理器

### 互斥锁

互斥锁：如果共享数据已经有其他线程加锁了，线程会进入休眠状态等待锁。一旦被访问的资源被解锁，则等待资源的线程会被唤醒。

#### 互斥锁使用情况

一般用于临界区持锁时间比较长的操作，如以下情况

- 预计线程等待锁的时间较长

- 临界区有IO操作
- 临界区代码复杂或者循环量大
- 临界区竞争激烈
- 单核处理器

### OSSpinLock

> 需要导入头文件#import <libkern/OSAtomic.h>
>
> `OSSpinLock`在iOS10.0以后就被弃用了，可以使用`os_unfair_lock_lock`替代。而且还有一些安全性问题：
>
> 安全性问题：苹果在iOS10以后定义了5个不同的线程优先级，高优先级线程始终会在低优先级线程前执行，一个线程不会受到比它更低优先级线程的干扰。如果一个低优先级线程获得锁并访问线程资源，一个高优先级线程在尝试获取这个锁时会处于spin lock的忙等状态而占用大量CPU，此时低优先级线程无法与高优先级线程争夺CPU，导致任务迟迟无法完成，无法解锁

#### 使用方法

```objc
OSSpinLock ticketLock = OS_SPINLOCK_INIT;	//初始化
OSSpinLockLock(&ticketLock);	//上锁
//对临界区的操作
OSSpinLockUnlock(&ticketLock);	//解锁
```

#### demo

```objc
#import "OSSpinLockDemo.h"
#import <libkern/OSAtomic.h>
@interface OSSpinLockDemo()
@property (assign, nonatomic) OSSpinLock ticketLock;
@end

@implementation OSSpinLockDemo

- (instancetype)init
{
self = [super init];
if (self) {
self.ticketLock = OS_SPINLOCK_INIT;
}
return self;
}


//卖票
- (void)sellingTickets{
OSSpinLockLock(&_ticketLock);

[super sellingTickets];

OSSpinLockUnlock(&_ticketLock);
}

@end
```

### os_unfair_lock

> 1.os_unfair_lock`用于取代不安全的`OSSpinLock`，从iOS10开始才支持 
> 2.从底层调用看，等待os_unfair_lock锁的线程会处于休眠状态，并非忙等
> 3.需要导入头文件`#import <os/lock.h>

#### 常用方法

```objc
//初始化
os_unfair_lock lock = OS_UNFAIR_LOCK_INIT;
//加锁
os_unfair_lock_lock(&lock);
//尝试加锁，加锁成功继续，加锁失败返回，继续执行后面的代码，不阻塞线程
os_unfair_lock_trylock(&lock);
//解锁
os_unfair_lock_unlock(&lock);
```

#### demo

```objc
#import "os_unfair_lockDemo.h"
#import <os/lock.h>
@interface os_unfair_lockDemo()
@property (assign, nonatomic) os_unfair_lock ticketLock;
@end

@implementation os_unfair_lockDemo
- (instancetype)init
{
self = [super init];
if (self) {
self.ticketLock = OS_UNFAIR_LOCK_INIT;
}
return self;
}

//卖票
- (void)sellingTickets{
os_unfair_lock_lock(&_ticketLock);

[super sellingTickets];

os_unfair_lock_unlock(&_ticketLock);
}
@end
```

### pthread_mutex

> mutex叫做”互斥锁”，等待锁的线程会处于休眠状态
>
> 需要导入头文件#import <pthread.h>

#### 使用步骤

```objc
//初始化属性
pthread_mutexattr_t attr;
pthread_mutexattr_init(&attr);
pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_RECURSIVE);

//初始化锁 
pthread_mutex_init(mutex, &attr);
//（我们可以不初始化属性，在传属性的时候直接传NULL，表示使用默认属性）：
pthread_mutex_init(mutex, NULL);

//初始化锁后销毁属性
pthread_mutexattr_destroy(&attr);

//加锁解锁
pthread_mutex_lock(&_mutex);
pthread_mutex_unlock(&_mutex);

//销毁锁
pthread_mutex_destroy(&_mutex);
```

关于属性

```objc
*
* Mutex type attributes
*/
#define PTHREAD_MUTEX_NORMAL        普通锁
#define PTHREAD_MUTEX_ERRORCHECK    错误检查
#define PTHREAD_MUTEX_RECURSIVE        递归锁
#define PTHREAD_MUTEX_DEFAULT        PTHREAD_MUTEX_NORMAL
```

#### demo

```objc
#import "pthread_mutexDemo.h"
#import <pthread.h>
@interface pthread_mutexDemo()
@property (assign, nonatomic) pthread_mutex_t ticketMutex;
@end

@implementation pthread_mutexDemo

- (instancetype)init
{
self = [super init];
if (self) {
// 初始化属性
pthread_mutexattr_t attr;
pthread_mutexattr_init(&attr);
pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_DEFAULT);
// 初始化锁
pthread_mutex_init(&(_ticketMutex), &attr);
// 销毁属性
pthread_mutexattr_destroy(&attr);


}
return self;
}

//卖票
- (void)sellingTickets{
pthread_mutex_lock(&_ticketMutex);

[super sellingTickets];

pthread_mutex_unlock(&_ticketMutex);
}
@end
```



#### 递归锁

使用条件：一个方法内部会上锁解锁，并且此方法会递归调用

demo：

```objc
#import "pthread_mutexDemo.h"
#import <pthread.h>
@interface pthread_mutexDemo()
@property (assign, nonatomic) pthread_mutex_t mutex;
@end

@implementation pthread_mutexDemo

- (instancetype)init
{
self = [super init];
if (self) {
// 初始化属性
    pthread_mutexattr_t attr;
    pthread_mutexattr_init(&attr);
    pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_RECURSIVE);
    // 初始化锁
    pthread_mutex_init(&_mutex, &attr);
		// 销毁属性
		pthread_mutexattr_destroy(&attr);

[self otherTest];
}
return self;
}
- (void)otherTest{
  pthread_mutex_lock(&_mutex);
    
    NSLog(@"%s", __func__);
    
    static int count = 0;
    if (count < 10) {
        count++;
        [self otherTest];
    }
    
    pthread_mutex_unlock(&_mutex);
}

@end
```

### NSLock、NSRecursiveLock

#### NSLock

- NSLock是对`mutex`普通锁的封装。`pthread_mutex_init(mutex, NULL);`

- NSLock 遵循 NSLocking 协议。

  - Lock 方法是加锁

  - unlock 是解锁

  - tryLock 是尝试加锁,如果失败的话返回 NO

  - lockBeforeDate: 是在指定Date之前尝试加锁，如果在指定时间之前都不能加锁，则返回NO

  ```objc
  @protocol NSLocking
  - (void)lock;
  - (void)unlock;
  @end
  
  @interface NSLock : NSObject <NSLocking> {
  @private
  void *_priv;
  }
  
  - (BOOL)tryLock;
  - (BOOL)lockBeforeDate:(NSDate *)limit;
  @property (nullable, copy) NSString *name
  @end
  ```

  

- 具体使用

```objc
#import "NSLockDemo.h"

@interface NSLockDemo()
@property (strong, nonatomic) NSLock *ticketLock;
@property (strong, nonatomic) NSLock *moneyLock;
@end

@implementation NSLockDemo


- (instancetype)init
{
    if (self = [super init]) {
        self.ticketLock = [[NSLock alloc] init];
        self.moneyLock = [[NSLock alloc] init];
    }
    return self;
}

// 卖票
- (void)__saleTicket
{
    [self.ticketLock lock];
    
    [super __saleTicket];
    
    [self.ticketLock unlock];
}
```

#### NSRecursiveLock

NSRecursiveLock也是对mutex递归锁的封装，API跟NSLock基本一致

### dispatch_semaphore

见之前CGD-信号量

###  dispatch_queue(DISPATCH_QUEUE_SERIAL)

GCD串行队列

### NSCondition

NSCondition是对`mutex`和`cond`的封装，可以确保线程仅在满足特定条件时才能获取锁。一旦获得了锁并执行了代码的关键部分，线程就可以放弃该锁并将关联条件设置为新的条件。条件本身是任意的：可以根据应用程序的需要定义它们。

```objc
@interface NSCondition : NSObject <NSLocking> {
- (void)wait;
- (BOOL)waitUntilDate:(NSDate *)limit;
- (void)signal;
- (void)broadcast;
@property (nullable, copy) NSString *name 
@end
```

生产者消费者例子

```objc
#import "NSConditionDemo.h"

@interface NSConditionDemo()
@property (strong, nonatomic) NSCondition *condition;
@property (strong, nonatomic) NSMutableArray *data;
@end

@implementation NSConditionDemo

- (instancetype)init
{
    if (self = [super init]) {
        self.condition = [[NSCondition alloc] init];
        self.data = [NSMutableArray array];
    }
    return self;
}

- (void)otherTest
{
    [[[NSThread alloc] initWithTarget:self selector:@selector(__remove) object:nil] start];
    
    [[[NSThread alloc] initWithTarget:self selector:@selector(__add) object:nil] start];
}

// 生产者-消费者模式

// 线程1
// 删除数组中的元素
- (void)__remove
{
    [self.condition lock];
    NSLog(@"__remove - begin");
    
    if (self.data.count == 0) {
        // 等待
        [self.condition wait];
    }
    
    [self.data removeLastObject];
    NSLog(@"删除了元素");
    
    [self.condition unlock];
}

// 线程2
// 往数组中添加元素
- (void)__add
{
    [self.condition lock];
    
    sleep(1);
    
    [self.data addObject:@"Test"];
    NSLog(@"添加了元素");
    
    // 信号
    [self.condition signal];
    
    sleep(2);
    
    [self.condition unlock];
}
@end
```

### NSConditionLock

NSConditionLock是对NSCondition的进一步封装，可以设置具体的条件值。根据条件值来设置对应线程的执行顺序

#### 常用方法

- `initWithCondition：`初始化`Condition`，并且设置状态值

- `lockWhenCondition:(NSInteger)condition:`当状态值为condition的时候加锁

- `unlockWithCondition:(NSInteger)condition`解锁并设置当前的状态值

#### demo

```objc
#import "NSConditionLockDemo.h"

@interface NSConditionLockDemo()
@property (strong, nonatomic) NSConditionLock *conditionLock;
@end

@implementation NSConditionLockDemo

- (instancetype)init
{
    if (self = [super init]) {
        self.conditionLock = [[NSConditionLock alloc] initWithCondition:1];
    }
    return self;
}

- (void)otherTest
{
    [[[NSThread alloc] initWithTarget:self selector:@selector(__one) object:nil] start];
    
    [[[NSThread alloc] initWithTarget:self selector:@selector(__two) object:nil] start];
    
    [[[NSThread alloc] initWithTarget:self selector:@selector(__three) object:nil] start];
}

- (void)__one
{
    [self.conditionLock lock];
    
    NSLog(@"__one");
    sleep(1);
    
    [self.conditionLock unlockWithCondition:2];
}

- (void)__two
{
    [self.conditionLock lockWhenCondition:2];
    
    NSLog(@"__two");
    sleep(1);
    
    [self.conditionLock unlockWithCondition:3];
}

- (void)__three
{
    [self.conditionLock lockWhenCondition:3];
    
    NSLog(@"__three");
    
    [self.conditionLock unlock];
}

@end
```

#### @synchronized

> 它是所有线程同步方案里面性能最差的,苹果非常不建议我们使用

`@synchronized`是对`mutex`递归锁的封装， `@synchronized(obj)`内部会生成obj对应的递归锁，然后进行加锁、解锁操作

```objc
@synchronized (lockObj) {
        /*
         加锁代码（临界区）
         */
    }
```

#### demo

```objc
@synchronized([self class]) {
        NSLog(@"123");
        [self otherTest];
    }
```

# 为什么iOS中不用atomic

atomic仅仅只是在该属性的成员变量在setter和getter的时候加上了线程同步锁，但是其他情况下并不能保证它是安全的。比如直接访问属性