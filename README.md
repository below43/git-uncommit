# git-uncommit

Undo the last git commit(s) while keeping changes staged.

## Usage

Undo last commit:

    git uncommit

Undo last 3 commits:

    git uncommit 3

Equivalent to:

    git reset --soft HEAD~N

## Install

### Homebrew

    brew tap YOURNAME/git-tools
    brew install git-uncommit

## Why?

Because I can never remember:

    git reset --soft HEAD~1
