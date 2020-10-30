# Contributing to Hugo

We welcome contributions to NetAM of any kind including documentation, tutorials,
blog posts, bug reports, issues, feature requests, feature implementations, pull requests,
answering questions on the forum, helping to manage issues, etc.

*Note that this repository only contains the actual source code of Hugo.
For **only** documentation-related pull requests / issues please refer to the [NetAM documentation](https://github.com/NetAM-OSC/documentation) repository.*

*Changes to the codebase **and** related documentation, e.g. for a new feature, should still use a single pull request.*

## Table of Contents

* [Reporting Issues](#reporting-issues)
* [Submitting Patches](#submitting-patches)
  * [Code Contribution Guidelines](#code-contribution-guidelines)
  * [Git Commit Message Guidelines](#git-commit-message-guidelines)

## Reporting Issues

You could report any issues into project GitHub issue tracker

- [NetAM Issues](https://github.com/NetaM-OSC/NetAM/issues)
- [NetAM Documentation Issues](https://github.com/NetaM-OSC/documentation/issues)

## Code Contribution

You could contribute to code to implement new feature, existing features enhancement, optimizations, etc…

The project is axed to be as much as possible user friendly, when you propose contribution think to keep
interface and usage as much as possible simple for a non expert user.

## Submitting Patches

The NetAM project welcomes all contributors and contributions regardless of skill or experience level.
If you are interested in helping with the project, we will help you with your contribution.

### Code Contribution Guidelines

Because we want to create the best and usefull possible product for our users, we have a set of guidelines which ensure that all contributions are acceptable.

To make the contribution process as seamless as possible, we ask for the following:

* Go ahead and fork the project and make your changes.  We encourage pull requests to allow for review and discussion of code changes.
* When you’re ready to create a pull request, be sure to:
    * Have test cases for the new code. If you have questions about how to do this, please ask in your pull request.
    * Add documentation if you are adding new features or changing functionality.
    * Add changelog for any change. Follow [changelog](#write-changelog) below
    * Follow the [Git Commit Message Guidelines](#git-commit-message-guidelines) below.

### Git Commit Message Guidelines

We encourage you to use your commit definitions.

We are based on [Angular contribution guide](https://github.com/angular/angular/blob/master/CONTRIBUTING.md#-coding-rules) for the essentiels of commit keys :

```text
- build: Changes that affect the build system or external dependencies (example scopes: gulp, broccoli, npm)
- ci: Changes to our CI configuration files and scripts (example scopes: Circle, BrowserStack, SauceLabs)
- docs: Documentation only changes
- feat: A new feature
- fix: A bug fix
- perf: A code change that improves performance
- refactor: A code change that neither fixes a bug nor adds a feature
- style: Changes that do not affect the meaning of the code (white-space, formatting, missing semi-colons, etc)
- test: Adding missing tests or correcting existing tests
- updt: Update one part of same file
- enc: Update multiples parts of same file
- chore: Massive update from multiples files
- add: Simple file adding
```

### Write Changelog

For each pull request you would submit, you must add an unrealeased changelog for will be computed at the release to create a update Changelog file.

A binary exist in repository to easily create unreleased changelog file. To create this file you must launch following command :

```bash
./bin/changelog -t <type> -m <PR id> "your message"
```

| type        | description                      |
| ----------- | -------------------------------- |
| added       | Add new feature into application |
| fixed       | Fix a bug                        |
| changed     | Change on existing functionality |
| deprecated  | Tag a functionality deprecation  |
| removed     | Remove a feature                 |
| security    | Work on application security     |
| performance | Work on application performance  |
| other       | Other                            |
