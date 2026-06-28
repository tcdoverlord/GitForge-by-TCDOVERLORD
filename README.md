# ⚙️ GitForge

> Turn any local project folder into a live GitHub repository with a simple PowerShell GUI.

**GitForge** is a lightweight Windows PowerShell automation tool that helps publish local project folders to GitHub using Git and the GitHub CLI.

Instead of typing the same Git commands every time, GitForge lets you pick a folder, choose a repository name, add a description and topics, then publish everything to GitHub.

Developed by **TCDOVERLORD**

---

## What GitForge Automates

GitForge runs the same proven pipeline:

```powershell
git init
git add .
git commit
gh repo create
gh repo edit --description
gh repo edit --add-topic
git status
gh repo view --web
```

---

## Requirements

- Windows 10/11
- PowerShell 5.1+
- Git installed
- GitHub CLI installed
- Logged in with:

```powershell
gh auth login
```

---

## Quick Start

Run:

```text
launchers\START_GITFORGE.bat
```

Choose:

- Project folder
- Repo name
- GitHub username
- Description
- Topics
- Public or private

Then click:

```text
Publish to GitHub
```

---

## Project Structure

```text
GitForge-by-TCDOVERLORD/
│   README.md
│   setup.ps1
│   LICENSE.md
│
├── scripts/
│   └── Start-GitForge.ps1
│
├── launchers/
│   └── START_GITFORGE.bat
│
├── config/
│   └── default-settings.json
│
├── docs/
│   └── Philosophy.md
│
└── logs/
    └── .gitkeep
```

---

## Philosophy

GitForge is a portfolio publishing assistant.

It is not meant to replace Git knowledge. It exists to make the repeated publishing workflow faster, cleaner, and easier to remember.

> If I have to do it twice... I build a system.
