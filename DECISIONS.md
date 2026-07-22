# Decisions

## Step 1: Pipeline skeleton (Parser -> Calculator -> Printer)

Split responsibilities: `Parser` (reads input), `Calculator` (tax logic), `Printer` (renders output), wired by an `Application` orchestrator. `Calculator` never touches raw input or output format directly.

Rationale: keeps the tax domain isolated from how input arrives or how the receipt gets rendered, so either can change independently later.

## Step 2: Input files in the challenge's original format

Added `inputs/input_1.txt`, `input_2.txt`, `input_3.txt` with the three baskets exactly as given in the challenge statement, to be read by `Parser`.

Rationale: parsing the original free-text format (instead of converting it to a structured format like CSV) is closer to the actual problem and demonstrates real parsing logic.
