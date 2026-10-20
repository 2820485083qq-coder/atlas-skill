# Learn with Feynman

A lightweight Codex Skill that uses the Feynman technique to turn “this feels familiar” into “I can explain and use this in my own words.”

Instead of opening with a polished lecture, it asks the learner to explain first. It then identifies the single gap that matters most, offers questions or hints, and tests the rebuilt understanding in a new situation.

## What problem does it solve?

After reading a source or hearing an explanation, familiarity can easily feel like understanding. Genuine understanding requires you to step away from the source and:

- explain the concept in your own words;
- make the key causes, relationships, or steps explicit;
- notice where your explanation becomes vague or stops;
- keep reasoning when one condition changes.

`learn-with-feynman-en` turns that process into a learning conversation that handles one problem at a time.

## How it works

### 1. Scope

Turn a broad topic into one question that can be explained and tested within a few minutes.

Instead of trying to learn “AI agents” all at once, start with:

> What is the most important difference between an AI agent and a regular chatbot?

### 2. Externalize

Put the source aside and explain the concept from memory in your own words. It is fine to pause, guess, or say “I don’t know.”

### 3. Diagnose

The Skill finds the earliest and most foundational gap that affects the rest of the explanation, such as:

- replacing a mechanism with unexplained jargon;
- stating an outcome without explaining the causal process;
- knowing the parts but not how they connect;
- recalling a definition but being unable to use it in an example;
- missing a condition, boundary, or exception.

It asks about one gap per turn instead of listing everything that is wrong.

### 4. Reconstruct

After repairing the gap, the learner explains the concept again from the beginning and tests it with a new example, counterexample, or slightly changed situation.

```text
Scope → Externalize → Diagnose → Reconstruct
                       ↑             ↓
                       └── A new case exposes a gap ──┘
```

## Example conversation

Start with:

```text
$learn-with-feynman-en I want to understand AI agents.
```

The Skill will not explain the whole topic immediately. It first narrows the target:

```text
This round, we will focus on one question:
What is the most important difference between an AI agent and a regular chatbot?

Evidence that you have explained it clearly:
you can describe the difference and decide whether a new example is an agent.

Do not look it up yet. Explain what you currently think the difference is
in your own words. If you get stuck, say where.
```

You can also begin with your own explanation:

```text
$learn-with-feynman-en I will explain opportunity cost. Check where my explanation breaks down.
```

## What does not count as a clear explanation?

- Saying only, “I understand it, but I can’t explain it.”
- Reciting a textbook definition or repeating an AI answer.
- Listing technical terms without connecting them.
- Giving only an analogy without explaining the real mechanism.
- Replacing one unexplained term with another.
- Recognizing the correct option without generating an explanation.

Informal wording, imperfect organization, or hesitation does not automatically mean the learner lacks understanding. The focus is whether the mechanism, relationships, and reasoning hold together.

## When to use it

- Learn a new concept.
- Check whether you genuinely understand something.
- Work through “I think I get it, but I can’t explain it.”
- Find a specific knowledge gap in an explanation.
- Reorganize a complex idea in plain language.
- Test understanding with examples or new situations.

If you only need a short fact, translation, summary, or piece of writing, there is no need to run the full Feynman loop.

## Install in Codex

Copy the `learn-with-feynman-en` folder into your global Codex Skills directory:

```text
~/.codex/skills/learn-with-feynman-en/
```

The installed structure should be:

```text
~/.codex/skills/learn-with-feynman-en/
├── README.md
├── SKILL.md
└── agents/
    └── openai.yaml
```

Restart Codex, then invoke `$learn-with-feynman-en` or simply ask Codex to help you understand a concept with the Feynman technique.

This version contains only Markdown and YAML files. It does not require Python, Node.js, or a virtual environment.

## Current scope

The current version focuses on concept learning within a single conversation. It does not yet include:

- automatic extraction from webpages, PDFs, or videos;
- cross-session learning memory;
- learner profiles or knowledge graphs;
- multi-agent orchestration;
- automated intent routing or a full behavioral test suite.

These capabilities can be added later if real usage justifies them. They are not required for the current lightweight learning loop.

## Project structure

```text
learn-with-feynman-en/
├── README.md
├── SKILL.md
└── agents/
    └── openai.yaml
```

`README.md` is for people who want to understand and install the project. `SKILL.md` contains the actual instructions Codex follows. Codex uses `SKILL.md` when selecting and running the Skill.

## Design principles

- The learner explains before the Agent teaches.
- Work on one testable concept at a time.
- Address one high-impact gap per turn.
- Ask first, then offer progressively stronger hints, and provide the minimum necessary fact only when needed.
- Use the learner’s language and examples.
- Test with a new situation instead of asking, “Does that make sense?”
- Distinguish “explained clearly in this session” from long-term mastery.

## Inspiration and references

- [Feynman Tutor](https://github.com/koukekoukej-glitch/feynman-tutor)
- [SuperTutor Skill](https://github.com/cskwork/supertutor-skill)
- [The Feynman Learning Technique — Farnam Street](https://fs.blog/feynman-learning-technique/)

