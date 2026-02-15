claude code

claude --resume
todo lists

! bash mode

ask claude to explain a file or project

auto accept shift+tab

/model  - switch models  - opusplan - use opus for planning, sonnet for code

escape - interrupt current prompt

can give image inputs for debugging UIs

ask claude to write tests for you

can ask claude to do test driven dev

claude.md - projects memory and guidelines - git, tests, workflows. Can ask claude code to write and update it.

message queue - tasks can be queued while other tasks 

can put promte in a file and then reference it use @filename

plan mode. "tab + shift". architecture. "Use parallel subagents" if you want. Ask it to save plan to a markdown file

think keywords: think, think hard, ultrathing

Can reference URLs in prompts for research. Can read pdfs

Can ask claude to generate Product Requirement Docs and technical design docs

/copy - copy last response to clipboard

Think like product manager. Gavin clear context and constraints. Work on verifying claude's outputs as opposed to the actual code

"use parallel subagents to ..." - add this to prompt to run multiple things in parallel

git worktrees allow multiple agents to work on project without conflicts
Create .trees directory. Use git add to create work tree for each feature or thread you want to work on 

Commands - help with repetative prompts
.claude/commands/<command name>.md   - it has "allowed tools" and "description" section. $ARGUMENTS 
if in ~/.cluade/commands then it is global, else project specific

claude.md always gets added to context. commands do not.

Custom subagents - get UX design, security reviewer, test runner, database admin
/agents 

/mcp - eg database mcp, playwright for browser automation for testing. Figma for design to code.

/init - create claude.md for the current project. claude.md can be build validation steps - eg run unit tests after every change

/memory

? - show keyboard shortcuts

escape - press this to stop current prompt

/context - check this. If too big then do /clear to reduce it

compaction - reduces the size of the context window

/resume - resume a context from a previous session

/mcp - warning - they can increase context window

--dangereously-skip-permissions

skill - is like a workflow
.claude/skills/my-skill-name.md
# Skill name
description
## Instructions
1. open file 
2. process file

Can mention a skill in a prompt (eg run "my-skill-name" on this file
While with commands you reference them with "/command-name"

Ask claude to write the skills and commands

MCP - ask claude to find ones for you, get playright. May be a bit out of date

Sub-agents - parallel work & protect current context window
