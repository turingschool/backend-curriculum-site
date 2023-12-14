---
title: Viewing Party Rubocop File
length: 2 weeks
type: project
---

Copy this code into a `rubocop.yml` at the root of your rails project.

```yml

require: rubocop-rails

AllCops:
  Exclude:
    - 'bin/**/*'
    - 'config/**/*'
    - 'coverage/**/*'
    - 'db/**/*'
    - 'lib/**/*'
    - 'log/**/*'
    - 'node_modules/**/*'
    - 'public/**/*'
    - 'spec/**/*'
    - 'tmp/**/*'
    - 'vendor/**/*'
    - './*'

Style/FrozenStringLiteralComment:
  Enabled: false

Style/Documentation:
  Enabled: false

Style/ClassAndModuleChildren:
  Enabled: false

Style/SafeNavigation:
  Enabled: false

Metrics/AbcSize:
  Enabled: false

Rails/UniqueValidationWithoutIndex:
  Enabled: false
```
