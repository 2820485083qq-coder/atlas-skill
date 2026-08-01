# Book 4: Verify Idea

Use this reference when the user has one or more candidate ideas and needs to decide whether to invest serious time in experiments, theory, code, empirical work, or writing.

## Source Scope

Distilled from the `《科研论4：验证idea》` section of the Keyanlun column index, the homepage layer table, and the five-step article's `验` explanation. The index emphasizes reading only what verifies the idea, building an "experiment verification" file, using grouped literature to know what has been excerpted, and browsing uncertain groups when necessary.

## Core Model

Verification is the 0-to-1 stage. It protects the user from spending months on an idea that should have been killed or redirected early.

The point is not to prove the entire paper. The point is to learn whether the idea deserves the 1-to-10 expansion stage.

## Chapter-Level Method Cards

### Card 1: 只读与验证有关的部分

During verification, do not read papers as if preparing a review article. Read to answer one question: "Can this idea work, and what would make it fail?"

Use this narrow reading lens:

- Which prior work proves the same route has already been done?
- Which method, dataset, theory, code, protocol, or empirical setting makes the idea feasible?
- Which result suggests the idea will not work?
- Which missing comparison would make the later paper unconvincing?

Output:

- Verification-relevant excerpt list.
- Already-done risk.
- Feasibility evidence.
- Failure evidence.

### Card 2: 实验验证文件

Create an `实验验证-1` style file for the first 0-to-1 attempt. The file is not the final experiment notebook. It is a small decision document.

Recommended fields:

- Idea being tested.
- Hypothesis or mechanism.
- Minimal material needed.
- Minimal procedure.
- Comparison or baseline.
- Expected signal.
- Pass/fail/ambiguous interpretation.
- What to do next if it passes.
- What to do next if it fails.

### Card 3: 快速失败

Verification should make failure cheap. If the first signal is weak, decide whether the problem is the idea, the search, the grouping, or the test design.

Use this triage:

- Idea duplicated -> return to Book 2/3 and look for a sharper gap.
- No feasible method/material -> return to Book 2 search or Book 3 grouping.
- Test too expensive -> redesign the kill test.
- Result weak but informative -> pivot the idea, do not simply scale effort.

### Card 4: 分组与验证衔接

Verification depends on earlier grouping quality. Before testing, check whether the relevant group has enough representative papers and whether the needed information has already been excerpted.

If the verification file lacks comparable methods, baselines, datasets, mechanisms, or failure cases, retreat to Book 3 before running more experiments.

## Verification Workflow

### 1. Choose One Main Idea and One Backup

Do not verify many ideas at once unless the tests share the same material.

Output:

- Main idea.
- Backup idea.
- Why these are worth testing.

### 2. Define the Kill Test

Ask:

- What result would make this idea no longer worth pursuing?
- What minimal evidence would make it worth expanding?
- Can this be checked with existing data, public data, quick code, simple theory, literature reproduction, small experiment, or expert/field evidence?

Output:

- Pass condition.
- Fail condition.
- Ambiguous condition.
- Maximum time/effort budget.

### 3. Build Verification Material

Use only the material needed for the test.

Possible contents:

- Key papers proving feasibility or failure.
- Minimal protocol, dataset, code, model, formula, or empirical design.
- Expected observable.
- Required comparison.
- Notes on whether the idea has already been solved.

### 4. Decide Advance, Retreat, or Pivot

- Pass -> go to Book 5 / `合` and build the material-experiment-writing system.
- Fail -> diagnose whether the idea is dead or whether search/grouping was too weak.
- Ambiguous -> add one small discriminating test, not a full project.

## Retrospective Routing

When verification fails, retreat deliberately:

- Missing comparable methods -> Book 2 search.
- Cannot find enough references -> Book 2 search or Book 3 wider grouping.
- No Plan B -> Book 3 grouping.
- Test is too large -> redesign Book 4 verification.
- Writing exposes no contribution -> Book 3 topic or Book 4 verification, not language polishing.

## Output Template

```markdown
候选idea：

0到1验证目标：

最小证据：

通过标准：

失败标准：

模糊结果怎么处理：

最多投入：

下一步：
```

## Common Mistakes

- Treating verification as the full experiment.
- Spending months before defining pass/fail conditions.
- Verifying an idea without a backup route.
- Reading broadly during verification instead of reading only what affects the kill test.
- Continuing because of sunk cost after evidence says the route is weak.

## Source Anchors

- Key article inspected: `https://t.zsxq.com/17AYfEgOY` / `《科研论4》103_第八章 【验】字诀：制定从0到1的研究方案：文献阅读只关心验证idea是否可行的部分`.
- Key article inspected: `https://t.zsxq.com/17RwhEpdw` / `《科研论4》105_第八章 【验】字诀：具体的文献阅读方式：《实验验证-1》文件`.
- Homepage framework source: `https://www.keyanlun.com/`, especially the five-step `搜聚分验合` positioning of `验` as 0-to-1 validation.
