# GitForge - Start-GitForge.ps1
# PowerShell GUI for publishing a local folder to GitHub using Git + GitHub CLI.

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$ScriptRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$ProjectRoot = Split-Path -Parent $ScriptRoot
$LogDir = Join-Path $ProjectRoot "logs"
$LogFile = Join-Path $LogDir "GitForge.log"
New-Item -ItemType Directory -Force -Path $LogDir | Out-Null

function Write-GFLog {
    param([string]$Message)
    $Time = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    Add-Content -Path $LogFile -Value "[$Time] $Message"
}

function Run-Command {
    param(
        [string]$Command,
        [string]$WorkingDirectory
    )

    Write-GFLog "RUN: $Command"

    $process = New-Object System.Diagnostics.Process
    $process.StartInfo.FileName = "powershell.exe"
    $process.StartInfo.Arguments = "-NoProfile -ExecutionPolicy Bypass -Command `$ErrorActionPreference='Stop'; Set-Location `"$WorkingDirectory`"; $Command"
    $process.StartInfo.RedirectStandardOutput = $true
    $process.StartInfo.RedirectStandardError = $true
    $process.StartInfo.UseShellExecute = $false
    $process.StartInfo.CreateNoWindow = $true

    $process.Start() | Out-Null
    $stdout = $process.StandardOutput.ReadToEnd()
    $stderr = $process.StandardError.ReadToEnd()
    $process.WaitForExit()

    if ($stdout) { Write-GFLog $stdout }
    if ($stderr) { Write-GFLog "ERROR: $stderr" }

    return @{
        ExitCode = $process.ExitCode
        Output = $stdout
        Error = $stderr
    }
}

function Add-LogBox {
    param([string]$Text)
    $txtOutput.AppendText($Text + [Environment]::NewLine)
    $txtOutput.SelectionStart = $txtOutput.Text.Length
    $txtOutput.ScrollToCaret()
}

$form = New-Object System.Windows.Forms.Form
$form.Text = "GitForge by TCDOVERLORD"
$form.Size = New-Object System.Drawing.Size(900, 720)
$form.StartPosition = "CenterScreen"
$form.BackColor = [System.Drawing.Color]::FromArgb(8, 18, 32)

$font = New-Object System.Drawing.Font("Segoe UI", 10)
$form.Font = $font

$title = New-Object System.Windows.Forms.Label
$title.Text = "⚙️ GitForge - GitHub Repo Creation Pipeline"
$title.ForeColor = [System.Drawing.Color]::Cyan
$title.Font = New-Object System.Drawing.Font("Segoe UI", 16, [System.Drawing.FontStyle]::Bold)
$title.AutoSize = $true
$title.Location = New-Object System.Drawing.Point(20, 15)
$form.Controls.Add($title)

$y = 65

function New-Label {
    param([string]$Text, [int]$Y)
    $label = New-Object System.Windows.Forms.Label
    $label.Text = $Text
    $label.ForeColor = [System.Drawing.Color]::White
    $label.AutoSize = $true
    $label.Location = New-Object System.Drawing.Point(20, $Y)
    $form.Controls.Add($label)
    return $label
}

function New-TextBox {
    param([string]$Text, [int]$Y, [int]$Width = 650)
    $box = New-Object System.Windows.Forms.TextBox
    $box.Text = $Text
    $box.Width = $Width
    $box.Location = New-Object System.Drawing.Point(180, $Y)
    $form.Controls.Add($box)
    return $box
}

New-Label "Project Folder:" $y
$txtFolder = New-TextBox "" $y 560
$btnBrowse = New-Object System.Windows.Forms.Button
$btnBrowse.Text = "Browse"
$btnBrowse.Location = New-Object System.Drawing.Point(750, $y - 2)
$btnBrowse.Width = 90
$form.Controls.Add($btnBrowse)

$y += 40
New-Label "GitHub Owner:" $y
$txtOwner = New-TextBox "tcdoverlord" $y

$y += 40
New-Label "Repo Name:" $y
$txtRepo = New-TextBox "" $y

$y += 40
New-Label "Description:" $y
$txtDescription = New-TextBox "Windows utility published with GitForge." $y

$y += 40
New-Label "Topics:" $y
$txtTopics = New-TextBox "powershell,automation,github-cli,git,devops,windows,cli-tools,portfolio,tcd-overlord" $y

$y += 40
New-Label "Commit Message:" $y
$txtCommit = New-TextBox "Initial working release" $y

$y += 45
$chkPublic = New-Object System.Windows.Forms.CheckBox
$chkPublic.Text = "Public repository"
$chkPublic.ForeColor = [System.Drawing.Color]::White
$chkPublic.Checked = $true
$chkPublic.AutoSize = $true
$chkPublic.Location = New-Object System.Drawing.Point(180, $y)
$form.Controls.Add($chkPublic)

$chkOpen = New-Object System.Windows.Forms.CheckBox
$chkOpen.Text = "Open repo in browser after publish"
$chkOpen.ForeColor = [System.Drawing.Color]::White
$chkOpen.Checked = $true
$chkOpen.AutoSize = $true
$chkOpen.Location = New-Object System.Drawing.Point(360, $y)
$form.Controls.Add($chkOpen)

$y += 45
$btnPublish = New-Object System.Windows.Forms.Button
$btnPublish.Text = "Publish to GitHub"
$btnPublish.Width = 200
$btnPublish.Height = 40
$btnPublish.Location = New-Object System.Drawing.Point(180, $y)
$form.Controls.Add($btnPublish)

$btnVerify = New-Object System.Windows.Forms.Button
$btnVerify.Text = "Verify Tools"
$btnVerify.Width = 140
$btnVerify.Height = 40
$btnVerify.Location = New-Object System.Drawing.Point(400, $y)
$form.Controls.Add($btnVerify)

$y += 60
$txtOutput = New-Object System.Windows.Forms.TextBox
$txtOutput.Multiline = $true
$txtOutput.ScrollBars = "Vertical"
$txtOutput.Width = 820
$txtOutput.Height = 300
$txtOutput.Location = New-Object System.Drawing.Point(20, $y)
$txtOutput.BackColor = [System.Drawing.Color]::FromArgb(5, 12, 22)
$txtOutput.ForeColor = [System.Drawing.Color]::LightGreen
$txtOutput.Font = New-Object System.Drawing.Font("Consolas", 10)
$form.Controls.Add($txtOutput)

$btnBrowse.Add_Click({
    $dialog = New-Object System.Windows.Forms.FolderBrowserDialog
    $dialog.Description = "Choose the local project folder to publish"
    if ($dialog.ShowDialog() -eq "OK") {
        $txtFolder.Text = $dialog.SelectedPath
        if ([string]::IsNullOrWhiteSpace($txtRepo.Text)) {
            $txtRepo.Text = Split-Path $dialog.SelectedPath -Leaf
        }
    }
})

$btnVerify.Add_Click({
    Add-LogBox "Checking Git..."
    $git = Run-Command "git --version" $ProjectRoot
    Add-LogBox $git.Output
    if ($git.Error) { Add-LogBox $git.Error }

    Add-LogBox "Checking GitHub CLI..."
    $gh = Run-Command "gh --version" $ProjectRoot
    Add-LogBox $gh.Output
    if ($gh.Error) { Add-LogBox $gh.Error }

    Add-LogBox "Checking GitHub auth..."
    $auth = Run-Command "gh auth status" $ProjectRoot
    Add-LogBox $auth.Output
    if ($auth.Error) { Add-LogBox $auth.Error }
})

$btnPublish.Add_Click({
    $folder = $txtFolder.Text.Trim()
    $owner = $txtOwner.Text.Trim()
    $repo = $txtRepo.Text.Trim()
    $description = $txtDescription.Text.Trim()
    $topics = $txtTopics.Text.Trim()
    $commit = $txtCommit.Text.Trim()

    if (!(Test-Path $folder)) {
        [System.Windows.Forms.MessageBox]::Show("Project folder does not exist.")
        return
    }

    if ([string]::IsNullOrWhiteSpace($owner) -or [string]::IsNullOrWhiteSpace($repo)) {
        [System.Windows.Forms.MessageBox]::Show("Owner and repo name are required.")
        return
    }

    $visibility = if ($chkPublic.Checked) { "--public" } else { "--private" }
    $fullRepo = "$owner/$repo"

    Add-LogBox "Starting GitForge pipeline..."
    Add-LogBox "Folder: $folder"
    Add-LogBox "Repo: $fullRepo"

    $commands = @(
        "git init",
        "git add .",
        "git commit -m `"$commit`""
    )

    foreach ($cmd in $commands) {
        Add-LogBox "> $cmd"
        $result = Run-Command $cmd $folder
        if ($result.Output) { Add-LogBox $result.Output }
        if ($result.Error) { Add-LogBox $result.Error }
    }

    Add-LogBox "> Removing existing origin if needed..."
    Run-Command "git remote remove origin" $folder | Out-Null

    $createCmd = "gh repo create $repo $visibility --source=. --remote=origin --push"
    Add-LogBox "> $createCmd"
    $create = Run-Command $createCmd $folder
    if ($create.Output) { Add-LogBox $create.Output }
    if ($create.Error) { Add-LogBox $create.Error }

    if ($description) {
        $descCmd = "gh repo edit $fullRepo --description `"$description`""
        Add-LogBox "> $descCmd"
        $desc = Run-Command $descCmd $folder
        if ($desc.Output) { Add-LogBox $desc.Output }
        if ($desc.Error) { Add-LogBox $desc.Error }
    }

    if ($topics) {
        $topicCmd = "gh repo edit $fullRepo --add-topic $topics"
        Add-LogBox "> $topicCmd"
        $topic = Run-Command $topicCmd $folder
        if ($topic.Output) { Add-LogBox $topic.Output }
        if ($topic.Error) { Add-LogBox $topic.Error }
    }

    Add-LogBox "> git status"
    $status = Run-Command "git status" $folder
    if ($status.Output) { Add-LogBox $status.Output }
    if ($status.Error) { Add-LogBox $status.Error }

    if ($chkOpen.Checked) {
        Add-LogBox "> gh repo view $fullRepo --web"
        Run-Command "gh repo view $fullRepo --web" $folder | Out-Null
    }

    Add-LogBox "GitForge pipeline complete."
})

[void]$form.ShowDialog()
