# 《代码整洁之道》第1-3章 详细学习笔记

> 作者：Robert C. Martin (Bob大叔)
> 章节：第一部分 整洁代码的基础

---

# 第1章 整洁代码

## 1.1 糟糕代码的代价

### 什么是糟糕的代码？

- 代码缺乏清晰结构，难以理解
- 变量名、函数名没有意义
- 函数过长，承担过多职责
- 重复代码遍布各处
- 缺乏注释或注释过时

### 糟糕代码的代价是什么？

1. **理解成本高**
   - 每次修改需要理解多出代码
   - 新人接手需要更长时间

2. **维护成本高**
   - 每修改一处，影响多处
   - 修Bug引入新Bug

3. **生产力下降**
   - 初期开发"迅速"
   - 后期改一点点都要花很长时间
   - 最终生产力趋向于零

4. **团队士气低落**
   - 害怕改动代码
   - 抵触需求变更
   - 抱怨"历史遗留问题"

---

## 1.2 破窗理论

### 起源

心理学上的"破窗理论"源自一项实验：
- 完好无损的车子放在街头，数周无人理睬
- 打破一扇窗户后，车子很快被偷走或拆解

### 在代码中的应用

- 对糟糕的代码放任不管
- 会让团队成员觉得"这里本来就是这样的"
- 人们争相效仿，甚至变本加厉
- 最终整个代码库腐烂

### 解决方法

- 发现问题立即修复
- 不要想"以后再改"
- 保持代码整洁是一种习惯

---

## 1.3 混乱的代价

### 华丽新设计

很多团队看到糟糕代码后的反应：
> "我们重写吧！"

但重写意味着：
- 巨大风险
- 长时间开发
- 可能重蹈覆辙
- 业务中断

### 更好的方式

- 渐进式改进
- 每次改动顺带清理周边代码
- 保持代码整洁是一种习惯

### 态度问题

常见错误态度：
- "先上线，以后再改"
- "时间紧，没办法"
- "这只是临时方案"

**勒布朗法则：**
> Later equals never
> "以后"等于"永不"

**真相：**
- 赶工期的唯一方法：从一开始就写整洁代码
- 技术债务，利滚利

---

## 1.4 什么是整洁代码

### 各路大神的定义

**Bjarne Stroustrup（C++之父）：**
> 优雅（Elegant）、高效（Efficient）、只做好一件事（does one thing well）

**Grady Booch（《面向对象分析与设计》作者）：**
> 整洁代码是简单直接的逻辑，读者可以把它当作自己写的

**Dave Thomas（O TI创始人）：**
> 整洁代码可以被除了作者之外的其他人阅读和修改

**Michael Feathers（《修改代码的艺术》作者）：**
> 整洁代码看起来像是一种精心为它写的语言

**Uncle Bob本人：**
> 整洁代码让缺陷难以隐藏，便于维护

---

## 1.5 童子军军规

### 原话

> "Make the camp cleaner than when you arrived."

### 含义

- 离开时把营地清理干净
- 比来时更干净

### 在代码中的应用

- 每次提交代码
- 代码都比检出时更干净
- 即使只改了一行，也要保持周围代码整洁

### 实践

```javascript
// 你来改一个函数，发现它命名不清晰
// 不要只改你需要改的部分
// 顺便把命名也改好

// 改之前
function calc(a, b) {
    return a * b * 0.1;
}

// 改之后（顺便改了命名）
function calculateDiscount(price, quantity) {
    return price * quantity * 0.1;
}
```

---

## 1.6 核心理念总结

> **消除重复，只做一件事，提高表达力，小规模抽象**

这16个字概括了全书全部内容。

---

# 第2章 有意义的命名

## 2.1 命名为什么重要

### 核心事实

- 读代码的时间 >> 写代码的时间
- 比例超过 **10:1**
- 好的命名节省的时间，远大于起名花的时间

### 命名本质

- 命名是给未来阅读代码的人（包括自己）看的
- 是代码清晰表达意图的最重要手段

---

## 2.2 名副其实

### 原则

变量名、函数名应该回答：
- 它是什么？
- 它做什么？
- 怎么使用？

### 反例 vs 正例

```javascript
// ❌ 差：看了等于没看
let d;
let temp;
let data;
let info;
const list = [];

// ✅ 好：顾名思义
let elapsedDays;
let tempBuffer;
let rawData;
let customerInfo;
const activeCustomers = [];
```

```java
// ❌ 差
public int getL() {
    return l.size();
}

// ✅ 好
public int getListSize() {
    return list.size();
}
```

---

## 2.3 避免误导

### 问题1：避免使用 List 之类的词

```java
// ❌ 误导：名字包含List，但类型不是List
List<Account> accountList;

// ✅ 好：直接用复数
List<Account> accounts;

// 或者如果需要说明
List<Account> accountCollection;
```

### 问题2：避免使用类型编码

```javascript
// ❌ 差
const stringName = "张三";
const numberAge = 25;
const booleanActive = true;

// ✅ 好
const name = "张三";
const age = 25;
const isActive = true;
```

### 问题3：避免太小或太像的字母

```javascript
// ❌ 差：这些字母难以分辨
const l = 1;
const I = 1;
const O = 0;
const 0 = 0;

// ✅ 好
const left = 1;
const right = 1;
const output = 0;
```

---

## 2.4 做有意义的区分

### 无意义的区分

| ❌ 差 | ✅ 好 | 说明 |
|--------|-------|------|
| `ProductInfo` | `Product` | Info 无意义 |
| `ProductData` | `Product` | Data 无意义 |
| `ProductObject` | `Product` | Object 无意义 |
| `getAccount()` | `getCustomer()` | 同一概念用不同词 |

### 同一个概念用同一个词

```javascript
// ❌ 差：一个团队用不同词
fetchCustomer()
getUser()
retrieveProduct()

// ✅ 好：统一
getCustomer()
getUser()
getProduct()
```

### 有意义的参数区分

```c
// ❌ 差
copyChars(char* a1, char* a2)

// ✅ 好
copyChars(char* destination, char* source)
```

---

## 2.5 使用读得出来的名称

### 原则

- 名称要能读出来
- 不要用自创的缩写
- 代码是给人读的，不是给机器读的

### 反例 vs 正例

```javascript
// ❌ 差
const genymdhms = new Date(); // 什么鬼？

// ✅ 好
const generationTimestamp = new Date();
```

```java
// ❌ 差
class DtaRcrd102 {
    private Date modymdhms;
}

// ✅ 好
class CustomerRecord {
    private Date modificationTimestamp;
}
```

---

## 2.6 使用可搜索的名称

### 原则

- 名称要容易被搜索到
- 太短的名字难以搜索
- 数字 literals 难以搜索

### 反例 vs 正例

```javascript
// ❌ 差
for (let i = 0; i < 7; i++) {
    // 不知道7是什么
    scheduleTask(i);
}

// ✅ 好
const DAYS_IN_WEEK = 7;
for (let day = 0; day < DAYS_IN_WEEK; day++) {
    scheduleTask(day);
}
```

```java
// ❌ 差
if (status == 4) {
    // 不知道4是什么
}

// ✅ 好
private static final int STATUS_APPROVED = 4;
if (status == STATUS_APPROVED) {
    // ...
}
```

---

## 2.7 避免使用编码

### 原则

- 除非项目规范要求
- 不要用类型前缀、编码等

### 常见编码（避免）

| 编码类型 | 例子 | 说明 |
|----------|------|------|
| 匈牙利标记法 | `strName`, `iCount` | JavaScript/TypeScript 不需要 |
| 成员前缀 | `m_name` | 现代语言不需要 |
| 接口前缀 | `ICustomer` | Java 常用但不是必须 |

### 注意事项

> 遵循项目/团队的编码规范
> 如果团队用 Google C++ 规范，那就用 `m_` 前缀

---

## 2.8 类名

### 原则

- 使用名词或名词短语
- 不要用动词

### 好例子

```
Customer
Account
ProductRepository
PaymentProcessor
```

### 避免

```
Manager (太笼统)
Processor (太笼统)
Data (无意义)
Handler (太笼统)
```

---

## 2.9 方法名

### 原则

- 使用动词或动词短语
- 访问器用 `get`, `set`, `is` 开头
- 修改器用动词
- 构造函数使用静态工厂方法

### 好例子

```java
// 访问器
getName()
setName()
isActive()

// 修改器
delete()
save()
addItem()

// 静态工厂
Customer.withName(String name)
Customer.fromJson(String json)
```

---

## 2.10 别扮可爱

### 原则

- 名称要描述功能
- 不要用俏皮话、玩笑话
- 未来的人可能不懂

### 反例 vs 正例

```javascript
// ❌ 差：俏皮话
function holyHandGrenade() { } // 圣手榴弹？

// ✅ 好：描述功能
function deleteAllItems() { }


// ❌ 差：只有你懂
function whack() { } // 打地鼠？

// ✅ 好
function activate() { }
```

---

## 2.11 每个概念对应一个词

### 原则

- 同一概念用同一词
- 不要用同义词

### 反例 vs 正例

```javascript
// ❌ 差
getUser()
fetchProduct()
retrieveCustomer()

// ✅ 好
getUser()
getProduct()
getCustomer()
```

---

## 2.12 别用双关语

### 原则

- 一个词只用一个含义
- 避免一词多义

### 反例 vs 正例

```java
// ❌ 差：一个方法名两个含义
int add(int a, int b) { return a + b; }
void add(String item) { list.add(item); }

// ✅ 好
int sum(int a, int b) { return a + b; }
void append(String item) { list.add(item); }
```

---

## 2.13 添加有意义的语境

### 原则

- 如果需要，给相关变量添加前缀
- 或者封装成类

### 例子

```javascript
// ❌ 差：孤立变量
const firstName = "张";
const lastName = "三";
const number = "123";

// ✅ 好：添加语境
class Customer {
    firstName = "张";
    lastName = "三";
    accountNumber = "123";
}
```

---

## 2.14 不要添加没用的语境

### 原则

- 名称不要过长
- 不要加不必要的词

### 反例 vs 正例

```javascript
// ❌ 差：前缀太长
const customerFirstName = "张";
const customerLastName = "三";

// ✅ 好
const firstName = "张";
const lastName = "三";
```

---

## 2.15 命名总结

### 快速检查清单

- [ ] 名称是否顾名思义？
- [ ] 名称是否能读出来？
- [ ] 名称是否容易被搜索？
- [ ] 是否有无意义的区分？
- [ ] 是否有类型编码？
- [ ] 类名是否是名词？
- [ ] 方法名是否是动词？
- [ ] 是否用了双关语？

---

# 第3章 函数 ⭐ 最重要的一章

## 3.1 短小

### 函数应该多短？

- **10-20 行** 是理想长度
- 甚至更短（5-10行）更好
- 每个函数只做一件事

### 为什么短函数更好？

1. **容易理解**
2. **容易测试**
3. **容易复用**
4. **容易维护**

### 短函数示例

```java
// ❌ 差：一个函数做太多事
public void submitOrder(Order order) {
    // 验证订单
    if (order.getItems().isEmpty()) {
        throw new IllegalArgumentException("订单不能为空");
    }
    if (order.getCustomer() == null) {
        throw new IllegalArgumentException("客户不能为空");
    }
    if (order.getAddress() == null) {
        throw new IllegalArgumentException("地址不能为空");
    }
    
    // 计算价格
    double total = 0;
    for (Item item : order.getItems()) {
        total += item.getPrice() * item.getQuantity();
    }
    if (order.hasDiscount()) {
        total *= 0.9;
    }
    order.setTotal(total);
    
    // 保存
    database.save(order);
    
    // 发邮件
    emailService.send(order.getCustomer().getEmail(), "订单已提交");
    
    // 记录日志
    logger.info("订单已提交: " + order.getId());
    
    // 更新缓存
    cache.invalidate(order.getCustomer().getId());
}

// ✅ 好：每个函数只做一件事
public void submitOrder(Order order) {
    validateOrder(order);
    calculateTotal(order);
    saveOrder(order);
    notifyCustomer(order);
    logOrderSubmission(order);
    updateCache(order);
}
```

---

## 3.2 只做一件事

### 定义

> 如果一个函数做了多件事，就可以把它拆分成多个函数

### 如何判断是否只做一件事？

**自检问题：**
- 这个函数是否做了超过一件事？
- 这个函数的每个步骤是否在同一抽象层级？
- 能否从函数中提取出另一个函数？

### 例子

```java
// ❌ 差：做了多件事
public void saveAndSendEmail(User user) {
    database.save(user);           // 保存用户
    String email = user.getEmail(); // 获取邮箱
    // 发送欢迎邮件
    emailService.send(email, "欢迎！");
}

// ✅ 好：拆分成两个函数
public void saveUser(User user) {
    database.save(user);
}

public void sendWelcomeEmail(User user) {
    emailService.send(user.getEmail(), "欢迎！");
}
```

---

## 3.3 每个函数一个抽象层级

### 什么是抽象层级？

- **高层级**：做什么（What）- 业务目标
- **中层级**：怎么做（How）- 实现步骤
- **低层级**：细节（Details）- 具体语法

### 例子

```java
// ✅ 好：同一抽象层级 - 都是"怎么做"
public void payOrder() {
    verifyPaymentMethod();      // 验证支付方式
    processPayment();           // 处理支付
    updateOrderStatus();        // 更新订单状态
    sendConfirmation();        // 发送确认
}

// ❌ 差：混合了抽象层级
public void payOrder() {
    // 高层级
    verifyPaymentMethod();
    
    // 低层级 - 这是细节，不应该在这里
    if (paymentMethod == "credit_card") {
        card.process(cardNumber, amount);
    } else if (paymentMethod == "paypal") {
        paypal.api.call(token, amount);
    }
    
    // 高层级
    updateOrderStatus();
}
```

### 自顶向下阅读原则

> 代码应该像报纸一样，从高层开始阅读，逐步深入细节

---

## 3.4 switch 语句

### 问题

- switch 天然要做多件事
- 难以短小
- 难以避免重复

### 解决方案：多态

```java
// ❌ 差：switch 做了多件事
public Money calculatePay(Employee employee) {
    switch (employee.getType()) {
        case HOURLY:
            return calculateHourlyPay(employee);
        case SALARY:
            return calculateSalaryPay(employee);
        case COMMISSION:
            return calculateCommissionPay(employee);
        default:
            throw new InvalidEmployeeType();
    }
}

// ✅ 好：利用多态，把选择逻辑隐藏
public abstract class Employee {
    public abstract Money calculatePay();
}

public class HourlyEmployee extends Employee {
    public Money calculatePay() {
        // 计算小时工资
    }
}

public class SalariedEmployee extends Employee {
    public Money calculatePay() {
        // 计算月薪
    }
}
```

---

## 3.5 使用描述性的名称

### 原则

- 名称要描述函数做什么
- 名称长一点没关系
- 保持一致性

### 好例子

```java
// ✅ 好：名称描述了具体行为
public void deleteAllExpiredOrders() { }
public void calculateMonthlyRevenue() { }
public void sendWelcomeEmailToCustomer() { }
```

### 保持一致性

```java
// ✅ 好：同系列函数命名一致
public void saveCustomer() { }
public void updateCustomer() { }
public void deleteCustomer() { }

// ✅ 好：同一操作不同对象命名一致
public Money calculateWeeklyPay() { }
public Money calculateMonthlyPay() { }
public Money calculateYearlyPay() { }
```

---

## 3.6 函数参数

### 参数数量原则

| 参数数量 | 评价 |
|----------|------|
| 0 | 最好 |
| 1 | 好 |
| 2 | 可以 |
| 3 | 避免 |
| 4+ | 封装为对象 |

### 为什么参数越少越好？

- 难以测试
- 难以理解
- 组合爆炸

### 一元函数（1个参数）

常见形式：

```java
// 1. 转换：返回转换后的值
String fileName = file.getName();
String transformed = transformFileName(fileName);

// 2. 条件：返回布尔值
boolean fileExists(String path) { }

// 3. 事件：没有返回值，只做操作
void fileSave(String content) { }
```

### 避免标识参数

```java
// ❌ 差：标识参数
render(true); // true 是什么？
renderForScreen();
renderForPrint();
render(false);

// ✅ 好：分成两个函数
renderForScreen();
renderForPrint();
```

### 二元函数（2个参数）

```java
// ⚠️ 尽量避免
void writeField(String name, String value) { }

// ✅ 更好的方式：封装
field.setName(name);
field.setValue(value);
```

### 三元及以上：封装为对象

```java
// ❌ 差
Circle makeCircle(double x, double y, double radius) { }

// ✅ 好
Circle makeCircle(Point center, double radius) { }
// 或者
class Circle {
    static Circle create(double x, double y, double radius) { }
}
```

---

## 3.7 命令与查询分离

### 原则

- 要么**做**一件事（命令）
- 要么**查询**一件事（查询）
- 不要混合

### 反例 vs 正例

```java
// ❌ 差：既是命令又是查询
public boolean set(String attribute, String value) {
    // 设置了值，同时返回是否成功
}

// ✅ 好：分离
public void set(String attribute, String value) { /* 设置 */ }
public boolean has(String attribute) { /* 查询 */ }
```

---

## 3.8 使用异常而非返回码

### 老式方法：返回码

```java
// ❌ 差：返回码
if (deletePage(page) == OK) {
    // 成功
} else {
    // 失败
}

// 问题：
// 1. 调用者必须立即检查
// 2. 容易忘记检查
// 3. 代码变乱
```

### 现代方法：异常

```java
// ✅ 好：使用异常
try {
    deletePage(page);
    // 成功
} catch (Exception e) {
    // 失败
}
```

---

## 3.9 抽离 Try/Catch

### 原则

- try/catch 抽离成独立函数
- 保持业务逻辑清晰

### 反例 vs 正例

```java
// ❌ 差：try/catch 混在业务代码中
public void delete(Page page) {
    try {
        registry.delete(page);
        logger.info("Page deleted: " + page.getPath());
    } catch (Exception e) {
        logger.error("Delete failed", e);
    }
}

// ✅ 好：抽离
public void delete(Page page) {
    try {
        doDelete(page);
    } catch (Exception e) {
        logError(e);
    }
}

private void doDelete(Page page) {
    registry.delete(page);
    logger.info("Page deleted: " + page.getPath());
}
```

---

## 3.10 重复是最恶魔的敌人

### 什么是重复？

- 同样的代码出现多次
- 相似的代码出现多次
- 类似的逻辑出现多次

### 重复的问题

- 维护成本翻倍
- 修改时容易遗漏
- Bug 容易传播

### 解决

- **DRY 原则**：Don't Repeat Yourself
- 提取重复代码成函数
- 使用继承/组合

---

## 3.11 函数总结

### 核心军规

| 规则 | 说明 |
|------|------|
| **短小** | 10-20 行以内 |
| **只做一件事** | 一个函数，一个目的 |
| **命名描述性** | 长名称比短名称好 |
| **参数少** | 0-2 个最好 |
| **抽象层级一致** | 高层只调高层 |
| **命令查询分离** | 要么做，要么查 |
| **异常而非返回码** | try/catch 抽离 |
| **无重复** | DRY 原则 |

### 快速自检清单

- [ ] 函数 < 20 行？
- [ ] 只做一件事？
- [ ] 命名描述做什么？
- [ ] 参数 ≤ 2 个？
- [ ] 嵌套层级 ≤ 2 层？
- [ ] 无重复代码？

---

# 第1-3章 核心要点总结

## 核心理念

> **消除重复，只做一件事，提高表达力，小规模抽象**

## 关键数字

- **10:1**：读代码时间 vs 写代码时间
- **20 行**：函数最大长度
- **2 个**：函数参数建议上限

## 童子军军规

> 每次提交代码时，代码都比检出时更干净

## 快速自检表

| 检查项 | 是 | 否 |
|--------|----|-----|
| 命名顾名思义？ | ☐ | ☐ |
| 函数 < 20 行？ | ☐ | ☐ |
| 函数只做一件事？ | ☐ | ☐ |
| 参数 ≤ 2 个？ | ☐ | ☐ |
| 嵌套 ≤ 2 层？ | ☐ | ☐ |
| 无重复代码？ | ☐ | ☐ |
| 使用异常处理？ | ☐ | ☐ |
| 代码比来时干净？ | ☐ | ☐ |
