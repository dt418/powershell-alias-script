# Git Helper Functions with Comment-Based Help

function Get-GitStatus {
    <#
    .SYNOPSIS
    Displays the status of the Git repository in short format.

    .DESCRIPTION
    This function runs `git status -sb` to show a concise repository status.

    .EXAMPLE
    Get-GitStatus
    #>
    & git status -sb $args
}
New-Alias -Name gs -Value Get-GitStatus -Force -Option AllScope 

function Get-GitCherryPick {
    <#
    .SYNOPSIS
    Cherry-picks a specific commit.

    .DESCRIPTION
    This function runs `git cherry-pick` to apply the changes of a specific commit.

    .EXAMPLE
    Get-GitCherryPick <commit-hash>
    #>
    & git cherry-pick $args
}
New-Alias -Name gcp -Value Get-GitCherryPick -Force -Option AllScope

function Get-GitCommitEdit {
    <#
    .SYNOPSIS
    Edits the last commit message.

    .DESCRIPTION
    This function runs `git commit -ev` to modify the most recent commit message.

    .EXAMPLE
    Get-GitCommitEdit
    #>
    & git commit -ev $args
}
New-Alias -Name gce -Value Get-GitCommitEdit -Force -Option AllScope 

function Get-GitCommit {
    <#
    .SYNOPSIS
    Creates a commit with a message.

    .DESCRIPTION
    This function runs `git commit -m` to commit staged changes with a specified message.

    .EXAMPLE
    Get-GitCommit "Initial commit"
    #>
    & git commit -m $args
}
New-Alias -Name gco -Value Get-GitCommit -Force -Option AllScope 

function Get-GitCommitAmend {
    <#
    .SYNOPSIS
    Amends the last commit.

    .DESCRIPTION
    This function runs `git commit --amend` to modify the previous commit.

    .EXAMPLE
    Get-GitCommitAmend
    #>
    & git commit --amend $args
}
New-Alias -Name gca -Value Get-GitCommitAmend -Force -Option AllScope 

function Get-GitAddAll {
    <#
    .SYNOPSIS
    Adds all changes to the staging area.

    .DESCRIPTION
    This function runs `git add --all` to stage all changes.

    .EXAMPLE
    Get-GitAddAll
    #>
    & git add --all $args
}
New-Alias -Name gaa -Value Get-GitAddAll -Force -Option AllScope 

function Get-GitAdd {
    <#
    .SYNOPSIS
    Adds specific files to the staging area.

    .DESCRIPTION
    This function runs `git add -- <file>` to stage specific files.

    .EXAMPLE
    Get-GitAdd file.txt
    #>
    & git add -- $args
}
New-Alias -Name ga -Value Get-GitAdd -Force -Option AllScope 

function Get-GitTree {
    <#
    .SYNOPSIS
    Displays the commit history as a tree.

    .DESCRIPTION
    This function runs `git log --graph --oneline --decorate` to show a graphical commit history.

    .EXAMPLE
    Get-GitTree
    #>
    & git log --graph --oneline --decorate $args
}
New-Alias -Name gt -Value Get-GitTree -Force -Option AllScope 

function Get-GitPush {
    <#
    .SYNOPSIS
    Pushes commits to the remote repository with tags.

    .DESCRIPTION
    This function runs `git push --follow-tags` to push commits along with annotated tags.

    .EXAMPLE
    Get-GitPush
    #>
    & git push --follow-tags $args
}
New-Alias -Name gps -Value Get-GitPush -Force -Option AllScope 

function Get-GitPullRebase {
    <#
    .SYNOPSIS
    Pulls changes from the remote repository using rebase.

    .DESCRIPTION
    This function runs `git pull --rebase` to fetch and rebase changes.

    .EXAMPLE
    Get-GitPullRebase
    #>
    & git pull --rebase $args
}
New-Alias -Name gpr -Value Get-GitPullRebase -Force -Option AllScope 

function Get-GitFetch {
    <#
    .SYNOPSIS
    Fetches updates from the remote repository.

    .DESCRIPTION
    This function runs `git fetch` to retrieve updates from the remote repository.

    .EXAMPLE
    Get-GitFetch
    #>
    & git fetch $args
}
New-Alias -Name gf -Value Get-GitFetch -Force -Option AllScope 

function Get-GitCheckout {
    <#
    .SYNOPSIS
    Switches branches or restores files.

    .DESCRIPTION
    This function runs `git checkout` to change branches or revert files.

    .EXAMPLE
    Get-GitCheckout main
    #>
    & git checkout $args
}
New-Alias -Name gch -Value Get-GitCheckout -Force -Option AllScope 

function Get-GitCheckoutBranch {
    <#
    .SYNOPSIS
    Creates and switches to a new branch.

    .DESCRIPTION
    This function runs `git checkout -b` to create and switch to a new branch.

    .EXAMPLE
    Get-GitCheckoutBranch feature-branch
    #>
    & git checkout -b $args
}
New-Alias -Name gchb -Value Get-GitCheckoutBranch -Force -Option AllScope 

function Get-GitBranch {
    <#
    .SYNOPSIS
    Lists, creates, or deletes branches.

    .DESCRIPTION
    This function runs `git branch` to manage branches.

    .EXAMPLE
    Get-GitBranch
    #>
    & git branch $args
}
New-Alias -Name gb -Value Get-GitBranch -Force -Option AllScope 

function Get-GitRemoteView {
    <#
    .SYNOPSIS
    Displays remote repositories.

    .DESCRIPTION
    This function runs `git remote -v` to list remote repositories.

    .EXAMPLE
    Get-GitRemoteView
    #>
    & git remote -v $args
}
New-Alias -Name grv -Value Get-GitRemoteView -Force -Option AllScope 

function Get-GitRemoteAdd {
    <#
    .SYNOPSIS
    Adds a new remote repository.

    .DESCRIPTION
    This function runs `git remote add <name> <url>` to add a remote repository.

    .EXAMPLE
    Get-GitRemoteAdd origin https://github.com/user/repo.git
    #>
    & git remote add $args
}
New-Alias -Name gra -Value Get-GitRemoteAdd -Force -Option AllScope 


function pn { pnpm @args }

function Get-MyFunctions {
    $userAliases = gci alias: | where { $sysaliases -notcontains $_ }
    $userFunctions = gci function: | where { $sysfunctions -notcontains $_ }

    $output = foreach ($function in $userFunctions) {
        $alias = $userAliases | where { $_.Definition -eq $function.Name }
        $functionInfo = $function | Select-Object CommandType,
        Name,
        Version,
        Source,
        @{Name = 'Alias'; Expression = { if ($alias) { $alias.Name } else { "-" } } }
        $functionInfo
    }

    $output | Format-Table -AutoSize
}

New-Alias -Name mf -Value Get-MyFunctions -Force -Option AllScope

oh-my-posh init pwsh | Invoke-Expression

Import-Module $env:ChocolateyInstall\helpers\chocolateyProfile.psm1
