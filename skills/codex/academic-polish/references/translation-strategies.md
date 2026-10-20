# 中英文学术翻译策略

本参考为中↔英学术翻译提供术语处理、句式重构、双语陷阱规避的系统方法。

## 一、核心原则

### 1.1 翻译 ≠ 转码

学术翻译**不是逐词替换**，而是：
1. **理解**原文本意
2. **重构**为目标语言的自然表达
3. **核实**术语准确性
4. **保留**修辞强度（hedges 不能轻易升级或降级）

### 1.2 翻译质量的双重标准

- **准确性**（不漏译、不误译、不擅自添加）
- **地道性**（读起来像目标语言母语学者写的）

**只满足其一都不合格**：
- 准确但生硬 = 翻译腔（EN→ZH）
- 地道但走样 = 自由发挥

## 二、中 → 英 翻译策略

### 2.1 句式重构

中文学术句式偏松散，常出现"长定语 + 多个并列分句"。翻译时需拆解：

**原句（中文）**：
> 本研究通过系统梳理近十年来国内外关于认知行为疗法对青少年抑郁症疗效的随机对照试验研究，综合分析了其在不同年龄、性别、疾病严重程度亚组中的效应量差异，旨在为临床实践提供更为精准的循证依据。

**直译（避免）**：
> This study, through systematically sorting out the past decade's domestic and foreign randomized controlled trials on the efficacy of cognitive behavioral therapy for adolescent depression, comprehensively analyzed its effect size differences in subgroups of different ages, genders, and disease severity, aiming to provide more precise evidence-based basis for clinical practice.

**学术化（推荐）**：
> We systematically reviewed randomized controlled trials from the past decade on cognitive behavioral therapy for adolescent depression. We computed pooled effect sizes across subgroups defined by age, sex, and baseline severity. This review aims to provide more precise, evidence-based guidance for clinical practice.

**改动要点**：
- 长句拆为 3 句
- "通过...综合分析了..." 拆为 2 个动词（reviewed, computed）
- "旨在" → This review aims to（主语明确）
- 删除冗余的"国内外"和"近十年来"（如果题目已说清）

### 2.2 学术动词选择

| 中文 | 直译（避免） | 学术化（推荐） |
| ---- | ------------ | -------------- |
| 研究 | study / research | investigate, examine |
| 发现 | find / discover | identify, reveal, demonstrate |
| 认为 | think / believe | argue, propose, suggest |
| 表明 | show / indicate | demonstrate, reveal, suggest |
| 探讨 | discuss | examine, explore |
| 综述 | summarize | synthesize, review |
| 进行 | carry out / conduct | perform, conduct, undertake |

### 2.3 中式英语 (Chinglish) 检测与修正

| 中式英语模式 | 修正 |
| ------------ | ---- |
| "the research of X" | "research on / into X" |
| "very..." | 删除或用具体程度 |
| "in China" 出现在 every sentence | 改用代词或重组 |
| "with the development of..." | 删除或用具体动词 |
| "play an important role in" | 用更具体的动词 |
| "more and more" | "increasingly" 或具体数字 |
| "in our country" | 在国际期刊中常被删除（除非必要） |
| "we take measures to..." | 用具体动作 |
| "has a great significance" | "is significant" 或 "matters because..." |

详见 `common-cn-errors.md`。

### 2.4 标点与格式转换

| 中文 | 英文 |
| ---- | ---- |
| 全角逗号"，" | 半角逗号"," |
| 全角括号"（）" | 半角"()" |
| 中文引号"" | 英文双引号"" |
| 破折号"——" | em-dash "—" |
| 数字千分位 "1,000" | "1,000"（中英文都用半角逗号） |
| 顿号"、" | 用逗号 + and |

## 三、英 → 中 翻译策略

### 3.1 避免翻译腔

**翻译腔**指英文原文的句式结构、被动语态、长定语等被生硬保留到中文里。

**原句（英文）**：
> It has been demonstrated by a number of studies that cognitive behavioral therapy can be considered to be effective in the treatment of adolescent depression.

**翻译腔（避免）**：
> 已经被许多研究证明的是，认知行为疗法可以被认为在青少年抑郁症的治疗中是有效的。

**学术化（推荐）**：
> 诸多研究表明，认知行为疗法对青少年抑郁症具有显著疗效。

**改动要点**：
- It has been demonstrated → 诸多研究表明
- can be considered to be → 去掉（中文不需要 hedging 套娃）
- in the treatment of → 对...具有疗效

### 3.2 句式重构原则

| 英文句式 | 中文对应 |
| -------- | -------- |
| Passive voice | 主动 / 无标记被动 / "被"字句 |
| Long noun phrases | 拆分为多个短句 |
| Multiple subordinate clauses | 拆分主干与修饰 |
| "It is X that Y" 强调句 | 直接陈述 |
| "However, ..., which ..., therefore ..." | 用中文逻辑连接词重组 |

### 3.3 学术词汇中文化

| 英文 | 直译（避免） | 学术化（推荐） |
| ---- | ------------ | -------------- |
| demonstrate | 证明 | 表明 / 证实 |
| investigate | 调查 | 考察 / 探究 |
| significant | 重要的 | 显著的（统计）/ 重要的（语义）|
| compare | 比较 | 对比 / 比较（视语境） |
| in contrast | 在对比中 | 相比之下 / 与此相反 |
| however | 然而 | 然而 / 不过 |
| therefore | 因此 | 因此 / 由此可见 |

### 3.4 量词与"被"字句

英文被动语态翻译成中文时：

| 英文 | 推荐中文 |
| ---- | -------- |
| "X is considered to be..." | "通常认为 X..." |
| "It is suggested that..." | "有研究提示..." |
| "X has been shown to..." | "已有研究表明 X..." |
| "X was found to..." | "研究发现 X..."（无标记被动）|

避免堆砌"被"字：
- ❌ "这个现象被认为是被..." 
- ✅ "通常认为此现象源于..." 

## 四、术语处理

### 4.1 通用原则

- **首次出现**给中英对照（"血清素 (serotonin)"）
- **之后单独使用**任一语言
- **保留约定俗成**的术语，不要自创新译

### 4.2 学科常用术语对照（精选）

| 中文 | 英文 |
| ---- | ---- |
| 认知行为疗法 | cognitive behavioral therapy (CBT) |
| 抑郁症 | depression / major depressive disorder (MDD) |
| 青少年 | adolescents / youth |
| 随机对照试验 | randomized controlled trial (RCT) |
| 系统综述 | systematic review |
| 元分析 | meta-analysis |
| 效应量 | effect size |
| 异质性 | heterogeneity |
| 偏倚 | bias |
| 漏斗图 | funnel plot |
| 置信区间 | confidence interval (CI) |
| 突触可塑性 | synaptic plasticity |
| 工作记忆 | working memory |
| 神经影像 | neuroimaging |
| 功能性磁共振成像 | functional magnetic resonance imaging (fMRI) |
| 表观遗传 | epigenetics |
| 微生物组 | microbiome |

### 4.3 不要音译

- ❌ "meta-分析" → ✅ "元分析" 或 "meta-分析"
- ❌ "随机化对照试验" → ✅ "随机对照试验"
- ❌ "循证医学" → ✅ "循证医学" (或 evidence-based medicine, 但中文版用前者)

## 五、标题翻译

### 5.1 中 → 英 标题

- 名词短语为主，少用完整句
- 关键词前置
- 避免冗余修饰

**原标题（中文）**：
> 认知行为疗法对青少年抑郁症患者干预效果的随机对照试验系统综述

**直译（避免）**：
> A Systematic Review of Randomized Controlled Trials on the Intervention Effect of Cognitive Behavioral Therapy on Adolescent Depression Patients

**学术化（推荐）**：
> Cognitive Behavioral Therapy for Adolescent Depression: A Systematic Review of Randomized Controlled Trials

### 5.2 英 → 中 标题

- 可用冒号分隔主副标题
- 重要概念可加"研究"、"分析"、"综述"作后缀

**原标题（英文）**：
> Working Memory Training Enhances Cognitive Control in ADHD: A Randomized Controlled Trial

**学术化（推荐）**：
> 工作记忆训练改善 ADHD 儿童认知控制：一项随机对照试验

## 六、避免最常见的翻译错误

1. **机翻痕迹**：动词名词化（如 "对...进行分析" → "分析了"）
2. **过度对仗**：强行四字结构（如 "在...的情况之下" → "在...时"）
3. **术语不一致**：同一术语前后译法不同
4. **被动语态堆砌**：过多 "被"字
5. **丢失 hedge**：原文 "may" / "suggest" 译成 "证明"
6. **添加内容**：翻译时"顺手"补全原文没说的内容
7. **缩写不一致**：首次定义后再用时大小写不一致

## 七、保留双语术语表的实用建议

翻译长文档（论文、学位论文、综述）时：

1. **首次出现**双语对照 + 英文缩写
2. **之后单独使用**任一语言
3. **建立术语表** (translation memory)，长文档统一
4. **跨文档一致**：同一团队 / 实验室术语统一