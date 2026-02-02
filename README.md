# Space Shuttle IPB Demo

Demo of an Illustrated Parts Breakdown (IPB) system using Space Shuttle components.

## Overview

Simulates an end-to-end IPB workflow for engineering parts data:  
- Parses XML modules for shuttle components (SRB, External Tank, Orbiter)
- Automates XML module combination
- Automates parts data validation
- Performs quality checks for missing descriptions and duplicate part numbers

## File Structure

```
shuttle-ipb-demo/
├── .gitignore
├── ipb_files/                    # XML module files
│   ├── solid_rocket_booster.xml
│   ├── external_tank.xml
│   └── orbiter.xml
├── scripts/                      # Ruby automation scripts
│   ├── combine_ipb.rb
│   └── quality_check.rb
├── outputs/                      # Generated CSV reports
│   └── .gitkeep
└── README.md

```

## Requirements

- Ruby 2.7+
- Nokogiri gem: gem install nokogiri

Note: If installation fails, try: gem install nokogiri --platform=ruby

## Usage

1. Combine XML modules into CSV

From the project root:
```bash
cd scripts
ruby combine_ipb.rb

```

Output: `outputs/ipb_combined_report.csv`

2. Run quality checks

```bash
ruby quality_check.rb

```

Validates:
- Missing/empty descriptions
- Duplicate part numbers across all modules

## Example Output
```irb
--- Missing Descriptions ---
ET001 (Module: External Tank)

```
```irb
--- Duplicate Part Numbers ---
ET001 - found in: External Tank, External Tank

```

## Real-World Application

Automates validation of parts data in an IPB workflow to detect duplicates and missing documentation.  
Produces structured reports for cross-functional use across departments.