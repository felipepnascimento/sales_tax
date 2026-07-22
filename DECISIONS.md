# Decisions

## Step 1: Pipeline skeleton (Parser -> Calculator -> Printer)

Split responsibilities: `Parser` (reads input), `Calculator` (tax logic), `Printer` (renders output), wired by an `Application` orchestrator. `Calculator` never touches raw input or output format directly.

Rationale: keeps the tax domain isolated from how input arrives or how the receipt gets rendered, so either can change independently later.
