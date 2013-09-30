# Contributing

Hi, thanks for taking you time *thinking* about contributing. I greatly encourages you
to do so. This is the only library that works with phone numbers, so we are making 
history. 

I really like [Bower](bower/bower)'s Contributing text, I'll just copy-paste here some interesting
instructions that you need to follow.

> Adhering to the following this process is the best way to get your work
> included in the project:

> 1. [Fork](http://help.github.com/fork-a-repo/) the project, clone your fork,
>    and configure the remotes:

```bash
# Clone your fork of the repo into the current directory
git clone https://github.com/<your-username>/front.phone
# Navigate to the newly cloned directory
cd front.phone
# Assign the original repo to a remote called "upstream"
git remote add upstream https://github.com/vtex/front.phone
```

> 2. If you cloned a while ago, get the latest changes from upstream:

```bash
git checkout master
git pull upstream master
```

> 3. Create a new topic branch (off the main project development branch) to
>    contain your feature, change, or fix:

```bash
git checkout -b <topic-branch-name>
```

> 4. Make sure to update, or add to the tests when appropriate. Patches and
>    features will not be accepted without tests. Run `grunt test` to check that
>    all tests pass after you've made changes.

> 5. Commit your changes in logical chunks. Please adhere to these [git commit
>    message guidelines](http://tbaggery.com/2008/04/19/a-note-about-git-commit-messages.html)
>    or your code is unlikely be merged into the main project. Use Git's
>    [interactive rebase](https://help.github.com/articles/interactive-rebase)
>    feature to tidy up your commits before making them public.

> 6. Locally merge (or rebase) the upstream development branch into your topic branch:

```bash
git pull [--rebase] upstream master
```

> 7. Push your topic branch up to your fork:

```bash
git push origin <topic-branch-name>
```

> 8. [Open a Pull Request](https://help.github.com/articles/using-pull-requests/)
>     with a clear title and description.

> 9. If you are asked to amend your changes before they can be merged in, please
>    use `git commit --amend` (or rebasing for multi-commit Pull Requests) and
>    force push to your remote feature branch. You may also be asked to squash
>    commits.

> **IMPORTANT**: By submitting a patch, you agree to license your work under the
> same license as that used by the project.

(thanks Bower [I've asked them if this was ok and they said yes])