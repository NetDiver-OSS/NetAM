# frozen_string_literal: true

## Changelog
changelog_creation_missing = git.added_files.grep(%r{changelog/unreleased}).empty?
changelog_modification_missing = git.modified_files.grep(%r{changelog/unreleased}).empty?

warn "There're changes, but no changelog." if changelog_creation_missing && changelog_modification_missing

## rubocop
rubocop.lint inline_comment: true
