# M1 数据来源与队列构成

> 所属 skill：paper-insight-reporter。模块索引与通用约定见 [../extraction-modules.md](../extraction-modules.md)。

## 触发信号

段落出现 "To build / we collected / we obtained / we analyzed ... samples / dataset / cohort"，或交代样本纳入、分组、配对设计。通常出现在 Results 第一段，或每个独立数据集首次登场处。

## 必填字段

| 字段 | 要求 |
|---|---|
| 数据模态与平台 | 测序/成像类型 + 平台 + 参考基因组。本段未给就写"本段未给"，标注去 Methods 核对 |
| 规模三件套 | 样本数、个体数、研究数。三者缺任一即为关键缺口 |
| 样本类型分组 | 逐条列：原文缩写 \| 原文全称 \| 中译 \| 数量 |
| 配对/纵向设计 | 是否同个体配对、配对比例。照抄原文口径（"接近一半"不等于"超过一半"） |
| 覆盖范围 | 癌种、原发器官、取样器官、时间点。严格区分"原发部位"与"转移部位" |
| 原文锚点 | 至少一句关键英文原句 + 图/表编号 |

## 选填字段

- 数据可获得性：accession、数据库、门户。本段未给时记"待查"，不写"未提供"
- 数据性质：新产生数据，还是公共数据二次整合
- 下一级规模数据（如细胞总数）

## 交付格式

按 SKILL.md 的四个部分出。"方法与复现要素"里 M1 的"方法"栏主要是数据从哪来、怎么取得，工具与参数多留待 Methods 核对。

## 格式样例

> 以下为**虚构示例**，仅示范输出格式，不对应任何真实文献。

**数据字段**

| 字段 | 内容 | 原文锚点 |
|---|---|---|
| 样本 / 个体 / 研究数 | 96 / 64 / 12 | "96 scRNA-seq samples compiled from 64 individuals across 12 independent studies" |
| 细胞总数 | 512,340（下一段才给） | "we retained 512,340 high-quality cells" |
| 癌种 / 取样部位 | 1 种癌、4 类取样部位：癌前病变、原发瘤、转移灶Ⅰ、转移灶Ⅱ | "premalignant lesions, primary tumours and two types of metastases" |
| 样本类型 | 病变组织 + 癌旁组织 + 正常组织 | "along with adjacent normal and healthy tissues" |
| 配对设计 | 约三分之一为同一个体的配对组织 | "roughly one-third of the dataset consisting of matched tissues from the same individual" |
| 数据性质 | 公共数据二次整合 | Methods "obtained from publicly available datasets" |
| 引用图表 | Fig. 1a、Fig. 1b；Table S1 | "(Fig. 1a and b and Table S1)" |

**问题**

| 问题 | 说明 |
|---|---|
| 分组缩写未展开 | 取样部位的四个缩写只在 Fig. 1a 图注给出 |
| 各类样本的数量未给 | 本段只说"包括哪几类"，未给每类各多少例 |
| 配对样本绝对例数未给 | 只有"约三分之一" |

**图表映射（按图型）**

| 图型 | 能支持 | 不能支持 | 看图要点 |
|---|---|---|---|
| 饼图 | 样本构成比 | 绝对数量 | 分母是样本总数 |
| 分布热图 | 各群在组织与样本中的分布 | 组间差异显著性 | 先确认分子与分母 |
