# Book 2: Search Intelligence

Use this reference when the user needs keywords, search queries, synonym libraries, search-result testing, corpus boundaries, or literature-library construction.

## Source Scope

Distilled from the `《科研论2：AI时代下的搜商》` section of the Keyanlun column index, the five-step article's `搜` and `聚` explanations, and the homepage layer table. The index emphasizes search intelligence, non-discipline-specific use, output-style learning, multiple search cases, universal search queries, and exporting search results into a literature library.

## Core Model

Search is not "find a few papers." Search is the first debugging tool for research. It determines whether later grouping, verification, experiments, theory, code, and writing have enough raw material.

The search task is complete only when it produces a bounded and inspectable corpus or a better query, not when the user feels they have read something.

## Chapter-Level Method Cards

### Card 1: 输出式学习

Use when the user wants to "learn the field" before acting.

Method:

1. Ask what output the search should create.
2. Force every search session to end with a tangible artifact: keyword map, query log, corpus, or problem evidence.
3. If the user cannot name an output, route back to Book 1 or Book 3.

Deliverable:

- Search output statement.
- Artifact format.
- Stop condition.

### Card 2: 万能检索式

Use when building queries for an unfamiliar or overly broad topic.

Method:

1. Split the search target into smallest meaningful components.
2. Test the smallest unit first.
3. Use deletion tests: remove or simplify terms to see which term controls recall/precision.
4. If results are too many, add `AND` constraints: object + method + performance + context + mechanism.
5. If results are too few, remove constraints, add synonyms, or switch databases/search mode.
6. Record each attempt; the failed attempts are part of the search intelligence.

Deliverable:

```markdown
检索目标：
最小单元：
同义词：
删减测试：
AND 叠加测试：
结果数量/质量：
保留检索式：
下一步：
```

### Card 3: 语义/AI搜索与传统检索配合

Use when the user uses Semantic Scholar, AI search, or embedding-style search and wonders whether Boolean search is still needed.

Method:

1. Use semantic search to discover vocabulary and adjacent expressions.
2. Use structured database queries to test coverage and export a stable corpus.
3. Use targeted fishing queries to fill gaps.
4. Do not treat one search platform as complete evidence.

Deliverable:

- Semantic discovery terms.
- Structured query.
- Gap-filling query.
- Corpus export plan.

### Card 4: 文献库形成

Use when the user has queries but no corpus.

Method:

1. Choose database/export source based on field and available metadata.
2. Export with abstracts/keywords when possible.
3. If result volume exceeds export limits, split by year or subquery.
4. Preserve search provenance so later grouping can trace where papers came from.

Deliverable:

- Export batches.
- Metadata fields.
- Corpus boundary.
- De-duplication plan.

## Search Modes

### Broad Recall Mode

Use when the user fears missing important work or does not yet know the field vocabulary.

Actions:

- Start from advisor/lab/project keywords or real-world demand.
- Expand with synonyms, object words, method words, performance words, mechanism words, population/context words, and adjacent-field words.
- Test query variants and track result counts.
- Keep possibly relevant items when title/abstract/keywords indicate enough signal.

Output:

- Keyword map.
- Inclusion/exclusion rule.
- Query log.
- Corpus boundary.

### Targeted Fishing Mode

Use when the user has a concrete question: a failed experiment, code error, theoretical route, empirical design, discussion point, or wording problem.

Actions:

- State the wanted "fish" first.
- Build exact terms around the object, action, constraint, and desired evidence.
- Adjust terms based on what the first results reveal.
- Search beyond titles when the platform supports full text.

Output:

- Question-to-query mapping.
- Revised query attempts.
- Evidence found or reason the query failed.

## Query Construction Checklist

Ask:

- What is the research object?
- What is the method, mechanism, tool, dataset, material, population, or context?
- What desired property, outcome, bottleneck, or failure matters?
- Which terms are domain-specific, and which are too generic?
- Which synonyms, abbreviations, translations, chemical formulas, model names, or spelling variants matter?
- Does the query return too many, too few, or the wrong kind of results?

## Corpus Construction

For normal research-paper work, enough means "can support the next output", not an arbitrary huge number.

Recommended fields:

- Query.
- Database/source.
- Date.
- Result count.
- Export batch.
- Title.
- Abstract.
- Keywords.
- Year.
- Journal/conference.
- Method/object/result tags.
- Why included.

## Search Failure Diagnosis

| Symptom | Likely Cause | Fix |
| --- | --- | --- |
| Too many results | Keywords too broad or not combined | Add object/method/context/performance terms |
| Too few results | Vocabulary mismatch or overly narrow query | Add synonyms, adjacent-field terms, full-text search |
| Results irrelevant | Query serves a vague question | Rewrite the research question first |
| User says field is too niche | Search boundary may be wrong | Try adjacent domains and method-transfer terms |
| User cannot find idea | Search may not expose field structure | Move from search to Book 3 grouping only after corpus exists |
| User says "I searched but still cannot act" | Search was not tied to an output | Rename the output and rebuild query log |
| User has only a few favorite papers | Corpus is too narrow or biased | Run broad recall mode and export a real corpus |

## Output Template

```markdown
搜索目标：
<idea / method / evidence / troubleshooting / writing material>

关键词池：
对象：
方法：
性能/结果：
机制/问题：
场景/人群/材料：
同义表达：

检索式测试：
1. <query> -> <result count / quality>
2. <query> -> <result count / quality>

进入聚的标准：
<when to export/build the library>
```

## Source Anchors

- Key article inspected: `https://t.zsxq.com/15e98PkPk` on search intelligence, literature library, and output-style learning.
- Key article inspected: `https://t.zsxq.com/159f7j9bq` on universal query patterns and deletion testing.
- Five-step article: `https://articles.zsxq.com/id_nb7kxtutq7x2.html`, `搜` and `聚` sections.
