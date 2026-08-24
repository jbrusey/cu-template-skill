# Install in pi

Pi installs the package and discovers all four skills:

```bash
pi install git:github.com/jbrusey/cu-template-skill
```

Use `-l` for a project-local install:

```bash
pi install -l git:github.com/jbrusey/cu-template-skill
```

You can also ask a coding agent:

```text
Install https://github.com/jbrusey/cu-template-skill as a skill.
```

Use the main skill:

```text
Use the cu-template-pdf skill to build a PDF from ./project.md.
```

The package includes platform-specific setup skills. The main skill loads the appropriate one when `pandoc` or `xelatex` is missing:

- `cu-template-pdf-install-windows`
- `cu-template-pdf-install-macos`
- `cu-template-pdf-install-ubuntu`
