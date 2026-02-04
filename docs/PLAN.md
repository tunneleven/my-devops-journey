# Plan: Audit 'review.md' Workflow

## Goal Description
Audit the `.agent/workflows/review.md` file to ensure it explicitly covers all user-requested verification points: accuracy, currency (up-to-date), best practices, official documentation alignment, and multi-agent triggering.

## User Review Required
> [!IMPORTANT]
> This plan outlines how we will verify the verifying tool. We will use 3 agents to critique the workflow definition.

## Proposed Strategy

### Phase 1: Gap Analysis (Project Planner)
-   Map user requirements to `review.md` sections.
-   Identify missing checks (e.g., is "up-to-date" explicitly checked?).

### Phase 2: Specialist Review
-   **DevOps Engineer**: Verify if the "Technical Accuracy" section is robust enough to catch "Legacy" vs "Modern" practices.
-   **Documentation Writer**: Verify if the "Clarity" section includes checking against "Official Documentation" sources.
-   **Orchestrator**: Verify if the "Behavior" section correctly mandates triggering other agents.

### Phase 3: Improvements
-   Update `review.md` if gaps are found.
-   Ensure specific prompts for "Official Docs" and "Skill Usage" are added.

## Verification
-   **Manual Walkthrough**: Simulate a run of the updated workflow against a sample topic.
