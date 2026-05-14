# front.phone — Agent Context

## Project Purpose

`front.phone` is a JavaScript library (written in CoffeeScript) that identifies, validates, and formats phone numbers for multiple countries. It follows the [E.123](http://en.wikipedia.org/wiki/E.123) notation standard and is published as `@vtex/phone`.

## Sources of Truth

- [README.md](./README.md) — usage, API, and contributing guidelines
- [CONTRIBUTING.md](./CONTRIBUTING.md) — contribution process
- [src/script/countries/](./src/script/countries/) — per-country phone rules
- [spec/](./spec/) — Mocha test suite

## Stack

- **Language**: CoffeeScript (`.coffee` files) — compiled via Grunt
- **Build**: Grunt (`grunt dist`) — produces `Phone.js` and country files in `dist/`
- **Test runner**: Mocha + Chai
- **Package manager**: yarn (lockfile committed)
- **Node**: see `.nvmrc` or engine constraints in `package.json`

## Verified Commands

```sh
yarn install --frozen-lockfile   # install dependencies
yarn test                        # run test suite (Mocha via Grunt)
yarn build                       # build distribution artifacts (grunt dist)
grunt                            # build + test + watch
grunt dist                       # build, test, and prepare for npm publish
```

## Architecture

- `src/script/Phone.coffee` — main Phone class with `getPhoneInternational`, `getPhoneNational`, `validate`, `format`, `normalize`
- `src/script/PhoneNumber.coffee` — PhoneNumber value object
- `src/script/countries/<ISO3>.coffee` — one file per country; each instantiates a class and registers itself on `Phone.countries[countryCode]`
- `src/script/phone-filter.coffee` — AngularJS filter adapter
- `spec/` — mirrors `src/` structure; one `*-spec.coffee` per country + `basics-spec.coffee` + `filter-spec.coffee`

## Adding a New Country

1. Create `src/script/countries/<ISO3>.coffee` following the pattern in `BRA.coffee`:
   - Define a class with `countryName`, `countryNameAbbr`, `countryCode`, `regex`, `nationalDestinationCode`, `specialRules()`, `splitNumber()`
   - Register on `Phone.countries[countryCode]`
   - Export the instance
2. Require it in `src/script/phone-all-countries.coffee`
3. Create `spec/countries/<ISO3>-spec.coffee` with at least valid + invalid number cases
4. Run `yarn test` before opening a PR

## Testing Expectations

- Every country rule **must** have a corresponding spec file in `spec/countries/`
- Tests use Mocha `describe/it` + Chai `expect`
- CoffeeScript indentation uses tabs
- Run tests with: `yarn test`

## Autonomy Limits

The agent **can** do autonomously:
- Add or update country rules following the existing pattern
- Add or update tests
- Fix bugs in Phone.coffee / PhoneNumber.coffee
- Update documentation

The agent **must not** do without human approval:
- Change the public API of `Phone` (method signatures, return shape)
- Add or remove npm dependencies
- Modify the Grunt build pipeline
- Publish to npm

## Expected Skills (SDD Full)

This project uses spec-kit (SDD Full flow). Skills are in `.claude/skills/`:

- `/speckit-constitution` — review or regenerate the project constitution
- `/speckit-specify` — create a baseline specification for a feature
- `/speckit-plan` — create an implementation plan
- `/speckit-tasks` — generate actionable tasks
- `/speckit-implement` — execute the implementation plan
- `/speckit-analyze` — cross-artifact consistency check
- `/speckit-clarify` — structured questions before planning

## spec-kit Context

<!-- SPECKIT START -->
For additional context about technologies to be used, project structure,
shell commands, and other important information, read the current plan
<!-- SPECKIT END -->
