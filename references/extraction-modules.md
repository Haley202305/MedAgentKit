# 提取模块：索引与通用约定

模块是逐步固化的。只有 `modules/` 下写明了字段定义的模块才算"已建立"；遇到尚未固化的信息类型时，按 SKILL.md 的铁律做临时提取，交付后询问用户是否固化，确认后在 `modules/` 新建文件并登记到下表。

## 模块索引

| 模块 | 覆盖的信息类型 | 触发信号速查 | 定义文件 |
|---|---|---|---|
| M1 | 数据来源与队列构成 | "we collected / obtained / analyzed ... samples"、"compiled from ... individuals" | [modules/m1-data-cohort.md](modules/m1-data-cohort.md) |
| M2 | 分群与细胞组成 | "we annotated ... cell types"、"we subdivided ... into ... subtypes"、"the distribution of cell proportions" | [modules/m2-clustering-composition.md](modules/m2-clustering-composition.md) |
| M3 | 分型定义与组间特征 | "To systematically characterize ..."、"grouped ... into N clusters"、"hereafter referred to as ..." | [modules/m3-program-definition.md](modules/m3-program-definition.md) |
| M4 | 独立维度刻画与分组互证 | "To establish a framework for ..."、"we calculated <metric> across ..."、"this observation aligns with ..." | [modules/m4-orthogonal-dimension.md](modules/m4-orthogonal-dimension.md) |
| M5 | 轨迹与拟时序 | "To uncover the differentiation dynamics ..."、"pseudotime"、"trajectory"、"transition from A to B" | [modules/m5-trajectory-pseudotime.md](modules/m5-trajectory-pseudotime.md) |
| M6 | 临床关联与预后分析 | "survival analysis"、"Kaplan-Meier"、"correlated with poor prognosis"、"TCGA" | [modules/m6-clinical-prognosis.md](modules/m6-clinical-prognosis.md) |
| M7 | 细胞通讯与配体-受体推断 | "cell–cell communication"、"ligand–receptor"、"interaction strength"、"CellPhoneDB" | [modules/m7-cell-communication.md](modules/m7-cell-communication.md) |
| M8 | 空间与实验验证 | "spatial deconvolution"、"multiplex immunofluorescence"、"colocalization"、"validated by" | [modules/m8-spatial-experimental-validation.md](modules/m8-spatial-experimental-validation.md) |

只读当前小节命中的模块，不要一次载入全部。

引言与讨论不按模块处理，用 [introduction-and-discussion.md](introduction-and-discussion.md) 里的固定模板。

## 通用约定

### 实例保留规则

每个模块保留**一个**完整实例，用于校准输出格式。实例一律使用**虚构示例**（标注"不对应任何真实文献"），不使用任何真实论文的内容——这样模块文件可以直接随 skill 分发，不涉及第三方论文的版权，也不会有读者把示例中的数字误当成真实发现。

实例只示范格式，不追求覆盖所有情形。需要更多真实案例时，看该论文自己的拆解产出，不往模块文件里追加。

### 分析单元：跟随作者的小节结构

分析单元**不由我们定义，由作者的小节标题定义**。

- 每个 Results 小节 = 一个分析单元，按论文中的出现顺序编号 `result-01`、`result-02`……
- 编号与小节标题一一对应；标题照抄英文原文，另附中译
- 一个小节若同时承载多个模块的信息，在同一份单元文件里分节写，不要拆成多个文件
- 一个小节若覆盖多个细胞类型或对象，仍按作者的小节走，不按分析对象重新划分
- **作者的组织结构本身就是信息**：缺了哪一环、哪一环被合并处理、哪一环只在讨论里补，都要在索引里标出来

### 产出结构：中间产物与交付物分开

每篇文献的拆解涉及两类文件，分开放：

```
work/<paper-slug>/            中间产物，不作为交付物
├── result-01-<slug>.md       每个结果小节一份，构成四部分
├── result-02-<slug>.md
└── ...

outputs/<paper-slug>/         交付物
└── <paper-slug>-report.html  合并后的完整报告，单文件自包含
```

交付目录里只放 HTML。中间 markdown 写在 work/ 下，通过构建脚本渲染成 HTML——内容只写一次，需要修改时改 md 重跑，避免手抄 HTML 引入偏差。用户明确要求时才把中间 markdown 一并交付。

单元文件固定四个部分：一句话结论、主要发现（逐条详写，带图号）、方法与复现要素（含图表映射的合并表）、逻辑张力与问题（一段话）。

各模块需要额外检查的点一律写进第 4 部分，不另起小节：

| 模块 | 特有固定小节 |
|---|---|
| M1 | 缺口清单（"原文未给出"逐条列） |
| M2 | 层级矛盾（同一批群在不同章节被叫成不同级别） |
| M3 | 逻辑张力、歧义句 |
| M4 | 交叉分组检查、反向结果的处理 |
| M5 | 方向性检查、循环性与自洽性检查 |
| M6 | 代理指标检查、队列适格性检查、KM 曲线形状检查 |
| M7 | 预测与验证的界限、机制链有无直接检验 |
| M8 | 验证层级检查、测量—概念错位检查 |

### 索引用法

索引写在 `work/<paper-slug>/00-index.md`，是拆解过程中的进度盘与交叉索引，同样属于中间产物。至少维护四张表：

1. 小节清单：编号、英文标题、中译、所属模块、状态（未读 / 已拆 / 已校验）
2. 图表清单：图/表编号、图型、位置、承载哪些小节
3. 术语表：缩写、全称、首次出现位置、是否在原文中有定义
4. 交叉索引：按主题或按分组（如各 program / 各亚群）反查相关内容分布在哪几个小节

索引不进 HTML 报告：图表清单与术语表是给拆解者自己用的，报告读者不需要。用户明确索取时再单独给。
