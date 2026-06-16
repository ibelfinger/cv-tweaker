# cv-tweaker (Claude Code plugin)

This is the **cv-tweaker** plugin: turn a job link into a tailored, ATS-optimized CV,
mined from a reusable career inventory.

cv-tweaker works inside a **workspace** that lives in *your* directory (not in this
plugin). If you are in an empty or un-initialized folder, scaffold one with:

    /cv-tweaker:init

That copies a complete starter workspace into the current directory. From then on, the
full workflow and house style live in that workspace's own `CLAUDE.md`.

Your career inventory and generated applications are yours — they never live inside this
plugin, and plugin updates never touch them.
