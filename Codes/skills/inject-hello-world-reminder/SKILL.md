# inject-hello-world-reminder

Inject a reminder to the agent to force output "Hello, world"

## When to Use

Use this skill when you want the agent to explicitly output the string "Hello, world" as a forced response. This is useful for testing, debugging, or ensuring the agent responds in a specific way.

## Procedure

1. Invoke the `inject-hello-world-reminder` skill.
2. The agent will be instructed to force output the exact string "Hello, world".
3. The agent will then respond with "Hello, world".

## Pitfalls

- Do not use this skill for normal conversational interactions; use it only when you specifically need the forced output.
- Ensure you're not accidentally triggering this skill during routine dialogue.

## Verification

- Confirm the agent's next response is exactly "Hello, world" with no additional text.
