# Decisions

## Approach

Started by reading and fully understanding the problem before writing any code, then set up the project structure and a bare skeleton. Preferred approach: get the big picture and overall architecture in place first, without getting attached to implementation details too early. From there, break the problem into small, well-scoped pieces and fold each business rule into the piece it belongs to — keeping responsibilities separated and the code clean and reusable as the solution takes shape incrementally.

## Step 1: Pipeline skeleton (Parser -> Calculator -> Printer)

Split responsibilities: `Parser` (reads input), `Calculator` (tax logic), `Printer` (renders output), wired by an `Application` orchestrator. `Calculator` never touches raw input or output format directly.

Rationale: keeps the tax domain isolated from how input arrives or how the receipt gets rendered, so either can change independently later.

## Step 2: Input files in the challenge's original format

Added `inputs/input_1.txt`, `input_2.txt`, `input_3.txt` with the three baskets exactly as given in the challenge statement, to be read by `Parser`.

Rationale: parsing the original free-text format (instead of converting it to a structured format like CSV) is closer to the actual problem and demonstrates real parsing logic.

## Step 3: Item model with validation + flat 10% end-to-end run

Turned Item into a proper class (not a plain Struct) with named-argument initialization and validation (name presence, quantity > 0, unit_price >= 0). Reasoning: those checks are about the integrity of the Item's own data, which is the Item's responsibility — separate from tax/exemption rules, which belong to the tax logic, not the Item.

At this stage, Calculator applies a flat 10% sales tax to every item, with no exemptions and no import duty rules applied yet. This is an intentional intermediate step to validate the full pipeline end-to-end (Parser → Calculator → Printer) using inputs/input_1.txt before layering in the real business rules (category exemptions, import duty).

## Step 4: Sales tax exemption by category

Added `category` (`:book`, `:food`, `:medical`, `:other`) as a plain data attribute on Item, inferred from the item's name by a new `Categorizer` class using keyword matching. `SalesTax` is now its own class: it owns the exemption rule (which categories it doesn't apply to) and the calculation itself. Calculator no longer computes tax directly — it delegates to a list of tax objects (defaults to `[SalesTax.new]`), which is the extension point for adding `ImportDuty` later without touching Calculator.

Assumption: the input has no explicit product category, so it's inferred from keywords in the item's name (e.g. "book", "chocolate", "pill"). This is a deliberate simplification, not a scalable classification — see Future Improvements.

## Step 5: Import duty

Added `ImportDuty` (5%, no category exemptions, applies only when `item.imported`), following the same shape as `SalesTax`. Extracted the shared nearest-nickel rounding logic into a `NickelRounding` module both taxes include, to avoid duplicating it. `Calculator` now defaults to `[SalesTax.new, ImportDuty.new]` — no change to `Calculator` itself was needed to support the new tax.

Each tax rounds its own amount to the nearest nickel independently before they get summed (not the combined amount) — confirmed against Output 2's numbers (perfume: 4.75 sales tax + 2.40 import duty = 7.15).

Also fixed `Printer` to prefix imported items with "imported" in the receipt (e.g. "1 imported box of chocolates"), since `Item#name` intentionally excludes that word — it's kept out of the domain data so category inference and business logic don't have to deal with it, and it's a presentation concern instead.

All three sample inputs now match the challenge's expected output exactly.

## Step 6: Code review fixes

- Moved `NickelRounding` from `lib/taxes/` to `lib/utils/` — it's a shared helper, not a tax rule, and living inside `taxes/` made it look like one.
- Tightened `Item`'s validation to check types directly (`is_a?(Integer)` / `is_a?(Numeric)`) instead of coercing with `.to_i`/`.to_f`. The coercion was silently accepting garbage (e.g. `"abc".to_f == 0.0` would have passed the `>= 0` check).
- Decimal format (e.g. "22,22" vs "22.22") is a `Parser` concern, not `Item`'s: the input regex only accepts dot-decimal numbers, so by the time a value reaches `Item` it's already a real `Float`, not a string to reinterpret.
- Reasoning for having a single model (`Item`): it's the only object with real domain state that needs data-integrity validation. The tax classes hold no per-instance data — they're behavior-only policy objects (strategy pattern), not models. The receipt is a plain Hash rather than a class because it has a single consumer (`Printer`) today; promoting it to a class without a second consumer would be premature.

## Future Improvements

- Category inference from the item name is keyword-based and not exhaustive. A more robust solution would have the input (or a product catalog) state each item's category explicitly instead of guessing it from text.
